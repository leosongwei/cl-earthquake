cl-earthquake
=============

Notify earthquakes recently happened.

* "notify-send" is required.
* Quicklisp is required.
* drakma is required(in Quicklisp).


Compile:

1. Start your SBCL

2. Load main-xml.lisp

3. Type:

```lisp
(save-lisp-and-die "cl-earthquake-xml" :executable t :toplevel #'main)
```
