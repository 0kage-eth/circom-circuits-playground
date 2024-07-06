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
- values of parameters should be known constants at compile time. If we pass constants into a template & use that template as a component, then an input signal from the calling template cannot be passed off as a constant to the inner template
- Templates can be modularized like libraries and included in scope using `include` keyword


---

## Components

- An arithmetic circuit that receives `N` input signals and produces `M` output signals and `K` intermediate signals

- A component can also produce its own set of constraints

- To access an input or output of a signal, we use `c.A` or `c.B` where `c` is the component, and `A` and `B` are the signals

- Intermediate signals are not accessible outside of a component

- **Component instantiation will not be triggered until all input signals are assigned concrete values** - this is important as the component creation instruction does not mean that component is immediately instantiated - there could be a delay here. 

`Creation instruction does not mean instantiation of the component object` 

- Output signal of a component can only be used after all inputs are set.

- components are immutable -> if there are several initialization instructions across different paths for same component, they all need to instantiate the same component

- If using an array of components, initialization is only allowed one-by-one

- components can also be used recursively (refer the `MultiAnd`template)[https://docs.circom.io/circom-language/templates-and-components/#components] and check that each component in an array is instantiated one-by-one

- In case of array components, note that if inputs are independent of each other, we can use the `parallel` keyword

- We can now define custom templates using `custom` keyword that are defined similar to standard templates. These are used in Plonk schemes  (not sure how  @follow-up)

- `Main` component is the initial component needed to start execution. Component `main` needs to be instantiated with some template as this is what the compiler expects. Only one main component for a circuit.

- main component kind of defines global inputs and outputs, and inputs that need to be public are defined by `public` keyword

---

## Functions

- Functions perform computation to return a value or expression
- Functions **CANNOT** declare signals or apply constraints
- Like normal functions, incase of conditional logic, every execution path must return something

---

## Operators

- boolean, arithmetic and bitwise operations are allowed
- Field element is a value in the `Z/pZ` domain, where p is large prime number set by default
- Field elements are operated in arithmetic modulo p
 
