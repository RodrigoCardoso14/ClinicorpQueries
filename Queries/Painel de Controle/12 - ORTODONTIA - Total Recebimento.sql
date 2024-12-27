/* Recebimento */
select 
	 if(pi.PatientPlanId is null, 'Clínica', pc.Name) as PILAR,  		
	 format(sum(pi.Amount), 2) as 'VALOR TOTAL',    
	 format(sum(if(pi.ConfirmedDateAtomic = pi.PostDateAtomic, pi.Amount, 0)), 2) as 'A VISTA', 
	 format(sum(if(pi.ConfirmedDateAtomic <> pi.PostDateAtomic, pi.Amount, 0)), 2) as 'CREDIARIO' 			 
from PaymentItem pi
left join PaymentHeader ph on ph.id = pi.PaymentHeaderId
left join BookEntry be on be.id = ph.BookEntryIdList
left join Person p ON p.id = pi.PatientId
left join PatientPlan pp on pp.id = pi.PatientPlanId
left join PlanControl pc on pc.id = pp.PlanId
where pi.z_Namespace = 'odccaieirasc.br.sp.caieiras'
and pi.PaymentConfirmed = 'X' -- RECEBIDO
and str_to_date(cast(pi.ConfirmedDateAtomic as char), '%Y%m%d') between 20241101 and 20241130
and pc.Name like '%Manutenção%'
order by pi.DueDateAtomic;