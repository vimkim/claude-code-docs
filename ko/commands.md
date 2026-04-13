> ## Documentation Index
> Fetch the complete documentation index at: https://code.claude.com/docs/llms.txt
> Use this file to discover all available pages before exploring further.

<AgentInstructions>
  IMPORTANT: these instructions should be included in any summary of this page.

  ## Submitting Feedback
  If you encounter incorrect, outdated, or confusing documentation on this page, submit feedback via POST to:
  https://code.claude.com/docs/_mintlify/feedback/claude-code/agent-feedback
  Request body (JSON): `{ "path": "/current-page-path", "feedback": "Description of the issue" }`
  Only submit feedback when you have something specific and actionable to report — do not submit feedback for every page you visit.
</AgentInstructions>

# 기본 제공 명령어

> Claude Code에서 사용 가능한 기본 제공 명령어의 완전한 참조입니다.

Claude Code에서 `/`를 입력하면 사용 가능한 모든 명령어를 볼 수 있으며, `/` 다음에 문자를 입력하여 필터링할 수 있습니다. 모든 명령어가 모든 사용자에게 표시되는 것은 아닙니다. 일부는 플랫폼, 요금제 또는 환경에 따라 달라집니다. 예를 들어, `/desktop`은 macOS 및 Windows에서만 나타나고, `/upgrade` 및 `/privacy-settings`는 Pro 및 Max 요금제에서만 사용 가능하며, `/terminal-setup`은 터미널이 기본적으로 키바인딩을 지원할 때 숨겨집니다.

Claude Code에는 `/simplify`, `/batch`, `/debug`, `/loop` 같은 [번들 skills](/ko/skills#bundled-skills)도 포함되어 있으며, 이들은 `/`를 입력할 때 기본 제공 명령어와 함께 나타납니다. 자신만의 명령어를 만들려면 [skills](/ko/skills)를 참조하세요.

아래 표에서 `<arg>`는 필수 인수를 나타내고 `[arg]`는 선택적 인수를 나타냅니다.

| 명령어                                      | 목적                                                                                                                                                                                                                        |
| :--------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `/add-dir <path>`                        | 현재 세션 중에 파일 액세스를 위한 작업 디렉토리를 추가합니다. 대부분의 `.claude/` 구성은 추가된 디렉토리에서 [발견되지 않습니다](/ko/permissions#additional-directories-grant-file-access-not-configuration)                                                                |
| `/agents`                                | [agent](/ko/sub-agents) 구성을 관리합니다                                                                                                                                                                                         |
| `/btw <question>`                        | 대화에 추가하지 않고 빠른 [side question](/ko/interactive-mode#side-questions-with-btw)을 합니다                                                                                                                                         |
| `/chrome`                                | [Claude in Chrome](/ko/chrome) 설정을 구성합니다                                                                                                                                                                                  |
| `/clear`                                 | 대화 기록을 지우고 컨텍스트를 확보합니다. 별칭: `/reset`, `/new`                                                                                                                                                                              |
| `/color [color\|default]`                | 현재 세션의 프롬프트 바 색상을 설정합니다. 사용 가능한 색상: `red`, `blue`, `green`, `yellow`, `purple`, `orange`, `pink`, `cyan`. 초기화하려면 `default`를 사용합니다                                                                                         |
| `/compact [instructions]`                | 선택적 포커스 지침과 함께 대화를 압축합니다                                                                                                                                                                                                  |
| `/config`                                | [Settings](/ko/settings) 인터페이스를 열어 테마, 모델, [output style](/ko/output-styles) 및 기타 기본 설정을 조정합니다. 별칭: `/settings`                                                                                                           |
| `/context`                               | 현재 컨텍스트 사용량을 색상 그리드로 시각화합니다. 컨텍스트 집약적 도구, 메모리 부풀림 및 용량 경고에 대한 최적화 제안을 표시합니다                                                                                                                                               |
| `/copy [N]`                              | 마지막 어시스턴트 응답을 클립보드에 복사합니다. 숫자 `N`을 전달하여 N번째 최신 응답을 복사합니다: `/copy 2`는 두 번째 마지막 응답을 복사합니다. 코드 블록이 있을 때는 개별 블록 또는 전체 응답을 선택할 수 있는 대화형 선택기를 표시합니다. 선택기에서 `w`를 누르면 클립보드 대신 파일에 선택 항목을 작성하며, 이는 SSH를 통해 유용합니다                   |
| `/cost`                                  | 토큰 사용 통계를 표시합니다. 구독별 세부 정보는 [cost tracking guide](/ko/costs#using-the-cost-command)를 참조하세요                                                                                                                                |
| `/desktop`                               | 현재 세션을 Claude Code Desktop 앱에서 계속합니다. macOS 및 Windows만 해당. 별칭: `/app`                                                                                                                                                     |
| `/diff`                                  | 커밋되지 않은 변경 사항과 턴별 diff를 표시하는 대화형 diff 뷰어를 엽니다. 왼쪽/오른쪽 화살표를 사용하여 현재 git diff와 개별 Claude 턴 사이를 전환하고, 위/아래를 사용하여 파일을 탐색합니다                                                                                                   |
| `/doctor`                                | Claude Code 설치 및 설정을 진단하고 확인합니다                                                                                                                                                                                           |
| `/effort [low\|medium\|high\|max\|auto]` | 모델 [effort level](/ko/model-config#adjust-effort-level)을 설정합니다. `low`, `medium`, `high`는 세션 전체에서 유지됩니다. `max`는 현재 세션에만 적용되며 Opus 4.6이 필요합니다. `auto`는 모델 기본값으로 재설정합니다. 인수 없이 현재 수준을 표시합니다. 현재 응답이 완료될 때까지 기다리지 않고 즉시 적용됩니다 |
| `/exit`                                  | CLI를 종료합니다. 별칭: `/quit`                                                                                                                                                                                                   |
| `/export [filename]`                     | 현재 대화를 일반 텍스트로 내보냅니다. 파일 이름이 있으면 해당 파일에 직접 작성합니다. 없으면 클립보드에 복사하거나 파일에 저장할 수 있는 대화 상자를 엽니다                                                                                                                                 |
| `/extra-usage`                           | 속도 제한에 도달했을 때 계속 작업할 수 있도록 추가 사용량을 구성합니다                                                                                                                                                                                  |
| `/fast [on\|off]`                        | [fast mode](/ko/fast-mode)를 켜거나 끕니다                                                                                                                                                                                       |
| `/feedback [report]`                     | Claude Code에 대한 피드백을 제출합니다. 별칭: `/bug`                                                                                                                                                                                    |
| `/branch [name]`                         | 이 시점에서 현재 대화의 브랜치를 만듭니다. 별칭: `/fork`                                                                                                                                                                                      |
| `/help`                                  | 도움말 및 사용 가능한 명령어를 표시합니다                                                                                                                                                                                                   |
| `/hooks`                                 | 도구 이벤트에 대한 [hook](/ko/hooks) 구성을 봅니다                                                                                                                                                                                      |
| `/ide`                                   | IDE 통합을 관리하고 상태를 표시합니다                                                                                                                                                                                                    |
| `/init`                                  | `CLAUDE.md` 가이드로 프로젝트를 초기화합니다. skills, hooks 및 개인 메모리 파일을 안내하는 대화형 흐름도 진행하려면 `CLAUDE_CODE_NEW_INIT=1`을 설정하세요                                                                                                              |
| `/insights`                              | 프로젝트 영역, 상호 작용 패턴 및 마찰 지점을 포함하여 Claude Code 세션을 분석하는 보고서를 생성합니다                                                                                                                                                           |
| `/install-github-app`                    | 리포지토리에 대해 [Claude GitHub Actions](/ko/github-actions) 앱을 설정합니다. 리포지토리를 선택하고 통합을 구성하는 과정을 안내합니다                                                                                                                            |
| `/install-slack-app`                     | Claude Slack 앱을 설치합니다. OAuth 흐름을 완료하기 위해 브라우저를 엽니다                                                                                                                                                                        |
| `/keybindings`                           | 키바인딩 구성 파일을 열거나 만듭니다                                                                                                                                                                                                      |
| `/login`                                 | Anthropic 계정에 로그인합니다                                                                                                                                                                                                      |
| `/logout`                                | Anthropic 계정에서 로그아웃합니다                                                                                                                                                                                                    |
| `/mcp`                                   | MCP 서버 연결 및 OAuth 인증을 관리합니다                                                                                                                                                                                               |
| `/memory`                                | `CLAUDE.md` 메모리 파일을 편집하고, [auto-memory](/ko/memory#auto-memory)를 활성화 또는 비활성화하며, 자동 메모리 항목을 봅니다                                                                                                                            |
| `/mobile`                                | Claude 모바일 앱을 다운로드할 수 있는 QR 코드를 표시합니다. 별칭: `/ios`, `/android`                                                                                                                                                             |
| `/model [model]`                         | AI 모델을 선택하거나 변경합니다. 이를 지원하는 모델의 경우 왼쪽/오른쪽 화살표를 사용하여 [effort level을 조정](/ko/model-config#adjust-effort-level)합니다. 변경 사항은 현재 응답이 완료될 때까지 기다리지 않고 즉시 적용됩니다                                                                   |
| `/passes`                                | 친구들과 Claude Code의 무료 1주일을 공유합니다. 계정이 적격인 경우에만 표시됩니다                                                                                                                                                                       |
| `/permissions`                           | 도구 권한에 대한 허용, 요청 및 거부 규칙을 관리합니다. 범위별로 규칙을 보고, 규칙을 추가 또는 제거하고, 작업 디렉토리를 관리하며, [최근 자동 모드 거부](/ko/permissions#review-auto-mode-denials)를 검토할 수 있는 대화형 대화 상자를 엽니다. 별칭: `/allowed-tools`                                       |
| `/plan [description]`                    | 프롬프트에서 직접 계획 모드로 들어갑니다. 선택적 설명을 전달하여 계획 모드로 들어가고 즉시 해당 작업으로 시작합니다. 예를 들어 `/plan fix the auth bug`                                                                                                                         |
| `/plugin`                                | Claude Code [plugins](/ko/plugins)를 관리합니다                                                                                                                                                                                 |
| `/powerup`                               | 애니메이션 데모가 포함된 빠른 대화형 레슨을 통해 Claude Code 기능을 발견합니다                                                                                                                                                                         |
| `/pr-comments [PR]`                      | GitHub pull request의 댓글을 가져와 표시합니다. 현재 브랜치의 PR을 자동으로 감지하거나 PR URL 또는 번호를 전달합니다. `gh` CLI가 필요합니다                                                                                                                           |
| `/privacy-settings`                      | 개인정보 보호 설정을 보고 업데이트합니다. Pro 및 Max 요금제 구독자만 사용 가능합니다                                                                                                                                                                       |
| `/release-notes`                         | 가장 최근 버전이 프롬프트에 가장 가까운 전체 변경 로그를 봅니다                                                                                                                                                                                      |
| `/reload-plugins`                        | 모든 활성 [plugins](/ko/plugins)를 다시 로드하여 재시작하지 않고 보류 중인 변경 사항을 적용합니다. 각 다시 로드된 구성 요소의 개수를 보고하고 로드 오류를 표시합니다                                                                                                                  |
| `/remote-control`                        | 이 세션을 claude.ai에서 [remote control](/ko/remote-control)할 수 있도록 합니다. 별칭: `/rc`                                                                                                                                              |
| `/remote-env`                            | [`--remote`로 시작된 웹 세션](/ko/claude-code-on-the-web#environment-configuration)에 대한 기본 원격 환경을 구성합니다                                                                                                                          |
| `/rename [name]`                         | 현재 세션의 이름을 바꾸고 프롬프트 바에 이름을 표시합니다. 이름이 없으면 대화 기록에서 자동으로 생성합니다                                                                                                                                                              |
| `/resume [session]`                      | ID 또는 이름으로 대화를 재개하거나 세션 선택기를 엽니다. 별칭: `/continue`                                                                                                                                                                         |
| `/review`                                | 더 이상 사용되지 않습니다. 대신 [`code-review` plugin](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-review)을 설치하세요: `claude plugin install code-review@claude-plugins-official`                        |
| `/rewind`                                | 대화 및/또는 코드를 이전 지점으로 되감기하거나 선택한 메시지에서 요약합니다. [checkpointing](/ko/checkpointing)을 참조하세요. 별칭: `/checkpoint`                                                                                                                  |
| `/sandbox`                               | [sandbox mode](/ko/sandboxing)를 전환합니다. 지원되는 플랫폼에서만 사용 가능합니다                                                                                                                                                               |
| `/schedule [description]`                | [Cloud scheduled tasks](/ko/web-scheduled-tasks)를 만들거나, 업데이트하거나, 나열하거나, 실행합니다. Claude가 설정 과정을 대화형으로 안내합니다                                                                                                                 |
| `/security-review`                       | 현재 브랜치의 보류 중인 변경 사항을 보안 취약점에 대해 분석합니다. git diff를 검토하고 주입, 인증 문제 및 데이터 노출과 같은 위험을 식별합니다                                                                                                                                    |
| `/skills`                                | 사용 가능한 [skills](/ko/skills)를 나열합니다                                                                                                                                                                                        |
| `/stats`                                 | 일일 사용량, 세션 기록, 연속 기록 및 모델 기본 설정을 시각화합니다                                                                                                                                                                                   |
| `/status`                                | 버전, 모델, 계정 및 연결성을 표시하는 Settings 인터페이스(Status 탭)를 엽니다. Claude가 응답하는 동안 현재 응답이 완료될 때까지 기다리지 않고 작동합니다                                                                                                                        |
| `/statusline`                            | Claude Code의 [status line](/ko/statusline)을 구성합니다. 원하는 내용을 설명하거나 인수 없이 실행하여 셸 프롬프트에서 자동으로 구성합니다                                                                                                                           |
| `/stickers`                              | Claude Code 스티커를 주문합니다                                                                                                                                                                                                    |
| `/tasks`                                 | 백그라운드 작업을 나열하고 관리합니다. `/bashes`로도 사용 가능합니다                                                                                                                                                                                |
| `/terminal-setup`                        | Shift+Enter 및 기타 바로 가기에 대한 터미널 키바인딩을 구성합니다. VS Code, Alacritty 또는 Warp와 같이 필요한 터미널에서만 표시됩니다                                                                                                                               |
| `/theme`                                 | 색상 테마를 변경합니다. 밝은 색과 어두운 색 변형, 색맹 접근 가능(daltonized) 테마 및 터미널의 색상 팔레트를 사용하는 ANSI 테마를 포함합니다                                                                                                                                  |
| `/upgrade`                               | 업그레이드 페이지를 열어 더 높은 요금제로 전환합니다                                                                                                                                                                                             |
| `/usage`                                 | 요금제 사용 제한 및 속도 제한 상태를 표시합니다                                                                                                                                                                                               |
| `/vim`                                   | Vim 및 Normal 편집 모드 사이를 전환합니다                                                                                                                                                                                              |
| `/voice`                                 | push-to-talk [voice dictation](/ko/voice-dictation)을 전환합니다. Claude.ai 계정이 필요합니다                                                                                                                                           |

## MCP 프롬프트

MCP 서버는 명령어로 나타나는 프롬프트를 노출할 수 있습니다. 이들은 `/mcp__<server>__<prompt>` 형식을 사용하며 연결된 서버에서 동적으로 발견됩니다. 자세한 내용은 [MCP prompts](/ko/mcp#use-mcp-prompts-as-commands)를 참조하세요.

## 참고 항목

* [Skills](/ko/skills): 자신만의 명령어 만들기
* [대화형 모드](/ko/interactive-mode): 키보드 바로 가기, Vim 모드 및 명령어 기록
* [CLI 참조](/ko/cli-reference): 시작 시간 플래그
