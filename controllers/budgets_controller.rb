require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('../models/budget')
also_reload('../models/*')

# INDEX route - DISPLAY ALL BUDGETS

get '/budgets' do
  @budgets = Budget.all()
  erb(:"budgets/index")
end

# NEW - DISPLAY A FORM TO MAKE A NEW BUDGET

get '/budgets/new' do
  erb(:"budgets/new")
end

# CREATE - CREATE A DATABASE ENTRY FOR THE NEW BUDGET

post '/budgets' do
  @budget = Budget.new(params)
  @budget.save()
  @budget.update_message()
  redirect '/budgets'
end

# SHOW - DISPLAY ONE BUDGET



# EDIT - DISPLAY A FORM TO EDIT A BUDGET's DETAILS

get '/budgets/:id/edit' do
  @budget = Budget.find_by_id(params['id'])
  erb(:"budgets/edit")
end

# UPDATE - UPDATES A DATABASE ENTRY FOR THE BUDGET

post '/budgets/:id' do
  @budget = Budget.new(params)
  @budget.update()
  @budget.update_message()
  redirect '/budgets'
end


# DELETE - DELETES A BUDGET  FROM THE DATABASE

post '/budgets/:id/delete' do
  @budget = Budget.find_by_id(params['id'])
  @budget.delete()
  redirect '/budgets'
end
