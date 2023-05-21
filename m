Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73170B199
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjEUWaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEUWag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:30:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D69198;
        Sun, 21 May 2023 15:30:13 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMNFZc024542;
        Sun, 21 May 2023 22:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qW3gQR2roTeQffrn8NsxMMfBYnZL7cvjg1jsIlx91Ns=;
 b=ihmpJAzXU68SgE8nSH00jLd3RqQx9MBlrwA3xXHpP9bc9XGfFKrbvTwk6QVXuQyA8efT
 GvlYWADDhZcHeowkfC+bIX/UryvOh9tCuoYzkYGi8SiX21J2lp64EZ8c//1FrKFxdffy
 1meBvXtceZ+MxhVNqzNgsqEYVobzRkxHfIi9eRnXL6/Vyb/Na1Ii04CfRHZ3zMRyViQV
 rcXswDRpsI0R17Sfkg9uBo1bGE4ndd1hZ1BTm6mc+dWBSHOPvKq5pdF94ztgf3tZdNxn
 22JJBnf14xTweBptljegIhYo+8cpikzuZ5l4+FB2yOM/9eQT6uN7JSHDUMteUIRUdtF1 2Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpqgf26eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMU0RF000476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:00 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:29:53 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <quic_mmanikan@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 06/13] clk: qcom: ipq5018: remove q6 bring up clocks
Date:   Mon, 22 May 2023 03:58:45 +0530
Message-ID: <20230521222852.5740-7-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iVat257bFjWbLGtxVBieiEQbAc4IiXkr
X-Proofpoint-GUID: iVat257bFjWbLGtxVBieiEQbAc4IiXkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210203
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Q6 firmware takes care of it's bring up clocks
in multipd model, remove from gcc driver.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5018.c | 414 ---------------------------------
 1 file changed, 414 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 7ac93b1d6b3f..0dab7d94a3ae 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -2225,159 +2225,6 @@ static struct clk_branch gcc_prng_ahb_clk = {
 	},
 };

-static struct clk_branch gcc_q6_ahb_clk = {
-	.halt_reg = 0x59138,
-	.clkr = {
-		.enable_reg = 0x59138,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_ahb_s_clk = {
-	.halt_reg = 0x5914C,
-	.clkr = {
-		.enable_reg = 0x5914C,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6_ahb_s_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_axim_clk = {
-	.halt_reg = 0x5913C,
-	.clkr = {
-		.enable_reg = 0x5913C,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6_axim_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&q6_axi_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_axim2_clk = {
-	.halt_reg = 0x59150,
-	.clkr = {
-		.enable_reg = 0x59150,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6_axim2_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&q6_axi_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_axis_clk = {
-	.halt_reg = 0x59154,
-	.clkr = {
-		.enable_reg = 0x59154,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6_axis_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&system_noc_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_tsctr_1to2_clk = {
-	.halt_reg = 0x59148,
-	.clkr = {
-		.enable_reg = 0x59148,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6_tsctr_1to2_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_tsctr_div2_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6ss_atbm_clk = {
-	.halt_reg = 0x59144,
-	.clkr = {
-		.enable_reg = 0x59144,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6ss_atbm_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_at_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6ss_pclkdbg_clk = {
-	.halt_reg = 0x59140,
-	.clkr = {
-		.enable_reg = 0x59140,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6ss_pclkdbg_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6ss_trig_clk = {
-	.halt_reg = 0x59128,
-	.clkr = {
-		.enable_reg = 0x59128,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_q6ss_trig_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_qdss_at_clk = {
 	.halt_reg = 0x29024,
 	.clkr = {
@@ -2803,23 +2650,6 @@ static struct clk_branch gcc_sys_noc_usb0_axi_clk = {
 	},
 };

-static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
-	.halt_reg = 0x26034,
-	.clkr = {
-		.enable_reg = 0x26034,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_sys_noc_wcss_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_ubi0_axi_clk = {
 	.halt_reg = 0x68200,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -3134,227 +2964,6 @@ static struct clk_branch gcc_usb0_pipe_clk = {
 	},
 };

-static struct clk_branch gcc_wcss_acmt_clk = {
-	.halt_reg = 0x59064,
-	.clkr = {
-		.enable_reg = 0x59064,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_acmt_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_ahb_s_clk = {
-	.halt_reg = 0x59034,
-	.clkr = {
-		.enable_reg = 0x59034,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_ahb_s_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_axi_m_clk = {
-	.halt_reg = 0x5903C,
-	.clkr = {
-		.enable_reg = 0x5903C,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_axi_m_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&system_noc_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_axi_s_clk = {
-	.halt_reg = 0x59068,
-	.clkr = {
-		.enable_reg = 0x59068,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wi_s_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&system_noc_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_apb_bdg_clk = {
-	.halt_reg = 0x59050,
-	.clkr = {
-		.enable_reg = 0x59050,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_apb_bdg_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_apb_clk = {
-	.halt_reg = 0x59040,
-	.clkr = {
-		.enable_reg = 0x59040,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_apb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_atb_bdg_clk = {
-	.halt_reg = 0x59054,
-	.clkr = {
-		.enable_reg = 0x59054,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_atb_bdg_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_at_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_atb_clk = {
-	.halt_reg = 0x59044,
-	.clkr = {
-		.enable_reg = 0x59044,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_atb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_at_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_dapbus_bdg_clk = {
-	.halt_reg = 0x59060,
-	.clkr = {
-		.enable_reg = 0x59060,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_dapbus_bdg_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_dapbus_clk = {
-	.halt_reg = 0x5905C,
-	.clkr = {
-		.enable_reg = 0x5905C,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_dapbus_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_nts_bdg_clk = {
-	.halt_reg = 0x59058,
-	.clkr = {
-		.enable_reg = 0x59058,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_nts_bdg_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_tsctr_div2_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_nts_clk = {
-	.halt_reg = 0x59048,
-	.clkr = {
-		.enable_reg = 0x59048,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_nts_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_tsctr_div2_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_ecahb_clk = {
-	.halt_reg = 0x59038,
-	.clkr = {
-		.enable_reg = 0x59038,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_wcss_ecahb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_hw *gcc_ipq5018_hws[] = {
 	&gpll0_out_main_div2.hw,
 	&pcnoc_clk_src.hw,
@@ -3444,15 +3053,6 @@ static struct clk_regmap *gcc_ipq5018_clks[] = {
 	[GCC_PCIE1_AXI_S_BRIDGE_CLK] = &gcc_pcie1_axi_s_bridge_clk.clkr,
 	[GCC_PCIE1_AXI_S_CLK] = &gcc_pcie1_axi_s_clk.clkr,
 	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
-	[GCC_Q6_AXIM_CLK] = &gcc_q6_axim_clk.clkr,
-	[GCC_Q6_AXIM2_CLK] = &gcc_q6_axim2_clk.clkr,
-	[GCC_Q6_AXIS_CLK] = &gcc_q6_axis_clk.clkr,
-	[GCC_Q6_AHB_CLK] = &gcc_q6_ahb_clk.clkr,
-	[GCC_Q6_AHB_S_CLK] = &gcc_q6_ahb_s_clk.clkr,
-	[GCC_Q6_TSCTR_1TO2_CLK] = &gcc_q6_tsctr_1to2_clk.clkr,
-	[GCC_Q6SS_ATBM_CLK] = &gcc_q6ss_atbm_clk.clkr,
-	[GCC_Q6SS_PCLKDBG_CLK] = &gcc_q6ss_pclkdbg_clk.clkr,
-	[GCC_Q6SS_TRIG_CLK] = &gcc_q6ss_trig_clk.clkr,
 	[GCC_QDSS_AT_CLK] = &gcc_qdss_at_clk.clkr,
 	[GCC_QDSS_CFG_AHB_CLK] = &gcc_qdss_cfg_ahb_clk.clkr,
 	[GCC_QDSS_DAP_AHB_CLK] = &gcc_qdss_dap_ahb_clk.clkr,
@@ -3479,7 +3079,6 @@ static struct clk_regmap *gcc_ipq5018_clks[] = {
 	[GCC_SYS_NOC_PCIE1_AXI_CLK] = &gcc_sys_noc_pcie1_axi_clk.clkr,
 	[GCC_SYS_NOC_QDSS_STM_AXI_CLK] = &gcc_sys_noc_qdss_stm_axi_clk.clkr,
 	[GCC_SYS_NOC_USB0_AXI_CLK] = &gcc_sys_noc_usb0_axi_clk.clkr,
-	[GCC_SYS_NOC_WCSS_AHB_CLK] = &gcc_sys_noc_wcss_ahb_clk.clkr,
 	[GCC_UBI0_AXI_CLK] = &gcc_ubi0_axi_clk.clkr,
 	[GCC_UBI0_CFG_CLK] = &gcc_ubi0_cfg_clk.clkr,
 	[GCC_UBI0_CORE_CLK] = &gcc_ubi0_core_clk.clkr,
@@ -3497,19 +3096,6 @@ static struct clk_regmap *gcc_ipq5018_clks[] = {
 	[GCC_USB0_MOCK_UTMI_CLK] = &gcc_usb0_mock_utmi_clk.clkr,
 	[GCC_USB0_PHY_CFG_AHB_CLK] = &gcc_usb0_phy_cfg_ahb_clk.clkr,
 	[GCC_USB0_SLEEP_CLK] = &gcc_usb0_sleep_clk.clkr,
-	[GCC_WCSS_ACMT_CLK] = &gcc_wcss_acmt_clk.clkr,
-	[GCC_WCSS_AHB_S_CLK] = &gcc_wcss_ahb_s_clk.clkr,
-	[GCC_WCSS_AXI_M_CLK] = &gcc_wcss_axi_m_clk.clkr,
-	[GCC_WCSS_AXI_S_CLK] = &gcc_wcss_axi_s_clk.clkr,
-	[GCC_WCSS_DBG_IFC_APB_BDG_CLK] = &gcc_wcss_dbg_ifc_apb_bdg_clk.clkr,
-	[GCC_WCSS_DBG_IFC_APB_CLK] = &gcc_wcss_dbg_ifc_apb_clk.clkr,
-	[GCC_WCSS_DBG_IFC_ATB_BDG_CLK] = &gcc_wcss_dbg_ifc_atb_bdg_clk.clkr,
-	[GCC_WCSS_DBG_IFC_ATB_CLK] = &gcc_wcss_dbg_ifc_atb_clk.clkr,
-	[GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK] = &gcc_wcss_dbg_ifc_dapbus_bdg_clk.clkr,
-	[GCC_WCSS_DBG_IFC_DAPBUS_CLK] = &gcc_wcss_dbg_ifc_dapbus_clk.clkr,
-	[GCC_WCSS_DBG_IFC_NTS_BDG_CLK] = &gcc_wcss_dbg_ifc_nts_bdg_clk.clkr,
-	[GCC_WCSS_DBG_IFC_NTS_CLK] = &gcc_wcss_dbg_ifc_nts_clk.clkr,
-	[GCC_WCSS_ECAHB_CLK] = &gcc_wcss_ecahb_clk.clkr,
 	[GCC_XO_CLK] = &gcc_xo_clk.clkr,
 	[GCC_XO_CLK_SRC] = &gcc_xo_clk_src.clkr,
 	[GMAC0_RX_CLK_SRC] = &gmac0_rx_clk_src.clkr,
--
2.17.1

