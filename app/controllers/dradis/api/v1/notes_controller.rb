module Dradis
  module API
    module V1
      class NotesController < APIController
        class Note < ::Note
          def as_json(options={})
            super({:only => [:id, :category_id, :text]}.reverse_merge(options))
          end
        end

        before_filter :find_or_initialize_node
        respond_to :json

        def index
          respond_with @node.notes.order('created_at desc')
        end

        def show
          respond_with @node.notes.find(params[:id])
        end

        def create
          # See:
          #   http://blog.plataformatec.com.br/tag/respond_with/
          note = @node.notes.new(params[:note])
          note.author = current_user
          note.updated_by = current_user
          note.save
          if note.valid?
            respond_with(note, location: api_node_note_path(@node, note))
          else
            respond_with(note)
          end
        end

        def update
          respond_with Note.update(params[:id], params[:note])
        end

        def destroy
          respond_with Note.destroy(params[:id])
        end

        private
        # For all of the operations of this controller we need to identify the Node
        # we are working with. This filter sets the @node instance variable if the
        # give :node_id is valid.
        def find_or_initialize_node
          @node = Node.where(id: params[:node_id].to_i).first
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