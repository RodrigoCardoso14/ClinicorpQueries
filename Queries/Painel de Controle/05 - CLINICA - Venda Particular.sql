/* Venda Particular */
select 
	ph.id,
	be.Description,
    ph.Description,
	pp.Name,    
    date_format(ph.PostDate, '%d/%m/%Y') as 'LANCAMENTO',
	p.Name as 'PACIENTE',
    format(sum(pi.Amount), 2) as 'VALOR'
    -- ph.*
from PaymentItem pi
left join PaymentHeader ph on ph.id = pi.PaymentHeaderId
left join BookEntry be on be.id = ph.BookEntryIdList
left join Person p ON p.id = pi.PatientId
left join PatientPlan pp on pp.id = pi.PatientPlanId
left join PlanControl pc on pc.id = pp.PlanId
where pi.z_Namespace = 'odccaieirasc.br.sp.caieiras'
and str_to_date(cast(pi.PostDateAtomic as char), '%Y%m%d')  between 20241101 and 20241130
and ph.PatientPlanId is null -- CLÍNICA
group by ph.id
order by ph.PostDate;