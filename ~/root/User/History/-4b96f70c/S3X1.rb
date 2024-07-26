class ApplicationController < ActionController::Base
    before_action :set_copyright
    def set_copyright
        @copy_right = DevcampViewTool:: Renderer.copyright 'Sushmita', 'All rights reserved '
    end
end


module DevcampViewTool
    class Renderer
        def self.copyright name, msg
            "&copy;  #{Time.now.year} | <b> #{name}</b> #{msg}".html_safe
        end
    end

end