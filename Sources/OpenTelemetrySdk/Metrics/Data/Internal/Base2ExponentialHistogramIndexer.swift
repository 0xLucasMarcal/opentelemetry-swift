//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import OpenTelemetryApi

public final class Base2ExponentialHistogramIndexer: Codable, @unchecked Sendable {

  private let scale: Int
  private let scaleFactor: Double

  init(scale: Int) {
    self.scale = scale
    scaleFactor = Self.computeScaleFactor(scale: scale)
  }

  func get(_ scale: Int) -> Base2ExponentialHistogramIndexer {
    // For simplicity and concurrency safety, just create a new instance
    return Base2ExponentialHistogramIndexer(scale: scale)
  }

  func computeIndex(_ value: Double) -> Int {
    let absValue = abs(value)
    if scale > 0 {
      return indexByLogarithm(absValue)
    }
    if scale == 0 {
      return mapToIndexScaleZero(absValue)
    }
    return mapToIndexScaleZero(absValue) >> -scale
  }

  func indexByLogarithm(_ value: Double) -> Int {
    Int(ceil(log(value) * scaleFactor) - 1)
  }

  func mapToIndexScaleZero(_ value: Double) -> Int {
    let raw = value.bitPattern
    var rawExponent = Int((Int64(raw) & Int64(0x7FF0_0000_0000_0000)) >> Int.significandWidth)
    let rawSignificand = Int(Int64(raw) & Int64(0xF_FFFF_FFFF_FFFF))
    if rawExponent == 0 {
      rawExponent -= (rawSignificand - 1).leadingZeroBitCount - Int.exponentWidth - 1
    }
    let ieeeExponent = rawExponent - Int.exponentBias
    if rawSignificand == 0 {
      return ieeeExponent - 1
    }
    return ieeeExponent
  }

  static func computeScaleFactor(scale: Int) -> Double {
    Double.logBase2E * pow(2.0, Double(scale))
  }
}

extension Int {
  static let exponentBias = 1023
  static let significandWidth = 52
  static let exponentWidth = 11
}

extension Double {
  static let logBase2E = 1.0 / log(2)
}
