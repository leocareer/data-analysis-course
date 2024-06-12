select * from m4t2.bbdd_union_nenes
union
select * from m4t2.bbdd_union_nens;

select * from m4t2.bbdd_union_nenes
union all
select * from m4t2.bbdd_union_nens;

-- union and union all syntax: The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL
-- so in the first request the line "kai;200" was removed