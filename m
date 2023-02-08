Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FF68E7F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBHF5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjBHF5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:57:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB498442C6;
        Tue,  7 Feb 2023 21:57:39 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3185WEEk009587;
        Wed, 8 Feb 2023 05:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=P1ygoWWcvDpON3+quPfXepBnoOPp6QN6ilpf6N9HsXc=;
 b=meSsM2bRckSaY5LJRgAWSNs2ENCzfVNlhZB6QrRj+NOHL9QAkzBp1gc711395+unZfSq
 RfX6A9nZ9UT16OLUAKQ4BQm1sCYwbvhJvI7REsojWfzHHrlccY2D/DOIHJAdiD+Mo5lB
 3WqbJZYCPqXtR+Fd+wZq60OQYgtV/CN1L1wlAl9r1pnb1SN8/LfCVQfWCYAQEho4oa+a
 K3JNGIEs47QtKY5gvo+cF16kX8ifl/QOGNc6/rRNeHvDRT4zUYXy186IJGfzN6qdevlF
 w8iQLHvXxLNW3FTvP8xxo08Uk7vZGpw0wcDGMxcd9p8FqaDKG8yFCh5BqwV/a9pMuVNY /g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkdeybpa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 05:57:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3185vZHX019544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 05:57:35 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 21:57:31 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add IDs for IPQ5332 and its variant
Date:   Wed, 8 Feb 2023 11:27:09 +0530
Message-ID: <20230208055709.13162-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230208055709.13162-1-quic_kathirav@quicinc.com>
References: <20230208055709.13162-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VUTefQg5TGl8qqYugUGyW_94CwrphoX-
X-Proofpoint-GUID: VUTefQg5TGl8qqYugUGyW_94CwrphoX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_02,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=795 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SOC ID for Qualcomm IPQ5332 and IPQ5322 variants.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 3b970a80f3aa..abe24e1b4022 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -439,6 +439,8 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QRU1032) },
 	{ qcom_board_id(QRU1052) },
 	{ qcom_board_id(QRU1062) },
+	{ qcom_board_id(IPQ5332) },
+	{ qcom_board_id(IPQ5322) },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.17.1

