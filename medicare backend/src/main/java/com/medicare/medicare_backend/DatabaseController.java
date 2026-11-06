package com.medicare.medicare_backend;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.web.bind.annotation.CrossOrigin;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = {
    "http://localhost:5500",
    "http://127.0.0.1:5500"
})
public class DatabaseController {

    private final JdbcTemplate jdbcTemplate;

    public DatabaseController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private static class TableInfo {
        final String table;
        final String id;
        final Set<String> columns;

        TableInfo(String table, String id, String... columns) {
            this.table = table;
            this.id = id;
            this.columns = new LinkedHashSet<>(Arrays.asList(columns));
        }
    }

    private static final Map<String, TableInfo> TABLES =
            new LinkedHashMap<>();

    static {
        register("hospitals", "Hospital", "hospital_id",
                "hospital_id", "name", "address", "phone",
                "location", "total_beds", "facilities");

        register("departments", "Department", "department_id",
                "department_id", "name", "description", "hospital_id");

        register("doctors", "Doctor", "doctor_id",
                "doctor_id", "name", "specialization", "phone",
                "email", "hospital_id", "department_id");

        register("patients", "Patient", "patient_id",
                "patient_id", "name", "age", "gender",
                "phone", "address");

        register("appointments", "Appointment", "appointment_id",
                "appointment_id", "patient_id", "doctor_id",
                "appointment_date", "appointment_time",
                "status", "notes");

        register("beds", "Bed", "bed_id",
                "bed_id", "bed_type", "status", "room_no",
                "hospital_id", "department_id");

        register("ambulances", "Ambulance", "ambulance_id",
                "ambulance_id", "vehicle_no", "type", "status",
                "hospital_id", "driver_name", "phone");

        register("areas", "Area", "area_id",
                "area_id", "name", "type", "description");

        register("locations", "Location", "location_id",
                "location_id", "name", "address", "latitude",
                "longitude", "area_id");

        register("emergencies", "Emergency", "emergency_id",
                "emergency_id", "patient_id", "hospital_id",
                "emergency_type", "description", "status",
                "created_at");

        register("emergency-services", "EmergencyService", "service_id",
                "service_id", "type", "description",
                "contact_no", "hospital_id");
    }

    private static void register(
            String resource, String table, String id, String... columns) {

        TableInfo info = new TableInfo(table, id, columns);

        TABLES.put(resource, info);

        // Also accept singular names, such as /api/hospital.
        if (resource.endsWith("ies")) {
            TABLES.put(resource.substring(0, resource.length() - 3) + "y",
                    info);
        } else if (resource.endsWith("s")
                && !resource.endsWith("ss")) {
            TABLES.put(resource.substring(0, resource.length() - 1), info);
        }
    }

    private TableInfo getTable(String resource) {
        TableInfo info = TABLES.get(resource.toLowerCase());

        if (info == null) {
            throw new IllegalArgumentException(
                    "Unknown resource: " + resource);
        }

        return info;
    }

    private Map<String, Object> success(String message, Object data) {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("success", true);
        result.put("message", message);
        result.put("data", data);
        return result;
    }

    private Map<String, Object> error(String message) {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("success", false);
        result.put("message", message);
        return result;
    }

    private Map<String, Object> validateFields(
            TableInfo info, Map<String, Object> body,
            boolean allowId) {

        if (body == null || body.isEmpty()) {
            throw new IllegalArgumentException(
                    "Request body must contain at least one field.");
        }

        Map<String, Object> clean = new LinkedHashMap<>();

        for (Map.Entry<String, Object> entry : body.entrySet()) {
            String column = entry.getKey();

            if (!info.columns.contains(column)) {
                throw new IllegalArgumentException(
                        "Invalid column '" + column
                        + "' for table " + info.table);
            }

            if (!allowId && column.equals(info.id)) {
                continue;
            }

            clean.put(column, entry.getValue());
        }

        if (clean.isEmpty()) {
            throw new IllegalArgumentException(
                    "No editable fields were provided.");
        }

        return clean;
    }

    // Test API and database connection.
    @GetMapping("/test-db")
    public ResponseEntity<?> testDatabase() {
        try {
            Integer result = jdbcTemplate.queryForObject(
                    "SELECT 1", Integer.class);

            List<String> tables = jdbcTemplate.queryForList(
                    "SHOW TABLES", String.class);

            Map<String, Object> data = new LinkedHashMap<>();
            data.put("database", "hospital_emergency_db");
            data.put("connection", result != null && result == 1
                    ? "Connected successfully" : "Connection failed");
            data.put("tables", tables);

            return ResponseEntity.ok(success(
                    "Database connection test completed.", data));

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(error("Database connection failed: "
                            + e.getMessage()));
        }
    }

    // Get all records from a table.
    @GetMapping("/{resource}")
    public ResponseEntity<?> getAll(
            @PathVariable String resource) {
        try {
            TableInfo info = getTable(resource);

            List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                    "SELECT * FROM `" + info.table + "`");

            return ResponseEntity.ok(success(
                    "Records retrieved successfully.", rows));

        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(error(e.getMessage()));
        }
    }

    // Get one record by its primary key.
    @GetMapping("/{resource}/{id}")
    public ResponseEntity<?> getById(
            @PathVariable String resource,
            @PathVariable String id) {
        try {
            TableInfo info = getTable(resource);

            List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                    "SELECT * FROM `" + info.table
                    + "` WHERE `" + info.id + "` = ?", id);

            if (rows.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(error("Record not found."));
            }

            return ResponseEntity.ok(success(
                    "Record retrieved successfully.", rows.get(0)));

        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(error(e.getMessage()));
        }
    }

    // Add a record.
    @PostMapping("/{resource}")
    public ResponseEntity<?> create(
            @PathVariable String resource,
            @RequestBody Map<String, Object> body) {
        try {
            TableInfo info = getTable(resource);
            Map<String, Object> fields =
                    validateFields(info, body, false);

            String columnNames = fields.keySet().stream()
                    .map(c -> "`" + c + "`")
                    .collect(Collectors.joining(", "));

            String placeholders = fields.keySet().stream()
                    .map(c -> "?")
                    .collect(Collectors.joining(", "));

            String sql = "INSERT INTO `" + info.table + "` ("
                    + columnNames + ") VALUES (" + placeholders + ")";

            jdbcTemplate.update(sql, fields.values().toArray());

            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(success("Record added successfully.", fields));

        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(error(e.getMessage()));
        }
    }

    // Update a record by its primary key.
    @PutMapping("/{resource}/{id}")
    public ResponseEntity<?> update(
            @PathVariable String resource,
            @PathVariable String id,
            @RequestBody Map<String, Object> body) {
        try {
            TableInfo info = getTable(resource);
            Map<String, Object> fields =
                    validateFields(info, body, false);

            String assignments = fields.keySet().stream()
                    .map(c -> "`" + c + "` = ?")
                    .collect(Collectors.joining(", "));

            List<Object> values = new ArrayList<>(fields.values());
            values.add(id);

            String sql = "UPDATE `" + info.table + "` SET "
                    + assignments + " WHERE `" + info.id + "` = ?";

            int changed = jdbcTemplate.update(sql, values.toArray());

            if (changed == 0) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(error(
                                "Record not found or no values changed."));
            }

            return ResponseEntity.ok(success(
                    "Record updated successfully.", Map.of("id", id)));

        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(error(e.getMessage()));
        }
    }

    // Delete a record by its primary key.
    @DeleteMapping("/{resource}/{id}")
    public ResponseEntity<?> delete(
            @PathVariable String resource,
            @PathVariable String id) {
        try {
            TableInfo info = getTable(resource);

            int changed = jdbcTemplate.update(
                    "DELETE FROM `" + info.table
                    + "` WHERE `" + info.id + "` = ?", id);

            if (changed == 0) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(error("Record not found."));
            }

            return ResponseEntity.ok(success(
                    "Record deleted successfully.", Map.of("id", id)));

        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(error(e.getMessage()));
        }
    }
}