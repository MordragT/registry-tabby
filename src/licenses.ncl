let { LicenseSchema, .. } = import "schema.ncl" in
{
  gemma | LicenseSchema
    = {
      license_name = "Gemma License",
      license_url = "https://ai.google.dev/gemma/terms",
    },
  tongyi | LicenseSchema
    = {
      license_name = "Tongyi Qianwen License",
      license_url = "https://github.com/QwenLM/Qwen/blob/main/Tongyi%20Qianwen%20LICENSE%20AGREEMENT",
    },
  deepseek | LicenseSchema
    = {
      license_name = "Deepseek License",
      license_url = "https://github.com/deepseek-ai/deepseek-coder/blob/main/LICENSE-MODEL",
    },
}
