module HasFlickrImage
  module ModelAdditions

    def has_flickr_image(attribute, options = nil)
      message = (options and options[:message]) || "only Flickr URLs are allowed"
      validates_format_of attribute, with: HasFlickrImage::FlickrImage.regex, message: message, allow_nil: true, allow_blank: true
      self.class_eval <<-EOF
        def flickr
          return @flickr if @flickr
          @flickr = HasFlickrImage::FlickrImage.new self.#{attribute}
        end
      EOF
    end
        
  end
  module HasFlickrImage
    class FlickrImage
      def key
        "af42c39b1fd78be9616ff0ffb22415a1"
      end
    
      def secret
        "c05d9dbc678673f3"
      end
    
      def self.regex
        /http?:\/\/(www\.)?flickr.com\/photos/[^/]+/(?<img>[0-9]+)/
      end
    
      def initialize url
        @url = url
      end
    
      def id
        return @id if @id
        return unless @url
        if result = @url.match(self.class.regex)
          @id = result[2]
        end
      end
    
      def info
        return @info if @info
        return unless id
        @info = flickr.photos.getInfo(:photo_id => "#{id}")
        end
      end
    
      def embed_url
        FlickRaw.url_z(flickr.photos.getInfo(:photo_id => "#{id}"))
      end
    
      def thumbnail
        FlickRaw.url_m(flickr.photos.getInfo(:photo_id => "#{id}"))
      end

    end
  
  end
end