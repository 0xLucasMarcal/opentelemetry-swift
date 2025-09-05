//
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum Aggregations {
  public static func drop() -> Aggregation {
    DropAggregation()
  }

  public static func defaultAggregation() -> Aggregation {
    DefaultAggregation()
  }

  public static func sum() -> Aggregation {
    SumAggregation()
  }

  public static func lastValue() -> Aggregation {
    LastValueAggregation()
  }

  public static func explicitBucketHistogram() -> Aggregation {
    ExplicitBucketHistogramAggregation(bucketBoundaries: ExplicitBucketHistogramAggregation.DEFAULT_BOUNDARIES)
  }

  public static func explicitBucketHistogram(buckets: [Double]) -> Aggregation {
    ExplicitBucketHistogramAggregation(bucketBoundaries: buckets)
  }

  static func base2ExponentialBucketHistogram() -> Aggregation {
    Base2ExponentialHistogramAggregation(maxBuckets: 160, maxScale: 20)
  }

  static func base2ExponentialBucketHistogram(maxBuckets: Int, maxScale: Int) -> Aggregation {
    Base2ExponentialHistogramAggregation(maxBuckets: maxBuckets, maxScale: maxScale)
  }
}
