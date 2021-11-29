class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :unproc_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    def create
      tenant = Tenant.create!(tenant_params)
      render json: tenant, status: :created
    end
  
    def update
      tenant = find_tenant
      tenant.update!(tenant_params)
      render json: tenant
    end
  
    def index
      tenants = Tenant.all
      render json: tenants
    end
  
    def show
      tenant = find_tenant
      render json: tenant
    end
  
    def destroy
      tenant = find_tenant
      tenant.destroy
      render json: {}
    end
  
  
  private
  
    def tenant_params
      params.permit(:name, :age)
    end
  
    def unproc_entity(invalid)
      render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def record_not_found
      render json: { errors: "Record not found" }, status: :not_found
    end
  
    def find_tenant
      Tenant.find(params[:id])
    end
end
  
