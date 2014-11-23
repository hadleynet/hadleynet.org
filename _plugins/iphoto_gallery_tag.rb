class IPhotoGalleryTag < Liquid::Tag
  def initialize(tag_name, url, tokens)
    super
    @url = url.strip
  end

  def render(context)
    galleries = ['<ul>']
    Dir.glob(File.join('photos/galleries', '*')).reverse.each do |gallery|
      gallery_dir_name = File.basename(gallery)
      year, month, *name = gallery_dir_name.split('_')
      gallery_date = Time.local(year.to_i, month.to_i) 
      galleries << "<li><a href='galleries/#{gallery_dir_name}'>#{name.join(' ')} #{gallery_date.strftime('%b %Y')}</a></li>"
    end
    galleries << '</ul>'
    galleries.join("\n")
  end
end

Liquid::Template.register_tag('gallery', IPhotoGalleryTag)