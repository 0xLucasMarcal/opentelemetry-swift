/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

public final class DefaultLogger: Logger {
  private let hasDomain: Bool

  public init(hasDomain: Bool) {
    self.hasDomain = hasDomain
  }

  public func eventBuilder(name: String) -> EventBuilder {
    if !hasDomain {
      /// log error
    }
    return NoopLogRecordBuilder()
  }

  public func logRecordBuilder() -> LogRecordBuilder {
    return NoopLogRecordBuilder()
  }

  private final class NoopLogRecordBuilder: EventBuilder {
    func setTimestamp(_ timestamp: Date) -> Self {
      return self
    }

    func setObservedTimestamp(_ observed: Date) -> Self {
      return self
    }

    func setSpanContext(_ context: SpanContext) -> Self {
      return self
    }

    func setSeverity(_ severity: Severity) -> Self {
      return self
    }

    func setBody(_ body: AttributeValue) -> Self {
      return self
    }

    func setAttributes(_ attributes: [String: AttributeValue]) -> Self {
      return self
    }

    func setData(_ attributes: [String: AttributeValue]) -> Self {
      return self
    }

    func emit() {}
  }
}
