class Admin::TranslateController < ApplicationController
  helper 'admin/translate'

  def index
    @view_translations = ViewTranslation.find(:all,
      :conditions => [ 'language_id = ?', Locale.language.id ], :order => 'id desc')
  end

  def translate
    from = params[:view][:text]
    to = params[:view][:translation]
    Locale.set_translation(from, to)
    flash[:notice] = "Translated '#{from}' to '#{to}'"
    redirect_to :controller => 'translate', :action => 'index'
  end

  def delete
    ViewTranslation.find(params[:id]).destroy
    render :update do |page|
      page.remove("row_#{params[:id]}")
    end
  end

  def get_translation_text
    @translation = ViewTranslation.find(params[:id])
    render :text => @translation.text || ""
  end

  def set_translation_text
    @translation = ViewTranslation.find(params[:id])
    previous = @translation.text
    @translation.text = params[:value]
    @translation.text = previous unless @translation.save
    render :text => @translation.text || '[no translation]'
  end
end

