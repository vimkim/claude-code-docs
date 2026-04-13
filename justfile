# Claude Code Docs Fetcher
# Usage: just fetch | just summarize | just qa <topic>

docs_url := "https://code.claude.com/docs"
out_dir := "en"

# Download all English markdown docs
fetch:
    mkdir -p {{out_dir}}/agent-sdk {{out_dir}}/whats-new
    curl -s {{docs_url}}/llms.txt -o llms.txt
    grep -oP 'https://code\.claude\.com/docs/en/[^\)]+\.md' llms.txt \
        | sort -u \
        | xargs -P 20 -I{} bash -c ' \
            url="{}"; \
            path="${url#https://code.claude.com/docs/en/}"; \
            curl -s "$url" -o "{{out_dir}}/$path" && echo "OK: $path" || echo "FAIL: $path"'
    @echo "Done. Files in {{out_dir}}/"
    @find {{out_dir}} -name '*.md' | wc -l | xargs -I{} echo "{} files downloaded"

# Download Korean docs instead
fetch-ko:
    mkdir -p ko/agent-sdk ko/whats-new
    curl -s {{docs_url}}/llms.txt -o llms.txt
    grep -oP 'https://code\.claude\.com/docs/en/[^\)]+\.md' llms.txt \
        | sort -u \
        | sed 's|/en/|/ko/|g' \
        | xargs -P 20 -I{} bash -c ' \
            url="{}"; \
            path="${url#https://code.claude.com/docs/ko/}"; \
            curl -s "$url" -o "ko/$path" && echo "OK: $path" || echo "FAIL: $path"'
    @echo "Done. Files in ko/"

# Concatenate all docs into a single file
bundle output="claude-code-all-docs.md":
    @echo "# Claude Code Documentation" > {{output}}
    @for f in $(find {{out_dir}} -name '*.md' | sort); do \
        echo -e "\n---\n# Source: $f\n" >> {{output}}; \
        cat "$f" >> {{output}}; \
    done
    @echo "Bundled into {{output}} ($(wc -c < {{output}} | xargs) bytes)"

# Summarize all docs via Claude
summarize: bundle
    cat claude-code-all-docs.md | claude -p "Summarize these Claude Code docs. Create a concise study guide organized by topic."

# Generate Q&A for specific topics (e.g., just qa "skills mcp hooks")
qa +topics:
    cat $(echo "{{topics}}" | tr ' ' '\n' | xargs -I{} find {{out_dir}} -name '{}*.md' | sort) \
        | claude -p "Create Q&A flashcards from these docs. Format: Q: ... A: ..."

# Pipe a single doc to Claude with a custom prompt
ask file prompt:
    cat {{out_dir}}/{{file}} | claude -p "{{prompt}}"

# List all downloaded docs
list:
    @find {{out_dir}} -name '*.md' | sort | sed 's|{{out_dir}}/||'

# Clean up downloaded files
clean:
    rm -rf {{out_dir}} ko llms.txt claude-code-all-docs.md
