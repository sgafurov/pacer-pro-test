# Test for Pacer Pro

## Test details:

### Create a new Ruby on Rails model named Item with the following attributes: 
* name(string)
* deleted_at(datetime)

```rails generate model Item name:string deleted_at:datetime```
```
class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
```
<em>located at pacer-pro-test/db/migrate/20231209015832_create_items.rb</em>

### Implement a soft delete mechanism using the deleted_at attribute:
* Add a method soft_delete that updates the deleted_at attribute with the current timestamp.
* Add a method restore that sets the deleted_at attribute to nil.
* Include a default scope in the Item model to exclude "deleted" items from normal queries.

```
class Item < ApplicationRecord
    def soft_delete
        #updates the deleted_at attribute with the current timestamp
        update(deleted_at: Time.current)
    end

    def restore
        #sets the deleted_at attribute to nil
        update(deleted_at: nil)
    end

    #excludes "deleted" items from normal queries
    default_scope {where(:deleted_at => nil)}
end
```
<em>located at pacer-pro-test/app/models/item.rb</em>

### Write RSpec tests to ensure the soft delete functionality works correctly, here are some suggestions to start with:
* Test soft deleting an item.
* Test restoring a soft-deleted item.
* Test that soft-deleted items are excluded from normal queries.

```
require 'rails_helper'

RSpec.describe Item, type: :model do
    it "Soft deletes item" do
        item = Item.create(name:"", deleted_at:nil)
        item.soft_delete
        expect(item.deleted_at).not_to be_nil
    end

    it "Restores soft deleted item" do
        item = Item.create(name:"", deleted_at:nil)
        item.soft_delete
        expect(item.deleted_at).not_to be_nil
        item.restore
        expect(item.deleted_at).to be_nil
    end

    it "Excludes soft deleted items from normal queries" do
        normalItem = Item.create(name:"", deleted_at:nil)
        softDeletedItem = Item.create(name:"", deleted_at:nil)
        softDeletedItem.soft_delete
        expect(Item.all).to include(normalItem)
        expect(Item.all).not_to include(softDeletedItem)
    end

end
```
<em>located at pacer-pro-test/spec/models/item_spec.rb</em>

## Implementation details:
The soft delete and restore functionalities are defined in app/models/item.rb.<br />
The soft delete function uses the update method to change the deleted_at attribute's value to the current time.<br />
The restore function uses the update method to change the deleted_at attribute's value to nil.<br />
The scope states that only items with a deleted_at attribute of nil can be shown in normal queries.

My RSpec test is located in spec/models/item_spec.rb and it tests for the three requirements stated above.<br />
To test the behavior of the soft delete function, an item is first created with a blank name and a nil deleted_at attribute, soft_delete is called, and we expect for the deleted_at to not be nil.<br />
To test the restore function, an item is created with a blank name and a nil deleted_at attribute, soft delete is called and we expect deleted_at to not be nil, and the restore function is called and we expect deleted_at to be nil again.<br />
To make sure that the scope is correctly defined, the test creates two items - a normal item with a nil deleted_at, and a softDeletedItem with a deleted_at value that is not nil. We expect that the normal item is included in the retrieval of all records when we call Item.all, and for the softDeletedItem to not be included.

## How to run
Clone this repo

* Ruby version => ruby 3.1.2p20

* System dependencies => Run ```bundle install``` to install the dependencies listed in the Gemfile

* Database creation => Run ```rails db:create```

* Database initialization => Run ```rails db:migrate```

* Server => Run ```rails server``` to start application locally

* How to run the test suite => Run ```rspec spec```
