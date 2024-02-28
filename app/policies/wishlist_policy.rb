class WishlistPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.wishlists
    end
  end
  def create?
    true
  end
  def destroy?
    true
  end
end
