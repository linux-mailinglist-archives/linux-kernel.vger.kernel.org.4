Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51296767B2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjAUReZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAUReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:34:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E9323D83;
        Sat, 21 Jan 2023 09:34:11 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LHRgaq029400;
        Sat, 21 Jan 2023 17:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=It6HwbxzBzijiUrWxDwnPsxlQeS2oJacAX0qTbCGG8Y=;
 b=Kyc/4LdKUtzxilq4g33ZVFryYss/AkFqmhA0Xn1/Dd8MkmMpQSgawA+P+an1AX4OLY/R
 dmrAUb4cifsrdvZcZUnxR7BvRHJT6DdAQ1r5kj+dULScmve1JKdr4lQTg5CSms1KyCA7
 vwvR/W2XfskEE8iBzrHx4I0O2+PD0d5jkyij2+k1meWraGXR23EptpToZ1TfUBVz3c47
 FnIUXWw5xvNb0DyS4HC5yCAjkou7Kvtezui9e57P1ziF7ndtPPpfKBA/nI7L2zd9VZmm
 T+esK24oaVlu91qVrASwnyVlXFNO+IoS6WJ4X49ijrPyjTLq0BJHEZQUY6abSbmnaJCq Iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89f58nsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 17:34:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30LHY3SU023819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 17:34:03 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sat, 21 Jan 2023 09:33:59 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v5 4/6] clk: qcom: lpasscorecc-sc7280: Skip lpasscorecc registration
Date:   Sat, 21 Jan 2023 23:02:18 +0530
Message-ID: <1674322340-25882-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aziAoKf_5ABToD7yq8vKmwMUqr-80adk
X-Proofpoint-GUID: aziAoKf_5ABToD7yq8vKmwMUqr-80adk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip lpasscorecc clocks registration for ADSP based platforms
as it's causing NOC errors when ADSP based clocks are enabled.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpasscorecc-sc7280.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpasscorecc-sc7280.c
index 6ad19b0..3aa16d8 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7280.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
@@ -395,6 +395,9 @@ static int lpass_core_cc_sc7280_probe(struct platform_device *pdev)
 	const struct qcom_cc_desc *desc;
 	struct regmap *regmap;
 
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode"))
+		return 0;
+
 	lpass_core_cc_sc7280_regmap_config.name = "lpass_core_cc";
 	lpass_core_cc_sc7280_regmap_config.max_register = 0x4f004;
 	desc = &lpass_core_cc_sc7280_desc;
-- 
2.7.4

