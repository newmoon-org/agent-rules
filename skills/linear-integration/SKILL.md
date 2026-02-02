---
name: linear-integration
description: Create, read, and modify Linear tickets using the Linear tool. Use when working with Linear issues, creating tickets, updating ticket status, assigning tickets, or querying Linear data.
---

# Linear Integration

This skill provides comprehensive guidance for interacting with Linear tickets using the Linear tool available in Augment Agent.

## When to Use This Skill

- Creating new Linear tickets
- Reading ticket information
- Updating ticket status, assignees, or other fields
- Querying tickets by various criteria
- Managing ticket workflows

## Available Operations

### 1. Create a Ticket

Create a new Linear ticket with title, description, and optional fields.

**Basic Example:**
```
Create a ticket with title "Fix login bug" and description "Users cannot log in with SSO"
```

**With Additional Fields:**
```
Create a ticket with title "Implement dark mode" and description "Add dark mode support to the dashboard" and assign it to me
```

**Best Practices:**
- Use clear, descriptive titles
- Provide detailed descriptions in Markdown format
- Specify the team if working across multiple teams
- Set priority and labels when relevant
- Assign to specific users by UUID (query for user UUID first if needed)

### 2. Read Ticket Information

Query and retrieve information about existing tickets.

**By Ticket ID:**
```
Get information about ticket TST-10
```

**Query Multiple Tickets:**
```
Find all tickets assigned to me
Find all open tickets in the current team
Find tickets with label "bug"
```

**Best Practices:**
- Use ticket identifiers (e.g., TST-10) when known
- Query by assignee, state, labels, or other fields
- Request specific fields to minimize response size

### 3. Update Tickets

Modify existing ticket properties including status, assignees, priority, and more.

**Update Status:**
```
Update TST-10 to the Done state
Move ticket TST-15 to In Progress
```

**Update Assignee:**
```
Assign TST-10 to me
Assign ticket TST-20 to [user UUID]
```

**Update Multiple Fields:**
```
Update TST-10: set status to In Progress, priority to High, and assign to me
```

**Best Practices:**
- Always reference tickets by their identifier
- Use proper state names (e.g., "Todo", "In Progress", "Done")
- When assigning to users, query for their UUID first if not known
- Provide clear reasoning for updates in comments when appropriate

## Workflow Examples

### Creating a Bug Report
1. Identify the bug details
2. Create ticket with descriptive title
3. Add detailed description with reproduction steps
4. Set appropriate labels (e.g., "bug")
5. Set priority if urgent
6. Optionally assign to team member

### Moving Ticket Through Workflow
1. Query current ticket status
2. Update status to next stage (e.g., "Todo" → "In Progress")
3. Optionally add comment explaining progress
4. Update assignee if needed
5. Set completion status when done

### Querying Team Progress
1. Query all tickets in current team
2. Filter by state (e.g., "In Progress")
3. Group by assignee to see workload
4. Identify blockers or high-priority items

## Common Fields

### Ticket States
Common Linear states (may vary by team):
- **Backlog** - Not yet prioritized
- **Todo** - Ready to work on
- **In Progress** - Currently being worked on
- **In Review** - Awaiting review
- **Done** - Completed
- **Canceled** - Will not be completed

### Priority Levels
- **No priority** (0)
- **Urgent** (1)
- **High** (2)
- **Medium** (3)
- **Low** (4)

### Common Query Filters
- `assignee` - Filter by assigned user
- `state` - Filter by ticket state
- `label` - Filter by label
- `priority` - Filter by priority level
- `team` - Filter by team

## Error Handling

### Common Issues

**UUID Requirements:**
- When assigning tickets, you must use user UUIDs, not emails
- Query for user information first to get their UUID
- Example: "Find user with email user@example.com, then assign TST-10 to that user's UUID"

**State Names:**
- Use exact state names as configured in Linear
- States are case-sensitive
- Query available states if unsure

**Team Context:**
- Some operations require team context
- Specify team ID or name when working across multiple teams

**Permissions:**
- Ensure you have permission to modify tickets
- Some fields may be restricted based on role

## Tips and Best Practices

1. **Query Before Update**: Always query ticket information before making updates to understand current state
2. **Use UUIDs**: Reference entities by UUID for reliability (users, teams, projects)
3. **Batch Operations**: When updating multiple tickets, process them systematically
4. **Clear Descriptions**: Use Markdown formatting for rich ticket descriptions
5. **Labels and Projects**: Organize tickets with labels and projects for better tracking
6. **Comments**: Add comments when making significant status changes
7. **Error Recovery**: If an operation fails, check the error message for specific requirements

## Integration with Other Skills

### With github-pr-linear
- Create Linear ticket first
- Use ticket ID as branch name
- Reference ticket in PR description
- Update ticket status when PR is merged

### Workflow Example
1. Create Linear ticket: "Implement feature X"
2. Note the ticket ID (e.g., TST-25)
3. Create branch: `tst-25`
4. Make changes and commit
5. Create PR using github-pr-linear skill
6. Update Linear ticket to "In Review"
7. After merge, update ticket to "Done"

## Examples

### Create a Feature Request
```
Create a ticket with title "Add export to CSV feature" and description "Users need ability to export data tables to CSV format. Should include all visible columns and respect current filters."
```

### Update Ticket Status
```
Update TST-10 to In Progress state
```

### Query Your Tickets
```
Show me all my assigned tickets that are in progress
```

### Assign and Prioritize
```
Find user John Doe's UUID, then assign TST-15 to that user and set priority to High
```

## Reference

For detailed Linear API information, see the Linear API documentation at https://developers.linear.app/docs/graphql/working-with-the-graphql-api

