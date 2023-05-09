Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410E66FBDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjEIDgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjEIDgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:36:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5293C1;
        Mon,  8 May 2023 20:36:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3492cVV1006947;
        Tue, 9 May 2023 03:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rWNtofa6g3fl52sjLngWZHFsYv7AoYjClRmTiV9Kg+w=;
 b=DBXYNLMPaRfl4UjJCyCYoRm622DxlfFrA4FjOCEwNK7OAH/fFg3nMW36Grko0Me21mKn
 mc8xu6VsB07MA8wJUja8G+VxvjFrDYj6iN0PIhf4fd7tZyB40x5TDt3GyEY9HZMTkJli
 rA5ouxdoJ72HsioX30Hqa0wZONROP7WRSnR5WATsM1soEKTOPhDstoOLcTpDHTsB00Bm
 0Cb63E8Bvr5CnPGKTslVMdjw3CuwZ4qYgOdEfcvqs38wdQrSlNmekpoa6wxDZd0uLXku
 u/nWYwq2jbKgdfWCACBzZcs5jzGjVnXdGvDeLo+CZbvxy9NcdurSCLKujga5mYVEhZso Zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf7860q5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 03:35:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3493ZrG6010053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 03:35:53 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 20:35:50 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 2/2] soc: qcom: socinfo: Add Soc ID for IPQ5312 and IPQ5302
Date:   Tue, 9 May 2023 09:05:31 +0530
Message-ID: <20230509033531.21468-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230509033531.21468-1-quic_kathirav@quicinc.com>
References: <20230509033531.21468-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k_3kBZYNfNk9K4hPea_RfTqR6K_O_txd
X-Proofpoint-ORIG-GUID: k_3kBZYNfNk9K4hPea_RfTqR6K_O_txd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=946 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC ID for IPQ5312 and IPQ5302, which belong to the family of
IPQ5332 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- s/are belongs/belong/ in commit message
	- Pick up R-b tag

 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index c2e4a57dd666..608c4f57c6c7 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -466,6 +466,8 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QRU1062) },
 	{ qcom_board_id(IPQ5332) },
 	{ qcom_board_id(IPQ5322) },
+	{ qcom_board_id(IPQ5312) },
+	{ qcom_board_id(IPQ5302) },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.17.1

