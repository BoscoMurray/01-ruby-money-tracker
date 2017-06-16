require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require('pry-byebug')

Transaction.delete_all
Tag.delete_all
Merchant.delete_all

@merchant1 = Merchant.new({
  "name" => "amazon"
  })
@merchant1.save

@merchant2 = Merchant.new({
  "name" => "lidl"
  })
@merchant2.save

@tag1 = Tag.new({
  "name" => "clothes"
  })
@tag1.save

@tag2 = Tag.new({
  "name" => "food"
  })
@tag2.save

@transaction1 = Transaction.new({
  "date" => "2017-04-10",
  "amount" => 89,
  "merchant_id" => @merchant1.id,
  "tag_id" => @tag1.id
  })
@transaction1.save

@transaction2 = Transaction.new({
    "date" => "2017-04-15",
    "amount" => 75,
    "merchant_id" => @merchant2.id,
    "tag_id" => @tag2.id
    })
@transaction2.save

binding.pry
nil
