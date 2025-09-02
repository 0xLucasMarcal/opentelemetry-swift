/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

/// No-op implementations of BaggageManager.
public final class DefaultBaggageManager: BaggageManager {
  public init() {}

  ///  Returns a BaggageManager singleton that is the default implementation for
  ///  BaggageManager.
  @available(*, deprecated, message: "Use instance-based approach with OpenTelemetryConfiguration")
  public static let instance = DefaultBaggageManager()

  public func baggageBuilder() -> BaggageBuilder {
    return DefaultBaggageBuilder()
  }

  public func getCurrentBaggage() -> Baggage? {
    return OpenTelemetry.instance.contextProvider.activeBaggage
  }
}
