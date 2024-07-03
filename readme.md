
<div align=center>

# 🧑‍🔬 tabby-registry 📋

[![forthebadge](https://forthebadge.com/images/badges/check-it-out.svg)](https://forthebadge.com)[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

Completion and Chat models for **Tabby**

</div>

## Chat Models

| Model ID | Quant | Size |
| -------- | ----- | ---- |
| MordragT/CodeGemma-7B-Instruct-Q4 | Q4-K-M | 5.32GB |
| MordragT/CodeQwen-7B-Chat-Q4 | Q4-K-M | 4.73GB |
| MordragT/DeepseekCoder-1.3B-Instruct-Q2 | Q2-K | 632MB |
| MordragT/DeepseekCoder-1.3B-Instruct-Q3 | Q3-K-M | 705MB |
| MordragT/DeepseekCoder-1.3B-Instruct-Q4 | Q4-K-M | 874MB |
| MordragT/DeepseekCoder-6.7B-Instruct-Q2 | Q2-K | 2.83GB |
| MordragT/DeepseekCoder-6.7B-Instruct-Q3 | Q3-K-M | 3.30GB |
| MordragT/DeepseekCoder-6.7B-Instruct-Q4 | Q4-K-M | 4.08GB |


## Completion Models

| Model ID | Quant | Size |
| -------- | ----- | ---- |
| MordragT/CodeGemma-2B-Q4 | Q4-K-M | 1.63GB |
| MordragT/CodeGemma-7B-Q4 | Q4-K-M | 5.32GB |
| MordragT/CodeQwen-7B-Q4 | Q4-K-M | 4.74GB |
| MordragT/DeepseekCoder-1.3B-Q2 | Q2-K | 632MB |
| MordragT/DeepseekCoder-1.3B-Q3 | Q3-K-M | 705MB |
| MordragT/DeepseekCoder-1.3B-Q4 | Q4-K-M | 874MB |
| MordragT/DeekseekCoder-5.7B-Q4 | Q4-K-M | 3.43GB |
| MordragT/DeepseekCoder-6.7B-Q4 | Q4-K-M | 4.08GB |

## Usage

```toml
# /etc/tabby/config.toml
[model.chat.local]
model_id = "MordragT/<model>"

[model.completion.local]
model_id = "MordragT/<model>"
```

## References

- [Tabby](https://github.com/TabbyML/tabby)
- [Tabby-Registry](https://github.com/TabbyML/tabby-registry)