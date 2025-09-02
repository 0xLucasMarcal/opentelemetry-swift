/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

#if canImport(os.log)
  import os.log
#endif

/// This class provides thread-safe access to telemetry objects Tracer, Meter and BaggageManager.
public final class OpenTelemetry: Sendable {
  public static let version = "v1.21.0"
  
  /// Backward compatibility - deprecated global instance
  @available(*, deprecated, message: "Use instance-based approach with OpenTelemetryConfiguration")
  public static let instance = OpenTelemetry()
  
  private let configuration: OpenTelemetryConfiguration
  
  /// Registered tracerProvider from configuration
  public var tracerProvider: TracerProvider { configuration.tracerProvider }
  
  /// Registered MeterProvider from configuration  
  public var meterProvider: any MeterProvider { configuration.meterProvider }
  
  /// Registered LoggerProvider from configuration
  public var loggerProvider: LoggerProvider { configuration.loggerProvider }
  
  /// Registered BaggageManager from configuration
  public var baggageManager: BaggageManager { configuration.baggageManager }
  
  /// Registered propagators from configuration
  public var propagators: ContextPropagators { configuration.propagators }
  
  /// Context provider from configuration
  public var contextProvider: OpenTelemetryContextProvider { configuration.contextProvider }
  
  /// Feedback handler from configuration
  public var feedbackHandler: (@Sendable (String) -> Void)? { configuration.feedbackHandler }

  public init(configuration: OpenTelemetryConfiguration = OpenTelemetryConfiguration()) {
    self.configuration = configuration
  }
  
  private init() {
    self.configuration = OpenTelemetryConfiguration()
  }

  // MARK: - Deprecated static methods for backward compatibility
  
  @available(*, deprecated, renamed: "registerMeterProvider")
  public static func registerStableMeterProvider(meterProvider: any MeterProvider) {
    Self.registerMeterProvider(meterProvider: meterProvider)
  }

  @available(*, deprecated, message: "Create OpenTelemetry instance with configuration instead")
  public static func registerMeterProvider(meterProvider: any MeterProvider) {
    // For backward compatibility, this would need to be implemented with a global mutable state
    // This is intentionally left as a placeholder since the goal is to migrate away from this pattern
  }

  @available(*, deprecated, message: "Create OpenTelemetry instance with configuration instead")  
  public static func registerTracerProvider(tracerProvider: TracerProvider) {
    // For backward compatibility, this would need to be implemented with a global mutable state
    // This is intentionally left as a placeholder since the goal is to migrate away from this pattern
  }

  @available(*, deprecated, message: "Create OpenTelemetry instance with configuration instead")
  public static func registerLoggerProvider(loggerProvider: LoggerProvider) {
    // For backward compatibility, this would need to be implemented with a global mutable state
    // This is intentionally left as a placeholder since the goal is to migrate away from this pattern
  }

  @available(*, deprecated, message: "Create OpenTelemetry instance with configuration instead")
  public static func registerBaggageManager(baggageManager: BaggageManager) {
    // For backward compatibility, this would need to be implemented with a global mutable state
    // This is intentionally left as a placeholder since the goal is to migrate away from this pattern
  }

  @available(*, deprecated, message: "Create OpenTelemetry instance with configuration instead")
  public static func registerPropagators(textPropagators: [TextMapPropagator],
                                         baggagePropagator: TextMapBaggagePropagator) {
    // For backward compatibility, this would need to be implemented with a global mutable state
    // This is intentionally left as a placeholder since the goal is to migrate away from this pattern
  }

  @available(*, deprecated, message: "Create OpenTelemetry instance with configuration instead")
  public static func registerContextManager(contextManager: ContextManager) {
    // For backward compatibility, this would need to be implemented with a global mutable state
    // This is intentionally left as a placeholder since the goal is to migrate away from this pattern
  }

  @available(*, deprecated, message: "Create OpenTelemetry instance with configuration instead")
  public static func registerFeedbackHandler(_ handler: @escaping @Sendable (String) -> Void) {
    // For backward compatibility, this would need to be implemented with a global mutable state
    // This is intentionally left as a placeholder since the goal is to migrate away from this pattern
  }

  /// A utility method for testing which sets the context manager for the duration of the closure, and then reverts it before the method returns
  @available(*, deprecated, message: "Use instance-based approach with OpenTelemetryConfiguration")
  static func withContextManager<T>(_ manager: ContextManager, _ operation: () throws -> T) rethrows -> T {
    // This method is deprecated and should not be used in new code
    return try operation()
  }
}
