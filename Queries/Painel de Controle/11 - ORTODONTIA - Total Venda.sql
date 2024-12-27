/* TOTAL VENDA ORTODONTIA */
select 
	format(sum(Valor), 2) as 'Valor Venda',
    Count(*) as Quantidade
from (
	select 
		sum(pi.Amount) as 'Valor'
        -- p.Name
	from PaymentItem pi
	left join PaymentHeader ph on ph.id = pi.PaymentHeaderId
	left join BookEntry be on be.id = ph.BookEntryIdList
	left join Person p ON p.id = pi.PatientId
	left join PatientPlan pp on pp.id = pi.PatientPlanId
	left join PlanControl pc on pc.id = pp.PlanId
	where pi.z_Namespace = 'odccaieirasl.br.sp.caieiras'
	and str_to_date(cast(pi.PostDateAtomic as char), '%Y%m%d')  between 20241101 and 20241130
	-- and pi.PatientPlanId is not null -- CONTRATOS OU ORTODONTIA
	-- and pc.id = 5110236031352832 -- ORTODONTIA
    and pc.Name = 'Manutenção Ortodontica'
	group by ph.id
	order by pi.DueDateAtomic
) t