# Generated via
#  `rails generate hyrax:work Article`
module Hyrax
  class ArticlePresenter < Hyrax::WorkShowPresenter
    delegate :doi, :publisher, :coverage, :apc, :tagged_version, :creator_nested, :date, :rights_nested,
      :relation, :subject_nested, :project, :admin_metadata, to: :solr_document
  end
end
