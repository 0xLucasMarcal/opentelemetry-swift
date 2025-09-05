/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

public protocol Logger: Sendable {
  func eventBuilder(name: String) -> EventBuilder
  func logRecordBuilder() -> LogRecordBuilder
}
