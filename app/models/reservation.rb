class Reservation < ApplicationRecord

    belongs_to :desk
    belongs_to :user

end
