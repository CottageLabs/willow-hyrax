# Generated via
#  `rails generate hyrax:work Dataset`
class DatasetIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # Custom indexing behavior
  def generate_solr_document
   super.tap do |solr_doc|
      # other title
      doc[Solrizer.solr_name('other_title', :stored_searchable)] = other_title.map { |r| r.title.first }
      doc[Solrizer.solr_name('other_title', :displayable)] = other_title.to_json
      # date
      doc[Solrizer.solr_name('date', :stored_searchable)] = date.map { |d| d.date.first }
      doc[Solrizer.solr_name('date', :displayable)] = date.to_json
      date.each do |d|
        label = DateTypesService.label(d.description.first) rescue nil
        if label
          doc[Solrizer.solr_name("date_#{label.downcase}", :stored_sortable)] = d.date
        end
      end
      # creator
      creators = creator_nested.map { |c| (c.first_name + c.last_name).join(' ') }
      doc[Solrizer.solr_name('creator_nested', :facetable)] = creators
      doc[Solrizer.solr_name('creator_nested', :stored_searchable)] = creators
      doc[Solrizer.solr_name('creator_nested', :displayable)] = creator_nested.to_json
      # rights
      doc[Solrizer.solr_name('rights_nested', :stored_searchable)] = rights_nested.map { |r| r.webpage.first }
      doc[Solrizer.solr_name('rights_nested', :facetable)] = rights_nested.map { |r| r.webpage.first }
      doc[Solrizer.solr_name('rights_nested', :displayable)] = rights_nested.to_json
      # subject
      doc[Solrizer.solr_name('subject_nested', :stored_searchable)] = subject_nested.map { |s| s.label.first }
      doc[Solrizer.solr_name('subject_nested', :facetable)] = subject_nested.map { |s| s.label.first }
      doc[Solrizer.solr_name('subject_nested', :displayable)] = subject_nested.to_json
      # relation
      doc[Solrizer.solr_name('relation_url', :facetable)] = relation.map { |r| r.url.first }
      doc[Solrizer.solr_name('relation_id', :facetable)] = relation.map { |r| r.identifier.first }
      doc[Solrizer.solr_name('relation', :displayable)] = relation.to_json
      # admin metadata
      doc[Solrizer.solr_name('admin_metadata', :displayable)] = admin_metadata.to_json
   end
  end
end
