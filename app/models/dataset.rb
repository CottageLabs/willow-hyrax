# Generated via
#  `rails generate hyrax:work Dataset`
class Dataset < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = DatasetIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your dataset must have a title.' }

  self.human_readable_type = 'Dataset'

  property :doi, predicate: ::RDF::Vocab::Identifiers.doi, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  property :other_title, predicate: ::RDF::Vocab::Bibframe.titleVariation, class_name:"OtherTitleStatement"
  property :date, predicate: ::RDF::Vocab::DC.date, class_name:"DateStatement"
  property :creator_nested, predicate: ::RDF::Vocab::DC.license, class_name:"PersonStatement"
  property :rights_nested, predicate: ::RDF::Vocab::DC.license, class_name:"RightsStatement"
  property :subject_nested, predicate: ::RDF::Vocab::DC.subject, class_name:"SubjectStatement"
  property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
  property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name: "AdministrativeStatement"

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
  include DatasetNestedAttributes
end
