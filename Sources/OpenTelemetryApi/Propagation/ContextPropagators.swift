/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

import Foundation

public protocol ContextPropagators: Sendable {
  var textMapPropagator: TextMapPropagator { get }
  var textMapBaggagePropagator: TextMapBaggagePropagator { get }
}
