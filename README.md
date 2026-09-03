# ECEA-5316 Assignment 1: Sequencer Generic

Periodic real-time service sequencer examples for CU Boulder's Real-Time Embedded Systems course (ECEA-5316). Starter code is based on Sam Siewert's sequencer generic examples.

## What's here

| File | Purpose |
| --- | --- |
| `seqgenex0.c` | Example 0 sequencer (S1/S2/S3) with Rate Monotonic priorities |
| `seqgen.c`, `seqgen2.c` | Fuller multi-service sequencer examples |
| `seqgen.h` | Shared timing constants and service prototypes |
| `clock_times.c` | POSIX clock / resolution check utility |
| `raspbian-ccr/` | Kernel module to enable user-level cycle-counter access on ARM |
| `syslog-trace.txt`, `syslog-trace-2x.txt` | Sample sequencer syslog traces |

Example 0 rates (from `seqgenex0.c`):

- Sequencer @ 100 Hz
- Service 1 @ 50 Hz (`T=2`)
- Service 2 @ 10 Hz (`T=10`)
- Service 3 @ 6.67 Hz (`T=15`)

## Build

```bash
make
```

This produces `seqgenex0`, `seqgen`, `seqgen2`, and `clock_times`.

## Run

These programs use real-time scheduling (`SCHED_FIFO`) and typically need elevated privileges:

```bash
sudo ./seqgenex0
```

Before running, confirm CPU cores are online and the platform has usable timer resolution (`lscpu`, `/proc/timer_list`). Sequencer events are logged with `syslog`.

To remove build artifacts:

```bash
make clean
```
