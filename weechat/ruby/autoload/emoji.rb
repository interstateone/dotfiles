require 'rumoji'

def render(data, modifier, modifier_data, message)
  Rumoji.decode(message)
end

def weechat_init
  Weechat.register 'rumoji', 'Pedro Ferreira', '0.0.1', 'MIT', 'Render emoki using Rumoji', '', ''
  Weechat.hook_modifier("weechat_print", "render", "")
  Weechat::WEECHAT_RC_OK
end
