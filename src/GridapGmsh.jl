module GridapGmsh

using Libdl

deps_jl = joinpath(@__DIR__, "..", "deps", "deps.jl")
if !isfile(deps_jl)
  s = """
  Package GridapGmsh not installed properly.
  Run Pkg.build(\"GridapGmsh\"), restart Julia and try again
  """
  error(s)
end

include(deps_jl)

include(gmsh_jl)

# Hack taken from MPI.jl
function __init__()
    @static if Sys.isunix()
        Libdl.dlopen(gmsh.lib, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end
end

end # module
