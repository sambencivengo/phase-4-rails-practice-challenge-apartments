class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :unproc_entity
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def update
    apartment = find_apartment
    apartment.update!(apartment_params)
    render json: apartment
  end

  def index
    apartments = Apartment.all
    render json: apartments
  end

  def show
    apartment = find_apartment
    render json: apartment
  end

  def destroy
    apartment = find_apartment
    apartment.destroy
    render json: {}
  end


private

  def apartment_params
    params.permit(:number)
  end

  def unproc_entity(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def record_not_found
    render json: { errors: "Record not found" }, status: :not_found
  end

  def find_apartment
    Apartment.find(params[:id])
  end
end
