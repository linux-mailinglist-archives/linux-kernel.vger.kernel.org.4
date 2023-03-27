Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F86CAAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjC0QeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjC0QeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:34:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993126AC;
        Mon, 27 Mar 2023 09:33:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32REefc8015630;
        Mon, 27 Mar 2023 16:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7S1232h/XwYZf89QBN7zUWlxPDxwqmmgYZt9Ya4kwYg=;
 b=WMeG9rKh8yB8fvQCHAySGFeI5ueEcRKPgWfw8mk7QAAVIaFf6RSUFElu4puxWtfcL9n9
 Pn21sl+5wAeDq3v4NbgcTBmUQlR3N2mKCfQQLMSaNTRaQLHAvjYEyQAOykuOAojcIWCL
 PTz8VhRehpj7r5sUhGnnGg2qbU8ZtPInu03xQTzWZXKvRrlNHwyT6JHvDY9+ciy6WxK/
 E7ZbePeH3V8n1tCklMDdFUZe1+cflUxHaksIr/i23ci7+01+HmSTh+m1GAxRF1edpevZ
 oYKgIq4/4eM0ZYnPSwB+5DoxIzMXlHdj5RYgUclvn8cY2BZHVli6bL64WUEBIJOhXHYC Gg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsqqn2cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32RGXcUP024417
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:38 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 09:33:33 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v1 4/4] clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock registration
Date:   Mon, 27 Mar 2023 22:02:49 +0530
Message-ID: <20230327163249.1081824-5-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327163249.1081824-1-quic_mohs@quicinc.com>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ONDpdOYg3H39CXoKa8g2vF3aYFYqxufd
X-Proofpoint-ORIG-GUID: ONDpdOYg3H39CXoKa8g2vF3aYFYqxufd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270133
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qdsp6ss memory region is being shared by ADSP remoteproc device and
lpasscc clock device, hence causing memory conflict.
As the qdsp6ss clocks are being enabled in remoteproc driver, remove the
qdsp6ss clock registration.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 63 +------------------------------
 1 file changed, 1 insertion(+), 62 deletions(-)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 48432010ce24..4719e3fa8b05 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -30,48 +30,6 @@ static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
 	},
 };
 
-static struct clk_branch lpass_qdsp6ss_core_clk = {
-	.halt_reg = 0x20,
-	/* CLK_OFF would not toggle until LPASS is out of reset */
-	.halt_check = BRANCH_HALT_SKIP,
-	.clkr = {
-		.enable_reg = 0x20,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "lpass_qdsp6ss_core_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch lpass_qdsp6ss_xo_clk = {
-	.halt_reg = 0x38,
-	/* CLK_OFF would not toggle until LPASS is out of reset */
-	.halt_check = BRANCH_HALT_SKIP,
-	.clkr = {
-		.enable_reg = 0x38,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "lpass_qdsp6ss_xo_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch lpass_qdsp6ss_sleep_clk = {
-	.halt_reg = 0x3c,
-	/* CLK_OFF would not toggle until LPASS is out of reset */
-	.halt_check = BRANCH_HALT_SKIP,
-	.clkr = {
-		.enable_reg = 0x3c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "lpass_qdsp6ss_sleep_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct regmap_config lpass_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -90,18 +48,6 @@ static const struct qcom_cc_desc lpass_cc_top_sc7280_desc = {
 	.num_clks = ARRAY_SIZE(lpass_cc_top_sc7280_clocks),
 };
 
-static struct clk_regmap *lpass_qdsp6ss_sc7280_clocks[] = {
-	[LPASS_QDSP6SS_XO_CLK] = &lpass_qdsp6ss_xo_clk.clkr,
-	[LPASS_QDSP6SS_SLEEP_CLK] = &lpass_qdsp6ss_sleep_clk.clkr,
-	[LPASS_QDSP6SS_CORE_CLK] = &lpass_qdsp6ss_core_clk.clkr,
-};
-
-static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
-	.config = &lpass_regmap_config,
-	.clks = lpass_qdsp6ss_sc7280_clocks,
-	.num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
-};
-
 static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
@@ -121,17 +67,10 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 		goto destroy_pm_clk;
 	}
 
-	lpass_regmap_config.name = "qdsp6ss";
-	desc = &lpass_qdsp6ss_sc7280_desc;
-
-	ret = qcom_cc_probe_by_index(pdev, 0, desc);
-	if (ret)
-		goto destroy_pm_clk;
-
 	lpass_regmap_config.name = "top_cc";
 	desc = &lpass_cc_top_sc7280_desc;
 
-	ret = qcom_cc_probe_by_index(pdev, 1, desc);
+	ret = qcom_cc_probe_by_index(pdev, 0, desc);
 	if (ret)
 		goto destroy_pm_clk;
 
-- 
2.25.1

