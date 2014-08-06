module Dradis
  module API
    module V1
      class NodesController < APIController
        class Node < ::Dradis::Core::Node
          def as_json(options={})

            # WARN: we can use the below because Node's #as_json is broken as
            # it doesn't make use of the upstream method from ActiveModel. It
            # just ignores the :only option.
            super({only: [:id, :label, :type_id, :parent_id]}.reverse_merge(options))

            # args = {only: [:id, :label, :type_id, :parent_id]}.reverse_merge(options)
            # ActiveRecord::Base.instance_method(:as_json).bind(self).call(args)
          end
        end

        respond_to :json

        def index
          respond_with Dradis::Core::Node.order('created_at desc')
        end

        def show
          respond_with Dradis::Core::Node.find(params[:id].to_i)
        end

        def create
          # See:
          #   http://blog.plataformatec.com.br/tag/respond_with/
          node = Dradis::Core::Node.create(node_params)
          if node.valid?
            respond_with(node, location: api_node_path(node))
          else
            respond_with(node)
          end
        end

        def update
          respond_with Dradis::Core::Node.update(params[:id].to_i, node_params)
        end

        def destroy
          respond_with Dradis::Core::Node.destroy(params[:id].to_i)
        end

        private
        def node_params
          params.require(:node).permit(:label, :type_id, :parent_id)
        end
      end
    end
  end
end