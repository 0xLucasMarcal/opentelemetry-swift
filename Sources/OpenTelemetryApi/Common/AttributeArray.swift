//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

open class AttributeArray: Hashable, Codable, @unchecked Sendable {
  public private(set) var values: [AttributeValue]

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
