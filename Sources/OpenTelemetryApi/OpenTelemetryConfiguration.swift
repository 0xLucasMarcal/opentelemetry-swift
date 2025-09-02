/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation
#if canImport(os.log)
import os.log
#endif

/// Immutable configuration for OpenTelemetry components
public struct OpenTelemetryConfiguration: Sendable {
    public let tracerProvider: TracerProvider
    public let meterProvider: any MeterProvider & Sendable
    public let loggerProvider: LoggerProvider
    public let baggageManager: BaggageManager
    public let propagators: ContextPropagators
    public let contextProvider: OpenTelemetryContextProvider
    public let feedbackHandler: (@Sendable (String) -> Void)?
    
    public init(
        tracerProvider: TracerProvider? = nil,
        meterProvider: (any MeterProvider & Sendable)? = nil,
        loggerProvider: LoggerProvider? = nil,
        baggageManager: BaggageManager? = nil,
        propagators: ContextPropagators? = nil,
        contextManager: ContextManager? = nil,
        feedbackHandler: (@Sendable (String) -> Void)? = nil
    ) {
        self.tracerProvider = tracerProvider ?? DefaultTracerProvider()
        self.meterProvider = meterProvider ?? DefaultMeterProvider()
        self.loggerProvider = loggerProvider ?? DefaultLoggerProvider()
        self.baggageManager = baggageManager ?? DefaultBaggageManager()
        self.propagators = propagators ?? DefaultContextPropagators(
            textPropagators: [W3CTraceContextPropagator()],
            baggagePropagator: W3CBaggagePropagator()
        )
        
        let manager: ContextManager
        if let contextManager = contextManager {
            manager = contextManager
        } else {
            #if canImport(os.activity)
                manager = ActivityContextManager()
            #elseif canImport(_Concurrency)
                manager = TaskLocalContextManager()
            #else
                #error("No default ContextManager is supported on the target platform")
            #endif
        }
        
        self.contextProvider = OpenTelemetryContextProvider(contextManager: manager)
        
        #if canImport(os.log)
            self.feedbackHandler = feedbackHandler ?? { message in
                os_log("%{public}s", message)
            }
        #else
            self.feedbackHandler = feedbackHandler
        #endif
    }
}
