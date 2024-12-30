/* Ticket Médio - Venda */
select 
	t.PILAR,	
    count(*) as QUANTIDADE,
    format(sum(t.Valor), 2) as 'VALOR',        
    format(sum(t.Valor) / count(*), 2) as 'TICKET MEDIO'    
from (
	select 	    
		if(pi.PatientPlanId is null, 'Clínica', pc.Name) as Pilar,  				
        sum(pi.Amount) as Valor        
	from PaymentItem pi	
	left join PaymentHeader ph on ph.id = pi.PaymentHeaderId
	left join Person p ON p.id = pi.PatientId
	left join PatientPlan pp on pp.id = pi.PatientPlanId
	left join PlanControl pc on pc.id = pp.PlanId
	where pi.z_Namespace = 'odcpqdocarmo.br.sp.sao_paulo'    
	and str_to_date(cast(pi.PostDateAtomic as char), '%Y%m%d') between 20241208 and 20241223
    and pi.PatientPlanId is null -- CLÍNICA
	group by ph.id
	order by pi.DueDateAtomic
) t;