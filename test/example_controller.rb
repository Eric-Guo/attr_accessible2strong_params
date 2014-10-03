require("csv")
class MaterialTransferIssuesController < ApplicationController
  load_and_authorize_resource
  # GET /material_transfer_issues
  # GET /material_transfer_issues.json
  def index
    @q = MaterialTransferIssue.search(params[:q])
    @material_transfer_issues = @q.result.order("created_at DESC").paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      # index.html.erb
      format.json do
        render(json: @material_transfer_issues)
      end
      format.csv do
        render_csv_header(:material_transfer_issues.to_s)
        csv_res = CSV.generate do |csv|
          csv << MaterialTransferIssue.new.attributes.keys
          MaterialTransferIssue.where("created_at > ?", 3.months.ago).find_each do |o|
            csv << o.attributes.values
          end
        end
        send_data("\uFEFF" << csv_res)
      end
    end
  end
  # GET /material_transfer_issues/1
  # GET /material_transfer_issues/1.json
  def show
    @material_transfer_issue = MaterialTransferIssue.find(params[:id])
    respond_to do |format|
      format.html
      # show.html.erb
      format.json do
        render(json: @material_transfer_issue)
      end
    end
  end
  # GET /material_transfer_issues/new
  # GET /material_transfer_issues/new.json
  def new
    if params[:last]
      @material_transfer_issue = MaterialTransferIssue.all.last.dup
    else
      @material_transfer_issue = MaterialTransferIssue.new
    end
    # after_controller_new
    respond_to do |format|
      format.html
      # new.html.erb
      format.json do
        render(json: @material_transfer_issue)
      end
    end
  end
  # GET /material_transfer_issues/1/edit
  def edit
    @material_transfer_issue = MaterialTransferIssue.find(params[:id])
  end
  # POST /material_transfer_issues
  # POST /material_transfer_issues.json
  def create
    @material_transfer_issue = MaterialTransferIssue.new(merge_create_fields(params[:material_transfer_issue]))
    respond_to do |format|
      if @material_transfer_issue.save
        format.html do
          redirect_to(material_transfer_issues_path, notice: "Material transfer issue was successfully created.")
        end
        format.json do
          render(json: @material_transfer_issue, status: :created, location: @material_transfer_issue)
        end
      else
        format.html do
          render(action: "new")
        end
        format.json do
          render(json: @material_transfer_issue.errors, status: :unprocessable_entity)
        end
      end
    end
  end
  # PUT /material_transfer_issues/1
  # PUT /material_transfer_issues/1.json
  def update
    @material_transfer_issue = MaterialTransferIssue.find(params[:id])
    respond_to do |format|
      if @material_transfer_issue.update_attributes(merge_update_fields(params[:material_transfer_issue]))
        format.html do
          redirect_to(@material_transfer_issue, notice: "Material transfer issue was successfully updated.")
        end
        format.json do
          head(:no_content)
        end
      else
        format.html do
          render(action: "edit")
        end
        format.json do
          render(json: @material_transfer_issue.errors, status: :unprocessable_entity)
        end
      end
    end
  end
  # DELETE /material_transfer_issues/1
  # DELETE /material_transfer_issues/1.json
  def destroy
    @material_transfer_issue = MaterialTransferIssue.find(params[:id])
    @material_transfer_issue.destroy
    respond_to do |format|
      format.html do
        redirect_to(material_transfer_issues_url)
      end
      format.json do
        head(:no_content)
      end
    end
  end
end
