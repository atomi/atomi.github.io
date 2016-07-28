---
title: Golang Recursion vs For Loops 
date: 2016-07-10
---

### Exercise:

Given a list, find the smallest number to the right that is `>=`   
e.g. for `x:8 2 4 1 6 0 5 3 7 9`   
`f(x)` should return `9 3 5 3 7 3 7 7 9`   

Using recursion - though strictly not a correct solution since f() takes 2 arguments:

```go
func main() {
        result := f([]int{8, 2, 4, 1, 6, 0, 5, 3, 7, 9}, []int{})
        fmt.Print(result)
}

func f(x []int, r []int) []int {
        min := 0
        cur := x[0]

        if len(x) == 1 {
                return r
        }

        x = append(x[:0], x[1:]...)
        for _, v := range x {
                if v >= cur {
                        if min == 0 || v < min {
                                min = v
                        }
                }
        }
        r = append(r, min)
        return f(x, r)
}
```
