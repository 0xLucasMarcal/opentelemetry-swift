//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public final class DefaultAggregation: Aggregation, Sendable {
  public init() {}

  public func createAggregator(descriptor: InstrumentDescriptor, exemplarFilter: ExemplarFilter) -> any Aggregator {
    resolve(for: descriptor).createAggregator(descriptor: descriptor, exemplarFilter: exemplarFilter)
  }

  public func isCompatible(with descriptor: InstrumentDescriptor) -> Bool {
    resolve(for: descriptor).isCompatible(with: descriptor)
  }

  private func resolve(for instrument: InstrumentDescriptor) -> Aggregation {
    switch instrument.type {
    case .counter, .upDownCounter, .observableCounter, .observableUpDownCounter:
      return SumAggregation()
    case .histogram:
      // Use advisory bucket boundaries if available, otherwise use default
      if let advisoryBoundaries = instrument.explicitBucketBoundariesAdvice {
        return ExplicitBucketHistogramAggregation(bucketBoundaries: advisoryBoundaries)
      } else {
        return ExplicitBucketHistogramAggregation(bucketBoundaries: ExplicitBucketHistogramAggregation.DEFAULT_BOUNDARIES)
      }
    case .observableGauge, .gauge:
      return LastValueAggregation()
    }
  }
}
