class RecalculateStatistics < ActiveRecord::Migration[5.0]
=begin
  def change
  #Recalculate statistics for all works
    @collection = Collection.all
    unless @collection.empty?
      @collection.each do |c|
        c.works.each do |w|
          w.work_statistic.recalculate
        end
      end
    end
  end
=end
end
