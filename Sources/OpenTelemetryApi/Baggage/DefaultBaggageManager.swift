/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

/// No-op implementations of BaggageManager.
public final class DefaultBaggageManager: BaggageManager {
  public init() {}



  public func baggageBuilder() -> BaggageBuilder {
    return DefaultBaggageBuilder()
  }

  public func getCurrentBaggage() -> Baggage? {
    // Note: This method cannot work without an OpenTelemetry instance
    // Users should access baggage through their OpenTelemetry instance's contextProvider
    return nil
  }
}
