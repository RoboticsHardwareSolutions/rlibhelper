include(CMakeParseArguments)

set(FORMAT_STYLE_FILE ${CMAKE_CURRENT_LIST_DIR}/.clang-format)


function(targetName format_files)
    set(flags)
    set(args)
    set(listArgs SOURCES)
    cmake_parse_arguments(ARG "${flags}" "${args}" "${listArgs}" ${ARGN})

    if (NOT ARG_SOURCES)
        message(FATAL_ERROR "[format_files]: SOURCES is a required argument")
    endif ()

    if (SOURCES IN_LIST ARG_KEYWORDS_MISSING_VALUES)
        message(FATAL_ERROR "[format_files]: SOURCES requires at least one value")
    endif ()
    find_program(clang_format NAMES clang-format)
    if (NOT clang_format)
        message(STATUS "Could not locate clang-format")
    else ()
        file(GLOB format_files ${ARG_SOURCES})
        file(GLOB format_style_file ${FORMAT_STYLE_FILE})
        message(STATUS "clang-format: ${clang_format}; files: ${format_files} ; style:  ${format_style_file}")
        add_custom_target(${targetName}_format COMMAND ${clang_format} -i -fallback-style=none -style=file:${format_style_file} ${format_files})
    endif ()

endfunction()



