class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :unproc_entity
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  end

  def destroy
    lease = Lease.find(params[:id])
    lease.destroy
    render json: {}
  end

  def index
    leases = Lease.all
    render json: leases
  end

  def show
    lease = Lease.find(params[:id])
    render json: lease
  end

  private

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def unproc_entity(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def record_not_found
    render json: { errors: "Record not found" }, status: :not_found
  end

end
