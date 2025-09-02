# Swift 6 Concurrency Sample

This example demonstrates the new Swift 6 strict concurrency compliant approach to using OpenTelemetry Swift SDK.

## Key Features

- **Thread-Safe**: All operations are safe for concurrent access
- **No Global Mutable State**: Uses immutable configuration and instance-based approach
- **Sendable Compliance**: All types conform to `Sendable` for Swift 6 compatibility
- **Builder Pattern**: Easy configuration using the builder pattern

## Migration from Singleton Pattern

### Old Way (Deprecated)
```swift
// Global singleton with mutable state
OpenTelemetry.registerTracerProvider(tracerProvider: provider)
let tracer = OpenTelemetry.instance.tracerProvider.get(...)
```

### New Way (Swift 6 Compatible)
```swift
// Immutable configuration
let config = OpenTelemetryConfigurationBuilder()
    .with(tracerProvider: provider)
    .build()

let openTelemetry = OpenTelemetry(configuration: config)
let tracer = openTelemetry.tracerProvider.get(...)
```

## Benefits

1. **Concurrency Safety**: No data races or thread safety issues
2. **Testability**: Easy to create different configurations for testing
3. **Immutability**: Configuration cannot be changed after creation
4. **Dependency Injection**: Easy to pass around specific configurations

## Running the Example

```bash
swift run Swift6ConcurrencySample
```

## Configuration Options

The `OpenTelemetryConfigurationBuilder` supports configuring:

- `TracerProvider` - for distributed tracing
- `MeterProvider` - for metrics collection  
- `LoggerProvider` - for structured logging
- `BaggageManager` - for context propagation
- `ContextPropagators` - for cross-service context propagation
- `ContextManager` - for context management (Activity or TaskLocal)
- `FeedbackHandler` - for debugging and diagnostics

All components have sensible defaults, so you only need to configure what you want to customize.
