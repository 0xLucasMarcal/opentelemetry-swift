//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import OpenTelemetryApi

public final class DropAggregator: Aggregator, Sendable {
  private static func emptyPointData() -> PointData {
    PointData(startEpochNanos: 0, endEpochNanos: 0, attributes: [String: AttributeValue](), exemplars: [ExemplarData]())
  }

  public func createHandle() -> AggregatorHandle {
    AggregatorHandle(exemplarReservoir: ExemplarReservoirCollection.doubleNoSamples())
  }

  public func diff(previousCumulative: PointData, currentCumulative: PointData) -> PointData {
    Self.emptyPointData()
  }

  public func toPoint(measurement: Measurement) -> PointData {
    Self.emptyPointData()
  }

  public func toMetricData(resource: Resource, scope: InstrumentationScopeInfo, descriptor: MetricDescriptor, points: [PointData], temporality: AggregationTemporality) -> MetricData {
    MetricData.empty
  }
}
