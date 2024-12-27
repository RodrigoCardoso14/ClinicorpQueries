/* RECEBIMENTO */
select 
	pi.id,
    pi.z_Namespace as 'UNIDADE',
    p.Name as 'PACIENTE',
    d.Name as 'DENTISTA',
    if(pi.PatientPlanId is null, 'Clinica', pc.Name) as 'PILAR',  
    -- pp.PlanIdentifier,
    -- pp.OwnPlanIdentifier,
    date_format(pi.DueDateAtomic, '%d/%m/%Y') as 'VENCIMENTO',
    date_format(pi.PostDateAtomic, '%d/%m/%Y') as 'LANCAMENTO',    
    date_format(pi.ConfirmedDateAtomic, '%d/%m/%Y') as 'PAGAMENTO',
    if(pi.PaymentConfirmed = 'X', 'PAGO', 'ABERTO') as 'STATUS',
    if(pi.ConfirmedDateAtomic = pi.PostDateAtomic, 'A VISTA', 'CREDIARIO') as "CONDICAO",
    -- be.Description as 'Descricao',
    -- bec.Description as 'Descricao2',
    -- pi.PaymentDescription 'Descricao3',
    fp.Description as 'FORMA PAGAMENTO',
    format(pi.Amount, 2) as 'VALOR'
	-- if(pi.PatientPlanId is null, 'Clínica', pc.Name) as Pilar,  		
	-- format(sum(pi.Amount), 2) as 'Valor Total R$'
	-- format(sum(if(pi.ConfirmedDateAtomic = pi.PostDateAtomic, pi.Amount, 0)), 2) as 'À Vista R$', 
	-- format(sum(if(pi.ConfirmedDateAtomic <> pi.PostDateAtomic, pi.Amount, 0)), 2) as 'Crediário R$' 			     
from PaymentItem pi
left join PaymentHeader ph on ph.id = pi.PaymentHeaderId
left join BookEntry be on be.id = ph.BookEntryIdList
left join Characteristic fp on fp.id = pi.PaymentForm_CharacteristicId
left join Treatment t on ph.TreatmentId = t.id
left join PatientPlan pp on pp.id = pi.PatientPlanId
left join PlanControl pc on pc.id = pp.PlanId
left join Person p ON p.id = pi.PatientId
left join Person d on d.id = t.Dentist_PersonId
where pi.z_Namespace = 'odccaieirasc.br.sp.caieiras'
and pi.PaymentConfirmed = 'X' -- RECEBIDO
and str_to_date(cast(pi.ConfirmedDateAtomic as char), '%Y%m%d')  between 20241101 and 20241130
and pc.Name like '%Manutenção%'
-- and pc.id = 5110236031352832 -- ORTODONTIA
group by pi.id
order by pi.DueDateAtomic;