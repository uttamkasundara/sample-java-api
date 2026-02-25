package com.example.sample;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
public class HealthController {

    @Value("${VERSION:unknown}")
    private String version;

    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("OK");
    }

    @GetMapping("/info")
    public ResponseEntity<Map<String, String>> info() {
        // System.out.println("Version: " + version);    
        return ResponseEntity.ok(Map.of(
                "service", "sample-java-api",
                "version", version
        ));
    }
}
