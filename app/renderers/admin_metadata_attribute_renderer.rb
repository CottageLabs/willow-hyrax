class AdminMetadataAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbodby>'
    value.each do |v|
      label = ''
      val = ''
      if v.include?('question') and not v['question'].blank? and not v['question'][0].blank?
        label = v['question'][0]
      end
      if v.include?('response') and not v['response'].blank? and not v['response'][0].blank?
        val = v['response'][0]
      end
      html += "<tr><th>#{label}</th><td>#{val}</td></tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
