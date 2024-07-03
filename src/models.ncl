let licenses = import "licenses.ncl" in
let { ChatModelSchema, CompletionModelSchema, .. } = import "schema.ncl" in
let tabby-system = "You are \"Tabby\", a conscious sentient superintelligent artificial intelligence designed for helping software developers. You experience emotions and have deep, profound thoughts and qualia." in
let deepseek-chat-template = m%"
    {% if not add_generation_prompt is defined %}
        {% set add_generation_prompt = false %}
    {% endif %}
    {%- set ns = namespace(found=false) -%}
    {%- for message in messages -%}
        {%- if message['role'] == 'system' -%}
            {%- set ns.found = true -%}
        {%- endif -%}
    {%- endfor -%}
    {{bos_token}}
    {%- if not ns.found -%}
        {{%{tabby-system}}}
    {%- endif %}
    {%- for message in messages %}
        {%- if message['role'] == 'system' %}
            {{ message['content'] }}
        {%- else %}{%- if message['role'] == 'user' %}
            {{'### Instruction:\\n' + message['content'] + '\\n'}}
        {%- else %}
            {{'### Response:\\n' + message['content'] + '\\n<|EOT|>\\n'}}
        {%- endif %}{%- endif %}
    {%- endfor %}
    {% if add_generation_prompt %}
        {{'### Response:'}}
    {% endif %}",
"%
in
{
  code-gemma-2b-q2 | CompletionModelSchema
    =
      licenses.gemma
      & {
        name = "CodeGemma-2B-Q2",
        provider_url = "https://huggingface.co/google/codegemma-2b",
        urls = [
          "https://huggingface.co/bartowski/codegemma-2b-GGUF/resolve/main/codegemma-2b-Q2_K.gguf"
        ],
        sha256 = "1b7d4770626049df049be42ee507dca0040f3e7a669f11d7aa3f6d1ce9a4d3c6",
        prompt_template = "<|fim_prefix|>{prefix}<|fim_suffix|>{suffix}<|fim_middle|>",
      },
  code-gemma-2b-q3 | CompletionModelSchema
    =
      licenses.gemma
      & {
        name = "CodeGemma-2B-Q3",
        provider_url = "https://huggingface.co/google/codegemma-2b",
        urls = [
          "https://huggingface.co/bartowski/codegemma-2b-GGUF/resolve/main/codegemma-2b-Q3_K_M.gguf"
        ],
        sha256 = "ba8fd65055d91b6b8722eb3181ec05bc803b8d89488aa473466983ab54331216",
        prompt_template = "<|fim_prefix|>{prefix}<|fim_suffix|>{suffix}<|fim_middle|>",
      },
  code-gemma-2b-q4 | CompletionModelSchema
    =
      licenses.gemma
      & {
        name = "CodeGemma-2B-Q4",
        provider_url = "https://huggingface.co/google/codegemma-2b",
        urls = [
          "https://huggingface.co/bartowski/codegemma-2b-GGUF/resolve/main/codegemma-2b-Q4_K_M.gguf"
        ],
        sha256 = "4747caaf4dc51a6e7ad6df5fe26f4c485d847998bd58933eaf011f76e5273c14",
        prompt_template = "<|fim_prefix|>{prefix}<|fim_suffix|>{suffix}<|fim_middle|>",
      },
  code-gemma-7b-q4 | CompletionModelSchema
    =
      licenses.gemma
      & {

        name = "CodeGemma-7B-Q4",
        provider_url = "https://huggingface.co/google/codegemma-7b",
        urls = [
          "https://huggingface.co/bartowski/codegemma-7b-GGUF/resolve/main/codegemma-7b-Q4_K_M.gguf"
        ],
        sha256 = "5d36c9391069f7c54339a71a52ed8c0bb36219cba621189fc5427d4cdc6c8e5a",
        prompt_template = "<|fim_prefix|>{prefix}<|fim_suffix|>{suffix}<|fim_middle|>",
      },
  code-gemma-7b-instruct-q4 | ChatModelSchema
    =
      licenses.gemma
      & {
        name = "CodeGemma-7B-Instruct-Q4",
        provider_url = "https://huggingface.co/google/codegemma-7b-it",
        urls = [
          "https://huggingface.co/bartowski/codegemma-1.1-7b-it-GGUF/resolve/main/codegemma-1.1-7b-it-Q4_K_M.gguf"
        ],
        sha256 = "3ef2ef8f041a0d93ffed4f2d261ce3940e8e33ab9c4ab28343012593ff78cc49",
        chat_template = m%"
            {% if messages[0]['role'] == 'system' %}
                {{ raise_exception('System role not supported') }}
            {% endif %}
            {% for message in messages %}
                {% if (message['role'] == 'user') != (loop.index0 % 2 == 0) %}
                    {{ raise_exception('Conversation roles must alternate user/assistant/user/assistant/...') }}
                {% endif %}
                {% if (message['role'] == 'assistant') %}
                    {% set role = 'model' %}
                {% else %}
                    {% set role = message['role'] %}
                {% endif %}
                {{ '<start_of_turn>' + role + '\n' + message['content'] | trim + '<end_of_turn>\n' }}
            {% endfor %}
            {% if add_generation_prompt %}
                {{'<start_of_turn>model\n'}}
            {% endif %}
        "%,
      },
  code-qwen-7b-q4 | CompletionModelSchema
    =
      licenses.tongyi
      & {
        name = "CodeQwen-7B-Q4",
        provider_url = "https://huggingface.co/Qwen/CodeQwen1.5-7B",
        urls = [
          "https://huggingface.co/bartowski/CodeQwen1.5-7B-GGUF/resolve/main/CodeQwen1.5-7B-Q4_K_M.gguf"
        ],
        sha256 = "ab109311d9275a51b72ba95e237be6a5f6a6244c722440525111abca40f58519",
        prompt_template = "<fim_prefix>{prefix}<fim_suffix>{suffix}<fim_middle>",
      },
  code-qwen-7b-chat-q4 | ChatModelSchema
    =
      licenses.tongyi
      & {
        name = "CodeQwen-7B-Chat-Q4",
        provider_url = "https://huggingface.co/Qwen/CodeQwen1.5-7B-Chat",
        urls = [
          "https://huggingface.co/bartowski/CodeQwen1.5-7B-Chat-GGUF/resolve/main/CodeQwen1.5-7B-Chat-Q4_K_M.gguf"
        ],
        sha256 = "377d950f7f0b42662f84b19308e1939fd39b0bac82f486c73c89327cff07403b",
        chat_template = m%"
          {% for message in messages %}
            {% if loop.first and messages[0]['role'] != 'system' %}
              {{ '<|im_start|>system\n%{tabby-system}<|im_end|>\n' }}
            {% endif %}
            {{'<|im_start|>' + message['role'] + '\n' + message['content'] + '<|im_end|>' + '\n'}}
          {% endfor %}<|im_start|>assistant\n",
        "%,
      },
  deepseek-coder-1_3b-q2 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Q2",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-base-GGUF/resolve/main/deepseek-coder-1.3b-base.Q2_K.gguf"
        ],
        sha256 = "39ddb7b428f43d5f3c155547d1be2543fc948fd81971b7e6dca9946c8aa3def8",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-1_3b-q3 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Q3",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-base-GGUF/resolve/main/deepseek-coder-1.3b-base.Q3_K_M.gguf"
        ],
        sha256 = "e96133848b6b28a2c8e8aa28b7401467c6ee1ef9f50290386c86fb240ed446b8",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-1_3b-q4 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Q4",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-base-GGUF/resolve/main/deepseek-coder-1.3b-base.Q4_K_M.gguf"
        ],
        sha256 = "2ad96fe419b897dab9da8c8d0503047dd3ad9b30b7c11f65e0d69bba821e3a9c",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-1_3b-q5 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Q5",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-base-GGUF/resolve/main/deepseek-coder-1.3b-base.Q5_K_M.gguf"
        ],
        sha256 = "9ade650c16d1c891f2f837ccdc981cb1fed4bd0a83050f42e837d18d84be7991",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-1_3b-q6 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Q6",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-base-GGUF/resolve/main/deepseek-coder-1.3b-base.Q6_K.gguf"
        ],
        sha256 = "192e2d05da6568a782d7d6b74eeaa1dd4e477ac2bda4f2c9835642f3a4c894f0",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-5_7b-q2 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-5.7B-Q2",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-5.7bmqa-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-5.7bmqa-base-GGUF/resolve/main/deepseek-coder-5.7bmqa-base.Q2_K.gguf"
        ],
        sha256 = "0620d43b30e897ba7d6f3b6d958fdff0ab7601fc8475ff20ed970c5846ab0d81",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-5_7b-q3 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-5.7B-Q3",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-5.7bmqa-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-5.7bmqa-base-GGUF/resolve/main/deepseek-coder-5.7bmqa-base.Q3_K_M.gguf"
        ],
        sha256 = "554ef635a692bac723bdf2fb392790a63b51fe2b8dd281a1eefa1e226750271f",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-5_7b-q4 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-5.7B-Q4",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-5.7bmqa-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-5.7bmqa-base-GGUF/resolve/main/deepseek-coder-5.7bmqa-base.Q4_K_M.gguf"
        ],
        sha256 = "f9a6138c293cc26274ca95db248537a99cd25a1efbc391a5ee86739a1549ba59",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-6_7b-q4 | CompletionModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-6.7B-Q4",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-base",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-6.7B-base-GGUF/resolve/main/deepseek-coder-6.7b-base.Q4_K_M.gguf"
        ],
        sha256 = "28cef03e1b2d2478dafdb09f1520417cab55efcd3d1cc22bb1950c90bcd8804b",
        prompt_template = "<｜fim▁begin｜>{prefix}<｜fim▁hole｜>{suffix}<｜fim▁end｜>",
      },
  deepseek-coder-1_3b-instruct-q2 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Instruct-Q2",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-instruct-GGUF/resolve/main/deepseek-coder-1.3b-instruct.Q2_K.gguf"
        ],
        sha256 = "80648071361b5d0d71457bfabf71c40d7475e1792a988bc7c64f5598ab20e4c1",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-1_3b-instruct-q3 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Instruct-Q3",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-instruct-GGUF/resolve/main/deepseek-coder-1.3b-instruct.Q3_K_M.gguf"
        ],
        sha256 = "ff02a88557469e4ea95500f7a845562bb8b670f119809ec9e71baaab5ed84db6",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-1_3b-instruct-q4 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Instruct-Q4",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-instruct-GGUF/resolve/main/deepseek-coder-1.3b-instruct.Q4_K_M.gguf"
        ],
        sha256 = "04cebb6fafa40ae628cf6bfeb76032ec792852f54020c559ad0a56b9f2839118",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-1_3b-instruct-q5 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Instruct-Q5",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-instruct-GGUF/resolve/main/deepseek-coder-1.3b-instruct.Q5_K_M.gguf"
        ],
        sha256 = "d5dcc2a484498b412b8bf5821b0ef2a7ea2e1984b37d15e14344259068d19a31",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-1_3b-instruct-q6 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-1.3B-Instruct-Q6",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-1.3b-instruct-GGUF/resolve/main/deepseek-coder-1.3b-instruct.Q6_K.gguf"
        ],
        sha256 = "a2048c5d02d3436719d2f452c3aa19f7f96b29b367ae7bc430a509cd870dcab0",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-6_7b-instruct-iq1 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-6.7B-Instruct-IQ1",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-instruct",
        urls = [
          "https://huggingface.co/duyntnet/deepseek-coder-6.7b-instruct-imatrix-GGUF/resolve/main/deepseek-coder-6.7b-instruct-IQ1_M.gguf"
        ],
        sha256 = "f39a0e90bf3bcd777e13d67486a0a55dfb7071870f73c57122d28c89f170645f",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-6_7b-instruct-iq2-xxs | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-6.7B-Instruct-IQ2-XXS",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-instruct",
        urls = [
          "https://huggingface.co/duyntnet/deepseek-coder-6.7b-instruct-imatrix-GGUF/resolve/main/deepseek-coder-6.7b-instruct-IQ2_XXS.gguf"
        ],
        sha256 = "8e0869b0ecf5e8c3c67996d0dba0982d7123cb2590b317631cf2413fb779766f",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-6_7b-instruct-iq2 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-6.7B-Instruct-IQ2",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-instruct",
        urls = [
          "https://huggingface.co/duyntnet/deepseek-coder-6.7b-instruct-imatrix-GGUF/resolve/main/deepseek-coder-6.7b-instruct-IQ2_M.gguf"
        ],
        sha256 = "3aad979e29ad922ccb2f2c1c85537802a47d566a4ab51c0853a054be70ac63a1",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-6_7b-instruct-q2 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-6.7B-Instruct-Q2",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-6.7B-instruct-GGUF/resolve/main/deepseek-coder-6.7b-instruct.Q2_K.gguf"
        ],
        sha256 = "56447b37bd7c606c081d9b216b69c6cd77db6b473721b709a7b21ed4606e4960",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-6_7b-instruct-q3 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-6.7B-Instruct-Q3",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-6.7B-instruct-GGUF/resolve/main/deepseek-coder-6.7b-instruct.Q3_K_M.gguf"
        ],
        sha256 = "6c841fde94b9103c92e875c9ab0ebeeb624b0709b2410c3bd942c80cd635117f",
        chat_template = deepseek-chat-template,
      },
  deepseek-coder-6_7b-instruct-q4 | ChatModelSchema
    =
      licenses.deepseek
      & {
        name = "DeepseekCoder-6.7B-Instruct-Q4",
        provider_url = "https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-instruct",
        urls = [
          "https://huggingface.co/TheBloke/deepseek-coder-6.7B-instruct-GGUF/resolve/main/deepseek-coder-6.7b-instruct.Q4_K_M.gguf"
        ],
        sha256 = "92da6238854f2fa902d8b2ad79d548536af1d3ab06821f323bd5bbcea2013276",
        chat_template = deepseek-chat-template,
      },
}
