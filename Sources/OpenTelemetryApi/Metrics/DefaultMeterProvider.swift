//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

@available(*, deprecated, renamed: "DefaultMeterProvider")
public typealias DefaultStableMeterProvider = DefaultMeterProvider

public final class DefaultMeterProvider: MeterProvider, @unchecked Sendable {
  public static func noop() -> NoopMeterBuilder {
    NoopMeterBuilder()
  }

  public init() {}

  public func get(name: String) -> DefaultMeter {
    DefaultMeter()
  }

  public func meterBuilder(name: String) -> NoopMeterBuilder {
    NoopMeterBuilder()
  }

  public final class NoopMeterBuilder: MeterBuilder {
    public func setSchemaUrl(schemaUrl: String) -> Self {
      self
    }

    public func setInstrumentationVersion(instrumentationVersion: String) -> Self {
      self
    }

    public func setAttributes(attributes: [String: AttributeValue]) -> Self {
      self
    }

    public func build() -> DefaultMeter {
      DefaultMeter()
    }
  }


}
