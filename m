Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C4D65D943
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbjADQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbjADQW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:22:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436501A048;
        Wed,  4 Jan 2023 08:22:29 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FUjAg022412;
        Wed, 4 Jan 2023 16:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3KPGEp3I4+Jctna2PAD8ox70bJxxOEzVkwc5+X1wK+Q=;
 b=MmEcmYe+z8KBtYu8e3a/BEBr5I6WSpQVppBPx+PW8iOY9g1WMYLODcqXzHp4GCr0GDTF
 Mpe3HearOffp94wUBKbLcD0XkVZKNnfV5TgxzwxOeC7hDQNdckHdqaTuKNPaDm9qT4wb
 jQuJtVRR4yMgYdLn3RR8RGuU6rRVTT4JZc9I7l1zaWs9B493E9K5krjPUr6R9FamWyJe
 eqFGnJKRmCck/pamj234qoZ7CxW/E85+tv2CXkKq1kEwtcgqOEPgcPI7fHBpGElcFJde
 lZpLd/Go7pptjahvOIv7z8j2FhmdAXrjFfLIYYSTLqDIjzQS3cPYv0GeaIEWwuDHwBER AQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvgt6eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 16:22:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 304GMMVY027391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 16:22:22 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 4 Jan 2023 08:22:17 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v3 4/4] clk: qcom: lpasscc-sc7280: Add resets for audioreach
Date:   Wed, 4 Jan 2023 21:51:37 +0530
Message-ID: <1672849297-3116-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com>
References: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AR6hxzU592cHiXw1FOkOZmhKxmUcohPG
X-Proofpoint-ORIG-GUID: AR6hxzU592cHiXw1FOkOZmhKxmUcohPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=888
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040136
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock gating control for TX/RX/WSA core bus clocks would be required
to be reset(moved from hardware control) from audio core driver. Thus
add the support for the reset clocks in audioreach based clock driver.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 85dd5b9..1efb72d 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -12,10 +12,12 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,lpass-sc7280.h>
+#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
 
 #include "clk-regmap.h"
 #include "clk-branch.h"
 #include "common.h"
+#include "reset.h"
 
 static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
 	.halt_reg = 0x0,
@@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
 	.num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
 };
 
+static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
+	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
+	[LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
+	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
+};
+
+static const struct qcom_cc_desc lpass_audio_cc_reset_sc7280_desc = {
+	.config = &lpass_regmap_config,
+	.resets = lpass_cc_sc7280_resets,
+	.num_resets = ARRAY_SIZE(lpass_cc_sc7280_resets),
+};
+
 static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
@@ -134,6 +148,15 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 	if (ret)
 		goto destroy_pm_clk;
 
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
+		lpass_regmap_config.name = "reset_cgcr";
+		desc = &lpass_audio_cc_reset_sc7280_desc;
+
+		ret = qcom_cc_probe_by_index(pdev, 2, desc);
+		if (ret)
+			goto destroy_pm_clk;
+	}
+
 	return 0;
 
 destroy_pm_clk:
-- 
2.7.4

