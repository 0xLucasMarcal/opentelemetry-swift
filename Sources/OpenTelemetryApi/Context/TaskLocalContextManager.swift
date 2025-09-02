/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

#if canImport(_Concurrency)
  /// A context manager utilizing a task local for tracking active context.
  ///
  /// Unlike the `os.activity` context manager, this class does not handle setting and removing context manually.
  /// You must always use the closure based APIs for setting active context when using this manager.
  /// The `OpenTelemetryConcurrency` module assists with this by hiding the imperative APIs by default.
  ///
  /// - Note: This restriction means this class is not suitable for dynamic context injection.
  /// If you require dynamic context injection, you will need a custom context manager.
  @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
  public final class TaskLocalContextManager: ContextManager {
    @available(*, deprecated, message: "Use instance-based approach with OpenTelemetryConfiguration")
    package static let instance = TaskLocalContextManager()

    @TaskLocal static var context = [String: any Sendable]()

    public init() {}

    public func getCurrentContextValue(forKey key: OpenTelemetryContextKeys) -> AnyObject? {
      Self.context[key.rawValue] as? AnyObject
    }

    public func setCurrentContextValue(forKey: OpenTelemetryContextKeys, value: AnyObject) {}

    public func removeContextValue(forKey: OpenTelemetryContextKeys, value: AnyObject) {}

    public func withCurrentContextValue<T>(forKey key: OpenTelemetryContextKeys, value: AnyObject?, _ operation: () async throws -> T) async rethrows -> T {
      var context = Self.context
      if let value = value {
        context[key.rawValue] = unsafeBitCast(value, to: (any Sendable).self)
      } else {
        context[key.rawValue] = nil
      }

      return try await Self.$context.withValue(context, operation: operation)
    }

    public func withCurrentContextValue<T>(forKey key: OpenTelemetryContextKeys, value: AnyObject?, _ operation: () throws -> T) rethrows -> T {
      var context = Self.context
      if let value = value {
        context[key.rawValue] = unsafeBitCast(value, to: (any Sendable).self)
      } else {
        context[key.rawValue] = nil
      }

      return try Self.$context.withValue(context, operation: operation)
    }
  }
#endif
