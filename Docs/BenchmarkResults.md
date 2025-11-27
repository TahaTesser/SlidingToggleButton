# SlidingToggleButton Benchmark Results

## Results (November 27, 2025)

| Metric | Value | Target |
|--------|-------|--------|
| First Render Time | 0.57ms | < 16.67ms (60fps) |
| State Toggle Latency | 0.02ms | < 16.67ms (60fps) |
| Memory Footprint | 152 bytes | < 512 bytes |
| View Hierarchy Depth | 194 levels | < 250 levels |
| Rapid Toggle (1000x) | 7.83ms | < 1000ms |

**Environment:** Apple Silicon (arm64e-apple-macos14.0), Swift 6.0

## Running Benchmarks

```bash
swift test --filter BenchmarkTests
```
