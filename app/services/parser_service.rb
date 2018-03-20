require "httparty"

class ParserService

    def initialize(url)
        @href = (url.present? && url.href.present?) ? url.href : ""
    end

    def run
        call_url
        parse_content
    end

    private

    def call_url
        if @href.present?
            response = HTTParty.get(@href)
            @response = response.parsed_response    
        end    
    end
    
    def parse_content
        if @response.present?
            @content = {
                :h1 => [],
                :h2 => [],
                :h3 => [],
                :links => []
            }
            doc = Nokogiri::HTML(@response)
            ['h1','h2','h3'].each do |tag|
                doc.css(tag).each do |link|
                    if link.text.present?
                        @content[tag.to_sym].push(link.text.squeeze(" \n"))
                    end    
                end
            end
            @content[:links] = doc.xpath('//a').map {|element| element["href"]}.compact
        end    
    end    
end