module Dradis
  module API
    module V1
      class IssuesController < APIController
        class Issue < ::Dradis::Core::Issue
          def as_json(options={})
            super({only: [:id, :label, :type_id, :parent_id]}.reverse_merge(options))
          end
        end

        respond_to :json

        def index
          respond_with Dradis::Core::Issue.order('created_at desc')
        end

        def show
          respond_with Dradis::Core::Issue.find(params[:id].to_i)
        end

        def create
          # See:
          #   http://blog.plataformatec.com.br/tag/respond_with/
          issue = Dradis::Core::Issue.new(issue_params)
          issue.author = current_user
          issue.category = Dradis::Core::Category.issue
          issue.node = Dradis::Core::Node.issue_library
          issue.updated_by = current_user
          issue.save

          if issue.valid?
            respond_with(issue, location: api_issue_path(issue))
          else
            respond_with(issue)
          end
        end

        def update
          respond_with Dradis::Core::Issue.update(params[:id].to_i, issue_params)
        end

        def destroy
          respond_with Dradis::Core::Issue.destroy(params[:id].to_i)
        end

        private
        def issue_params
          params.require(:issue).permit(:text)
        end
      end
    end
  end
end