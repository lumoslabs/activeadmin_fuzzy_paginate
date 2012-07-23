# Lazy evaluation of num_pages
module Kaminari::ActionViewExtension
  def paginate(scope, options = {}, &block)
    options.reverse_merge!(:current_page => scope.current_page, :per_page => scope.limit_value, :param_name => Kaminari.config.param_name, :remote => false)
    options.merge!(:num_pages => scope.num_pages) unless options[:num_pages]
    paginator = Kaminari::Helpers::Paginator.new self, options
    paginator.to_s
  end
end