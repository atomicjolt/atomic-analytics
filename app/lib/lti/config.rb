# https://canvas.instructure.com/doc/api/tools_xml.html
# LTI gem docs: https://github.com/instructure/ims-lti
module Lti

  class Config

    def self.xml(args = {})
      config(args).to_xml(indent: 2)
    end

    def self.config(args = {})
      tc = tool_config(args)

      canvas_ext_config = default_config(args)
      canvas_ext_config = resource_selection_from_args(canvas_ext_config, args)
      canvas_ext_config = course_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = account_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = editor_button_from_args(canvas_ext_config, args)

      tc.set_ext_params("canvas.instructure.com", canvas_ext_config.stringify_keys)
      tc
    end

    def self.tool_config(args = {})
      IMS::LTI::ToolConfig.new(
        title: args[:title],
        launch_url: args[:launch_url],
        description: args[:description],
        icon: args[:icon],
      )
    end

    def self.default_config(args = {})
      {
        "privacy_level" => args[:privacy_level] || "public",
        "domain" => args[:domain],
      }
    end

    def self.resource_selection_from_args(config = {}, args = {})
      if args[:resource_selection].present?
        config["resource_selection"] = args[:resource_selection].stringify_keys
        default_configs_from_args!(args, config, :resource_selection)
        default_dimensions!(config, "resource_selection")
      end
      config
    end

    def self.course_navigation_from_args(config = {}, args = {})
      if args[:course_navigation].present?
        default_configs_from_args!(args, config, :course_navigation)
      end
      config
    end

    def self.account_navigation_from_args(config = {}, args = {})
      if args[:account_navigation].present?
        default_configs_from_args!(args, config, :account_navigation)
      end
      config
    end

    def self.editor_button_from_args(config = {}, args = {})
      if args[:editor_button].present?
        config["editor_button"] = args[:editor_button].stringify_keys
        config["editor_button"]["canvas_icon_class"] ||= "icon-lti"
        config["editor_button"]["message_type"] ||= "ContentItemSelectionRequest"
        config["editor_button"]["url"] ||= args[:launch_url]
        default_dimensions!(config, "editor_button")
      end
      config
    end

    def self.default_dimensions!(config, key)
      config[key]["selection_width"] ||= "892"
      config[key]["selection_height"] ||= "800"
    end

    def self.default_configs_from_args!(args, config, key)
      config[key] = args[key].stringify_keys
      config[key]["url"] ||= args[:launch_url]
      config[key]["default"] ||= "enabled"
      config[key]["visibility"] ||= "admins"
    end

  end

end