defmodule Photography.Image do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  use Arc.Ecto.Definition

  @versions [:original, :large, :medium, :small, :large_webp, :medium_webp, :small_webp]

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Override the bucket on a per definition basis:
  # def bucket do
  #   :custom_bucket_name
  # end

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name) |> String.downcase())
  end

  # Define a thumbnail transformation:

  def transform(:small_webp, _) do
    {:convert, "-resize 400x300 -format webp -quality 85", :webp}
  end

  def transform(:medium_webp, _) do
    {:convert, "-resize 800x600 -format webp -quality 85", :webp}
  end

  def transform(:large_webp, _) do
    {:convert, "-resize 1280x960 -format webp -quality 85", :webp}
  end


  def transform(:small, _) do
    {:convert, "-resize 400x300 -format jpg -quality 85", :jpg}
  end

  def transform(:medium, _) do
    {:convert, "-resize 800x600 -format jpg -quality 85", :jpg}
  end

  def transform(:large, _) do
    {:convert, "-resize 1280x960 -format jpg -quality 85", :jpg}
  end




  # Override the persisted filenames:
  def filename(version, _) do
    version
  end

  # Override the storage directory:
  def storage_dir(version, {_, scope}) do
    "media/photos/#{scope.uuid}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: MIME.from_path(file.file_name)]
  # end
end
