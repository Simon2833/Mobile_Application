class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy, :show]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    #@reservation = Reservation.new
    @reservation = current_user.reservations.build
  
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    #@reservation = Reservation.new(reservation_params)
    @reservation = current_user.reservations.build(reservation_params)
    if (@reservation.start_date == nil) or (@reservation.end_date == nil)
      redirect_to desks_path, notice: "Missing date"
    else
      if ((@reservation.start_date > @reservation.end_date) or (@reservation.start_date < DateTime.yesterday))
        redirect_to desks_path, notice: "Invalid date"
      else
        respond_to do |format|
          if @reservation.save
            format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
            format.json { render :show, status: :created, location: @reservation }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @reservation.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy!

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def correct_user
    
    @reservation = current_user.reservations.find_by(id: params[:id])
    redirect_to reservations_path, notice: "not authorized to edit" if @reservation.nil?

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:desk_id, :user_id, :start_date, :end_date)
    end
end
