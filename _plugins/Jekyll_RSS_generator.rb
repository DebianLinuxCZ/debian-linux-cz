require 'rss'
require 'rss/2.0'

module Jekyll_RSS_generator

  class FeedGenerator
    def self.generate(site)
      feeds = site.data['rss_feeds']
      if !feeds
        return
      end

      config = site.config['generate_rss']
      feed_data = feeds[config['from']] # from Jekyll_RSS_merger

      rss = RSS::Maker.make('2.0') do |maker|
        maker.channel.link = config['link']
        maker.channel.title = '%s - %s' % [site.config['title'], feed_data['title']]
        maker.channel.description = site.config['description']
        maker.channel.language = site.config['locale']
        maker.channel.lastBuildDate = Time.now

        feed_data['items'].sort_by { |it| it['published'] }.reverse.each do |feed_data_item|
          maker.items.new_item do |item|
            item.guid.isPermaLink = false
            item.guid.content = feed_data_item['id']
            item.link = feed_data_item['url']
            item.title = feed_data_item['title']
            item.description = feed_data_item['summary']
            if feed_data_item['authors'][0]
              item.author = feed_data_item['authors'][0]['text']
            end
            item.pubDate = feed_data_item['published']
          end
        end
      end

      site.pages << Jekyll::PageWithoutAFile.new(site, __dir__, '', config['path']).tap do |file|
        file.content = rss.to_s
        file.output
      end
    end
  end

end
