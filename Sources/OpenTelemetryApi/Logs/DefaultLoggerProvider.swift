/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

public final class DefaultLoggerProvider: LoggerProvider {
  public init() {}

  public func get(instrumentationScopeName: String) -> Logger {
    return loggerBuilder(instrumentationScopeName: instrumentationScopeName).build()
  }

  public func loggerBuilder(instrumentationScopeName: String) -> LoggerBuilder {
    return NoopLoggerBuilder(false)
  }
}

private final class NoopLoggerBuilder: LoggerBuilder {
  private let hasDomain: Bool

  fileprivate init(_ hasDomain: Bool) {
    self.hasDomain = hasDomain
  }

  public func setEventDomain(_ eventDomain: String) -> Self {
    // Return a new builder with the appropriate domain setting
    if eventDomain.isEmpty {
      return NoopLoggerBuilder(false) as! Self
    }
    return NoopLoggerBuilder(true) as! Self
  }

  public func setSchemaUrl(_ schemaUrl: String) -> Self {
    return self
  }

  public func setInstrumentationVersion(_ instrumentationVersion: String) -> Self {
    return self
  }

  public func setIncludeTraceContext(_ includeTraceContext: Bool) -> Self {
    return self
  }

  public func setAttributes(_ attributes: [String: AttributeValue]) -> Self {
    return self
  }

  public func build() -> Logger {
    return DefaultLogger(hasDomain: hasDomain)
  }
}
