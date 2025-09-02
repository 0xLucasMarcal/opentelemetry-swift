/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

open class AttributeSet: Hashable, Codable, @unchecked Sendable {
  public private(set) var labels: [String: AttributeValue]

  /// Empty LabelSet.
  @available(*, deprecated, message: "Create new instances instead of using shared instance")
  public static let empty = AttributeSet()

  public init() {
    labels = [String: AttributeValue]()
  }

  public required init(labels: [String: AttributeValue]) {
    self.labels = labels
  }

  public static func == (lhs: AttributeSet, rhs: AttributeSet) -> Bool {
    return lhs.labels == rhs.labels
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(labels)
  }
}
