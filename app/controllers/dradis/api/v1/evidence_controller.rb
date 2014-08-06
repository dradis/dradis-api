module Dradis
  module API
    module V1
      class EvidenceController < APIController
        class Evidence < ::Dradis::Core::Evidence
          def as_json(options={})
            super({:only => [:id, :content]}.reverse_merge(options))
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

        # def create
        #   # See:
        #   #   http://blog.plataformatec.com.br/tag/respond_with/
        #   evidence = @node.notes.new(params[:note])
        #   evidence.author = current_user
        #   evidence.updated_by = current_user
        #   evidence.save
        #   if note.valid?
        #     respond_with(note, location: api_node_note_path(@node, note))
        #   else
        #     respond_with(note)
        #   end
        # end

        # def update
        #   respond_with Note.update(params[:id], params[:note])
        # end

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
      end
    end
  end
end