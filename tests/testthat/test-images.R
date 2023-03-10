# Tests for generate_hex
test_that("generate_hex", {
  invisible(capture.output({
    # package does not exist
    expect_error(generate_hex())
    expect_error(generate_hex("hexFinder"))

    # file is generated
    pkg_name <- "test"
    path <- generate_hex(pkg_name, tempdir())

    expect_true(file.exists(path))
  }))
})

# Tests for crop_image
test_that("crop_image ", {
  invisible(capture.output({
    # package does not exist
    expect_error(crop_image())
  }))
})

# Tests for download_logo
with_mock_api({
  test_that("download_logo ", {
    expect_error(download_logo())
    expect_error(download_logo("hexFinder"))
    expect_error(download_logo("hexFinder", "https://raw.githubusercontent.com/pedrocoutinhosilva/hexFinder/main/man/figures/logo.svg")) #nolint
  })
})