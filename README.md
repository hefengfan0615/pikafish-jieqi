# Pikafish-Jieqi

> A strong UCI Jieqi (uncovering chess / dark xiangqi) engine powered by the **AB-JChess V8.2 NNUE** neural network, derived from [AB-JChess](https://github.com/lxsgx23/AB-JChess) and [Pikafish](https://github.com/official-pikafish/Pikafish).

This repository replaces the original `nnue` evaluation with the new **ABJCHESSV82** network architecture from AB-JChess:
feature encoder (`HalfKAv2_hm_jieqi_v8`, 31776 features), 2048-wide transformer accumulator, 16 PSQT buckets, and 16 runtime eval heads, plus probability score/mass tables.

## Features

- **NNUE Evaluation (V8.2)** — efficiently updatable neural network scoring using the `abjnnue` runtime (ABJCHESSV82 package format).
- **UCI Protocol** — compatible with any UCI-capable GUI.
- **Configurable EvalFile** — load a custom `.nnue` network via the `EvalFile` UCI option (default `abjchess-20260911.nnue`).
- **Cross-platform** — builds on Linux, Windows, and macOS.

## Usage

The engine expects an `.nnue` file for evaluation. The default `EvalFile` is `abjchess-20260911.nnue`.

```text
setoption name EvalFile value /path/to/abjchess-20260911.nnue
uci
isready
position startpos
go movetime 5000
```

The start FEN is the standard Jieqi face-down layout:

```text
xxxxkxxxx/9/1x5x1/x1x1x1x1x/9/9/X1X1X1X1X/1X5X1/9/XXXXKXXXX w R2A2C2P5N2B2r2a2c2p5n2b2 0 1
```

## NNUE network file

- Download `abjchess-20260911.nnue` from the [Release assets](https://github.com/hefengfan0615/pikafish-jieqi/releases).
- Place it next to the engine binary (or set `EvalFile` to its absolute path).

## Compiling

```bash
cd src
make -j build
```

## CI test

The GitHub Actions workflow [build-and-test.yml](.github/workflows/build-and-test.yml) compiles the engine,
downloads the NNUE from the repository Release, and runs a `go movetime 5000` smoke test with full engine output.

## License

GNU General Public License v3.0.
