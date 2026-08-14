# TruGame — game engine (sports)

TruGame runs the sim, packs franchise state with TRU8, and seals the save with Chamber.

Drive SoT (2026-08-14): **TruGame v0.3**  
Inquire: **corey@slidphilabs.com** · subject `TruGame`

| File | Role |
|------|------|
| `drive_v03/trugame_core.py` | BitStream WorldState + residual split |
| `drive_v03/trugame_streamer.py` | Non-destructive packer → `.trugame` |
| `drive_v03/tru8_optimizer.py` | benefit_check · group · delta · dedup |
| `drive_v03/bench_results.json` | +13.5% group, +22.5% gain from grouping |
| `json_chamber/` | BitStream · StPetersCloak · Creator + optimizer |
| `pack/tru8_pack.py` | TG8 pack using public TRU8 tokens + residual transport |
| `tru8/` | Public TRU8 demo tokens (from `projects/TRU8`) |
| `chamber/` | Browser AES-GCM seal |
| `src/index.mjs` | JS sports bridge (TRU8 pack + benefit check) |
| `lab/zrw/` | Lab series |

## Path

```
game assets / franchise state
  → tru8_benefit_check
  → TRU8 pack (tokens + residual)
  → Chamber seal (device vault)
  → originals stay; streamer writes trugame_dist/
```

Production residual coefficients stay licensed.  
Contact: corey@slidphilabs.com

## Smoke

```bash
cd packages/trugame
npm run smoke:tru8
npm run smoke:py
```

## NFL wire

1. `packages/sim-nfl` engine
2. Franchise autosave → `src/index.mjs` `packFranchiseJson` + Chamber seal
3. Asset levels → Python `TruGameStreamer.pack_level` with TRU8 compress_fn
