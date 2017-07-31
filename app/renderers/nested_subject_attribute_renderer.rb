class NestedSubjectAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      subject = []
      if v.include?('label') and not v['label'].blank? and not v['label'][0].blank?
        subject << link_to(ERB::Util.h(v['label'][0]), search_path(v['label'][0]))
      end
      if v.include?('definition') and not v['definition'].blank? and not v['definition'][0].blank? and
         v.include?('classification') and not v['classification'].blank? and not v['classification'][0].blank?
        link = link_to(v['classification'][0], v['definition'][0], target: :_blank)
        subject << "Classification: <span class='glyphicon glyphicon-new-window'></span>&nbsp;#{link}"
      elsif v.include?('definition') and not v['definition'].blank? and not v['definition'][0].blank?
        subject << "Definition: #{link_to(v['definition'][0])}"
      elsif v.include?('classification') and not v['classification'].blank? and not v['classification'][0].blank?
        subject << "Classification: #{v['classification'][0]}"
      end
      html << subject.join('<br>')
    end
    html = html.join('<br/>')
    %(#{html})
  end
end
