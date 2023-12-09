# Test for Pacer Pro

## Test details:

Create a new Ruby on Rails model named Item with the following attributes: 
* name(string)
* deleted_at(datetime)

Implement a soft delete mechanism using the deleted_at attribute:
* Add a method soft_delete that updates the deleted_at attribute with the current timestamp.
* Add a method restore that sets the deleted_at attribute to nil.
* Include a default scope in the Item model to exclude "deleted" items from normal queries.

Write RSpec tests to ensure the soft delete functionality works correctly, here are some suggestions to start with:
* Test soft deleting an item.
* Test restoring a soft-deleted item.
* Test that soft-deleted items are excluded from normal queries.


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
