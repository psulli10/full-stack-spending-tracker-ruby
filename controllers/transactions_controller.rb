require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('../models/transaction')
also_reload('../models/*')

# INDEX route - DISPLAY ALL TAGS

get '/transactions' do
  @transactions = Transaction.all()
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total = Transaction.total()
  erb(:"transactions/index")
end

# SORT - SORT TRANSACTIONS BY DATE

get '/transactions/by_date' do
  @transactions = Transaction.sort_by_date()
  @merchants = Merchant.all()
  @tags = Tag.all()
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

# DELETE - DELETES A MERCHSANT  FROM THE DATABASE

post '/transactions/:id/delete' do
  @transaction = Transaction.find_by_id(params['id'])
  @transaction.delete()
  redirect '/transactions'
end

# FILTER BY MERCHANT

get '/transactions/filter_merchant' do
  @transactions = Transaction.filter_merchant(params['merchant_id'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total = Transaction.total()
  @total_by_merchant = Transaction.total_by_merchant(params['merchant_id'])
  erb(:"transactions/index")
end

# FILTER BY TAG

get '/transactions/filter_tag' do
  @transactions = Transaction.filter_by_tag(params['tag_id'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total = Transaction.total()
  @total_by_tag = Transaction.total_by_tag(params['tag_id'])
  erb(:"transactions/index")
end

# FILTER BY MONTH

get '/transactions/filter_month' do
  @transactions = Transaction.filter_by_month(params['month_number'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total = Transaction.total()
  @total_by_merchant = Transaction.total_by_month(params['month_number'])
  erb(:"transactions/index")
end
