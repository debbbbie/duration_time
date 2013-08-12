
def get_duration_time(reg_date, current_date = Time.now, include_current_year_month = false)
  to_current_year_month = include_current_year_month ? current_date.month : current_date.month - 1

  years = (reg_date.year..current_date.year).to_a; months = []; quarters = []
  years.each do |selected_year|
    data_month =  if    selected_year == reg_date.year and selected_year == current_date.year
                    (reg_date.month..to_current_year_month).to_a
                  elsif selected_year  > reg_date.year and selected_year == current_date.year
                    (1..to_current_year_month).to_a
                  elsif selected_year == reg_date.year and selected_year <  current_date.year
                    (reg_date.month..12).to_a
                  elsif selected_year  > reg_date.year and selected_year <  current_date.year
                    (1..12).to_a
                  end
    months.concat(   data_month.map{|m|"#{selected_year}-#{m.to_s.rjust(2,'0')}"} )
    quarters.concat( data_month.select{|m|m%3==0}.map{|m|"#{selected_year}-#{(m/3).to_s.rjust(2,'0')}"} )
  end
  {:years => years, :months => months, :quarters => quarters}
end