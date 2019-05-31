require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require('pry')

Merchant.delete_all()
# Tag.delete_all()
# Transaction.delete_all()

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

binding.pry

nil
