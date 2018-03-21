require "pdfjs_viewer-rails/version"
require "pdfjs_viewer-rails/helpers"

module PdfjsViewer
  class << self
    def setup
      yield self
    end
  end

  mattr_accessor :pdfjs_locale
  @@pdfjs_locale = "en"

  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace PdfjsViewer

      initializer 'pdfjs_viewer-rails.load_static_assets' do |app|
        app.middleware.insert_before ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      initializer "pdfjs_viewer-rails.view_helpers" do
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
end
