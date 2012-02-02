#encoding:UTF-8
class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.build(params[:document])
    unless Document.all.empty?
      @document.update_attributes(:dispatch_number => Document.last.dispatch_number + 1)
    else
      @document.update_attributes(:dispatch_number => 1)
    end
    if @document.save
      redirect_to documents_path, :notice => "Número gerado com sucesso: <span class=\"big-number\">#{@document.dispatch_number}</span>".html_safe
    else
      render :action => 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params[:document])
      redirect_to @document, :notice  => "Successfully updated document."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url, :notice => "Successfully destroyed document."
  end
end
