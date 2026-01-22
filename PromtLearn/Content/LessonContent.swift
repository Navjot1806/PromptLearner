//
//  LessonContent.swift
//  PromptCraftAcademy
//
//  All 8 lessons content for the AI Prompting Masterclass
//

import Foundation

class LessonContentProvider {
    static let shared = LessonContentProvider()

    let allLessons: [Lesson] = [
        // LESSON 1 - FREE
        Lesson(
            id: 1,
            title: "Prompt Basics for Developers",
            subtitle: "Master the fundamentals of effective AI prompting",
            duration: 15,
            isPremium: false,
            order: 1,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "What is AI Prompting?",
                    body: """
                    AI prompting is the art and science of communicating with AI systems to get the results you want. For developers, this means crafting instructions that help AI understand your coding needs precisely.

                    Think of prompts as function calls to an incredibly smart but literal-minded assistant. The clearer your input, the better your output.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Three Core Principles",
                    body: """
                    1. CLARITY: Be specific about what you want. Instead of "write a function," say "write a Python function that validates email addresses using regex."

                    2. CONTEXT: Provide relevant background. Mention the framework, coding style, or constraints that matter.

                    3. CONSTRAINTS: Define boundaries. Specify language version, libraries to use or avoid, performance requirements, or code style preferences.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Your First Effective Prompt",
                    body: """
                    Let's compare two prompts:

                    BAD: "Make a sorting function"

                    GOOD: "Write a TypeScript function that sorts an array of user objects by their 'lastLogin' date property in descending order. Include TypeScript types and handle null values."

                    The good prompt specifies language, data structure, sorting criteria, order, and edge cases.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "Vague Prompt",
                    code: "Write a function to process data",
                    language: "prompt",
                    explanation: "Too vague - what kind of data? What processing?"
                ),
                Lesson.CodeExample(
                    title: "Specific Prompt",
                    code: """
                    Write a Python function that:
                    - Takes a list of dictionaries as input
                    - Filters items where 'status' is 'active'
                    - Returns a new list sorted by 'created_at' timestamp
                    - Includes type hints and docstring
                    """,
                    language: "prompt",
                    explanation: "Clear input, output, operations, and requirements"
                )
            ],
            keyTakeaways: [
                "Be specific about language, framework, and requirements",
                "Provide context about your project and constraints",
                "Good prompts save time and reduce back-and-forth iterations"
            ]
        ),

        // LESSON 2 - FREE
        Lesson(
            id: 2,
            title: "Code Generation Fundamentals",
            subtitle: "Learn to generate production-ready code with AI",
            duration: 20,
            isPremium: false,
            order: 2,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "Writing Prompts for Code Generation",
                    body: """
                    Code generation is more than asking for a function. You need to specify:

                    - Programming language and version
                    - Framework or library (React 18, Django 4, etc.)
                    - Code style (functional, OOP, specific patterns)
                    - Error handling approach
                    - Testing requirements

                    The more details you provide upfront, the less editing you'll need later.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Specifying Language and Framework",
                    body: """
                    Always mention your exact stack. Compare:

                    "Create a login component" vs "Create a React 18 login component using TypeScript, React Hook Form for validation, and Tailwind CSS for styling."

                    The second prompt will generate code that drops right into your project with minimal adjustments.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Iterating on Generated Code",
                    body: """
                    Generated code is rarely perfect on the first try. Iterate effectively:

                    1. Generate initial code with a detailed prompt
                    2. Review and test the output
                    3. Ask for specific modifications: "Add error boundary to this component" or "Refactor to use async/await"
                    4. Request explanations: "Explain why you used useCallback here"

                    Think of it as pair programming with an AI.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "Effective Code Generation Prompt",
                    code: """
                    Generate a REST API endpoint in Node.js with Express that:
                    - Handles POST requests to /api/users
                    - Validates email and password fields using Joi
                    - Hashes passwords with bcrypt
                    - Returns 201 on success, 400 for validation errors
                    - Uses async/await and proper error handling
                    - Follows the existing project structure
                    """,
                    language: "prompt",
                    explanation: "Comprehensive specification for immediate usability"
                ),
                Lesson.CodeExample(
                    title: "Iteration Prompt",
                    code: """
                    Refactor the above function to:
                    - Extract validation into a separate middleware
                    - Add rate limiting
                    - Include JSDoc comments
                    """,
                    language: "prompt",
                    explanation: "Building on previous output for improvements"
                )
            ],
            keyTakeaways: [
                "Specify exact language versions and frameworks upfront",
                "Include code style and architectural preferences",
                "Iterate with specific, targeted refinement prompts"
            ]
        ),

        // LESSON 3 - PREMIUM
        Lesson(
            id: 3,
            title: "Advanced Prompt Engineering",
            subtitle: "Master sophisticated prompting techniques",
            duration: 25,
            isPremium: true,
            order: 3,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "Few-Shot Learning Techniques",
                    body: """
                    Few-shot learning means providing examples of what you want. This dramatically improves output quality.

                    Instead of describing your coding style, show it:

                    "Generate functions following this pattern:
                    [Example 1: Your existing code]
                    [Example 2: Another function from your codebase]
                    Now create a similar function for..."

                    The AI will match the style, naming conventions, and structure of your examples.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Chain-of-Thought Prompting",
                    body: """
                    For complex tasks, ask the AI to think step-by-step:

                    "Before writing code, first:
                    1. Analyze the requirements
                    2. Identify edge cases
                    3. Design the data structures
                    4. Then implement the solution"

                    This produces more thoughtful, robust code by encouraging systematic thinking.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Role-Based Prompts",
                    body: """
                    Frame the AI's perspective for better results:

                    - "As a senior backend engineer, review this API design..."
                    - "Acting as a security expert, audit this authentication flow..."
                    - "From a performance optimization perspective, analyze this database query..."

                    Role-based prompts leverage different knowledge domains within the AI's training.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "Few-Shot Example",
                    code: """
                    I use this error handling pattern:

                    function processUser(data) {
                      try {
                        return { success: true, data: transform(data) };
                      } catch (error) {
                        logger.error('User processing failed', { error, data });
                        return { success: false, error: error.message };
                      }
                    }

                    Generate a similar function for processing orders.
                    """,
                    language: "prompt",
                    explanation: "Providing a concrete example ensures consistent patterns"
                ),
                Lesson.CodeExample(
                    title: "Chain-of-Thought Prompt",
                    code: """
                    Design a caching layer for our API. First:
                    1. List the requirements (TTL, invalidation, storage)
                    2. Identify key design decisions (in-memory vs Redis, cache keys structure)
                    3. Consider failure modes (cache miss, stale data)
                    4. Then implement the solution with TypeScript
                    """,
                    language: "prompt",
                    explanation: "Structured thinking leads to better architecture"
                )
            ],
            keyTakeaways: [
                "Use few-shot examples from your codebase for consistency",
                "Chain-of-thought prompts improve complex problem-solving",
                "Role-based prompts access specialized knowledge domains"
            ]
        ),

        // LESSON 4 - PREMIUM
        Lesson(
            id: 4,
            title: "Debugging with AI",
            subtitle: "Solve bugs faster with effective AI assistance",
            duration: 20,
            isPremium: true,
            order: 4,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "Effective Error Explanation Prompts",
                    body: """
                    When you hit an error, don't just paste the error message. Provide:

                    1. The error message and stack trace
                    2. Relevant code that's failing
                    3. What you expected to happen
                    4. What actually happened
                    5. Environment details (Node version, browser, etc.)

                    This context helps AI identify the root cause quickly.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Asking for Debugging Strategies",
                    body: """
                    Beyond fixes, ask for debugging approaches:

                    "This function sometimes returns undefined. What debugging strategy would you use to find why?"

                    This teaches you debugging techniques while solving the immediate problem. The AI can suggest:
                    - Logging strategies
                    - Test cases to write
                    - Breakpoint locations
                    - Hypothesis testing approaches
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Root Cause Analysis Prompts",
                    body: """
                    For complex bugs, request systematic analysis:

                    "I'm seeing [symptom]. Walk through potential root causes:
                    1. Data flow issues
                    2. Race conditions
                    3. State management problems
                    4. External dependencies

                    Then suggest the most likely culprit and how to verify."

                    This structured approach prevents bandaid fixes.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "Comprehensive Bug Report Prompt",
                    code: """
                    I'm getting "TypeError: Cannot read property 'map' of undefined" at line 45:

                    ```javascript
                    const results = data.users.map(u => u.name);
                    ```

                    Context:
                    - This is a React component fetching from /api/users
                    - Error occurs only on first render, not subsequent ones
                    - API returns 200 status
                    - Using React 18, Next.js 13

                    Expected: Should display user names
                    Actual: Crashes on initial render

                    What's causing this and how should I fix it?
                    """,
                    language: "prompt",
                    explanation: "Complete context enables accurate diagnosis"
                ),
                Lesson.CodeExample(
                    title: "Debugging Strategy Request",
                    code: """
                    My Express API endpoint intermittently returns stale data.
                    It works correctly most of the time but occasionally serves
                    data from previous requests.

                    What debugging approach would help identify if this is:
                    - A caching issue
                    - A race condition
                    - A database connection pooling problem
                    - Something else
                    """,
                    language: "prompt",
                    explanation: "Requesting methodology, not just a fix"
                )
            ],
            keyTakeaways: [
                "Provide full context: error, code, environment, and expectations",
                "Ask for debugging strategies to learn systematic approaches",
                "Request root cause analysis for complex, non-obvious bugs"
            ]
        ),

        // LESSON 5 - PREMIUM
        Lesson(
            id: 5,
            title: "Refactoring & Code Review",
            subtitle: "Improve code quality with AI-assisted refactoring",
            duration: 25,
            isPremium: true,
            order: 5,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "Prompting for Code Improvements",
                    body: """
                    Effective refactoring prompts specify what to improve:

                    - "Refactor for readability while maintaining functionality"
                    - "Reduce duplication in these three functions"
                    - "Improve performance of this data processing loop"
                    - "Make this more testable by reducing side effects"

                    Be explicit about your goals. "Make it better" is too vague.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Architecture Suggestions",
                    body: """
                    Use AI to evaluate architectural decisions:

                    "Review this module's architecture for:
                    - Separation of concerns
                    - Dependency injection opportunities
                    - Potential circular dependencies
                    - Scalability concerns

                    Suggest specific improvements."

                    AI can spot patterns you might miss and suggest industry-standard solutions.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Best Practices Analysis",
                    body: """
                    Request comprehensive code review:

                    "Analyze this code for:
                    - Security vulnerabilities
                    - Performance bottlenecks
                    - Memory leaks
                    - Error handling gaps
                    - Violation of [language] best practices

                    Prioritize issues by severity."

                    This systematic review catches issues before they reach production.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "Targeted Refactoring Prompt",
                    code: """
                    Refactor this function to:
                    1. Eliminate nested callbacks (use async/await)
                    2. Extract validation logic into separate functions
                    3. Add proper TypeScript types
                    4. Improve variable naming for clarity

                    Maintain the same external API and behavior.

                    [paste your function here]
                    """,
                    language: "prompt",
                    explanation: "Specific goals guide effective refactoring"
                ),
                Lesson.CodeExample(
                    title: "Architecture Review Prompt",
                    code: """
                    Review this service layer architecture:
                    [paste code]

                    Evaluate:
                    - Is business logic properly separated from data access?
                    - Are dependencies testable?
                    - Does it follow SOLID principles?
                    - How would this scale to 10x more features?

                    Suggest specific improvements with examples.
                    """,
                    language: "prompt",
                    explanation: "Comprehensive architectural assessment"
                )
            ],
            keyTakeaways: [
                "Be specific about refactoring goals and constraints",
                "Request architectural analysis for systemic improvements",
                "Use AI for systematic code review and best practice checks"
            ]
        ),

        // LESSON 6 - PREMIUM
        Lesson(
            id: 6,
            title: "Documentation & Comments",
            subtitle: "Generate clear, helpful documentation effortlessly",
            duration: 20,
            isPremium: true,
            order: 6,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "Generating Clear Documentation",
                    body: """
                    Good documentation explains why, not just what. Prompt for this:

                    "Generate documentation for this module that:
                    - Explains its purpose and when to use it
                    - Provides usage examples
                    - Documents all public APIs
                    - Notes any gotchas or limitations
                    - Uses [your team's documentation format]"

                    Include examples of your existing docs for consistency.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Writing Effective Comments",
                    body: """
                    Comments should clarify intent, not restate code:

                    BAD: "// Loop through users"
                    GOOD: "// Filter active users to avoid notifying deleted accounts"

                    Prompt AI to add meaningful comments:
                    "Add comments to this code that explain:
                    - Why this approach was chosen
                    - Non-obvious business logic
                    - Edge cases being handled

                    Don't comment obvious code."
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "README and API Docs",
                    body: """
                    For project documentation, provide structure:

                    "Create a README that includes:
                    - Quick start guide
                    - Installation steps
                    - Basic usage examples
                    - Configuration options
                    - Common troubleshooting
                    - Contribution guidelines

                    Target audience: developers integrating this library."

                    Specify your audience and documentation goals.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "API Documentation Prompt",
                    code: """
                    Generate JSDoc comments for these functions following this example:

                    /**
                     * Validates user input against schema
                     * @param {Object} data - User input to validate
                     * @param {Schema} schema - Validation schema
                     * @returns {ValidationResult} Validation outcome with errors if any
                     * @throws {SchemaError} If schema is malformed
                     * @example
                     * const result = validate(userData, userSchema);
                     * if (!result.valid) console.log(result.errors);
                     */

                    [paste your functions]
                    """,
                    language: "prompt",
                    explanation: "Example ensures consistent documentation style"
                ),
                Lesson.CodeExample(
                    title: "README Generation Prompt",
                    code: """
                    Create a README for this API client library:

                    Project: [name]
                    Purpose: [description]
                    Target users: Frontend developers using React
                    Key features: [list]

                    Include:
                    - Installation with npm/yarn
                    - Quick start with code example
                    - Configuration options table
                    - Common use cases
                    - Error handling guide
                    - Link to full API docs

                    Use clear, concise language. Focus on getting started quickly.
                    """,
                    language: "prompt",
                    explanation: "Structured prompt for comprehensive documentation"
                )
            ],
            keyTakeaways: [
                "Provide examples of your documentation style for consistency",
                "Request comments that explain why, not what",
                "Structure README prompts with target audience and key sections"
            ]
        ),

        // LESSON 7 - PREMIUM
        Lesson(
            id: 7,
            title: "Test Generation",
            subtitle: "Create comprehensive test suites with AI",
            duration: 25,
            isPremium: true,
            order: 7,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "Prompting for Unit Tests",
                    body: """
                    Great test prompts specify:
                    - Testing framework (Jest, Pytest, etc.)
                    - What to test (happy path, edge cases, errors)
                    - Coverage expectations
                    - Mocking requirements

                    Example:
                    "Write Jest unit tests for this function covering:
                    - Success case
                    - Invalid input handling
                    - Boundary conditions
                    Use describe/it blocks and meaningful test names."
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Integration Test Scenarios",
                    body: """
                    Integration tests need context about system behavior:

                    "Generate integration tests for this API endpoint:
                    - Test full request/response cycle
                    - Mock database with [tool]
                    - Verify authentication requirements
                    - Test rate limiting
                    - Check error responses

                    Use [testing framework] and follow our test structure."

                    Include your project's testing patterns.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Edge Case Identification",
                    body: """
                    AI excels at finding edge cases you might miss:

                    "Analyze this function and list all edge cases that should be tested:
                    - Input boundary values
                    - Null/undefined handling
                    - Empty collections
                    - Concurrent access scenarios
                    - Network failures

                    Then generate tests for each case."

                    This ensures comprehensive test coverage.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "Comprehensive Unit Test Prompt",
                    code: """
                    Generate Jest unit tests for this TypeScript function:

                    [paste function]

                    Requirements:
                    - Test happy path with valid inputs
                    - Test each error condition separately
                    - Test boundary values (empty, max, min)
                    - Mock external dependencies
                    - Aim for 100% code coverage
                    - Use descriptive test names
                    - Follow AAA pattern (Arrange, Act, Assert)

                    Match this test style:
                    [paste example test from your codebase]
                    """,
                    language: "prompt",
                    explanation: "Detailed requirements ensure thorough test coverage"
                ),
                Lesson.CodeExample(
                    title: "Edge Case Discovery Prompt",
                    code: """
                    Analyze this payment processing function:
                    [paste code]

                    Identify all edge cases including:
                    - Invalid card numbers
                    - Expired cards
                    - Insufficient funds
                    - Network timeouts
                    - Currency mismatches
                    - Race conditions
                    - Any other failure scenarios

                    For each, explain the risk and write a test case.
                    """,
                    language: "prompt",
                    explanation: "Systematic edge case identification improves reliability"
                )
            ],
            keyTakeaways: [
                "Specify testing framework, structure, and coverage expectations",
                "Provide example tests from your codebase for consistency",
                "Use AI to identify edge cases you might overlook"
            ]
        ),

        // LESSON 8 - PREMIUM
        Lesson(
            id: 8,
            title: "Production-Ready Patterns",
            subtitle: "Apply AI prompting to real-world development workflows",
            duration: 30,
            isPremium: true,
            order: 8,
            content: Lesson.LessonContent(sections: [
                Lesson.LessonContent.Section(
                    heading: "Security Considerations in Prompts",
                    body: """
                    When generating production code, always include security requirements:

                    "Generate this authentication endpoint ensuring:
                    - Input validation and sanitization
                    - Protection against SQL injection
                    - XSS prevention
                    - CSRF token validation
                    - Rate limiting
                    - Secure password hashing (bcrypt with salt)
                    - No sensitive data in logs

                    Follow OWASP Top 10 guidelines."

                    Security by default, not as an afterthought.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Performance Optimization Prompts",
                    body: """
                    Optimize code with specific performance goals:

                    "Optimize this database query for:
                    - Sub-100ms response time
                    - Handling 10,000+ records
                    - Minimal memory usage

                    Consider:
                    - Index usage
                    - Query batching
                    - Caching opportunities
                    - N+1 query prevention

                    Explain performance impact of each change."

                    Quantifiable goals produce measurable improvements.
                    """
                ),
                Lesson.LessonContent.Section(
                    heading: "Real-World Project Workflows",
                    body: """
                    Integrate AI into your development workflow:

                    FEATURE DEVELOPMENT:
                    1. "Design the architecture for [feature]"
                    2. "Generate implementation with tests"
                    3. "Review for security and performance"
                    4. "Generate documentation"

                    BUG FIXING:
                    1. "Analyze this error and suggest root causes"
                    2. "Propose fixes with trade-offs"
                    3. "Generate test cases to prevent regression"

                    CODE REVIEW:
                    1. "Review this PR for best practices"
                    2. "Identify potential issues"
                    3. "Suggest improvements"

                    Use AI as a pair programmer throughout the development cycle.
                    """
                )
            ]),
            codeExamples: [
                Lesson.CodeExample(
                    title: "Security-First Code Generation",
                    code: """
                    Generate a file upload endpoint in Express that:

                    Security requirements:
                    - Validate file type (only images: jpg, png, webp)
                    - Check file size (max 5MB)
                    - Sanitize filename (prevent directory traversal)
                    - Scan for malware signatures
                    - Use signed URLs for storage
                    - Rate limit uploads (5 per minute per user)
                    - Log all upload attempts with user ID

                    Technical requirements:
                    - Use multer for multipart handling
                    - Store in AWS S3
                    - Return CDN URL on success
                    - Proper error handling and status codes

                    Include security comments explaining each check.
                    """,
                    language: "prompt",
                    explanation: "Security requirements integrated from the start"
                ),
                Lesson.CodeExample(
                    title: "Performance Optimization Prompt",
                    code: """
                    This function processes 50,000 records and takes 45 seconds:
                    [paste code]

                    Optimize for <5 second execution:
                    - Profile the bottlenecks
                    - Suggest algorithmic improvements
                    - Consider parallelization
                    - Evaluate memory vs speed tradeoffs
                    - Recommend caching strategies

                    Provide benchmarks for each optimization.
                    Maintain correctness and readability.
                    """,
                    language: "prompt",
                    explanation: "Specific performance goals with measurement"
                ),
                Lesson.CodeExample(
                    title: "Complete Feature Development Workflow",
                    code: """
                    Feature: Add real-time notifications to web app

                    Phase 1 - Design:
                    "Design a WebSocket-based notification system for:
                    - User mentions
                    - Comment replies
                    - System alerts

                    Consider: scalability, reliability, delivery guarantees"

                    Phase 2 - Implementation:
                    "Implement the backend WebSocket server with:
                    - Connection management
                    - Room-based broadcasting
                    - Authentication
                    - Reconnection handling"

                    Phase 3 - Testing:
                    "Generate tests for:
                    - Connection lifecycle
                    - Message delivery
                    - Error scenarios
                    - Load testing"

                    Phase 4 - Documentation:
                    "Create docs for:
                    - Integration guide
                    - API reference
                    - Troubleshooting"
                    """,
                    language: "prompt",
                    explanation: "End-to-end AI-assisted feature development"
                )
            ],
            keyTakeaways: [
                "Always include security requirements in production code prompts",
                "Specify measurable performance goals and constraints",
                "Integrate AI throughout your entire development workflow",
                "Use systematic, phased prompting for complex features"
            ]
        )
    ]

    func getLesson(byId id: Int) -> Lesson? {
        allLessons.first { $0.id == id }
    }

    func getFreeLessons() -> [Lesson] {
        allLessons.filter { !$0.isPremium }
    }

    func getPremiumLessons() -> [Lesson] {
        allLessons.filter { $0.isPremium }
    }
}
