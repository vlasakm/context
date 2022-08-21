-- winmerge e:\tex-context\tex\texmf-mine\web2c\contextcnf.lua e:\tex-context\tex\texmf-context\web2c\contextcnf.lua e:\tex-context\tex\texmf\web2c\texmfcnf.lua

return {

    type    = "configuration",
    version = "1.1.2",      -- "1.1.1",
    date    = "2021-05-12", -- "2011-06-02"
    time    = "14:59:00",
    comment = "ConTeXt MkIV and LMTX configuration file",
    author  = "Hans Hagen, PRAGMA-ADE, Hasselt NL",

    content = {

        -- Originally there was support for engines and progname but I don't expect other engines to
        -- use this file, so first engines were removed. After that if made sense also to get rid of
        -- progname. In principle we could support multiple formats here (using subtables) but time
        -- has demonstrated that we only have one format (the original ideas was to make a base layer
        -- but I don't see it being used to it would be  waste of time). So, after a decade it was
        -- time to prune and update this file, also because LMTX has a few more features.

        variables = {

            -- The following variable is predefined (but can be overloaded) and in most cases you can
            -- leave this one untouched. The built-in definition permits relocation of the tree.
            --
            --  if this_is_texlive then
            --      resolvers.luacnfspec = 'selfautodir:;selfautoparent:;{selfautodir:,selfautoparent:}{/share,}/texmf{-local,}/web2c'
            --  else
            --      resolvers.luacnfspec = 'home:texmf/web2c;selfautoparent:texmf{-local,-context,}/web2c'
            --  end
            --
            -- more readable is:
            --
            -- TEXMFCNF     = {
            --     "home:texmf/web2c,
            --     "selfautoparent:texmf-local/web2c",
            --     "selfautoparent:texmf-context/web2c",
            --     "selfautoparent:texmf/web2c",
            -- }

            -- We have only one cache path but there can be more. The first writable one will be taken
            -- but there can be more readable paths.

            TEXMFCACHE      = "home:.cache",

            -- I don't like this texmf under home and texmf-home would make more sense. One never knows
            -- what installers put under texmf anywhere and sorting out problems will be a pain. But on
            -- the other hand ... home mess is normally the users own responsibility.
            --
            -- By using prefixes we don't get expanded paths in the cache __path__ entry. This makes the
            -- tex root relocatable.

            TEXMFDOTDIR = ".",
            TEXMFCONTEXT = "selfautodir:share/context/texmf",
            TEXMF = "$TEXMFCONTEXT",
            OSFONTDIR = "/usr/share/fonts//",

            -- We need texmfos for a few rare files but as I have a few more bin trees a hack is needed.
            -- Maybe other users also have texmf-platform-new trees, but so far I've never heard of it.

            TEXFONTMAPS     = "$TEXMFDOTDIR;$TEXMF/fonts/data//;$TEXMF/fonts/map/{pdftex,dvips}//",
            ENCFONTS        = "$TEXMFDOTDIR;$TEXMF/fonts/data//;$TEXMF/fonts/enc/{dvips,pdftex}//",
            VFFONTS         = "$TEXMFDOTDIR;$TEXMF/fonts/{data,vf}//",
            TFMFONTS        = "$TEXMFDOTDIR;$TEXMF/fonts/{data,tfm}//",
            PKFONTS         = "$TEXMFDOTDIR;$TEXMF/fonts/{data,pk}//",
            T1FONTS         = "$TEXMFDOTDIR;$TEXMF/fonts/{data,type1}//;$OSFONTDIR",
            AFMFONTS        = "$TEXMFDOTDIR;$TEXMF/fonts/{data,afm}//;$OSFONTDIR",
            TTFONTS         = "$TEXMFDOTDIR;$TEXMF/fonts/{data,truetype}//;$OSFONTDIR",
            OPENTYPEFONTS   = "$TEXMFDOTDIR;$TEXMF/fonts/{data,opentype}//;$OSFONTDIR",
            FONTFEATURES    = "$TEXMFDOTDIR;$TEXMF/fonts/{data,fea}//;$OPENTYPEFONTS;$TTFONTS;$T1FONTS;$AFMFONTS",
            FONTCIDMAPS     = "$TEXMFDOTDIR;$TEXMF/fonts/{data,cid}//",
            OFMFONTS        = "$TEXMFDOTDIR;$TEXMF/fonts/{data,ofm,tfm}//",
            OVFFONTS        = "$TEXMFDOTDIR;$TEXMF/fonts/{data,ovf,vf}//",

            TEXINPUTS       = "$TEXMFDOTDIR;$TEXMF/tex/{context,plain/base,generic}//",
            MPINPUTS        = "$TEXMFDOTDIR;$TEXMF/metapost/{context,base,}//",

            -- In the next variable the inputs path will go away.

            --TEXMFSCRIPTS    = "$TEXMFDOTDIR;$TEXMF/scripts/context/{lua,ruby,python,perl}//;$TEXINPUTS",
            TEXMFSCRIPST    = "$SELFAUTOLOC/texmf//",
            PERLINPUTS      = "$TEXMFDOTDIR;$TEXMF/scripts/context/perl",
            PYTHONINPUTS    = "$TEXMFDOTDIR;$TEXMF/scripts/context/python",
            RUBYINPUTS      = "$TEXMFDOTDIR;$TEXMF/scripts/context/ruby",
            LUAINPUTS       = "$TEXMFDOTDIR;$TEXINPUTS;$TEXMF/scripts/context/lua//",
            CLUAINPUTS      = "$TEXMFDOTDIR;$SELFAUTOLOC/lib/$engine//",

            -- Not really used by MkIV so they might go away.

            BIBINPUTS       = "$TEXMFDOTDIR;$TEXMF/bibtex/bib//;$TEXMF/tex/context//",
            BSTINPUTS       = "$TEXMFDOTDIR;$TEXMF/bibtex/bst//;$TEXMF/tex/context//",

            -- Experimental

            ICCPROFILES     = "$TEXMFDOTDIR;$TEXMF/colors/icc/{context,profiles}//;$OSCOLORDIR",

            -- A few special ones that will change some day.

            FONTCONFIG_FILE = "fonts.conf",
            FONTCONFIG_PATH = "$TEXMFSYSTEM/fonts/conf",

        },

        -- We have a few reserved subtables. These control runtime behaviour. Some are frozen at
        -- at startup time, others can be changed any time.

        directives = {

            -- The default settings are actually set at startup so the values below overload
            -- them. You can also specify a plus field which will bump a value and in LMTX a
            -- step field that sets the incremental allocation of memory (because there we don't
            -- allocate all at once).

            -- texconfig.max_print_line  =   100000
            -- texconfig.function_size   =    32768
            -- texconfig.properties_size =    10000

            -- These are for luametatex:

            ["luametatex.errorlinesize"]     = { size =      250                 }, -- max =       255
            ["luametatex.halferrorlinesize"] = { size =      250                 }, -- max =       255
            ["luametatex.expandsize"]        = { size =    10000                 }, -- max =   1000000
            ["luametatex.stringsize"]        = { size =   500000, step =  100000 }, -- max =   2097151 -- number of strings
            ["luametatex.poolsize"]          = { size = 10000000, step = 1000000 }, -- max = 100000000 -- chars in string
            ["luametatex.hashsize"]          = { size =   250000, step =  100000 }, -- max =   2097151
            ["luametatex.nodesize"]          = { size = 50000000, step =  500000 }, -- max =  50000000
            ["luametatex.tokensize"]         = { size = 10000000, step =  250000 }, -- max =  10000000
            ["luametatex.buffersize"]        = { size = 10000000, step = 1000000 }, -- max = 100000000
            ["luametatex.inputsize"]         = { size =   100000, step =   10000 }, -- max =    100000 -- aka stack
            ["luametatex.filesize"]          = { size =     2000, step =     200 }, -- max =      2000
            ["luametatex.nestsize"]          = { size =    10000, step =    1000 }, -- max =     10000
            ["luametatex.parametersize"]     = { size =   100000, step =   10000 }, -- max =    100000
            ["luametatex.savesize"]          = { size =   500000, step =   10000 }, -- max =    500000
            ["luametatex.fontsize"]          = { size =   100000, step =     250 }, -- max =    100000
            ["luametatex.languagesize"]      = { size =      250, step =     250 }, -- max =     10000
            ["luametatex.marksize"]          = { size =      250, step =      50 }, -- max =     10000
            ["luametatex.insertsize"]        = { size =      250, step =      25 }, -- max =       250

            -- These are for luatex:

            ["luatex.errorline"]         =    250,
            ["luatex.halferrorline"]     =    125,
            ["luatex.expanddepth"]       =  10000,
            ["luatex.hashextra"]         = 100000,
            ["luatex.nestsize"]          =   1000,
            ["luatex.maxinopen"]         =    500,
            ["luatex.maxprintline"]      =  10000,
            ["luatex.maxstrings"]        = 500000,
            ["luatex.paramsize"]         =  25000,
            ["luatex.savesize"]          = 100000,
            ["luatex.stacksize"]         = 100000,

            -- A few process related variables come next.

         -- ["system.checkglobals"]      = "10",
         -- ["system.nostatistics"]      = "yes",
            ["system.errorcontext"]      = "10",
            ["system.compile.cleanup"]   = "no",    -- remove tma files
            ["system.compile.strip"]     = "yes",   -- strip tmc files

            -- The io modes are similar to the traditional ones. Possible values are all, paranoid
            -- and restricted.

            ["system.outputmode"]        = "restricted",
            ["system.inputmode"]         = "any",

            -- The following variable is under consideration. We do have protection mechanims but
            -- it's not enabled by default.

            ["system.commandmode"]       = "any", -- any none list
            ["system.commandlist"]       = "mtxrun, convert, inkscape, gs, imagemagick, curl, bibtex, pstoedit",

            -- The mplib library support mechanisms have their own configuration. Normally these
            -- variables can be left as they are.

            ["mplib.texerrors"]          = "yes",

            -- Normally you can leave the font related directives untouched as they only make sense
            -- when testing.

         -- ["fonts.autoreload"]         = "no",
         -- ["fonts.otf.loader.cleanup"] = "0",     -- 0 1 2 3

            -- In an edit cycle it can be handy to launch an editor. The
            -- preferred one can be set here.

         -- ["pdfview.method"]           = "sumatra",

         -- ["system.engine"]            = "luajittex",
         -- ["fonts.usesystemfonts"]     = false,
         -- ["modules.permitunprefixed"] = false,
         -- ["resolvers.otherwise"]      = false,

         -- Sandboxing has been available for a while but is probably never used to maybe that mechanism
         -- should be removed some day. Normally you will configure this in a local configuration file. By
         -- default we are rather permissive. The next list comes from my machine:

         -- ["system.rootlist"]      = { "/data" }, -- { { "/data", "read" }, ... }

      --    ["system.executionmode"] = "list", -- none | list | all
      --    ["system.executionlist"] = {
      --        "context",
      --        "bibtex", "mlbibcontext",
      --        "curl",
      --        "gswin64c", "gswin32c", "gs",
      --        "gm", "graphicmagick",
      --        "pdftops",
      --        "pstoedit",
      --        "inkscape",
      --        "woff2_decompress",
      --        "hb-shape",
      --    },
      --
      --    ["system.librarymode"]   = "list", -- none | list | all
      --    ["system.librarylist"]   = {
      --        "mysql",
      --        "sqlite3",
      --        "libharfbuzz", "libharfbuzz-0",
      --    },
      -- -- ["system.librarynames"]  = {
      -- --     ["libcurl"] = { "libcurl", "libcurl-4" },
      -- -- },

        },

        experiments = {
            ["fonts.autorscale"] = "yes",
        },

        trackers = {
        },

    },

}
