defmodule ImageConverterTest do
  use ImageConverter.DataCase

  test "converts markdown image to html with default width" do
    markdown_link = "![alt text](https://example.com/image.jpg)"

    [result] = ImageConverter.generate_image_tags(markdown_link)

    assert result ==
             "<img src=\"https://example.com/image.jpg\" alt=\"alt text\" width=\"300\"><br/>"
  end

  test "converts two markdown images to list of html with default width" do
    markdown_links =
      """
      ![alt text](https://example.com/image.jpg)
      ![alt text2](https://example.com/image2.jpg)
      """

    result = ImageConverter.generate_image_tags(markdown_links)

    assert result == [
             "<img src=\"https://example.com/image.jpg\" alt=\"alt text\" width=\"300\"><br/>",
             "<img src=\"https://example.com/image2.jpg\" alt=\"alt text2\" width=\"300\"><br/>"
           ]
  end

  test "converts headings and markdown images to list of html with default width" do
    markdown_links =
      """
      ### Test

      ![alt text2](https://example.com/image2.jpg)
      """

    result = ImageConverter.generate_image_tags(markdown_links)

    assert result == [
             "### Test",
             "<img src=\"https://example.com/image2.jpg\" alt=\"alt text2\" width=\"300\"><br/>"
           ]
  end
end
