module Dradis
  module API
    module V1
      class EvidenceController < APIController
        class Evidence < ::Dradis::Core::Evidence
          def as_json(options={})
            super({only: [:id, :content]}.reverse_merge(options))
          end
        end

        before_filter :find_node
        respond_to :json

        def index
          respond_with @node.evidence.order('created_at desc')
        end

        def show
          respond_with @node.evidence.find(params[:id].to_i)
        end

        def create
          # See:
          #   http://blog.plataformatec.com.br/tag/respond_with/
          evidence = @node.evidence.new(evidence_params)
          evidence.author = current_user
          evidence.updated_by = current_user
          evidence.save
          if evidence.valid?
            respond_with(evidence, location: api_node_evidence_path(@node, evidence))
          else
            respond_with(evidence)
          end
        end

        def update
          respond_with @node.evidence.update(params[:id].to_i, evidence_params)
        end

        def destroy
          respond_with @node.evidence.destroy(params[:id].to_i)
        end

        private
        # For all of the operations of this controller we need to identify the Node
        # we are working with. This filter sets the @node instance variable if the
        # give :node_id is valid.
        def find_node
          @node = Dradis::Core::Node.where(id: params[:node_id].to_i).first
          unless @node
            respond_to do |format|
              format.json do
                render json: {message: 'Node not found'}, status: :unprocessable_entity
              end
            end
          end
        end

        def evidence_params
          params.require(:evidence).permit(:content, :issue_id)
        end
      end
    end
  end
end