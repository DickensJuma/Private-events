# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @events = Event.all
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @event = Event.find(params[:id])
    # @owner = User.find(@event.user_id)
  end

  # GET /authors/new
  def new
    @event = Event.new
  end

  # GET /authors/1/edit
  def edit; end

  # POST /authors
  # POST /authors.json
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @events.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @events.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :day, :time, :about)
  end
end
