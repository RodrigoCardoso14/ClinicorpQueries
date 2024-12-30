/* VENDA PARTICULAR (Orçamentos Aprovados) */
select		
	t.id,
    p.id,
	date_format(t.CreateDateAtomic,'%d/%m/%Y') as LANCAMENTO,    
    date_format(t.ApprovedDateAtomic,'%d/%m/%Y') as APROVADO,    
    d.Name as DENTISTA,    
	p.Name as PACIENTE,        
    format(teste.Valor_BE, 2) as "VALOR BOOK ENTRY",
    format(x.Valor, 2) as VALOR, 
    REGEXP_SUBSTR(
        group_concat(c.Description),
        'ODC|AESP|AMIL|CLIN|PRIMAVIDA|SULAMERICA|UNIMED|DENTAL INTEGRAL|INPAO|ODONTOMAXI|RODRIGUES LEIRA|PROASA|IPSM|PASA|ODONTOPREV|METLIFE|IDEAL ODONTO|ODONTOSYSTEM|DENTAL MAIS|ODONTOGROUP|ODONTOLIFE|SEMPRE ODONTO|ODONTOART|PORTO SEGURO|BRAZIL DENTAL|COPASS|NOVODENTE|ODONTOEMPRESAS|UNIODONTO|PLENODONTO|MAIS DENTAL|ODONTO SA|QUALIDONTO|HAPVIDA|GOLDEN CROSS|TEM SAUDE|ASSIM|PRODENTAL'
    ) AS TIPO,    
    group_concat(c.Description) as 'PROCEDIMENTO',
    t.*	
from Treatment t
left join TreatmentOperation ti on ti.TreatmentId = t.id
left join Characteristic c on c.id = ti.Procedure_CharacteristicId
left join Person p on p.id = t.Patient_PersonId
left join Person d on d.id = t.Dentist_PersonId

left join(
	select 
		be.TreatmentId,
		sum(be.Amount) AS Valor_BE
	from BookEntry be 
    where be.Type = 'CREDIT'
    group by be.TreatmentId
) teste on teste.TreatmentId = t.id

left join (
	select 
		ph.TreatmentId,
		sum(pi.Amount) as VALOR
    from PaymentHeader ph    
    left join PaymentItem pi on pi.PaymentHeaderId = ph.id
    group by pi.PaymentHeaderId
) x on x.TreatmentId = t.id

where t.z_Namespace = 'odcpqdocarmo.br.sp.sao_paulo'
and str_to_date(cast(t.ApprovedDateAtomic as char), '%Y%m%d') between 20241201 and 20241222
and t.ApprovedByUserId is not null
-- and be.Type = 'CREDIT'
-- and coalesce(pi.Canceled, '') <> 'X'
-- and p.Name like '%SABRINA LOPES%'
group by t.id
order by t.ApprovedDateAtomic, p.Name;