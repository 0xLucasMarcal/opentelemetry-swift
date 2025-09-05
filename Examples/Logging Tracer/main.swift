/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation
import OpenTelemetryApi

Logger.printHeader()

// Create OpenTelemetry configuration with custom tracer provider
let config = OpenTelemetryConfigurationBuilder()
  .with(tracerProvider: LoggingTracerProvider())
  .build()

let openTelemetry = OpenTelemetry(configuration: config)

let tracer = openTelemetry.tracerProvider.get(instrumentationName: "ConsoleApp", instrumentationVersion: "semver:1.0.0")

let span1 = tracer.spanBuilder(spanName: "Main (span1)").startSpan()
openTelemetry.contextProvider.setActiveSpan(span1)
let semaphore = DispatchSemaphore(value: 0)
DispatchQueue.global().async {
  // Get tracer in the async context to avoid actor isolation issues
  let asyncTracer = openTelemetry.tracerProvider.get(instrumentationName: "ConsoleApp", instrumentationVersion: "semver:1.0.0")
  let span2 = asyncTracer.spanBuilder(spanName: "Main (span2)").startSpan()
  openTelemetry.contextProvider.setActiveSpan(span2)
  openTelemetry.contextProvider.activeSpan?.setAttribute(key: "myAttribute", value: "myValue")
  sleep(1)
  span2.end()
  semaphore.signal()
}

span1.end()

semaphore.wait()
