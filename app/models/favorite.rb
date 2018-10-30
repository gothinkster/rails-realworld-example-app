# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: true
end
