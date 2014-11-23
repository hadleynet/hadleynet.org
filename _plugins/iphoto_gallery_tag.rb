class IPhotoGalleryTag < Liquid::Tag
  def initialize(tag_name, url, tokens)
    super
    @url = url.strip
  end

  def render(context)
    galleries = []
    Dir.glob(File.join('photos/galleries', '*')).each do |gallery|
      gallery_name = File.basename(gallery)
      galleries << "<a href='galleries/#{gallery_name}'>#{gallery_name.capitalize}</a>"
    end
    galleries.join(' ')
  end
end

Liquid::Template.register_tag('gallery', IPhotoGalleryTag)