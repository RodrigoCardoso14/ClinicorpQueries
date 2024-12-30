SELECT     
	p.Name,
	t.z_Namespace AS Unidade,     
	t.ExecutedDate AS Data,     
	COUNT(*) AS TotalInstalacoes 
FROM PatientPlan pp 
left JOIN TreatmentOperation t ON t.PatientPlanId = pp.id 
left JOIN PlanControl pc ON pp.PlanId = pc.id 
left join Person p on p.id = pp.PatientId
WHERE pp.z_Namespace = 'odcpqdocarmo.br.sp.sao_paulo'	
and t.Executed = 'X'     
-- AND upper(pc.Name) LIKE '%MANUTENÇÃO%'     
AND t.ExecutedDate >= '2024-12-01'     
AND t.ExecutedDate = (         
	SELECT MIN(t1.ExecutedDate)         
	FROM TreatmentOperation t1         
	WHERE t1.PatientPlanId = t.PatientPlanId           
	AND t1.Executed = 'X') 
GROUP BY t.ExecutedDate;