//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import OpenTelemetryApi

public final class RegisteredReader: Equatable, Hashable, @unchecked Sendable {
  public let id: Int32
  public let reader: MetricReader
  public let registry: ViewRegistry
  public var lastCollectedEpochNanos: UInt64 = 0

  init(reader: MetricReader, registry: ViewRegistry) {
    // Use a simple random ID to avoid concurrency issues with counters
    id = Int32.random(in: 1...Int32.max)

    self.reader = reader
    self.registry = registry
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func == (lhs: RegisteredReader, rhs: RegisteredReader) -> Bool {
    if lhs === rhs {
      return true
    }
    return lhs.id == rhs.id
  }
}
