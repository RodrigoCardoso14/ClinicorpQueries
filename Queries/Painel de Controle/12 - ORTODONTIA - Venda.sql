/* ORTODONTIA - Venda */
select 
	ph.id,
	upper(pc.Name) as 'PILAR',    
    pp.PlanIdentifier as 'ORTODONTIA',    
    p.Name as 'PACIENTE',	
    date_format(ph.PostDate, '%d.%m.%Y') as 'EMISSAO',            
    pp.id,        
    format(sum(pi.Amount), 2) as 'VALOR'      
from PaymentHeader ph
left join PaymentItem pi on pi.PaymentHeaderId = ph.id
left join Person p on p.id = ph.PatientId
left join PatientPlan pp on pp.id = ph.PatientPlanId
left join PlanControl pc on pc.id = pp.PlanId
where ph.z_Namespace = 'odcpqdocarmo.br.sp.sao_paulo'	
and str_to_date(cast(ph.PostDate as char), '%Y%m%d')  between 20241201 and 20241231
and UPPER(pc.Name) like '%MANUTENÇÃO%'
group by pp.PlanIdentifier
order by ph.PostDate;