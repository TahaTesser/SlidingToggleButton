# SlidingToggleButton Benchmark Results

## Results (November 28, 2025)

### 2-Icon Mode

| Metric | Value | Target |
|--------|-------|--------|
| First Render Time | 0.48ms | < 16.67ms (60fps) |
| State Toggle Latency | 0.03ms | < 16.67ms (60fps) |
| Memory Footprint | 96 bytes | < 512 bytes |
| Rapid Toggle (1000x) | 5.53ms | < 1000ms |

### 3-Icon Mode

| Metric | Value | Target |
|--------|-------|--------|
| First Render Time | 0.50ms | < 16.67ms (60fps) |
| State Toggle Latency | 0.02ms | < 16.67ms (60fps) |
| Memory Footprint | 96 bytes | < 512 bytes |
| Rapid Toggle (1000x) | 5.53ms | < 1000ms |

**Environment:** Apple Silicon (arm64e-apple-macos14.0), Swift 6.0

## Running Benchmarks

```bash
swift test --filter BenchmarkTests
```
