require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('../models/tag')
also_reload('../models/*')

# INDEX route - DISPLAY ALL TAGS

get '/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

# NEW - DISPLAY A FORM TO MAKE A NEW TAG

get '/tags/new' do
  erb(:"tags/new")
end

# CREATE - CREATE A DATABASE ENTRY FOR THE NEW TAG

post '/tags' do
  @tag = Tag.new(params)
  @tag.save()
  redirect '/tags'
end

# SHOW - DISPLAY ONE TAG



# EDIT - DISPLAY A FORM TO EDIT A TAG's DETAILS

get '/tags/:id/edit' do
  @tag = Tag.find_by_id(params['id'])
  erb(:"tags/edit")
end

# UPDATE - UPDATES A DATABASE ENTRY FOR THE TAG

post '/tags/:id' do
  @tag = Tag.new(params)
  @tag.update()
  redirect '/tags'
end


# DELETE - DELETES A MERCHSANT  FROM THE DATABASE

post '/tags/:id/delete' do
  @tag = Tag.find_by_id(params['id'])
  @tag.delete()
  redirect '/tags'
end
