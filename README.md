# JuliaCon.jl

[![Build Status](https://github.com/JuliaCon/JuliaCon.jl/workflows/CI/badge.svg)](https://github.com/JuliaCon/JuliaCon.jl/actions)
[![Coverage](https://codecov.io/gh/JuliaCon/JuliaCon.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaCon/JuliaCon.jl)

## T-Shirt code

This package makes the code on the JuliaCon 2021 [T-shirt](#t-shirt) work! Of course, you should [buy one here](https://www.bonfire.com/juliacon-repl/)!

To make the `@everywhere` do something you need to start Julia with multiple worker processes: `julia -p 4`.

<!-- <img width="588" alt="Screenshot 2021-05-31 at 22 28 07" src="https://user-images.githubusercontent.com/187980/120239846-7c6afc80-c25f-11eb-892b-dd52be136f36.png"> -->

```julia
using JuliaCon, Distributed

@everywhere juliacon2021()
```

<img width="1145" alt="Screenshot 2021-06-02 at 02 05 12" src="https://user-images.githubusercontent.com/187980/120404611-04780180-c347-11eb-860e-88eed268d1a0.png">


## Live schedule

```julia
JuliaCon.now()
```

<img width="1145" alt="Screenshot 2021-06-02 at 02 04 16" src="https://user-images.githubusercontent.com/187980/120404636-15287780-c347-11eb-9111-ff1677d5c15c.png">


```julia
JuliaCon.today()
```

<img width="1904" alt="Screenshot 2021-06-02 at 02 04 33" src="https://user-images.githubusercontent.com/187980/120404647-19549500-c347-11eb-8152-cbf432cb8292.png">

### Caching

When it is needed, the package fetches the JuliaCon schedule (`schedule.json`) from the [JuliaConDataArchive](https://github.com/JuliaCon/JuliaConDataArchive) and keeps the information in memory for further usage. Hence, by default, the fetching happens once per Julia session. To force an update of the JuliaCon schedule you can call `update_schedule()`.

If fetching the `schedule.json` takes longer than 5 seconds - you can change this default by setting the env variable `JULIACON_TIMEOUT` - the package will fall back to using the last cached version (which might be stale).

You can set the env variable `JULIACON_CACHE_DIR` to specify the location of the cache, i.e. where the `schedule.json` will be stored.

#### Cache modes

There are three cache modes: `DEFAULT"`, `NEVER`, `ALWAYS`. You can switch between them by setting the env variable `JULIACON_CACHE_MODE` appropriately.

* `DEFAULT`: As described above: tries to download / update the schedule and falls back to the cache if necessary.
* `NEVER`: The cache will never be used / created. If the download fails it fails.
* `ALWAYS`: Always use the cached `schedule.json`. Never attempts to download / update it.

### Testing / Debugging

* `JuliaCon.debugmode(on::Bool)`: Simulates that we are live / in the middle of JuliaCon.
* `JuliaCon.set_json_src(src::Symbol)`: Anticipated input: `:pretalx`, `:github` ([JuliaConDataArchive](https://github.com/JuliaCon/JuliaConDataArchive))
