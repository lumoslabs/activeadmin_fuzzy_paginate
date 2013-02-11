#This overrides the total_count method on an AREL used by
#ActiveAdmin pagination to force DISTINCT COUNT not to be used
module Kaminari
  module ActiveRecordRelationMethods
    def total_count
      @total_count ||= begin
        c = except(:offset, :limit, :order)
        c = c.reorder nil
        c = c.except(:includes) unless references_eager_loaded_tables?
        #Ugly, but the DISTINCT clause needs to be overridden manually since
        #count(:distinct => false) doesn't work for queries involving joins
        c.loaded? ? c.length : c.connection.execute(c.select('COUNT(*)').to_sql).first.first
      end
    end
  end
end
