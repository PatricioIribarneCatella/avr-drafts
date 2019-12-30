# avr-drafts

Some drafts of AVR examples (Laboratorio de Microcomputadoras (61.09) - _FIUBA_)

### Contents

- average (with RAM and ROM memory usage)
- bubble-sort
- date-sum (add _days_ to a calendar date)
- division (signed and unsigned integers)
- flip-flop (simulation of a JK bi-stable)
- interrupt (external interrupt handling)
- serial (serial communication using the USART protocol)

### Compile

```bash
$ cd example
$ make
```

### Run

It uses the [_simavr_](https://github.com/buserror/simavr) simulator for debugging and running the code. It can also be uploaded to an _AVR_ chip with the command: `make upload`.

The _Makefile_ was generated using [_avr-make_](https://github.com/PatricioIribarneCatella/avr-make) and a _README_ can be found there for more information on how to run the simulator and the debugger (_GDB_).

