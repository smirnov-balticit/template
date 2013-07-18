class ApplicationController < ActionController::Base
  protect_from_forgery
   
  before_filter :export_i18n_messages

  def export_i18n_messages
    SimplesIdeias::I18n.export! if Rails.env.development?
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ::AbstractController::ActionNotFound, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private

  def render_403(exception)
    respond_to do |format|
      format.html { render template: 'errors/error_403', layout: 'layouts/application', status: 403 }
      format.all { render nothing: true, status: 403 }
    end
  end

  def render_404(exception)
    respond_to do |format|
      format.html { render 'errors/error_404', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    ExceptionNotifier.notify_exception(exception,
                                       env: request.env,
                                       data: {message: 'an error happened'})
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end

  def set_admin_locale
    I18n.locale = params[:locale] || :ru
  end

end
