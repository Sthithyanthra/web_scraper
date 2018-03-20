
class UrlsController < JSONAPI::ResourceController
    def create 
        binding.pry
        # url = Url.new(url_params)
        url = Url.new(:href => params["data"]["attributes"]["href"])
        if url.save!
            ParserService.new(url).run
            render json: 'URL Saved', status: 201
        else
            render json: 'Something went wrong!', status: 400
        end
    end

    private

    def url_params
        params.permit(:href)
    end
end
