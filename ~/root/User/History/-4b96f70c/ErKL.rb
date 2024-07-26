class ApplicationController < ActionController::Base
    before_action :set_copyright
    def set_copyright
        @copy_right = DevcampViewTool:: Renderer.copyright 'Sushmita', 'All rights reserved '
    end
end