# ECEA-5316 Assignment 1: Sequencer Generic

Emulates the Example 0 timing diagram (`sched-example-0-safe-within-LUB-disharmonic`) with three `SCHED_FIFO` service threads and Fibonacci fake workloads.

## Example 0 schedule (time unit = 10 ms)

| Service | Period T | Execution C | Deadline | Sequencer rate |
| --- | --- | --- | --- | --- |
| Sequencer | 1 | — | — | 100 Hz |
| S1 / Thread 1 | 2 (20 ms) | 1 (10 ms) | T | every 2nd tick (50 Hz) |
| S2 / Thread 2 | 10 (100 ms) | 1 (10 ms) | T | every 10th tick (10 Hz) |
| S3 / Thread 3 | 15 (150 ms) | 2 (20 ms) | T | every 15th tick (6.67 Hz) |

Utilization: `U = 1/2 + 1/10 + 2/15 ≈ 0.733`, which is below the n=3 RM LUB (~0.780). Verify this chart in Cheddar using the course Excel file.

## Build

```bash
make seqgenex0
```

## Run

Needs `SCHED_FIFO` privileges. All four threads are pinned to one CPU core.

```bash
sudo ./seqgenex0
./capture-syslog.sh assignment1-syslog.txt
```

The default run is 2400 sequencer periods at 100 Hz (about 24 seconds).

## Required syslog format

Every program log is tagged `[COURSE:2][ASSIGNMENT:1]`. Service lines look like:

```text
[COURSE:2][ASSIGNMENT:1]: Thread 1 start 3 @ 0.040000 sec on core 3
```

`capture-syslog.sh` writes `uname -a` as the first line of the submission file, then the tagged events.

To remove build artifacts:

```bash
make clean
```
