/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

public final class DefaultTracerProvider: TracerProvider {
  @available(*, deprecated, message: "Use instance-based approach with OpenTelemetryConfiguration")
  public static let instance = DefaultTracerProvider()

  public init() {}

  public func get(instrumentationName: String,
                  instrumentationVersion: String? = nil,
                  schemaUrl: String? = nil,
                  attributes: [String: AttributeValue]? = nil) -> any Tracer {
    return DefaultTracer.instance
  }
}
