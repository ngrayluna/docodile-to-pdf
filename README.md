
# Docusaurus PDF

Create a PDF of W&B Docs with [`docs-to-pdf`](https://github.com/jean-humann/docs-to-pdf). 

## Requirements

1. GitHub access and access to W&B GitHub organization.
2. Satisfy [Docusaurus dependencies](https://github.com/wandb/docodile/tree/main?tab=readme-ov-file#docusaurus-dependencies).
3. Install `docs-to-pdf`:
```
npm install -g docs-to-pdf
```

## How it works
At a high level, the scripts in this repo complete the following:

1. Remove markdown that breaks `docs-to-pdf`
2. Create a local copy of the W&B Docs
3. Install Docusaurus React App
4. Use a local host on port `3000` as the staging area where `docs-to-pdf` grabs the docs from and generates PDFs. You can change the port number by updating `PORT` in `make_pdf.sh`.
3. Generates PDF

For the second to last point, this means that, if you click on a URL within the PDF, it will redirect you to a path that starts with `http://localhost:3000/`. In other words, you will not be redirected to a public website. This is done on purpose since the primary users of the W&B docs PDF do not have internet restrictions. 

## How to use

The default setting of the script generates the Developer guide portion of the docs. In other words, only content that starts with `https://docs.wandb.ai/guides`. To create other parts of the docs, change the `DOC_TYPE` in `make_pdf.sh` to: 

| Docs | DOC_TYPE | 
| ----- | ----- |
| [Developer guide](https://docs.wandb.ai/guides) | `guides` | 
| [Tutorials](https://docs.wandb.ai/tutorials) | `tutorials` | 
| [API Reference guide](https://docs.wandb.ai/ref) | `ref` |

You can specify a smaller subset of docs by providing the additional path name. For example, if you want to only generate the W&B Python SDK, specify `ref/python` for `DOC_TYPE`.

See the official [docs-to-pdf](https://github.com/jean-humann/docs-to-pdf) repo for a full list of options.

Once you have the decided which docs you want to generate, run the `make_pdf.sh` script:

```bash
cd create_doc_pdf
bash ./scripts/make_pdf.sh
```

By default, the generated PDF is stored in `create_doc_pdf/generated_pdf` as wb_dev_guide.pdf. You can change this by updating `OUTPUT_DIR` and `OUTPUT_FILENAME`, in `make_pdf.sh` respectively.