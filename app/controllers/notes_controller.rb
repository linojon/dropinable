class NotesController < ApplicationController

  def index
    @notes = Note.all
  end

  def new
    @note = Note.new
  end

  def create
  byebug
    @note = Note.new note_params
    if @note.save
      redirect_to notes_url
    else
      render 'new'
    end
  end

  def edit
    @note = Note.find params[:id]
  end

  def update
  byebug
    @note = Note.find params[:id]
    if @note.update_attributes(note_params)
      redirect_to notes_url
    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find params[:id]
    @note.destroy
    redirect_to :back
  end

  private

  def note_params
    params.require(:note).permit(:body, :photo ) #images: [])
  end

end
