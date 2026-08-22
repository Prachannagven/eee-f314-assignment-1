# Summary of Keys
- Sequence Key: 0013 -> 4 -> 0100 & 0010
- 4 Bit Serial Password: 0000 0000 0001 0011 -> 0011

# Task 1
## Coverage Table for Sequence Generator
| Test           | Purpose                                      |
| -------------- | -------------------------------------------- |
| `0010`         | Direct detection of first pattern            |
| `0100`         | Direct detection of second pattern           |
| `0010010`      | Overlapping `0010` candidate                 |
| `0100100`      | Overlapping `0100` candidate                 |
| `00100`        | Pattern followed by partial candidate        |
| `01001`        | Pattern followed by failed/partial candidate |
| `00000000`     | Continuous zeros                             |
| `11111111`     | Continuous ones                              |
| `00110010`     | Near miss + valid `0010`                     |
| `01010010`     | Near miss + valid `0010`                     |
| `11001001`     | Pattern embedded in arbitrary data           |
| `10100100`     | Pattern embedded in arbitrary data           |
| `00010000`     | Zero-heavy / partial-prefix behavior         |
| `11101111`     | One-heavy behavior                           |
| `001001000100` | Multiple detections                          |
| `010000100010` | Multiple detections, mixed patterns          |

