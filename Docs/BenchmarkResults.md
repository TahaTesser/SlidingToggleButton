# SlidingToggleButton Benchmark Results

## Overview

This document contains benchmark results for the SlidingToggleButton Swift package. Benchmarks are run using Swift Testing framework.

## Test Environment

| Attribute | Value |
|-----------|-------|
| Platform | macOS 14+ / iOS 17+ |
| Swift Version | 6.0 |
| Test Framework | Swift Testing |

## Benchmark Categories

### 1. Initialization Benchmarks

#### Minimal Initialization (1000 iterations)
Creates button instances with only required parameters.

| Metric | Target | Description |
|--------|--------|-------------|
| Time | < 1000ms | Total time for 1000 initializations |
| Per Instance | < 1ms | Average time per initialization |

#### Full Custom Initialization (1000 iterations)
Creates button instances with all custom parameters specified.

| Metric | Target | Description |
|--------|--------|-------------|
| Time | < 1000ms | Total time for 1000 initializations |
| Per Instance | < 1ms | Average time per initialization |

### 2. Orientation Benchmarks

#### Horizontal vs Vertical Initialization (1000 iterations each)
Compares initialization performance between horizontal and vertical orientations.

| Orientation | Target |
|-------------|--------|
| Horizontal | < 1000ms |
| Vertical | < 1000ms |

### 3. State Management Benchmarks

#### Binding Updates (10000 iterations)
Measures the performance of toggling the bound value.

| Metric | Target | Description |
|--------|--------|-------------|
| Time | < 500ms | Total time for 10000 toggles |
| Per Toggle | < 0.05ms | Average time per toggle |

### 4. View Generation Benchmarks

#### Body Generation (100 iterations)
Measures the time to generate the SwiftUI body.

| Metric | Target | Description |
|--------|--------|-------------|
| Time | < 1000ms | Total time for 100 body generations |
| Per Generation | < 10ms | Average time per generation |

### 5. Memory Benchmarks

#### Multiple Instance Creation (1000 instances)
Creates and holds 1000 button instances in memory.

| Metric | Target | Description |
|--------|--------|-------------|
| Time | < 1000ms | Total time to create all instances |
| Instance Count | 1000 | Verify all instances created |

#### Defaults Access (100000 iterations)
Measures the overhead of accessing static default values.

| Metric | Target | Description |
|--------|--------|-------------|
| Time | < 500ms | Total time for 100000 accesses |
| Per Access | < 0.005ms | Average time per access |

## Running Benchmarks

To run the benchmark tests:

```bash
# Run all tests including benchmarks
swift test

# Run only benchmark tests
swift test --filter BenchmarkTests

# Run with verbose output to see timing results
swift test --filter BenchmarkTests 2>&1 | grep -E "(Benchmark|ms)"
```

## Results History

### Latest Results (Recorded: November 2024)

| Test | Result | Status |
|------|--------|--------|
| Minimal Initialization (1000x) | 1.80ms | PASS |
| Full Custom Initialization (1000x) | 1.01ms | PASS |
| Horizontal Initialization (1000x) | 1.84ms | PASS |
| Vertical Initialization (1000x) | 0.65ms | PASS |
| Binding Updates (10000x) | 1.33ms | PASS |
| Body Generation (100x) | 2.50ms | PASS |
| Multiple Instance Creation (1000x) | 1.76ms | PASS |
| Defaults Access (100000x) | 8.70ms | PASS |

> **Note**: Run `swift test --filter BenchmarkTests` to update these results.
> Results recorded on Apple Silicon (arm64e-apple-macos14.0)

## Performance Guidelines

### Acceptable Performance

- Initialization: < 1ms per instance
- Binding updates: < 0.1ms per update
- Body generation: < 10ms per generation
- Defaults access: < 0.01ms per access

### Performance Considerations

1. **SwiftUI View Lifecycle**: The button uses `@State` for internal state management, which is handled efficiently by SwiftUI.

2. **Animation Performance**: Animations use `.spring(response: 0.3)` which is optimized for smooth 60fps rendering.

3. **Symbol Effects**: The `phaseAnimator` and `symbolEffect` modifiers leverage Metal rendering for efficient GPU-accelerated animations.

4. **Memory Footprint**: Each button instance has a minimal memory footprint with only essential stored properties.
