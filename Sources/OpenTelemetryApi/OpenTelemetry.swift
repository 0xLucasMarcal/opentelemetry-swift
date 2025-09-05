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
  
  /// Default context provider for SDK components that need context access
  /// This provides a minimal singleton-like access without the full singleton pattern
  public static let defaultContextProvider = OpenTelemetryContextProvider(
    contextManager: {
      #if canImport(os.activity)
        return ActivityContextManager()
      #elseif canImport(_Concurrency)
        return TaskLocalContextManager()
      #else
        #error("No default ContextManager is supported on the target platform")
      #endif
    }()
  )
  
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


}
