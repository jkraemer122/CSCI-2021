## Determines if pointer to given int has a positive or
## negative value. Returns 0 for positive, 1 for negative.
        .text
        .global posneg
posneg:
        movq    (%rdi),%rsi
        cmpq    $0,%rsi
        jl      .NEG
        movl    $0,%eax
        ret
.NEG:
        movl    $1,%eax
        ret

