/* Recebimento e Ticket Médio */
select 
	t.Pilar as 'PILAR',	
    format(t.ValorPago, 2) as 'RECEBIDO',    
    format(t.ValorPago / t.Quantidade, 2) as 'TICKET MEDIO'
from (
	select 	    
		if(pi.PatientPlanId is null, 'Clínica', pc.Name) as Pilar,  		
		sum(if(pi.PaymentConfirmed = 'X', pi.Amount, 0)) as ValorPago,    
        count(pi.id) as Quantidade
		from PaymentItem pi	
	left join PaymentHeader ph on ph.id = pi.PaymentHeaderId
	left join Person p ON p.id = pi.PatientId
	left join PatientPlan pp on pp.id = pi.PatientPlanId
	left join PlanControl pc on pc.id = pp.PlanId
	where pi.z_Namespace = 'odcpqdocarmo.br.sp.sao_paulo'
    and pi.PaymentConfirmed = 'X'
	and str_to_date(cast(pi.ConfirmedDateAtomic as char), '%Y%m%d')  between 20241201 and 20241231
    and pc.name = 'Contrato ODC'
    -- and pc.id = '5457761867268096'	
	group by pc.id
	order by pi.DueDateAtomic
) t
order by t.Pilar;