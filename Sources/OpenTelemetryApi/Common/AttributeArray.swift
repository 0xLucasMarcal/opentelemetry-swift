//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

open class AttributeArray: Hashable, Codable, @unchecked Sendable {
  public private(set) var values: [AttributeValue]
  @available(*, deprecated, message: "Create new instances instead of using shared instance")
  public static let empty = AttributeArray()
  public var description: String {
    values.description
  }

  public init() {
    values = [AttributeValue]()
  }

  public required init(values: [AttributeValue]) {
    self.values = values
  }

  public static func == (lhs: AttributeArray, rhs: AttributeArray) -> Bool {
    return lhs.values == rhs.values
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(values)
  }
}
