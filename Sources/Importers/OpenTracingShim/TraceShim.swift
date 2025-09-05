/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation
import OpenTelemetryApi
import OpenTelemetrySdk
import Opentracing

public class TraceShim {
  public private(set) var otTracer: OTTracer

  public init() {
    otTracer = TraceShim.createTracerShim()
  }

  public static func createTracerShim() -> OTTracer {
    return TracerShim(telemetryInfo: TelemetryInfo(tracer: TraceShim.getTracer(tracerProvider: DefaultTracerProvider()),
                                                   baggageManager: DefaultBaggageManager(),
                                                   propagators: DefaultContextPropagators(textPropagators: [W3CTraceContextPropagator()], baggagePropagator: W3CBaggagePropagator())))
  }

  public static func createTracerShim(tracerProvider: TracerProvider, baggageManager: BaggageManager) -> OTTracer {
    return TracerShim(telemetryInfo: TelemetryInfo(tracer: TraceShim.getTracer(tracerProvider: tracerProvider),
                                                   baggageManager: baggageManager,
                                                   propagators: DefaultContextPropagators(textPropagators: [W3CTraceContextPropagator()], baggagePropagator: W3CBaggagePropagator())))
  }

  private static func getTracer(tracerProvider: TracerProvider) -> Tracer {
    tracerProvider.get(instrumentationName: "opentracingshim")
  }
}
