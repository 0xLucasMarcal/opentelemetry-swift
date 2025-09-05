/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

/// No-op implementation of the Tracer
public final class DefaultTracer: Tracer, @unchecked Sendable {
  public init() {}

  public func spanBuilder(spanName: String) -> SpanBuilder {
    return PropagatedSpanBuilder(tracer: self, spanName: spanName)
  }
}
