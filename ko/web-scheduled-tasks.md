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

# 웹에서 작업 예약하기

> Anthropic 관리 인프라를 사용하여 반복되는 작업 자동화하기

예약된 작업은 Anthropic 관리 인프라를 사용하여 반복되는 일정에 따라 프롬프트를 실행합니다. 작업은 컴퓨터가 꺼져 있어도 계속 작동합니다.

자동화할 수 있는 반복 작업의 몇 가지 예시입니다:

* 매일 아침 열린 pull request 검토
* 밤새 CI 실패 분석 및 요약 제공
* PR 병합 후 문서 동기화
* 매주 종속성 감사 실행

예약된 작업은 Pro, Max, Team, Enterprise를 포함한 모든 Claude Code 웹 사용자가 사용할 수 있습니다.

## 예약 옵션 비교

Claude Code offers three ways to schedule recurring work:

|                            | [Cloud](/en/web-scheduled-tasks) | [Desktop](/en/desktop-scheduled-tasks) | [`/loop`](/en/scheduled-tasks) |
| :------------------------- | :------------------------------- | :------------------------------------- | :----------------------------- |
| Runs on                    | Anthropic cloud                  | Your machine                           | Your machine                   |
| Requires machine on        | No                               | Yes                                    | Yes                            |
| Requires open session      | No                               | No                                     | Yes                            |
| Persistent across restarts | Yes                              | Yes                                    | No (session-scoped)            |
| Access to local files      | No (fresh clone)                 | Yes                                    | Yes                            |
| MCP servers                | Connectors configured per task   | [Config files](/en/mcp) and connectors | Inherits from session          |
| Permission prompts         | No (runs autonomously)           | Configurable per task                  | Inherits from session          |
| Customizable schedule      | Via `/schedule` in the CLI       | Yes                                    | Yes                            |
| Minimum interval           | 1 hour                           | 1 minute                               | 1 minute                       |

<Tip>
  Use **cloud tasks** for work that should run reliably without your machine. Use **Desktop tasks** when you need access to local files and tools. Use **`/loop`** for quick polling during a session.
</Tip>

## 예약된 작업 만들기

세 가지 위치에서 예약된 작업을 만들 수 있습니다:

* **웹**: [claude.ai/code/scheduled](https://claude.ai/code/scheduled)를 방문하고 **새 예약된 작업** 클릭
* **데스크톱 앱**: **일정** 페이지를 열고 **새 작업**을 클릭한 후 **새 원격 작업**을 선택합니다. 자세한 내용은 [데스크톱 예약된 작업](/ko/desktop#schedule-recurring-tasks)을 참조하세요.
* **CLI**: 모든 세션에서 `/schedule`을 실행합니다. Claude가 설정을 대화형으로 안내합니다. `/schedule daily PR review at 9am`과 같이 설명을 직접 전달할 수도 있습니다.

웹 및 데스크톱 진입점은 양식을 엽니다. CLI는 안내식 대화를 통해 동일한 정보를 수집합니다.

아래 단계는 웹 인터페이스를 통해 설명합니다.

<Steps>
  <Step title="생성 양식 열기">
    [claude.ai/code/scheduled](https://claude.ai/code/scheduled)를 방문하고 **새 예약된 작업**을 클릭합니다.
  </Step>

  <Step title="작업 이름 지정 및 프롬프트 작성">
    작업에 설명적인 이름을 지정하고 Claude가 매번 실행할 프롬프트를 작성합니다. 프롬프트가 가장 중요한 부분입니다: 작업이 자율적으로 실행되므로 프롬프트는 자체 포함되어야 하며 수행할 작업과 성공이 무엇인지에 대해 명시적이어야 합니다.

    프롬프트 입력에는 모델 선택기가 포함됩니다. Claude는 작업의 각 실행에 이 모델을 사용합니다.
  </Step>

  <Step title="저장소 선택">
    Claude가 작업할 하나 이상의 GitHub 저장소를 추가합니다. 각 저장소는 실행 시작 시 기본 분기에서 시작하여 복제됩니다. Claude는 변경 사항에 대해 `claude/` 접두사가 붙은 분기를 만듭니다. 모든 분기로의 푸시를 허용하려면 해당 저장소에 대해 **제한 없는 분기 푸시 허용**을 활성화합니다.
  </Step>

  <Step title="환경 선택">
    작업에 대한 [클라우드 환경](/ko/claude-code-on-the-web#cloud-environment)을 선택합니다. 환경은 클라우드 세션이 액세스할 수 있는 항목을 제어합니다:

    * **네트워크 액세스**: 각 실행 중에 사용 가능한 인터넷 액세스 수준 설정
    * **환경 변수**: Claude가 사용할 수 있는 API 키, 토큰 또는 기타 비밀 제공
    * **설정 스크립트**: 각 세션 시작 전에 종속성 설치 또는 도구 구성과 같은 설치 명령 실행

    **기본** 환경은 기본적으로 사용 가능합니다. 사용자 정의 환경을 사용하려면 작업을 만들기 전에 [하나를 만드세요](/ko/claude-code-on-the-web#cloud-environment).
  </Step>

  <Step title="일정 선택">
    [빈도 옵션](#frequency-options)에서 작업이 실행되는 빈도를 선택합니다. 기본값은 현지 시간대의 매일 오전 9:00입니다. 작업은 예약된 시간보다 몇 분 후에 실행될 수 있습니다.

    사전 설정 옵션이 필요에 맞지 않으면 가장 가까운 옵션을 선택하고 `/schedule update`를 사용하여 CLI에서 일정을 업데이트하여 특정 일정을 설정합니다.
  </Step>

  <Step title="커넥터 검토">
    연결된 모든 [MCP 커넥터](/ko/mcp)는 기본적으로 포함됩니다. 작업에 필요하지 않은 것들을 제거합니다. 커넥터는 Claude에게 각 실행 중에 Slack, Linear 또는 Google Drive와 같은 외부 서비스에 대한 액세스를 제공합니다.
  </Step>

  <Step title="작업 만들기">
    **만들기**를 클릭합니다. 작업이 예약된 작업 목록에 나타나고 다음 예약된 시간에 자동으로 실행됩니다. 각 실행은 다른 세션과 함께 새 세션을 만들며, 여기서 Claude가 수행한 작업을 확인하고, 변경 사항을 검토하고, pull request를 만들 수 있습니다. 실행을 즉시 트리거하려면 작업의 세부 정보 페이지에서 **지금 실행**을 클릭합니다.
  </Step>
</Steps>

### 빈도 옵션

일정 선택기는 시간대 변환을 처리하는 사전 설정 빈도를 제공합니다. 현지 시간대에서 시간을 선택하면 클라우드 인프라가 어디에 있든 관계없이 작업이 해당 벽시계 시간에 실행됩니다.

<Note>
  작업은 예약된 시간보다 몇 분 후에 실행될 수 있습니다. 오프셋은 각 작업에 대해 일관성이 있습니다.
</Note>

| 빈도  | 설명                                            |
| :-- | :-------------------------------------------- |
| 시간별 | 매시간 실행됩니다.                                    |
| 일일  | 지정한 시간에 하루에 한 번 실행됩니다. 기본값은 현지 시간 오전 9:00입니다. |
| 평일  | 일일과 동일하지만 토요일과 일요일을 건너뜁니다.                    |
| 주간  | 지정한 요일과 시간에 주당 한 번 실행됩니다.                     |

2시간마다 또는 매월 첫 번째와 같은 사용자 정의 간격의 경우 가장 가까운 사전 설정을 선택하고 `/schedule update`를 사용하여 CLI에서 일정을 업데이트하여 특정 일정을 설정합니다.

### 저장소 및 분기 권한

추가하는 각 저장소는 모든 실행에서 복제됩니다. Claude는 프롬프트에서 달리 지정하지 않는 한 저장소의 기본 분기에서 시작합니다.

기본적으로 Claude는 `claude/` 접두사가 붙은 분기로만 푸시할 수 있습니다. 이는 예약된 작업이 실수로 보호되거나 오래된 분기를 수정하는 것을 방지합니다.

특정 저장소에 대해 이 제한을 제거하려면 작업을 만들거나 편집할 때 해당 저장소에 대해 **제한 없는 분기 푸시 허용**을 활성화합니다.

### 커넥터

예약된 작업은 연결된 MCP 커넥터를 사용하여 각 실행 중에 외부 서비스에서 읽고 쓸 수 있습니다. 예를 들어 지원 요청을 분류하는 작업은 Slack 채널에서 읽고 Linear에서 문제를 만들 수 있습니다.

작업을 만들 때 현재 연결된 모든 커넥터는 기본적으로 포함됩니다. 실행 중에 Claude가 액세스할 수 있는 도구를 제한하기 위해 필요하지 않은 것들을 제거합니다. 작업 양식에서 직접 커넥터를 추가할 수도 있습니다.

작업 양식 외부에서 커넥터를 관리하거나 추가하려면 claude.ai의 **설정 > 커넥터**를 방문하거나 CLI에서 `/schedule update`를 사용합니다.

### 환경

각 작업은 네트워크 액세스, 환경 변수 및 설정 스크립트를 제어하는 [클라우드 환경](/ko/claude-code-on-the-web#cloud-environment)에서 실행됩니다. 작업을 만들기 전에 환경을 구성하여 Claude에게 API에 대한 액세스를 제공하거나, 종속성을 설치하거나, 네트워크 범위를 제한합니다. 전체 설정 가이드는 [클라우드 환경](/ko/claude-code-on-the-web#cloud-environment)을 참조하세요.

## 예약된 작업 관리

**예약됨** 목록의 작업을 클릭하여 세부 정보 페이지를 엽니다. 세부 정보 페이지는 작업의 저장소, 커넥터, 프롬프트, 일정 및 과거 실행 목록을 표시합니다.

### 실행 보기 및 상호 작용

모든 실행을 클릭하여 전체 세션으로 엽니다. 여기서 Claude가 수행한 작업을 확인하고, 변경 사항을 검토하고, pull request를 만들거나, 대화를 계속할 수 있습니다. 각 실행 세션은 다른 세션처럼 작동합니다: 세션 제목 옆의 드롭다운 메뉴를 사용하여 이름을 바꾸거나, 보관하거나, 삭제합니다.

### 작업 편집 및 제어

작업 세부 정보 페이지에서 다음을 수행할 수 있습니다:

* **지금 실행**을 클릭하여 다음 예약된 시간을 기다리지 않고 즉시 실행을 시작합니다.
* **반복** 섹션의 토글을 사용하여 일정을 일시 중지하거나 재개합니다. 일시 중지된 작업은 구성을 유지하지만 다시 활성화할 때까지 실행되지 않습니다.
* 편집 아이콘을 클릭하여 이름, 프롬프트, 일정, 저장소, 환경 또는 커넥터를 변경합니다.
* 삭제 아이콘을 클릭하여 작업을 제거합니다. 작업에서 만든 과거 세션은 세션 목록에 남아 있습니다.

CLI에서 `/schedule`을 사용하여 작업을 관리할 수도 있습니다. `/schedule list`를 실행하여 모든 작업을 보거나, `/schedule update`를 사용하여 작업을 변경하거나, `/schedule run`을 사용하여 즉시 트리거합니다.

## 관련 리소스

* [데스크톱 예약된 작업](/ko/desktop#schedule-recurring-tasks): 로컬 파일에 액세스할 수 있는 컴퓨터에서 실행되는 작업을 예약합니다. 데스크톱 앱의 **일정** 페이지는 동일한 그리드에 로컬 및 원격 작업을 모두 표시합니다.
* [`/loop` 및 CLI 예약된 작업](/ko/scheduled-tasks): CLI 세션 내의 경량 예약
* [클라우드 환경](/ko/claude-code-on-the-web#cloud-environment): 클라우드 작업의 런타임 환경 구성
* [MCP 커넥터](/ko/mcp): Slack, Linear 및 Google Drive와 같은 외부 서비스 연결
* [GitHub Actions](/ko/github-actions): 저장소 이벤트에서 CI 파이프라인에서 Claude 실행
