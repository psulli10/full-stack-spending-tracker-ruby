require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require('pry')

Merchant.delete_all()
Tag.delete_all()
# Transaction.delete_all()


# MERCHANTS
merchant1 = Merchant.new({
  'name' => 'Scotrail'
})

merchant2 = Merchant.new({
  'name' => 'Morrisons'
})

merchant1.save()
merchant2.save()

merchant1.name = 'CodeClan'
merchant1.update()

all_merchants = Merchant.all()


# TAGS
tag1 = Tag.new({
  'name' => 'Travel'
})

tag2 = Tag.new({
  'name' => 'Beer'
})

tag1.save()
tag2.save()

tag1.name = 'Groceries'
tag1.update()

all_tags = Tag.all()

binding.pry

nil
