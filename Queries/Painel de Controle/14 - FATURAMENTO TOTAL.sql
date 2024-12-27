/* FATURAMENTO TOTAL */
select 
	format(sum(t.Valor), 2) as 'FATURAMENTO TOTAL'
from (
	select 
		if(pi.PatientPlanId is null, 'Clínica', pc.Name) as PILAR,  
		sum(pi.Amount) as valor
	from PaymentItem pi
	left join PatientPlan pp on pp.id = pi.PatientPlanId
	left join PlanControl pc on pc.id = pp.PlanId
	where pi.z_Namespace = 'odccaieirasc.br.sp.caieiras'
	and str_to_date(cast(pi.ConfirmedDateAtomic as char), '%Y%m%d')  between 20241101 and 20241130
	group by pc.id
) t;