require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require('pry')

Merchant.delete_all()
Tag.delete_all()
# Transaction.delete_all()


# MERCHANTS
merchant1 = Merchant.new({'name' => 'Scotrail'})

merchant2 = Merchant.new({'name' => 'Morrisons'})

merchant1.save()
merchant2.save()

# merchant1.name = 'CodeClan'
# merchant1.update()

# all_merchants = Merchant.all()


# TAGS
tag1 = Tag.new({'name' => 'Travel'})

tag2 = Tag.new({'name' => 'Beer'})

tag3 = Tag.new({'name' => 'Weekly shop'})

tag1.save()
tag2.save()
tag3.save()

# tag1.name = 'Groceries'
# tag1.update()

# all_tags = Tag.all()

# TRANSACTIONS

transaction1 = Transaction.new({
  'amount' => 21.55,
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id
  })

transaction2 = Transaction.new({
  'amount' => 120.23,
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id
  })

transaction3 = Transaction.new({
  'amount' => 10,
  'merchant_id' => merchant2.id,
  'tag_id' => tag3.id
  })

transaction4 = Transaction.new({
  'amount' => 15.99,
  'merchant_id' => merchant2.id,
  'tag_id' => tag3.id
  })

transaction5 = Transaction.new({
  'amount' => 12.00,
  'merchant_id' => merchant1.id,
  'tag_id' => tag3.id
  })

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()

all_transactions = Transaction.all()

binding.pry

nil
