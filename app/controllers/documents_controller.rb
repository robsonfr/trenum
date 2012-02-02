#encoding:UTF-8
class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_profile_completeness
  
  def index
    unless current_user.admin?
      @documents = current_user.documents
    else
      @documents = Document.all
    end
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
      @document.update_attributes(:dispatch_number => Document.last.dispatch_number + 1, :status => "Upload pendente")
    else
      @document.update_attributes(:dispatch_number => 1, :status => "Upload pendente")
    end
    if @document.save
      redirect_to documents_path, :notice => "Número gerado com sucesso: <span class=\"big-number\">#{@document.dispatch_number}</span><br />Por favor, não se esqueça de fazer o upload de uma cópia do documento assinado após o envio.".html_safe
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
      redirect_to @document, :notice  => "Documento atualizado com sucesso."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url, :notice => "Documento destruído com sucesso."
  end

  def cancel
    @document = Document.find(params[:id])
    @document.update_attributes(:status => "Cancelado")
    if @document.update_attributes(params[:document])
      redirect_to @document, :notice => "Documento cancelado com sucesso"
    else
      render :action => 'show'
      flash.now[:error] = "Seu documento não foi cancelado. Por favor tente novamente."
    end
  end
end
