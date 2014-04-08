cl-earthquake
=============

Notify earthquakes recently happened.

May including chinese earthquake data in the future.

**Attention: No further functions are planed! I'll never update these code unless it crashes on my computer(If it crashes on my computer and it did'nt updated, you may think i'm not taking it's fun anymore).**

Requirements:

* notify-send
* Quicklisp
* drakma(in Quicklisp)
* s-xml(in Quicklisp)

Compile:

1. Start your SBCL
2. Load main-xml.lisp
3. Type:

```lisp
(save-lisp-and-die "cl-earthquake-xml" :executable t :toplevel #'main)
```
