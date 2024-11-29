install(
    TARGETS buffalo_exe
    RUNTIME COMPONENT buffalo_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
