
# Create PDF of W&B Docs 

Create a PDF of W&B Docs with [`docs-to-pdf`](https://github.com/jean-humann/docs-to-pdf). 

## Requirements

1. GitHub access and access to [W&B GitHub organization](https://github.com/wandb)
2. Satisfy [Docusaurus dependencies](https://github.com/wandb/docodile/tree/main?tab=readme-ov-file#docusaurus-dependencies)
3. Install `docs-to-pdf`:
```
npm install -g docs-to-pdf
```

## How to use

The default setting of the script generates the Developer guide portion of the docs (content that starts with `https://docs.wandb.ai/guides`). To create other parts of the docs, change the `DOC_TYPE` in `make_pdf.sh` to: 

| DOC_TYPE | Docs generated  |
| ----- | ----- |
| `guides` | [Developer guide](https://docs.wandb.ai/guides) |
|  `tutorials` | [Tutorials](https://docs.wandb.ai/tutorials) |
|  `ref` | [API Reference guide](https://docs.wandb.ai/ref) |

You can specify a smaller subset of docs by providing the additional path name. For example, if you want to only generate the W&B Python SDK, specify `ref/python` for `DOC_TYPE`.

Once you have the decided which docs you want to generate, run the `make_pdf.sh` script:

```bash
cd docodile-to-pdf
bash ./scripts/make_pdf.sh
```

By default, the generated PDF is stored in `docodile-to-pdf/generated_pdf` as `wb_dev_guide.pdf`. You can change this by updating `OUTPUT_DIR` and `OUTPUT_FILENAME`, in `make_pdf.sh` respectively.

In summary:

| Varialbe | Description |
| ----- | ----- |
| `DOC_TYPE` | The type of docs to generate. Set either to `guides`, `tutorials`, or `ref` |
| `OUTPUT_DIR` | Directory where  the PDF is stored |
| `OUTPUT_FILENAME` | The name of the generated PDF |
| `PORT` | Port number to use for locally hosting the docs site |

For a full list of docs-to-pdf flags, see their [CLI Global Options](https://github.com/jean-humann/docs-to-pdf?tab=readme-ov-file#-cli-global-options).

## How it works
At a high level, the scripts in this repo complete the following:

1. Remove markdown that breaks `docs-to-pdf`
2. Create a local copy of the W&B Docs
3. Install Docusaurus React App
4. Use a local host on port `3000` as the staging area where `docs-to-pdf` grabs the docs from and generates PDFs. You can change the port number by updating `PORT` in `make_pdf.sh`
3. Generates PDF

For the second to last point, this means that, if you click on a URL within the PDF, it will redirect you to a path that starts with `http://localhost:3000/`. In other words, you will not be redirected to a public website. This is done on purpose since the primary users of the W&B docs PDF do not have internet restrictions. 

