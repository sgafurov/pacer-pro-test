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