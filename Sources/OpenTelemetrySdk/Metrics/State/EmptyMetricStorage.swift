//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import OpenTelemetryApi

public final class EmptyMetricStorage: SynchronousMetricStorageProtocol, Sendable {
  public func recordLong(value: Int, attributes: [String: OpenTelemetryApi.AttributeValue]) {}

  public func recordDouble(value: Double, attributes: [String: OpenTelemetryApi.AttributeValue]) {}

  public init() {}

  public let metricDescriptor: MetricDescriptor = .init(name: "", description: "", unit: "")

  public func collect(resource: Resource, scope: InstrumentationScopeInfo, startEpochNanos: UInt64, epochNanos: UInt64) -> MetricData {
    MetricData.empty
  }

  public func isEmpty() -> Bool {
    true
  }
}
