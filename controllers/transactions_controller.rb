require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('../models/transaction')
also_reload('../models/*')

# INDEX route - DISPLAY ALL TRANSACTIONS

get '/transactions' do
  @transactions = Transaction.all()
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total = Transaction.total()
  @budgets = Budget.all()
  @total_by_month = -1
  if @budgets.length > 0
  @remaining_budget = Budget.pretty_number(Budget.remaining_budget())
  end
  erb(:"transactions/index")
end

# SORT - SORT TRANSACTIONS BY DATE

get '/transactions/by_date' do
  @transactions = Transaction.sort_by_date()
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total_by_month = -1
  @total = Transaction.total()
  @budgets = Budget.all()
  @remaining_budget = Budget.remaining_budget()
  erb(:"transactions/index")
end

# NEW - DISPLAY A FORM TO MAKE A NEW TRANSACTION

get '/transactions/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transactions/new")
end

# CREATE - CREATE A DATABASE ENTRY FOR THE NEW TRANSACTION

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save()
  @budgets = Budget.all()
  if @budgets.length > 0
  @update_message = Budget.update_message
  @remaining_budget = Budget.remaining_budget()
  end
  redirect '/transactions'
end

# DELETE - DELETES A TRANSACTION FROM THE DATABASE

post '/transactions/:id/delete' do
  @transaction = Transaction.find_by_id(params['id'])
  @transaction.delete()
  @budgets = Budget.all()
  if @budgets.length > 0
  @update_message = Budget.update_message
  @remaining_budget = Budget.remaining_budget()
  end
  redirect '/transactions'
end

# FILTER TRANSACTIONS BY MERCHANT

get '/transactions/filter_merchant' do
  @transactions = Transaction.filter_merchant(params['merchant_id'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total_by_month = -1
  @total = Transaction.total()
  @total_by_merchant = Transaction.total_by_merchant(params['merchant_id'])
  @budgets = Budget.all()
  @remaining_budget = Budget.remaining_budget()
  @merchant_name = Merchant.find_merchant(params['merchant_id'])
  erb(:"transactions/index")
end

# FILTER TRANSACTIONS BY TAG

get '/transactions/filter_tag' do
  @transactions = Transaction.filter_by_tag(params['tag_id'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total = Transaction.total()
  @total_by_month = -1
  @total_by_tag = Transaction.total_by_tag(params['tag_id'])
  @budgets = Budget.all()
  @remaining_budget = Budget.remaining_budget()
  @tag_name = Transaction.find_tag(params['tag_id'])
  erb(:"transactions/index")
end

# FILTER TRANSACTIONS BY MONTH

get '/transactions/filter_month' do
  @transactions = Transaction.filter_by_month(params['month_number'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @total = Transaction.total()
  @total_by_month = Transaction.total_by_month(params['month_number'])
  @budgets = Budget.all()
  @remaining_budget = Budget.remaining_budget()
  @month_name = Transaction.return_month(params['month_number'])
  erb(:"transactions/index")
end
