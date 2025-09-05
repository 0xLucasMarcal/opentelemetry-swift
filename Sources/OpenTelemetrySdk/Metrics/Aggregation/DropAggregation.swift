//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import OpenTelemetryApi

public final class DropAggregation: Aggregation, Sendable {
  public init() {}

  public func createAggregator(descriptor: InstrumentDescriptor, exemplarFilter: ExemplarFilter) -> any Aggregator {
    DropAggregator()
  }

  public func isCompatible(with descriptor: InstrumentDescriptor) -> Bool {
    true
  }
}
