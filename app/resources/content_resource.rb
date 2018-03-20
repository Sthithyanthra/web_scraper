class ContentResource < JSONAPI::Resource
    attributes :title, :content
    has_one :url
    filter :url
end    