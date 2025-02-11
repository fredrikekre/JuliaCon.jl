const CACHE_MODE = Symbol(uppercase(@load_preference("cache_mode", "DEFAULT")))
const CACHE_DIR = @load_preference(
    "cache_dir", joinpath(DEPOT_PATH[1], "datadeps", "JuliaConSchedule")
)
const TIMEOUT = parse(Float64, @load_preference("timeout", "5.0"))
const TERMINAL_LINKS = parse(Bool, @load_preference("terminal_links", "false"))
const JULIACON_TIMEZONE = tz"UTC"

function set_cachemode(mode::Symbol)
    @assert mode in (:DEFAULT, :NEVER, :ALWAYS)
    @set_preferences!("cache_mode" => uppercase(string(mode)))
    @info("New cache mode set; restart your Julia session for this change to take effect!")
end
function set_cachedir(path::String)
    @set_preferences!("cache_dir" => string(path))
    @info("New cache dir set; restart your Julia session for this change to take effect!")
end
function set_timeout(val::Union{Float64,Int})
    @assert val > 0
    @set_preferences!("timeout" => string(val))
    @info("New timeout set; restart your Julia session for this change to take effect!")
end
function set_terminallinks(on::Bool)
    @set_preferences!("terminal_links" => string(on))
    @info(
        "New terminal links preference set; restart your Julia session for this change to take effect!"
    )
end

const PRETALX_JSON_URL = "https://pretalx.com/juliacon2021/schedule/export/schedule.json"
const DATA_ARCHIVE_JSON_URL = "https://raw.githubusercontent.com/JuliaCon/JuliaConDataArchive/master/juliacon2021_schedule/schedule.json"
const jcon = Ref{JuliaConSchedule}()

default_json_url() = DATA_ARCHIVE_JSON_URL
default_now() = TimeZones.now(localzone())

"""
    debugmode(on::Bool=true)

Simulates that we are live / in the middle of JuliaCon.
"""
function debugmode(on::Bool=true)
    if on
        # @eval JuliaCon default_now() = ZonedDateTime(Dates.DateTime("2021-07-20T18:00:00.000"), tz"MET") # JuliaCon2021 workshops
        # @eval JuliaCon default_now() = ZonedDateTime(Dates.DateTime("2021-07-30T22:00:00.000"), tz"MET") # JuliaCon2021 posters
        @eval JuliaCon function default_now()
            return ZonedDateTime(Dates.DateTime("2021-07-30T21:30:00.000"), tz"MET")
        end # JuliaCon2021
    else
        @eval JuliaCon default_now() = TimeZones.now(localzone())
    end
    return nothing
end

"""
    set_json_source(src::Symbol)

Anticipated input: `:pretalx`, `:github` (JuliaConDataArchive)
"""
function set_json_source(src::Symbol)
    if src == :pretalx
        @eval JuliaCon default_json_url() = PRETALX_JSON_URL
    else
        @eval JuliaCon default_json_url() = DATA_ARCHIVE_JSON_URL
    end
    return nothing
end
