module Dradis
  module API
    module V1
      class NodesController < APIController
        class Node < ::Node
          def as_json(options={})
            super({:only => [:id, :label, :type_id, :parent_id]}.reverse_merge(options))
          end
        end

        respond_to :json

        def index
          respond_with Node.order('created_at desc')
        end

        def show
          respond_with Node.find(params[:id])
        end

        def create
          # See:
          #   http://blog.plataformatec.com.br/tag/respond_with/
          node = Node.create(params[:node])
          if node.valid?
            respond_with(node, location: api_node_path(node))
          else
            respond_with(node)
          end
        end

        def update
          respond_with Node.update(params[:id], params[:node])
        end

        def destroy
          respond_with Node.destroy(params[:id])
        end
      end
    end
  end
end