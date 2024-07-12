# Implemented some basic linear algebra manually because of difficulties with Arraymancer/neo (Specifically the OpenBLAS dependency) on Windows.
import sequtils
import sugar
import math


proc dot*[T](v1, v2: seq[T]): float = 
    let mults = collect:
        for i, val in v1:
            val * v2[i]
    return sum(mults)

proc euc_len*[T](v: seq[T]): float = 
    return sqrt(dot(v, v))

proc `+`*[T](v1, v2: seq[T]): seq[T] =
    # echo v1  
    # echo v2
    assert len(v1) == len(v2), "Sequences must be the same length for addition/subtraction"
    var total: seq[T] = @[]
    for i, el in v1:
        total.add(el + v2[i])
    return total

proc `*`*[T, S](c: S, v: seq[T]): seq[T] = # Multiplication by a scalar
    let c_T: T = T(c) 
    # Cast scalar to seq type (dangerous) I did it this way because it's faster and allows for custom seq types.
    # There is a less naive way to do this.
    return v.mapIt(c_T * it)


proc `*`*[T, S](v: seq[T], c: S,): seq[T] = # Multiplication by a scalar (postfix)
    let c_T: T = T(c) # Cast scalar to seq type (dangerous) I did it this way because it's fast and allows for custom seq types.
    return v.mapIt(c_T * it)


proc `-`*[T](v1, v2: seq[T]): seq[T] =
    let T_id: T = T(-1) # Cast negative identity to parameter type
    return v1 + (T_id * v2)

proc `==`*[T](r1, r2: seq[T]): bool =  
    assert len(r1) == len(r2), "Sequences must be the same length for comparison"
    for i, val in r1:
        if val != r2[i]:
            return false
    return true

# All comparisons are strict by default, 
# Other interpretations of comparison are TBD

proc `<=`*[T](r1, r2: seq[T]): bool =  
    assert len(r1) == len(r2), "Sequences must be the same length for comparison"
    for i, val in r1:
        if val > r2[i]:
            return false
    return true

proc `>=`*[T](r1, r2: seq[T]): bool =  
    assert len(r1) == len(r2), "Sequences must be the same length for comparison"
    for i, val in r1:
        if val < r2[i]:
            return false
    return true

proc `<`*[T](r1, r2: seq[T]): bool = 
    assert len(r1) == len(r2), "Sequences must be the same length for comparison" 
    for i, val in r1:
        if val >= r2[i]:
            return false
    return true

proc `>`*[T](r1, r2: seq[T]): bool =  
    assert len(r1) == len(r2), "Sequences must be the same length for comparison"
    for i, val in r1:
        if val <= r2[i]:
            return false
    return true

