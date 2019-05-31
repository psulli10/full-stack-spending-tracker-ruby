require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('../models/merchant')
also_reload('../models/*')

# INDEX route - DISPLAY ALL MERCHANTS

get '/merchants' do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

# NEW - DISPLAY A FORM TO MAKE A NEW MERCHANT

get '/merchants/new' do
  erb(:"merchants/new")
end

# CREATE - CREATE A DATABASE ENTRY FOR THE NEW MERCHANT

post '/merchants' do
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect '/merchants'
end

# SHOW - DISPLAY ONE MERCHANT



# EDIT - DISPLAY A FORM TO EDIT A MERCHANT's DETAILS

get '/merchants/:id/edit' do
  @merchant = Merchant.find_by_id(params['id'])
  erb(:"merchants/edit")
end

# UPDATE - UPDATES A DATABASE ENTRY FOR THE MERCHANT

post '/merchants/:id' do
  @merchant = Merchant.new(params)
  @merchant.update()
  redirect '/merchants'
end


# DELETE - DELETES A MERCHSANT  FROM THE DATABASE

post '/merchants/:id/delete' do
  @merchant = Merchant.find_by_id(params['id'])
  @merchant.delete()
  redirect '/merchants'
end
