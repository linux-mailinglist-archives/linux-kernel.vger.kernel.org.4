Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9702A74D37B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjGJK35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjGJK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:29:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC69FE;
        Mon, 10 Jul 2023 03:29:08 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A9TVT1026068;
        Mon, 10 Jul 2023 10:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Eybpy6N9kiEz+STVoex5+gzAzPiSMzTvQDCQKtGPOdI=;
 b=gUDM4q6qY0rpQRajOWK5SNsiviOHbaIjR3orfnAGZb40tGPHtzyxjT67A2K+dwrS/gmc
 Py+STfk6EwxDEWj5cOezhIXYMFAiqj5jwVrM4r+oFxJwfsjdtqZDpHW1CiEgULQ9Kzbs
 z3mGz8k5S6mBzJSIvviY/a/ID8Mc6ExhkRAUjmd1XbiMPnNnPISFgN8AWjXuxUeqzGWW
 8/81CxLjWinq2dacJ8bdmB+76bAlM8lferYviLLyVFxDc3vp0hX2yi8lOeJujDJ6jxYR
 N83QMrrfJ2YFaFBMYlq1ofIwlIOsVAdncsEv2v1T2htL5P+BoAFz93ppeh9XBmO2ICWg tA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rrfde83s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:28:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AASXMI001847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:28:33 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:28:28 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 1/2] clk: qcom: ipq5332: drop the mem noc clocks
Date:   Mon, 10 Jul 2023 15:58:06 +0530
Message-ID: <20230710102807.1189942-2-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
References: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZNGd7A_D5ozVxGe7-HS8KmggrNOkeEZU
X-Proofpoint-ORIG-GUID: ZNGd7A_D5ozVxGe7-HS8KmggrNOkeEZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the recent design changes, all the mem noc clocks will be
configured by the bootloaders and it will be access protected by the TZ
firmware. So drop these clocks from the GCC driver.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 95 ----------------------------------
 1 file changed, 95 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index a75ab88ed14c..939925baa9eb 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -1635,42 +1635,6 @@ static struct clk_branch gcc_mdio_slave_ahb_clk = {
 	},
 };
 
-static struct clk_branch gcc_mem_noc_q6_axi_clk = {
-	.halt_reg = 0x19010,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x19010,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_mem_noc_q6_axi_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_q6_axim_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_mem_noc_ts_clk = {
-	.halt_reg = 0x19028,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x19028,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_mem_noc_ts_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_tsctr_div8_clk_src.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_nss_ts_clk = {
 	.halt_reg = 0x17018,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -3339,42 +3303,6 @@ static struct clk_branch gcc_nssnoc_pcnoc_1_clk = {
 	},
 };
 
-static struct clk_branch gcc_mem_noc_ahb_clk = {
-	.halt_reg = 0x1900c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x1900c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_mem_noc_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_pcnoc_bfdcd_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_mem_noc_apss_axi_clk = {
-	.halt_reg = 0x1901c,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0xb004,
-		.enable_mask = BIT(6),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_mem_noc_apss_axi_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_apss_axi_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_regmap_div gcc_snoc_qosgen_extref_div_clk_src = {
 	.reg = 0x2e010,
 	.shift = 0,
@@ -3390,24 +3318,6 @@ static struct clk_regmap_div gcc_snoc_qosgen_extref_div_clk_src = {
 	},
 };
 
-static struct clk_branch gcc_mem_noc_qosgen_extref_clk = {
-	.halt_reg = 0x19024,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x19024,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_mem_noc_qosgen_extref_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_snoc_qosgen_extref_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GPLL0_MAIN] = &gpll0_main.clkr,
 	[GPLL0] = &gpll0.clkr,
@@ -3451,8 +3361,6 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_LPASS_SWAY_CLK_SRC] = &gcc_lpass_sway_clk_src.clkr,
 	[GCC_MDIO_AHB_CLK] = &gcc_mdio_ahb_clk.clkr,
 	[GCC_MDIO_SLAVE_AHB_CLK] = &gcc_mdio_slave_ahb_clk.clkr,
-	[GCC_MEM_NOC_Q6_AXI_CLK] = &gcc_mem_noc_q6_axi_clk.clkr,
-	[GCC_MEM_NOC_TS_CLK] = &gcc_mem_noc_ts_clk.clkr,
 	[GCC_NSS_TS_CLK] = &gcc_nss_ts_clk.clkr,
 	[GCC_NSS_TS_CLK_SRC] = &gcc_nss_ts_clk_src.clkr,
 	[GCC_NSSCC_CLK] = &gcc_nsscc_clk.clkr,
@@ -3573,10 +3481,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_XO_DIV4_CLK] = &gcc_xo_div4_clk.clkr,
 	[GCC_IM_SLEEP_CLK] = &gcc_im_sleep_clk.clkr,
 	[GCC_NSSNOC_PCNOC_1_CLK] = &gcc_nssnoc_pcnoc_1_clk.clkr,
-	[GCC_MEM_NOC_AHB_CLK] = &gcc_mem_noc_ahb_clk.clkr,
-	[GCC_MEM_NOC_APSS_AXI_CLK] = &gcc_mem_noc_apss_axi_clk.clkr,
 	[GCC_SNOC_QOSGEN_EXTREF_DIV_CLK_SRC] = &gcc_snoc_qosgen_extref_div_clk_src.clkr,
-	[GCC_MEM_NOC_QOSGEN_EXTREF_CLK] = &gcc_mem_noc_qosgen_extref_clk.clkr,
 	[GCC_PCIE3X2_PIPE_CLK_SRC] = &gcc_pcie3x2_pipe_clk_src.clkr,
 	[GCC_PCIE3X1_0_PIPE_CLK_SRC] = &gcc_pcie3x1_0_pipe_clk_src.clkr,
 	[GCC_PCIE3X1_1_PIPE_CLK_SRC] = &gcc_pcie3x1_1_pipe_clk_src.clkr,
-- 
2.34.1

