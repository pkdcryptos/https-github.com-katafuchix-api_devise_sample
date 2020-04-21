module Admin
  class ApplicationController < ::ApplicationController
    layout 'admin/layouts/application'

    before_action :set_pending_status_count
    def admin_only_accessible
      redirect_to admin_path unless current_admin_user.admin? || current_admin_user.special?
    end

    def special_admin_only_accessible
      redirect_to admin_index_path unless current_admin_user.special?
    end

    def skip_bullet
      Bullet.enable = false
      yield
    ensure
      Bullet.enable = true
    end

    def set_pending_status_count
      @pending_status_count = UserProfile.pending_status_count
    end

  end
end
