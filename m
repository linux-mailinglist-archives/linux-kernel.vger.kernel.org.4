Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB76598EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiL3NoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiL3NoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:44:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8519006;
        Fri, 30 Dec 2022 05:44:08 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BUDaILE026548;
        Fri, 30 Dec 2022 13:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wEMPCGuMSZZgvLGYyfZTWtrPvNcqL5GABUnGYTh++2A=;
 b=bhH/RRHf2r9ZyS6nCUsNd6KyG1UbgmxylRELwnR+MSICdpo/XLw3a2UiL+ba1OTbQJ/C
 1uwhxpmc6lQpzSm+psFzi5fs5EAFN2OzeTZq2jeR2pLMPIO9H64FphlpVv9gPFLIB51Y
 ePfsIahyzTkxGTOpn67b9Hv+3yt2Q7HMh6Op9aJ8s7temezYjY0YynplxEufDyW4Ek8Z
 hhos5sZzL0gN+8XrIJbhzYE/sAb1sSe8Yvehix1xsxJKR9HSMVb83PyDr3+QF37Qvrve
 fmA1KPVKHlldWPfXcJ/WsHUmsOqpwp7Ee0wKsGNP247Fu+ysLnV5Im8xBzwW+9SB2Pve Qw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mrp0yv305-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 13:44:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BUDi12n030836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 13:44:01 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 30 Dec 2022 05:43:56 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 3/4] clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock control
Date:   Fri, 30 Dec 2022 19:13:18 +0530
Message-ID: <1672407799-13768-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
References: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3NHclXBprvhMylzz32qHvsV5sAEUm3nQ
X-Proofpoint-ORIG-GUID: 3NHclXBprvhMylzz32qHvsV5sAEUm3nQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_08,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300120
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qdsp6ss memory region is being shared by ADSP remoteproc device and
lpasscc clock device, hence causing memory conflict.
As the qdsp6ss clocks are being enabled in remoteproc driver,
remove clock controlling in the clock driver.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 63 +--------------------------------------
 1 file changed, 1 insertion(+), 62 deletions(-)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 5c1e17b..87e1c21 100644
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
@@ -118,17 +64,10 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
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
2.7.4

