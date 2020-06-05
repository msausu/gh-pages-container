FROM alpine:latest

MAINTAINER msausu

ENV CREATED 2020-06-02

RUN apk upgrade --update

RUN apk --no-cache add --virtual jekyll_build_deps \
        make gcc                         \
        build-base                       \
        ruby-dev                         \
        libc-dev                         \
        linux-headers                    \
        libxml2-dev                      \
        libxslt-dev

RUN apk add ruby-bundler                 \
        ruby-rdoc                        \
        ruby-json                        \
        ruby-bigdecimal                  \
        ruby-webrick                     \
        ruby-concurrent-ruby             \
        ruby-concurrent-ruby-ext         \
        ruby-ffi                         \
        ruby-i18n                        \
        ruby-mini_portile2               \
        ruby-minitest                    \
        ruby-nokogiri

RUN bundle config --global silence_root_warning 1

RUN gem install --no-document            \
        activesupport                    \
        addressable                      \
        colorator                        \
        em-websocket                     \
        eventmachine                     \
        forwardable-extended             \
        gemoji                           \
        html-pipeline                    \
        http_parser.rb                   \
        jekyll                           \
        jekyll-feed                      \
        jekyll-paginate                  \
        jekyll-readme-index              \
        jekyll-sass-converter            \
        jekyll-seo-tag                   \
        jekyll-sitemap                   \
        jekyll-watch                     \
        jemoji                           \
        kramdown                         \
        kramdown-parser-gfm              \
        github-pages                     \
        liquid                           \
        listen                           \
        mercenary                        \
        pathutil                         \
        public_suffix                    \
        rb-fsevent                       \
        rb-inotify                       \
        rexml rouge                      \
        safe_yaml                        \
        sassc                            \
        terminal-table                   \
        thread_safe                      \
        tzinfo                           \
        unicode-display_width            \
        zeitwerk

WORKDIR /srv/jekyll

RUN echo 'source "https://rubygems.org"' >  /srv/jekyll/Gemfile

RUN echo 'gem "github-pages"'            >> /srv/jekyll/Gemfile

RUN touch Gemfile.lock

RUN bundle install

RUN bundle exec jekyll build --drafts

RUN apk del jekyll_build_deps
