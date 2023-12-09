class Item < ApplicationRecord
    def soft_delete
        #updates the deleted_at attribute with the current timestamp.
        update(deleted_at: Time.current)

    def soft_delete
        #sets the deleted_at attribute to nil
        update(deleted_at: nil)

    default_scope where(:deleted_at => nil)
end
