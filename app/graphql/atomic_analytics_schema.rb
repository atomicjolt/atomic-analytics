class AtomicAnalyticsSchema < GraphQL::Schema
  use GraphQL::Batch

  mutation(Types::AtomicAnalyticsMutationType)
  query(Types::AtomicAnalyticsQueryType)
end
