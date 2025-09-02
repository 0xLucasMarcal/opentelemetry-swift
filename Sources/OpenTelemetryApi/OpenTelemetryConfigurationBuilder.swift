/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

public final class OpenTelemetryConfigurationBuilder: Sendable {
    private let tracerProvider: TracerProvider?
    private let meterProvider: (any MeterProvider & Sendable)?
    private let loggerProvider: LoggerProvider?
    private let baggageManager: BaggageManager?
    private let propagators: ContextPropagators?
    private let contextManager: ContextManager?
    private let feedbackHandler: (@Sendable (String) -> Void)?
    
    public init() {
        self.tracerProvider = nil
        self.meterProvider = nil
        self.loggerProvider = nil
        self.baggageManager = nil
        self.propagators = nil
        self.contextManager = nil
        self.feedbackHandler = nil
    }
    
    private init(
        tracerProvider: TracerProvider?,
        meterProvider: (any MeterProvider & Sendable)?,
        loggerProvider: LoggerProvider?,
        baggageManager: BaggageManager?,
        propagators: ContextPropagators?,
        contextManager: ContextManager?,
        feedbackHandler: (@Sendable (String) -> Void)?
    ) {
        self.tracerProvider = tracerProvider
        self.meterProvider = meterProvider
        self.loggerProvider = loggerProvider
        self.baggageManager = baggageManager
        self.propagators = propagators
        self.contextManager = contextManager
        self.feedbackHandler = feedbackHandler
    }
    
    public func with(tracerProvider: TracerProvider) -> OpenTelemetryConfigurationBuilder {
        OpenTelemetryConfigurationBuilder(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
    
    public func with(meterProvider: any MeterProvider & Sendable) -> OpenTelemetryConfigurationBuilder {
        OpenTelemetryConfigurationBuilder(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
    
    public func with(loggerProvider: LoggerProvider) -> OpenTelemetryConfigurationBuilder {
        OpenTelemetryConfigurationBuilder(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
    
    public func with(baggageManager: BaggageManager) -> OpenTelemetryConfigurationBuilder {
        OpenTelemetryConfigurationBuilder(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
    
    public func with(propagators: ContextPropagators) -> OpenTelemetryConfigurationBuilder {
        OpenTelemetryConfigurationBuilder(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
    
    public func with(contextManager: ContextManager) -> OpenTelemetryConfigurationBuilder {
        OpenTelemetryConfigurationBuilder(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
    
    public func with(feedbackHandler: @escaping @Sendable (String) -> Void) -> OpenTelemetryConfigurationBuilder {
        OpenTelemetryConfigurationBuilder(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
    
    public func build() -> OpenTelemetryConfiguration {
        OpenTelemetryConfiguration(
            tracerProvider: tracerProvider,
            meterProvider: meterProvider,
            loggerProvider: loggerProvider,
            baggageManager: baggageManager,
            propagators: propagators,
            contextManager: contextManager,
            feedbackHandler: feedbackHandler
        )
    }
}
