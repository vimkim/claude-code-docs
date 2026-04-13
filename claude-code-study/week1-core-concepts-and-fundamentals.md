# Claude Code 학습 가이드 - 요약 & Q&A

---

## 1. Core Concepts (핵심 개념)

### 요약

Claude Code는 터미널, IDE, 데스크톱 앱, 브라우저에서 실행되는 **에이전트 코딩 도구**다. 코드베이스를 읽고, 파일을 편집하고, 명령을 실행하고, 개발 도구와 통합할 수 있다.

핵심 구성요소:
- **에이전트 루프**: 컨텍스트 수집 -> 작업 수행 -> 결과 검증의 3단계 반복
- **모델**: Claude 모델이 코드를 이해하고 추론 (Sonnet=일반, Opus=복잡한 아키텍처)
- **도구**: 파일 작업, 검색, 실행, 웹, 코드 인텔리전스 5개 범주
- **에이전트 하네스**: Claude Code는 언어 모델을 코딩 에이전트로 변환하는 도구+컨텍스트 관리+실행 환경

### Q&A

**Q1: Claude Code의 에이전트 루프 3단계는?**
A: (1) 컨텍스트 수집 - 파일 검색/읽기로 코드 이해, (2) 작업 수행 - 파일 편집/명령 실행, (3) 결과 검증 - 테스트 실행 등으로 확인. 이 단계는 작업 완료까지 반복된다.

**Q2: Claude Code의 내장 도구 5개 범주는?**
A: (1) 파일 작업(읽기/편집/생성), (2) 검색(패턴으로 파일 찾기, 정규식 콘텐츠 검색), (3) 실행(셸 명령, 테스트, git), (4) 웹(검색, 문서 가져오기), (5) 코드 인텔리전스(타입 오류 확인, 정의로 이동 - 플러그인 필요).

**Q3: Sonnet과 Opus 모델의 차이는?**
A: Sonnet은 대부분의 코딩 작업에 적합하고, Opus는 복잡한 아키텍처 결정을 위한 더 강력한 추론을 제공한다. `/model`로 세션 중 전환 가능.

**Q4: Claude Code의 "에이전트 하네스" 역할이란?**
A: 언어 모델을 능력 있는 코딩 에이전트로 변환하는 도구, 컨텍스트 관리, 실행 환경을 제공하는 것. 도구 없이는 텍스트로만 응답할 수 있지만, 도구가 있어서 실제로 작용할 수 있다.

---

## 2. How Claude Code Works (작동 방식)

### 요약

- **세션 독립성**: 각 새 세션은 이전 대화 기록 없이 새 컨텍스트 윈도우로 시작
- **세션 저장**: 대화를 로컬에 저장하여 되돌리기, 재개, 포크 가능
- **체크포인트**: 파일 편집 전 스냅샷 -> `Esc` 두 번으로 되돌리기
- **실행 환경**: 로컬(사용자 머신), 클라우드(Anthropic VM), 원격 제어(로컬+브라우저)
- **접근 범위**: 프로젝트 파일, 터미널, git 상태, CLAUDE.md, 자동 메모리, 구성된 확장

### Q&A

**Q5: 세션을 재개하는 방법은?**
A: `claude --continue`(가장 최근 대화 재개), `claude --resume`(세션 선택), `claude --resume <name>`(이름으로 재개). `--fork-session` 플래그로 원본에 영향 없이 분기 가능.

**Q6: 체크포인트와 git의 차이는?**
A: 체크포인트는 세션에 로컬이며 Claude가 편집한 파일 변경만 다룬다. 원격 시스템(DB, API, 배포)에 영향을 주는 작업은 체크포인트할 수 없다. git의 대체품이 아니다.

**Q7: 브랜치를 전환하면 Claude 세션에 어떤 영향이 있는가?**
A: Claude는 새 브랜치의 파일을 보지만 대화 기록은 동일하게 유지된다. 세션은 디렉토리에 연결되어 있으므로 git worktree를 사용하면 병렬 세션을 실행할 수 있다.

**Q8: Claude Code가 접근할 수 있는 것들은?**
A: 프로젝트 파일, 터미널(빌드 도구/git/패키지 관리자), git 상태, CLAUDE.md, 자동 메모리(MEMORY.md), 구성된 확장(MCP, skills, subagents, Chrome).

---

## 3. Extend Claude Code (확장하기)

### 요약

확장 기능 계층:
| 기능 | 수행 작업 | 사용 시기 |
|------|----------|----------|
| **CLAUDE.md** | 모든 세션 로드 컨텍스트 | 프로젝트 규칙, "항상 X" 규칙 |
| **Skills** | 온디맨드 지식/워크플로우 | 참조 문서, 반복 작업 |
| **Subagents** | 격리된 컨텍스트 실행 | 병렬 작업, 컨텍스트 격리 |
| **Agent teams** | 여러 독립 세션 조정 | 병렬 연구, 경쟁 가설 디버깅 |
| **MCP** | 외부 서비스 연결 | DB 쿼리, Slack 게시 |
| **Hooks** | 이벤트 기반 결정론적 스크립트 | 파일 편집 후 lint 자동 실행 |
| **Plugins** | 위 기능을 패키징/배포 | 팀/커뮤니티 공유 |

### Q&A

**Q9: Skill과 Subagent의 차이는?**
A: Skill은 재사용 가능한 지침/지식/워크플로우(컨텍스트에 로드됨). Subagent는 별도 컨텍스트 윈도우에서 실행되는 격리된 워커(요약만 반환). Subagent는 많은 파일을 읽어도 주 컨텍스트를 오염시키지 않는다.

**Q10: CLAUDE.md와 Skill의 차이는?**
A: CLAUDE.md는 모든 세션에 자동 로드(코딩 규칙, 빌드 명령 등). Skill은 온디맨드 로드(참조 자료, `/name`으로 트리거하는 워크플로우). CLAUDE.md는 200줄 이하 유지 권장.

**Q11: MCP란 무엇인가?**
A: Model Context Protocol - AI 도구를 외부 데이터 소스에 연결하는 개방형 표준. Google Drive, Jira, Slack, DB 등 외부 서비스와 Claude Code를 연결한다. `.mcp.json`에서 프로젝트 범위로 구성.

**Q12: Hook과 CLAUDE.md 지침의 차이는?**
A: CLAUDE.md는 Claude가 읽는 "권고적" 지침(때때로 무시 가능). Hook은 특정 이벤트(파일 편집, 도구 사용 등)에서 자동 실행되는 결정론적 스크립트로, 반드시 실행된다.

**Q13: 플러그인의 기본 구조는?**
A: `.claude-plugin/plugin.json`(매니페스트) + `skills/`(스킬) + `agents/`(에이전트) + `hooks/`(훅) + `.mcp.json`(MCP 서버). 네임스페이스로 충돌 방지(`/plugin-name:skill-name`).

---

## 4. Explore the .claude Directory (.claude 디렉토리)

### 요약

프로젝트 레벨 `.claude/` 디렉토리 구조:
- `settings.json` - 권한, hooks, 구성 (committed)
- `settings.local.json` - 개인 설정 오버라이드 (gitignored)
- `rules/` - 주제별 지침 파일, 경로별 스코핑 가능
- `skills/` - SKILL.md가 있는 에이전트 스킬
- `agents/` - 커스텀 서브에이전트 정의
- `commands/` - 레거시 명령 (skills 사용 권장)

프로젝트 루트 파일:
- `CLAUDE.md` - 프로젝트 지침
- `.mcp.json` - MCP 서버 구성
- `.worktreeinclude` - worktree에 복사할 gitignored 파일

홈 디렉토리 `~/.claude/`:
- `CLAUDE.md` - 글로벌 개인 지침
- `settings.json` - 글로벌 설정
- `rules/` - 모든 프로젝트에 적용되는 개인 규칙
- `projects/<project>/memory/` - 자동 메모리 저장소

### Q&A

**Q14: `.claude/settings.json`과 `settings.local.json`의 차이는?**
A: `settings.json`은 팀 공유용으로 커밋됨. `settings.local.json`은 개인용으로 gitignored. 로컬이 더 높은 우선순위. 배열 설정(permissions.allow)은 병합, 스칼라 설정(model)은 더 구체적인 값 사용.

**Q15: `.claude/rules/`에서 경로별 규칙을 만드는 방법은?**
A: YAML frontmatter에 `paths:` 필드 사용. 예: `paths: ["src/api/**/*.ts"]` -> Claude가 해당 패턴 파일을 읽을 때만 규칙이 로드됨. `paths` 없으면 무조건 세션 시작 시 로드.

**Q16: `.worktreeinclude` 파일의 역할은?**
A: worktree 생성 시 `.env` 같은 gitignored 파일을 자동 복사할 목록. `.gitignore` 구문 사용. gitignored 파일만 대상.

---

## 5. Explore the Context Window (컨텍스트 윈도우)

### 요약

컨텍스트 윈도우 로드 순서:
1. 시스템 프롬프트 (~4,200 토큰, 숨김)
2. 자동 메모리 MEMORY.md (~680 토큰, 숨김)
3. 환경 정보 (~280 토큰, 숨김)
4. MCP 도구 이름 (지연 로드, ~120 토큰)
5. Skill 설명 (~450 토큰, `/compact` 후 미보존)
6. `~/.claude/CLAUDE.md` (~320 토큰)
7. 프로젝트 CLAUDE.md (~1,800 토큰)
8. 사용자 프롬프트
9. Claude의 도구 사용(파일 읽기, 검색, 편집 등)
10. 경로별 규칙 (매칭 파일 읽을 때 자동 로드)
11. Hooks 출력 (additionalContext 필드로)

컨텍스트가 가득 찰 때: 이전 도구 출력 지우기 -> 대화 요약 -> 지속적 규칙은 CLAUDE.md에 보존

### Q&A

**Q17: 컨텍스트 윈도우에서 가장 많은 공간을 차지하는 것은?**
A: 파일 읽기가 컨텍스트를 가장 많이 소비한다. 프롬프트를 구체적으로 하면("auth.ts의 버그 수정") Claude가 더 적은 파일을 읽는다. 연구가 많은 작업은 subagent 사용 권장.

**Q18: `/compact`와 `/clear`의 차이는?**
A: `/compact`는 대화를 요약하여 컨텍스트 축소(CLAUDE.md는 디스크에서 다시 읽어 보존). `/clear`는 컨텍스트 윈도우를 완전히 리셋. 관련 없는 작업 간에는 `/clear`, 같은 작업 계속 시 `/compact` 사용.

**Q19: MCP 도구의 "지연 로드"란?**
A: 기본적으로 MCP 도구 이름만 컨텍스트에 로드되고, 전체 스키마는 Claude가 실제로 사용할 때 tool search를 통해 로드됨. `ENABLE_TOOL_SEARCH=false`로 전부 즉시 로드 가능.

**Q20: Skill 설명이 `/compact` 후 보존되지 않는 이유는?**
A: Skill 설명 목록은 `/compact` 후 재주입되지 않음. 실제로 호출한 skill만 보존됨. `disable-model-invocation: true` 설정된 skill은 수동 호출 전까지 설명 목록에도 포함되지 않음.

---

## 6. Use Claude Code (사용법)

### 요약

핵심 사용 팁:
- **대화형**: 완벽한 프롬프트 불필요. 시작 -> 반복 -> 개선
- **중단 가능**: 언제든 수정 입력 -> Enter -> Claude가 방향 조정
- **구체적으로**: 파일 참조, 제약 조건, 예제 패턴 지정
- **검증 제공**: 테스트 케이스, 스크린샷, 예상 출력
- **탐색 먼저**: Plan Mode로 분석 -> 계획 검토 -> 구현
- **위임**: 세부 지시 대신 컨텍스트+방향 제공

### Q&A

**Q21: Claude Code에서 "지시하지 말고 위임하라"는 무슨 의미인가?**
A: 읽을 파일이나 실행할 명령을 지정하는 대신, 컨텍스트와 방향을 제공하고 세부사항은 Claude가 파악하도록 한다. 예: "src/payments/ 확인하고 만료 카드 버그 수정해" (O) vs "auth.ts 32줄 읽고 if문 추가해" (X).

**Q22: Plan Mode를 어떻게 사용하는가?**
A: `Shift+Tab`으로 전환하거나 `claude --permission-mode plan`으로 시작. Claude가 읽기 전용으로 탐색/분석 후 계획 제시. 계획 승인 시 자동 모드, 편집 수락, 수동 검토 중 선택 가능. 복잡한 리팩토링, 다단계 구현에 유용.

**Q23: `@` 참조란?**
A: 프롬프트에서 `@src/auth.js`처럼 파일을 직접 참조하면 해당 파일 내용이 대화에 포함됨. 디렉토리도 가능(`@src/components`). MCP 리소스도 참조 가능(`@github:repos/owner/repo/issues`).

---

## 7. Store Instructions and Memories (지침 및 메모리)

### 요약

**CLAUDE.md 파일:**
- 범위: 관리 정책(조직), 프로젝트(`./CLAUDE.md`), 사용자(`~/.claude/CLAUDE.md`)
- 200줄 이하 권장. `@path/to/import`로 추가 파일 가져오기
- 구체적이고 간결한 지침이 가장 잘 작동
- `/init`으로 자동 생성, `/memory`로 편집

**자동 메모리:**
- Claude가 자동으로 학습을 저장 (빌드 명령, 디버깅 인사이트, 선호도)
- `~/.claude/projects/<project>/memory/`에 저장
- `MEMORY.md` 처음 200줄 또는 25KB가 세션 시작 시 로드
- 주제 파일은 필요할 때 읽음
- 기본 켜짐, `/memory`에서 토글 가능

**`.claude/rules/`:**
- 주제별 마크다운 파일로 지침 분리
- `paths:` frontmatter로 특정 파일 유형에만 적용 가능
- 심볼릭 링크로 프로젝트 간 공유 가능

### Q&A

**Q24: CLAUDE.md와 자동 메모리의 차이는?**
A: CLAUDE.md는 사용자가 작성하는 지침/규칙(코딩 표준, 워크플로우). 자동 메모리는 Claude가 자동 작성하는 학습 노트(빌드 명령, 디버깅 인사이트). 둘 다 세션 시작 시 로드되지만 목적이 다름.

**Q25: CLAUDE.md에 포함할 것과 제외할 것은?**
A: 포함: Claude가 추측 불가한 Bash 명령, 기본값과 다른 코드 스타일, 테스트 지침, 저장소 에티켓, 일반적인 함정. 제외: 코드 읽으면 파악 가능한 것, 표준 언어 규칙, 긴 API 문서(링크 대신), 자주 변경되는 정보.

**Q26: `@path` 가져오기의 동작은?**
A: CLAUDE.md에서 `@README`처럼 참조하면 해당 파일이 세션 시작 시 함께 로드됨. 상대/절대 경로 가능. 최대 5홉 재귀 가져오기 지원. 외부 가져오기는 첫 발견 시 승인 대화 표시.

**Q27: `/compact` 후 CLAUDE.md 지침이 사라지는가?**
A: 아니요. CLAUDE.md는 압축을 완전히 생존한다. `/compact` 후 디스크에서 다시 읽어 재주입됨. 사라진 지침은 CLAUDE.md가 아닌 대화에서만 제공된 것.

**Q28: 자동 메모리를 다른 위치에 저장하려면?**
A: 사용자 또는 로컬 설정에서 `"autoMemoryDirectory": "~/my-custom-dir"` 설정. 보안상 프로젝트 설정(`.claude/settings.json`)에서는 허용 안됨.

---

## 8. Permission Modes (권한 모드)

### 요약

| 모드 | Claude가 묻지 않고 하는 것 | 최적 사용 |
|------|------------------------|---------|
| `default` | 파일 읽기만 | 민감한 작업, 시작 단계 |
| `acceptEdits` | 파일 읽기 + 편집 | 코드 반복 중 |
| `plan` | 파일 읽기만 (쓰기 불가) | 코드베이스 탐색, 계획 |
| `auto` | 모든 작업 (분류기 검사) | 장시간 작업, 프롬프트 피로 감소 |
| `bypassPermissions` | 거의 모든 작업 | 격리된 컨테이너/VM만 |
| `dontAsk` | 사전 승인된 도구만 | CI, 잠금 환경 |

전환: `Shift+Tab`(세션 중), `--permission-mode <mode>`(시작 시), 설정 파일 `defaultMode`(기본값)

**자동 모드 특징:**
- 별도 분류기 모델(Sonnet 4.6)이 각 작업 평가
- 범위 초과, 알 수 없는 인프라, 악의적 지시 차단
- Team/Enterprise/API 플랜 + Sonnet 4.6 또는 Opus 4.6 필요
- 3회 연속 또는 20회 총 차단 시 일시 중지

### Q&A

**Q29: `Shift+Tab` 순환 순서는?**
A: `default` -> `acceptEdits` -> `plan` -> `auto` (auto는 `--enable-auto-mode` 전달 시만). `dontAsk`는 순환에 나타나지 않음. `bypassPermissions`는 명시적 활성화 시만.

**Q30: 자동 모드의 분류기는 무엇을 차단하는가?**
A: 기본 차단: 코드 다운로드+실행(`curl | bash`), 외부로 민감한 데이터 전송, 프로덕션 배포, 클라우드 대량 삭제, IAM 권한 부여, 강제 푸시. 기본 허용: 로컬 파일 작업, 선언된 종속성 설치, `.env` 읽기, 읽기 전용 HTTP.

**Q31: 보호된 디렉토리란?**
A: `.git`, `.vscode`, `.idea`, `.husky`, `.claude`에 대한 쓰기는 모든 모드에서 자동 승인되지 않음(`.claude/commands`, `.claude/agents`, `.claude/skills` 제외). 리포지토리 상태, 편집기 구성, git 훅 보호.

**Q32: `dontAsk`와 `bypassPermissions`의 차이는?**
A: `dontAsk`는 허용 규칙에 없는 모든 도구를 자동 거부(완전 비대화형). `bypassPermissions`는 보호된 디렉토리 쓰기 외 모든 권한 프롬프트 비활성화. `dontAsk`는 CI에, `bypassPermissions`는 격리된 컨테이너에.

---

## 9. Common Workflows (일반적인 워크플로우)

### 요약

**코드베이스 이해:**
- `"give me an overview of this codebase"` -> 특정 구성 요소로 좁히기
- `"trace the login process from front-end to database"`

**버그 수정:**
- 오류 메시지/스택 추적 공유 -> 수정 요청 -> 적용

**리팩토링:**
- 레거시 코드 식별 -> 권장사항 -> 안전한 변경 -> 테스트 검증

**테스트 작성:**
- 테스트 안된 코드 식별 -> 스캐폴딩 생성 -> 엣지 케이스 추가 -> 실행 검증

**PR 생성:**
- `"create a pr for my changes"` 또는 단계별 안내

**Subagent 사용:**
- `/agents`로 사용 가능한 에이전트 확인
- 자동 위임 또는 명시적 요청: `"use the code-reviewer subagent to check the auth module"`

**비대화형 모드:**
- `claude -p "prompt"` - CI, 스크립트 통합
- `--output-format json` 또는 `stream-json`

**병렬 세션:**
- 데스크톱 앱, 웹, Agent teams
- Writer/Reviewer 패턴: 작성 세션 + 검토 세션

### Q&A

**Q33: Claude에게 인터뷰를 받는 워크플로우란?**
A: 간단한 설명 + "AskUserQuestion 도구로 인터뷰해달라" 요청. Claude가 기술 구현, UI/UX, 엣지 케이스, 트레이드오프에 대해 질문. 인터뷰 완료 후 SPEC.md 작성 -> 새 세션에서 구현.

**Q34: 파일 전체에 fan out하는 방법은?**
A: `for file in $(cat files.txt); do claude -p "React->Vue 마이그레이션 $file" --allowedTools "Edit,Bash(git commit *)"; done`. 먼저 2-3개 파일로 프롬프트 테스트 후 전체 실행.

**Q35: `--from-pr` 플래그의 용도는?**
A: `claude --from-pr 123`으로 특정 PR에 연결된 세션을 재개. `gh pr create`로 PR을 만들면 세션이 자동 연결됨.

**Q36: 확장된 사고(thinking mode)를 제어하는 방법은?**
A: `/effort`로 노력 수준 조정, "ultrathink" 키워드로 일회성 높은 추론, `Option+T`/`Alt+T`로 토글, `/config`로 전역 기본값, `MAX_THINKING_TOKENS` 환경변수로 예산 제한.

---

## 10. Best Practices (모범 사례)

### 요약

**가장 중요한 원칙: 컨텍스트 윈도우 관리**
- LLM 성능은 컨텍스트가 채워질수록 저하
- 가장 중요한 관리 대상 리소스

**핵심 모범 사례:**

1. **검증 방법 제공** (가장 높은 영향)
   - 테스트 케이스, 스크린샷, 예상 출력 포함
   - Claude가 자체 작업을 확인할 수 있게

2. **탐색 -> 계획 -> 코드**
   - Plan Mode로 연구와 구현 분리
   - 작은 작업은 계획 건너뛰기

3. **구체적 컨텍스트 제공**
   - 파일 참조, 제약 조건 명시, 패턴 지적
   - `@`로 파일 참조, 이미지 붙여넣기, 데이터 파이프

4. **환경 구성**
   - CLAUDE.md 200줄 이하 유지
   - `/permissions`로 허용 목록 관리
   - MCP 서버, hooks, skills, subagents 설정

5. **컨텍스트 적극 관리**
   - 작업 간 `/clear` 사용
   - subagent로 연구 위임
   - 2번 수정 실패 시 `/clear` + 더 나은 프롬프트

**일반적인 실패 패턴:**
- 주방 싱크 세션 (관련 없는 작업 혼합) -> `/clear`
- 반복적 수정 (실패 접근 방식 오염) -> `/clear` + 새 프롬프트
- 과도한 CLAUDE.md (규칙 무시) -> 정리 또는 hook 전환
- 검증 없는 신뢰 -> 항상 테스트/스크린샷 제공
- 범위 없는 탐색 -> subagent 사용 또는 좁게 범위 지정

### Q&A

**Q37: CLAUDE.md가 무시되는 이유는?**
A: (1) 파일이 너무 길어서 규칙이 노이즈에 묻힘, (2) 지침이 모호함, (3) 충돌하는 지침 존재. 해결: `/memory`로 로드 확인, 더 구체적으로, 충돌 제거, 200줄 이하 유지.

**Q38: 컨텍스트 관리를 위한 최선의 전략은?**
A: (1) 작업 간 `/clear`, (2) subagent로 연구 위임, (3) `/compact <focus>`로 선택적 압축, (4) `/btw`로 사이드 질문(컨텍스트 미소비), (5) 구체적 프롬프트로 파일 읽기 최소화.

**Q39: Writer/Reviewer 패턴이란?**
A: 세션 A(작성자)가 코드 구현 -> 세션 B(검토자)가 새 컨텍스트로 독립 검토 -> 세션 A가 피드백 반영. 새 컨텍스트는 방금 작성한 코드에 편향되지 않아 검토 품질 향상.

**Q40: "직관 개발하기"의 핵심 메시지는?**
A: 모범 사례는 시작점이지 절대 규칙이 아님. Claude가 좋은 출력을 낼 때의 패턴(프롬프트 구조, 컨텍스트, 모드)을 관찰하고, 어려움을 겪을 때 원인(시끄러운 컨텍스트? 모호한 프롬프트? 너무 큰 작업?)을 분석하여 자신만의 직관을 발전시키라.

---

## 종합 복습 Q&A

**Q41: Claude Code 세션의 전체 생명주기를 설명하라.**
A: (1) 시작: 시스템 프롬프트 + 자동 메모리 + CLAUDE.md + 환경 정보 로드 (2) 사용자 프롬프트 입력 (3) 에이전트 루프: 컨텍스트 수집(파일 읽기/검색) -> 작업 수행(편집/명령) -> 결과 검증(테스트) 반복 (4) 필요시 컨텍스트 압축/정리 (5) 세션 저장(재개/포크 가능). 체크포인트로 언제든 되돌리기 가능.

**Q42: 대규모 모노레포에서 Claude Code를 효과적으로 사용하는 방법은?**
A: (1) `claudeMdExcludes`로 불필요한 CLAUDE.md 제외, (2) `.claude/rules/`에 `paths:` 경로별 규칙으로 관련 지침만 로드, (3) subagent로 탐색 위임하여 컨텍스트 보존, (4) git worktree로 병렬 세션 실행, (5) Skills로 팀별 워크플로우 패키징.

**Q43: Claude Code의 보안 모범 사례는?**
A: (1) `default` 모드로 시작하여 작업 검토, (2) `/permissions`로 신뢰 명령만 허용, (3) `bypassPermissions`는 격리 환경만, (4) auto 모드는 분류기가 있지만 안전 보장 아님, (5) 보호된 디렉토리(.git 등) 자동 보호, (6) hooks로 결정론적 보안 검사 강제.

**Q44: 새 프로젝트에서 Claude Code를 처음 설정하는 순서는?**
A: (1) `claude` 실행 + 로그인, (2) `/init`으로 CLAUDE.md 자동 생성, (3) 프로젝트 규칙 추가/수정, (4) 필요시 MCP 서버 연결(`claude mcp add`), (5) 반복 작업을 Skills로 정의, (6) 팀 공유 시 `.claude/settings.json`에 권한/hooks 설정.

**Q45: 컨텍스트 윈도우가 가득 찼을 때 대처법은?**
A: (1) `/compact <focus>`로 포커스 유지하며 압축, (2) `/clear`로 완전 리셋 후 더 나은 프롬프트로 재시작, (3) subagent로 탐색 위임, (4) `Esc+Esc`로 특정 지점에서 요약, (5) CLAUDE.md에 압축 시 보존할 내용 명시("When compacting, preserve...").
