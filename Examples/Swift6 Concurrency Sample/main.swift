/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation
import OpenTelemetryApi

// MARK: - Swift 6 Concurrency-Safe OpenTelemetry Usage

@main
struct Swift6ConcurrencySample {
    static func main() async {
        print("=== Swift 6 Concurrency-Safe OpenTelemetry Example ===")
        
        // 1. Create configuration using the builder pattern
        let config = OpenTelemetryConfigurationBuilder()
            .with(feedbackHandler: { message in
                print("OpenTelemetry: \(message)")
            })
            .build()
        
        // 2. Create OpenTelemetry instance with configuration
        let openTelemetry = OpenTelemetry(configuration: config)
        
        // 3. Use the instance-based approach (thread-safe)
        await demonstrateTracing(openTelemetry: openTelemetry)
        await demonstrateMetrics(openTelemetry: openTelemetry)
        await demonstrateBaggage(openTelemetry: openTelemetry)
        
        print("\n=== Comparison with Deprecated Singleton Pattern ===")
        demonstrateDeprecatedUsage()
    }
    
    static func demonstrateTracing(openTelemetry: OpenTelemetry) async {
        print("\n--- Tracing Example ---")
        
        // Get a tracer from the instance
        let tracer = openTelemetry.tracerProvider.get(instrumentationName: "swift6-example")
        
        // Create and use spans
        let span = tracer.spanBuilder(spanName: "example-operation").startSpan()
        span.setAttribute(key: "example.attribute", value: "swift6-concurrency")
        
        // Simulate some work
        await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        span.end()
        print("Created and ended span: example-operation")
    }
    
    static func demonstrateMetrics(openTelemetry: OpenTelemetry) async {
        print("\n--- Metrics Example ---")
        
        // Get a meter from the instance
        let meter = openTelemetry.meterProvider.get(name: "swift6-example")
        
        // Create instruments (in a real app, these would be created once and reused)
        let counter = meter.createIntCounter(name: "example.counter")
        let histogram = meter.createDoubleHistogram(name: "example.histogram")
        
        // Record measurements
        counter.add(value: 1, attributes: ["operation": AttributeValue.string("swift6-demo")])
        histogram.record(value: 123.45, attributes: ["status": AttributeValue.string("success")])
        
        print("Recorded counter and histogram metrics")
    }
    
    static func demonstrateBaggage(openTelemetry: OpenTelemetry) async {
        print("\n--- Baggage Example ---")
        
        // Get baggage manager from the instance
        let baggageManager = openTelemetry.baggageManager
        
        // Create baggage
        let baggage = baggageManager.baggageBuilder()
            .put(key: "user.id", value: "12345")
            .put(key: "request.id", value: "req-67890")
            .build()
        
        // Set active baggage
        openTelemetry.contextProvider.setActiveBaggage(baggage)
        
        // Retrieve current baggage
        if let currentBaggage = baggageManager.getCurrentBaggage() {
            print("Current baggage contains \(currentBaggage.getEntries().count) entries")
        }
    }
    
    static func demonstrateDeprecatedUsage() {
        print("\n--- Deprecated Singleton Usage (for comparison) ---")
        
        // This is the old way - now deprecated
        let deprecatedTracer = OpenTelemetry.instance.tracerProvider.get(instrumentationName: "deprecated-example")
        print("Using deprecated singleton: \(type(of: deprecatedTracer))")
        
        // Show deprecation warnings for static registration methods
        // Note: These are now no-ops in our implementation
        OpenTelemetry.registerFeedbackHandler { message in
            print("Deprecated feedback: \(message)")
        }
        
        print("⚠️  The above methods are deprecated. Use instance-based approach instead.")
    }
}

// MARK: - Concurrent Usage Example

extension Swift6ConcurrencySample {
    /// Demonstrates that the new approach is safe for concurrent usage
    static func demonstrateConcurrentUsage() async {
        print("\n--- Concurrent Usage Example ---")
        
        let config = OpenTelemetryConfigurationBuilder().build()
        let openTelemetry = OpenTelemetry(configuration: config)
        
        // Create multiple concurrent tasks
        await withTaskGroup(of: Void.self) { group in
            for i in 0..<5 {
                group.addTask {
                    let tracer = openTelemetry.tracerProvider.get(instrumentationName: "concurrent-task-\(i)")
                    let span = tracer.spanBuilder(spanName: "concurrent-operation-\(i)").startSpan()
                    
                    // Simulate work
                    await Task.sleep(nanoseconds: UInt64.random(in: 50_000_000...150_000_000))
                    
                    span.end()
                    print("Task \(i) completed")
                }
            }
        }
        
        print("All concurrent tasks completed safely")
    }
}
