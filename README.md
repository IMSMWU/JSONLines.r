# JSONLines.r

Requires [Julia installation (v.1.4.0 or greater)](https://julialang.org/downloads/#current_stable_release)

Exports:

```R
readfile(path, nrows, skip)
```

where nrows specifies the number of rows to read and skip the number of rows to skip before reading. This allows loading of larger than memory files sequentialy. [See also here](https://github.com/danielw2904/JSONLines.jl)

and

```R
writefile(x, file)
```

where x is a `data.frame`
