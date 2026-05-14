-- Inline ghost-text completion via Ollama (Copilot-style)
-- Requires: `ollama pull JetBrains/Mellum-4b-base`
return {
  "huggingface/llm.nvim",
  opts = {
    backend = "ollama",
    model = "JetBrains/Mellum-4b-base",
    url = "http://localhost:11434",
    request_body = {
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    },
    fim = {
      enabled = true,
      prefix = "<fim_prefix>",
      middle = "<fim_middle>",
      suffix = "<fim_suffix>",
    },
    debounce_ms = 150,
    accept_keymap = "<Tab>",
    dismiss_keymap = "<S-Tab>",
    enable_suggestions_on_startup = true,
    display = {
      renderer = "virtual_text",
      virtual_text = {
        cursor_offset = 0,
        hlgroup = "Comment",
      },
    },
  },
}
