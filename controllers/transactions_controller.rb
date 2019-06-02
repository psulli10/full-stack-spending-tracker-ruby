require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('../models/transaction')
also_reload('../models/*')

# INDEX route - DISPLAY ALL TAGS

get '/transactions' do
  @transactions = Transaction.all()
  @total = Transaction.total()
  erb(:"transactions/index")
end

get '/transactions/by_date' do
  @transactions = Transaction.sort_by_date()
  @total = Transaction.total()
  erb(:"transactions/index")
end

# NEW - DISPLAY A FORM TO MAKE A NEW TAG

get '/transactions/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transactions/new")
end

# CREATE - CREATE A DATABASE ENTRY FOR THE NEW TAG

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save()
  redirect '/transactions'
end
