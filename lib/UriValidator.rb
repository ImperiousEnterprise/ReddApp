require 'net/http'
=begin
This class serves as a validator for url by checking the format and confirming
its authenticity.
=end

class UriValidator < ActiveModel::EachValidator
  VALID_URL_REGEX = /^(http|https):\/\/?([a-z0-9]+)([-.]{1}[a-z0-9]+)([\/.]{1}[a-z0-9]+){1}$/

  def validate_each(object, attribute, value)
    raise(ArgumentError, "A regular expression must be supplied as the :format option of the options hash") unless options[:format].nil? or options[:format].is_a?(Regexp)
    configuration = { :message => "Invalid Url Format", :format => VALID_URL_REGEX , :multiline => true}
    configuration.update(options)
    if value =~ configuration[:format]
      begin # check header response
        case Net::HTTP.get_response(URI(value))
          when Net::HTTPSuccess then true
          else
            configuration[:message] = "Direct URL's only no redirects"
            object.errors.add(attribute, configuration[:message]) and false
        end

      rescue # Recover on DNS failures..
        configuration[:message] = "URL not responding"
        object.errors.add(attribute, configuration[:message]) and false
      end
    else
      object.errors.add(attribute, configuration[:message]) and false
    end
  end
end