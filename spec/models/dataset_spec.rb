# Generated via
#  `rails generate hyrax:work Dataset`
require 'rails_helper'

RSpec.describe Dataset, :vcr do
  it 'has human readable type dataset' do
    @obj = build(:dataset)
    expect(@obj.human_readable_type).to eq('Dataset')
  end

  describe 'title' do
    it 'requires title' do
      @obj = build(:dataset, title: nil)
      #@obj.save!
      expect{@obj.save!}.to raise_error(ActiveFedora::RecordInvalid, 'Validation failed: Title Your dataset must have a title.')
    end

    it 'has a multi valued title field' do
      @obj = build(:dataset, title: ['test dataset'])
      expect(@obj.title).to eq ['test dataset']
    end
  end

  describe 'doi' do
    it 'has a single valued doi' do
      @obj = build(:dataset, doi: '0000-0000-0000-0000')
      expect(@obj.doi).to be_kind_of String
      expect(@obj.doi).to eq '0000-0000-0000-0000'
    end
  end

  describe 'publisher' do
    it 'has publisher' do
      @obj = build(:dataset, publisher: ['Willow'])
      expect(@obj.publisher).to be_kind_of ActiveTriples::Relation
      expect(@obj.publisher).to eq ['Willow']
    end
  end

  describe 'nested attributes for other title' do
    it 'accepts other title attributes' do
      @obj = build(:dataset, other_title_attributes: [{
            title: 'Another title',
            title_type: 'Title type'
          }]
      )
      expect(@obj.other_title.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.other_title.first.id).to include('#title')
      expect(@obj.other_title.first.title).to eq ['Another title']
      expect(@obj.other_title.first.title_type).to eq ['Title type']
    end

    it 'rejects other title attributes if title is blank' do
      @obj = build(:dataset, other_title_attributes: [{
            title: 'Another title',
            title_type: 'Title type'
          }, {
            title: 'A third title'
          }, {
            title_type: 'Title type'
          }
        ]
      )
      expect(@obj.other_title.size).to eq(2)
    end

    it 'destroys other titles' do
      @obj = build(:dataset, other_title_attributes: [{
          title: 'Another title',
          title_type: 'Title type'
        }]
      )
      expect(@obj.other_title.size).to eq(1)
      @obj.attributes = {
        other_title_attributes: [{
          id: @obj.other_title.first.id,
          title: 'Another title',
          title_type: 'Title type',
          _destroy: "1"
        }]
      }
      expect(@obj.other_title.size).to eq(0)
    end
  end

  describe 'nested attributes for date' do
    it 'accepts date attributes' do
      @obj = build(:dataset, date_attributes: [{
            date: '2017-01-01',
            description: 'Date definition'
          }]
      )
      expect(@obj.date.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.date.first.id).to include('#date')
      expect(@obj.date.first.date).to eq ['2017-01-01']
      expect(@obj.date.first.description).to eq ['Date definition']
    end

    it 'rejects date attributes if date is blank' do
      @obj = build(:dataset, date_attributes: [{
            date: '2017-01-01',
            description: 'date definition'
          }, {
            description: 'Date definition'
          }, {
            date: '2018-01-01'
          }, {
            date: ''
          }]
      )
      expect(@obj.date.size).to eq(2)
    end

    it 'destroys date' do
      @obj = build(:dataset, date_attributes: [{
          date: '2017-01-01',
          description: 'date definition'
        }]
      )
      expect(@obj.date.size).to eq(1)
      @obj.attributes = {
        date_attributes: [{
          id: @obj.date.first.id,
          date: '2017-01-01',
          description: 'date definition',
          _destroy: "1"
        }]
      }
      expect(@obj.date.size).to eq(0)
    end
  end

  describe 'nested attributes for rights' do
    it 'accepts rights attributes' do
      @obj = build(:dataset, rights_nested_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }]
      )
      expect(@obj.rights_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.rights_nested.first.id).to include('#rights')
      expect(@obj.rights_nested.first.label).to eq ['A rights label']
      expect(@obj.rights_nested.first.definition).to eq ['A definition of the rights']
      expect(@obj.rights_nested.first.webpage).to eq ['http://example.com/rights']
    end

    it 'rejects rights attributes if all blank' do
      @obj = build(:dataset, rights_nested_attributes: [{ label: '' }] )
      expect(@obj.rights_nested.size).to eq(0)
    end

    it 'destroys rights' do
      @obj = build(:dataset, rights_nested_attributes: [{ label: 'test label' }] )
      expect(@obj.rights_nested.size).to eq(1)
      @obj.attributes = {
        rights_nested_attributes: [{
            id: @obj.rights_nested.first.id,
            label: 'test label',
            _destroy: "1"
          }]
      }
      expect(@obj.rights_nested.size).to eq(0)
    end
  end

  describe 'nested attributes for creator' do
    it 'accepts person attributes' do
      @obj = build(:dataset,  creator_nested_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          },
          {
            last_name: 'Hello world',
            orcid: '0001-0001-0001-0001',
            role: 'Author'
          }]
      )
      expect(@obj.creator_nested.size).to eq(2)
      expect(@obj.creator_nested[0]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator_nested[0].id).to include('#person')
      expect(@obj.creator_nested[1]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator_nested[1].id).to include('#person')
    end

    it 'rejects person if first name and last name are blank' do
      @obj = build(:dataset, creator_nested_attributes: [
          {
            first_name: 'Foo',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            first_name: '',
            last_name: nil,
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }
        ]
      )
      expect(@obj.creator_nested.size).to eq(2)
    end

    it 'rejects person if orcid is blank' do
      @obj = build(:dataset, creator_nested_attributes: [
          {
            first_name: 'Foo',
            last_name: 'Bar',
            role: 'Author'
          },
          {
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '',
            role: 'Author'
          }
        ]
      )
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'rejects person if role is blank' do
      @obj = build(:dataset, creator_nested_attributes: [
          {
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000'
          },
          {
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: nil
          }
        ]
      )
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'rejects person if all are blank' do
      @obj = build(:dataset, creator_nested_attributes: [
          {
            first_name: '',
            last_name: nil,
            role: nil
          }
        ]
      )
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'destroys creator' do
      @obj = build(:dataset, creator_nested_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          }]
      )
      expect(@obj.creator_nested.size).to eq(1)
      @obj.attributes = {
        creator_nested_attributes: [{
            id: @obj.creator_nested.first.id,
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author',
            _destroy: "1"
          }]
      }
      expect(@obj.creator_nested.size).to eq(0)
    end
  end

  describe 'nested attributes for subject' do
    it 'accepts subject attributes' do
      @obj = build(:dataset, subject_nested_attributes: [{
            label: 'Subject label',
            definition: 'Subject label definition',
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }]
      )
      expect(@obj.subject_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.subject_nested.first.id).to include('#subject')
      expect(@obj.subject_nested.first.label).to eq ['Subject label']
      expect(@obj.subject_nested.first.definition).to eq ['Subject label definition']
      expect(@obj.subject_nested.first.classification).to eq ['LCSH']
      expect(@obj.subject_nested.first.homepage).to eq ['http://example.com/homepage']
    end

    it 'rejects subject attributes if label is blank' do
      @obj = build(:dataset, subject_nested_attributes: [{
            label: 'Subject label',
            definition: 'Subject label definition',
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }, {
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }, {
            label: ''
          }]
      )
      expect(@obj.subject_nested.size).to eq(1)
    end

    it 'destroys subject' do
      @obj = build(:dataset, subject_nested_attributes: [{
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage'
        }]
      )
      expect(@obj.subject_nested.size).to eq(1)
      @obj.attributes = {
        subject_nested_attributes: [{
          id: @obj.subject_nested.first.id,
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage',
          _destroy: "1"
        }]
      }
      expect(@obj.subject_nested.size).to eq(0)
    end
  end

  describe 'nested attributes for relation' do
    it 'accepts relation attributes' do
      @obj = build(:dataset, relation_attributes: [
          {
            label: 'A relation label',
            url: 'http://example.com/relation',
            identifier: '123456',
            identifier_scheme: 'local',
            relationship_name: 'Is part of',
            relationship_role: 'http://example.com/isPartOf'
          }
        ]
      )
      expect(@obj.relation.size).to eq 1
      expect(@obj.relation.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.relation.first.id).to include('#relation')
      expect(@obj.relation.first.label).to eq ['A relation label']
      expect(@obj.relation.first.url).to eq ['http://example.com/relation']
      expect(@obj.relation.first.identifier).to eq ['123456']
      expect(@obj.relation.first.identifier_scheme).to eq ['local']
      expect(@obj.relation.first.relationship_name).to eq ['Is part of']
      expect(@obj.relation.first.relationship_role).to eq ['http://example.com/isPartOf']
    end

    it 'rejects relation if label is blank' do
      @obj = build(:dataset, relation_attributes: [{
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: '',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }]
      )
      expect(@obj.relation.size).to eq(1)
    end

    it 'rejects relation if url or identifier is blank' do
      @obj = build(:dataset, relation_attributes: [{
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: '',
          identifier: nil,
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }]
      )
      expect(@obj.relation.size).to eq(3)
    end

    it 'rejects relation if relationship role or relationship name blank' do
      @obj = build(:dataset, relation_attributes: [{
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: '',
          relationship_role: nil
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
        }]
      )
      expect(@obj.relation.size).to eq(3)
    end

    it 'destroys relation' do
      @obj = build(:dataset, relation_attributes: [{
          label: 'test label',
          url: 'http://example.com/relation',
          relationship_name: 'Is part of'
          }]
      )
      expect(@obj.relation.size).to eq(1)
      @obj.attributes = {
        relation_attributes: [{
          id: @obj.relation.first.id,
          label: 'test label',
          url: 'http://example.com/relation',
          relationship_name: 'Is part of',
          _destroy: "1"
          }]
      }
      expect(@obj.relation.size).to eq(0)
    end
  end

  describe 'nested attributes for admin_metadata' do
    it 'accepts admin_metadata attributes' do
      @obj = build(:dataset, admin_metadata_attributes: [{
          question: 'An admin question needing an answer',
          response: 'Response to admin question'
        }]
      )
      expect(@obj.admin_metadata.size).to eq(1)
      expect(@obj.admin_metadata.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.admin_metadata.first.id).to include('#admin_metadata')
      expect(@obj.admin_metadata.first.question).to eq ['An admin question needing an answer']
      expect(@obj.admin_metadata.first.response).to eq ['Response to admin question']
    end

    it 'rejects attributes if question blank' do
      @obj = build(:dataset, admin_metadata_attributes: [
          {
            question: 'An admin question needing an answer'
          },
          {
            response: 'a response'
          },
          {
            question: '',
            response: nil
          }]
      )
      expect(@obj.admin_metadata.size).to eq(1)
    end

    it 'destroys admin_metadata' do
      @obj = build(:dataset, admin_metadata_attributes: [{
            question: 'An admin question needing an answer',
            response: 'Response to admin question'
          }]
      )
      expect(@obj.admin_metadata.size).to eq(1)
      @obj.attributes = {
        admin_metadata_attributes: [{
            id: @obj.admin_metadata.first.id,
            question: 'An admin question needing an answer',
            response: 'Response to admin question',
            _destroy: "1"
          }]
      }
      expect(@obj.admin_metadata.size).to eq(0)
    end
  end
end
