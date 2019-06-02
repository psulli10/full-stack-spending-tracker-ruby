date = Time.new
#set 'date' equal to the current date/time.

date = date.day.to_s + "/" + date.month.to_s + "/" + date.year.to_s
#Without this it will output 2015-01-10 11:33:05 +0000; this formats it to display DD/MM/YYYY

puts date
#output the date
