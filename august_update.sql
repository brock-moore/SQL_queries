SELECT ACP.CustomerID,
			   ACP.Year,
			   ACP.Month,
			   ACP.PredictionScore,
			   ACP.DateRan,
			   CASE WHEN HDR.Transactions IS NULL THEN 0
			   ELSE 1 END AS [ClassificationStatus],
			   CASE WHEN ACP.PredictionScore < 0.5 THEN 0
			   ELSE 1 END AS [ClassificationPrediction]

		FROM dbo.AugustClassificationPrediction ACP
		LEFT JOIN (
				SELECT	HDR.CustomerID		AS [CustomerID]
					,	COUNT(*) AS [Transactions]
				FROM	dbo.TransactionHeader	HDR
				WHERE	Type = 2
				AND YEAR(Date) = 2020
				AND MONTH(Date) = 8
				GROUP BY	HDR.CustomerID
				) 	HDR ON ACP.CustomerID = HDR.CustomerID