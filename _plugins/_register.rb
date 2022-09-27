Jekyll::Hooks.register :site, :post_read do |site|
  Jekyll_Get_Remote_Content::FeedFetcher.fetchFor(site)
end
