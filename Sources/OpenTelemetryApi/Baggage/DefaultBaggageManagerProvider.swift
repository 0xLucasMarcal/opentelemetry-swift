/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

/// No-op implementations of BaggageManager.
public final class DefaultBaggageManagerProvider: BaggageManagerProvider, @unchecked Sendable {
  @available(*, deprecated, message: "Use instance-based approach with OpenTelemetryConfiguration")
  public static let instance = DefaultBaggageManagerProvider()

  public init() {}

  public func create() -> BaggageManager {
    return DefaultBaggageManager()
  }
}
