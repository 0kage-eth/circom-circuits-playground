# Circom Notes

## Signals
- Signal could be of 3 types - input / intermediate / output
- input signal can be public or private (default)
- a public input needs to be explicitly specified using `public` keyword
- output signal of main component is always public and can't be changed
- from external programmer perspective, only output and public input signals are accessible, not intermediate signals
- Signals can be assigned using `<--` or `<==`
- A `<==` adds a constraint to the R1CS, signifying that the assigned value is the *ONLY* solution for the constraint system
- A `<--` on the other hand is only an assignment of a signal without imposing a constraint on it -> **it could be dangerous and most common source of buggy circuits**
- A `<--` and `<==` indicate that signal to be assigned is on left and `-->` and `==>` indicate signate to be assigned on the right
- Signals are immutable -> once assigned a value, a signal cannot be reassigned a value
- At compilation time, content of a signal is always considered unknown, even if a constant is already assigned to them

---

## Constraints


---

## Variables
- Variables cannot hold signal data
- Don't have any restrictions like constraint operations

---

## Templates

- templates are circuit objects that can be instantiated to create more complex circuits
- in effect, templates allow for composability
- templates define circuits by instantiation -> they have own input/output signals
- an input cannot be assigned a value inside a template
- instantiation of a template is made by
`component c = template(v1, .... vm)`

---
