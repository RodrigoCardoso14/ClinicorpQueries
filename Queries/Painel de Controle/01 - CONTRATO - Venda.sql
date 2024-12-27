/* Quantidade de Contratos Vendidos */
select 
	-- count(*),    
	p.Name,	
    date_format(pp.CreatedDate, '%d.%m.%Y') as CreatedDate,
    pp.Amount as 'Valor R$',
    pp.Status,
    if(pp.Payed = 0, '', 'PAGO') as 'Situação Pagamento',
    pp.RelatedPatientPlanId,    
    pp.StartDate,
    pp.*
from PatientPlan pp
left join Person p on p.id = pp.PatientId
left join PlanControl pc on pc.id = pp.PlanId
left join Status s on s.id = pp.Status
where pp.z_Namespace = 'odccaieirasc.br.sp.caieiras'
and cast(pp.CreatedDate as date) between '2024-08-01' and '2024-08-31'
-- and pc.id = 6251197879091200 -- CONTRATO ODC
and pc.Name = 'Contrato ODC'
-- and p.name like '%ROBERTO TADEU%'
-- and pp.Status = 'ACTIVE'
and pp.RelatedPatientPlanId is null -- TITULAR
order by pp.CreatedDate;