class ActiveAdmin::Views::PaginatedCollection
  # Set num pages explicitly for fuzzy counts
  def build_pagination
    options =  request.query_parameters.except(:commit, :format)
    options[:param_name] = @param_name if @param_name

    options.merge!(:num_pages => collection.empty? ? collection.current_page : collection.current_page + 1) if active_admin_config.fuzzy_paginate

    text_node paginate(collection, options.symbolize_keys)
  end

  def page_entries_info(options = {})
    if options[:entry_name]
      entry_name = options[:entry_name]
      entries_name = options[:entries_name]
    elsif collection.empty?
      entry_name = I18n.translate("active_admin.pagination.entry", :count => 1, :default => 'entry')
      entries_name = I18n.translate("active_admin.pagination.entry", :count => 2, :default => 'entries')
    else
      begin
        entry_name = I18n.translate!("activerecord.models.#{collection.first.class.model_name.i18n_key}", :count => 1)
        entries_name = I18n.translate!("activerecord.models.#{collection.first.class.model_name.i18n_key}", :count => collection.size)
      rescue I18n::MissingTranslationData
        entry_name = collection.first.class.name.underscore.sub('_', ' ')
      end
    end
    entries_name = entry_name.pluralize unless entries_name

    # Display a place holder for fuzzy counts
    if active_admin_config.fuzzy_paginate
      "Displaying results for #{entries_name}"
    elsif collection.num_pages < 2
      case collection.size
      when 0; I18n.t('active_admin.pagination.empty', :model => entries_name)
      when 1; I18n.t('active_admin.pagination.one', :model => entry_name)
      else;   I18n.t('active_admin.pagination.one_page', :model => entries_name, :n => collection.total_count)
      end
    else
      offset = collection.current_page * collection.size
      total  = collection.total_count
      I18n.t('active_admin.pagination.multiple', :model => entries_name, :from => (offset - collection.size + 1), :to => offset > total ? total : offset, :total => total)
    end
  end
end
