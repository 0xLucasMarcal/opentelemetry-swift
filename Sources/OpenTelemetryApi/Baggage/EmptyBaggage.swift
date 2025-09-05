/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

/// An immutable implementation of the Baggage that does not contain any entries.
final class EmptyBaggage: Baggage, @unchecked Sendable {
  public init() {}



  static func baggageBuilder() -> BaggageBuilder {
    return EmptyBaggageBuilder()
  }

  func getEntries() -> [Entry] {
    return [Entry]()
  }

  func getEntryValue(key: EntryKey) -> EntryValue? {
    return nil
  }
}
