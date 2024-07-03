{
  LicenseSchema = {
    license_name | String,
    license_url | String,
  },
  ModelSchema =
    LicenseSchema
    & {
      name | String,
      provider_url | String,
      urls | Array String,
      sha256 | String
    },
  ChatModelSchema =
    ModelSchema
    & {
      chat_template | String,
    },
  CompletionModelSchema =
    ModelSchema
    & {
      prompt_template | String,
    }
}
