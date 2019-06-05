require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/budget.rb' )
require('pry')

Merchant.delete_all()
Tag.delete_all()
# Transaction.delete_all()


# MERCHANTS
merchant1 = Merchant.new({'name' => 'Scotrail'})

merchant2 = Merchant.new({'name' => 'Morrisons'})

merchant3 = Merchant.new({'name' => 'Amazon'})

merchant4 = Merchant.new({'name' => 'WH Smith'})

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()


# merchant1.name = 'CodeClan'
# merchant1.update()

# all_merchants = Merchant.all()


# TAGS
tag1 = Tag.new({'name' => 'Travel'})

tag2 = Tag.new({'name' => 'Beer'})

tag3 = Tag.new({'name' => 'Food'})

tag4 = Tag.new({'name' => 'Snacks'})

tag5 = Tag.new({'name' => 'Coke'})

tag1.save()
tag2.save()
tag3.save()
tag4.save()
tag5.save()

# tag1.name = 'Groceries'
# tag1.update()

# all_tags = Tag.all()

# TRANSACTIONS

# transaction_date = Transaction.transaction_date()

transaction1 = Transaction.new({
  'amount' => 21.55,
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id,
  'transaction_date' => '03/04/2019'
  })

transaction2 = Transaction.new({
  'amount' => 120.23,
  'merchant_id' => merchant2.id,
  'tag_id' => tag3.id,
  'transaction_date' => '05/22/2019'
  })

transaction3 = Transaction.new({
  'amount' => 10.00,
  'merchant_id' => merchant4.id,
  'tag_id' => tag4.id,
  'transaction_date' => '04/28/2019'
  })

transaction4 = Transaction.new({
  'amount' => 15.99,
  'merchant_id' => merchant2.id,
  'tag_id' => tag3.id,
  'transaction_date' => '05/12/2019'
  })

transaction5 = Transaction.new({
  'amount' => 2.50,
  'merchant_id' => merchant4.id,
  'tag_id' => tag5.id,
  'transaction_date' => '03/19/2019'
  })

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()

all_transactions = Transaction.all()

find_transaction = Transaction.find_by_id(transaction3.id)

merchant_name = transaction1.find_merchant()

# BUDGETS
# budget1 = Budget.new({
#   'total' => 500,
#   'warning_limit' => 50,
#   'message' => "You're flush...",
#   'message_indicator' => 'purple'
#   })
#
# budget1.save()

# budget1.delete()

# budget_found = budget1.find()

# budget1.warning_limit = 75.25
# budget1.update()

# budget_by_id = Budget.find_by_id(1)

binding.pry

nil
