Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145C74D37E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjGJKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjGJK3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:29:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0ED137;
        Mon, 10 Jul 2023 03:29:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A8duui024037;
        Mon, 10 Jul 2023 10:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=vwz8sirgI8Vum32CR8k5p21/W3ZdmD/EEFx0n4P5ptY=;
 b=JlVuTGZNebr8tFYvVVfJSRFRm9F3vH+NbEVDgOMPbPD6b7HCMRpb81oh8EBjhBbo/qz1
 yGBDSzgkpttmCOe4vkhMIDN6gogkt3S0d9dbGbuSOZuyv54uAPXuL6Xp1WEe1JlzyyGH
 cfl2DnEoHOyYORuIS5iNzNEHKczwNXKFhf1cu0qOLW9UCCQt7rBLESxhVrtMuSc5adNe
 kyidLjjF2/+ylior6sDoNGkkT1BMV+qn2knU+UZaZu8GIc+P7fwcJGIwQcBXctbObk0m
 tczIWKx726/vITrMbac3UXdNDaXPwLpwRV0U0tCqshYwi45HYg6tW8g4nz+cPSD/NQxU Aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq0yt34k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:28:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AASb92030008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:28:37 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:28:33 -0700
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
Subject: [PATCH 2/2] clk: qcom: ipq5332: drop the gcc_apss_axi_clk_src clock
Date:   Mon, 10 Jul 2023 15:58:07 +0530
Message-ID: <20230710102807.1189942-3-quic_kathirav@quicinc.com>
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
X-Proofpoint-GUID: HaQ1-cUQBPXtK008zA436Flrk3xmjSdY
X-Proofpoint-ORIG-GUID: HaQ1-cUQBPXtK008zA436Flrk3xmjSdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
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

With the removal of the mem noc clocks in the commit e224dc703521 ("clk:
qcom: gcc-ipq5332: drop the mem noc clocks"), we can drop the
gcc_apss_axi_clk_src clock as well, since there are no clocks uses this
clock as a parent.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 111 ++++++++++++---------------------
 1 file changed, 39 insertions(+), 72 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 939925baa9eb..40d8e8d5956f 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -224,38 +224,20 @@ static const struct clk_parent_data gcc_parent_data_4[] = {
 };
 
 static const struct parent_map gcc_parent_map_5[] = {
-	{ P_XO, 0 },
-	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_GPLL2_OUT_AUX, 2 },
-	{ P_GPLL4_OUT_AUX, 3 },
-	{ P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC, 4 },
-	{ P_GPLL0_OUT_AUX, 5 },
-};
-
-static const struct clk_parent_data gcc_parent_data_5[] = {
-	{ .index = DT_XO },
-	{ .hw = &gpll0.clkr.hw },
-	{ .hw = &gpll2.clkr.hw },
-	{ .hw = &gpll4.clkr.hw },
-	{ .hw = &gpll0_div2.hw },
-	{ .hw = &gpll0.clkr.hw },
-};
-
-static const struct parent_map gcc_parent_map_6[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_SLEEP_CLK, 6 },
 };
 
-static const struct clk_parent_data gcc_parent_data_6[] = {
+static const struct clk_parent_data gcc_parent_data_5[] = {
 	{ .index = DT_XO },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll0.clkr.hw },
 	{ .index = DT_SLEEP_CLK },
 };
 
-static const struct parent_map gcc_parent_map_7[] = {
+static const struct parent_map gcc_parent_map_6[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL2_OUT_AUX, 2 },
@@ -263,7 +245,7 @@ static const struct parent_map gcc_parent_map_7[] = {
 	{ P_SLEEP_CLK, 6 },
 };
 
-static const struct clk_parent_data gcc_parent_data_7[] = {
+static const struct clk_parent_data gcc_parent_data_6[] = {
 	{ .index = DT_XO },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll2.clkr.hw },
@@ -271,74 +253,74 @@ static const struct clk_parent_data gcc_parent_data_7[] = {
 	{ .index = DT_SLEEP_CLK },
 };
 
-static const struct parent_map gcc_parent_map_8[] = {
+static const struct parent_map gcc_parent_map_7[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL2_OUT_AUX, 2 },
 };
 
-static const struct clk_parent_data gcc_parent_data_8[] = {
+static const struct clk_parent_data gcc_parent_data_7[] = {
 	{ .index = DT_XO },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll2.clkr.hw },
 };
 
-static const struct parent_map gcc_parent_map_9[] = {
+static const struct parent_map gcc_parent_map_8[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL2_OUT_MAIN, 2 },
 	{ P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC, 4 },
 };
 
-static const struct clk_parent_data gcc_parent_data_9[] = {
+static const struct clk_parent_data gcc_parent_data_8[] = {
 	{ .index = DT_XO },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll2.clkr.hw },
 	{ .hw = &gpll0_div2.hw },
 };
 
-static const struct parent_map gcc_parent_map_10[] = {
+static const struct parent_map gcc_parent_map_9[] = {
 	{ P_SLEEP_CLK, 6 },
 };
 
-static const struct clk_parent_data gcc_parent_data_10[] = {
+static const struct clk_parent_data gcc_parent_data_9[] = {
 	{ .index = DT_SLEEP_CLK },
 };
 
-static const struct parent_map gcc_parent_map_11[] = {
+static const struct parent_map gcc_parent_map_10[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL4_OUT_MAIN, 2 },
 	{ P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC, 3 },
 };
 
-static const struct clk_parent_data gcc_parent_data_11[] = {
+static const struct clk_parent_data gcc_parent_data_10[] = {
 	{ .index = DT_XO },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll4.clkr.hw },
 	{ .hw = &gpll0_div2.hw },
 };
 
-static const struct parent_map gcc_parent_map_12[] = {
+static const struct parent_map gcc_parent_map_11[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_SLEEP_CLK, 6 },
 };
 
-static const struct clk_parent_data gcc_parent_data_12[] = {
+static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .index = DT_XO },
 	{ .hw = &gpll0.clkr.hw },
 	{ .index = DT_SLEEP_CLK },
 };
 
-static const struct parent_map gcc_parent_map_13[] = {
+static const struct parent_map gcc_parent_map_12[] = {
 	{ P_XO, 0 },
 	{ P_GPLL4_OUT_AUX, 1 },
 	{ P_GPLL0_OUT_MAIN, 3 },
 	{ P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC, 4 },
 };
 
-static const struct clk_parent_data gcc_parent_data_13[] = {
+static const struct clk_parent_data gcc_parent_data_12[] = {
 	{ .index = DT_XO },
 	{ .hw = &gpll4.clkr.hw },
 	{ .hw = &gpll0.clkr.hw },
@@ -371,20 +353,6 @@ static const struct freq_tbl ftbl_gcc_apss_axi_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_apss_axi_clk_src = {
-	.cmd_rcgr = 0x24004,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_5,
-	.freq_tbl = ftbl_gcc_apss_axi_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "gcc_apss_axi_clk_src",
-		.parent_data = gcc_parent_data_5,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_blsp1_qup1_spi_apps_clk_src[] = {
 	F(960000, P_XO, 1, 1, 25),
 	F(4800000, P_XO, 5, 0, 0),
@@ -733,12 +701,12 @@ static struct clk_rcg2 gcc_pcie_aux_clk_src = {
 	.cmd_rcgr = 0x28004,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_6,
+	.parent_map = gcc_parent_map_5,
 	.freq_tbl = ftbl_gcc_pcie_aux_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pcie_aux_clk_src",
-		.parent_data = gcc_parent_data_6,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
+		.parent_data = gcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -810,12 +778,12 @@ static struct clk_rcg2 gcc_q6_axim_clk_src = {
 	.cmd_rcgr = 0x25004,
 	.mnd_width = 0,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_7,
+	.parent_map = gcc_parent_map_6,
 	.freq_tbl = ftbl_gcc_apss_axi_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_q6_axim_clk_src",
-		.parent_data = gcc_parent_data_7,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
+		.parent_data = gcc_parent_data_6,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -931,12 +899,12 @@ static struct clk_rcg2 gcc_qpic_io_macro_clk_src = {
 	.cmd_rcgr = 0x32004,
 	.mnd_width = 0,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_8,
+	.parent_map = gcc_parent_map_7,
 	.freq_tbl = ftbl_gcc_qpic_io_macro_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_qpic_io_macro_clk_src",
-		.parent_data = gcc_parent_data_8,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
+		.parent_data = gcc_parent_data_7,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -957,12 +925,12 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 	.cmd_rcgr = 0x33004,
 	.mnd_width = 8,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_9,
+	.parent_map = gcc_parent_map_8,
 	.freq_tbl = ftbl_gcc_sdcc1_apps_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_sdcc1_apps_clk_src",
-		.parent_data = gcc_parent_data_9,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
+		.parent_data = gcc_parent_data_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
@@ -976,12 +944,12 @@ static struct clk_rcg2 gcc_sleep_clk_src = {
 	.cmd_rcgr = 0x3400c,
 	.mnd_width = 0,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_10,
+	.parent_map = gcc_parent_map_9,
 	.freq_tbl = ftbl_gcc_sleep_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_sleep_clk_src",
-		.parent_data = gcc_parent_data_10,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_10),
+		.parent_data = gcc_parent_data_9,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -998,12 +966,12 @@ static struct clk_rcg2 gcc_system_noc_bfdcd_clk_src = {
 	.cmd_rcgr = 0x2e004,
 	.mnd_width = 0,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_11,
+	.parent_map = gcc_parent_map_10,
 	.freq_tbl = ftbl_gcc_system_noc_bfdcd_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_system_noc_bfdcd_clk_src",
-		.parent_data = gcc_parent_data_11,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_11),
+		.parent_data = gcc_parent_data_10,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_10),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -1039,12 +1007,12 @@ static struct clk_rcg2 gcc_usb0_aux_clk_src = {
 	.cmd_rcgr = 0x2c018,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_12,
+	.parent_map = gcc_parent_map_11,
 	.freq_tbl = ftbl_gcc_pcie_aux_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_usb0_aux_clk_src",
-		.parent_data = gcc_parent_data_12,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_12),
+		.parent_data = gcc_parent_data_11,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_11),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -1091,12 +1059,12 @@ static struct clk_rcg2 gcc_usb0_mock_utmi_clk_src = {
 	.cmd_rcgr = 0x2c02c,
 	.mnd_width = 8,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_13,
+	.parent_map = gcc_parent_map_12,
 	.freq_tbl = ftbl_gcc_usb0_mock_utmi_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_usb0_mock_utmi_clk_src",
-		.parent_data = gcc_parent_data_13,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_13),
+		.parent_data = gcc_parent_data_12,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_12),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -3328,7 +3296,6 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_ADSS_PWM_CLK] = &gcc_adss_pwm_clk.clkr,
 	[GCC_ADSS_PWM_CLK_SRC] = &gcc_adss_pwm_clk_src.clkr,
 	[GCC_AHB_CLK] = &gcc_ahb_clk.clkr,
-	[GCC_APSS_AXI_CLK_SRC] = &gcc_apss_axi_clk_src.clkr,
 	[GCC_BLSP1_AHB_CLK] = &gcc_blsp1_ahb_clk.clkr,
 	[GCC_BLSP1_QUP1_I2C_APPS_CLK] = &gcc_blsp1_qup1_i2c_apps_clk.clkr,
 	[GCC_BLSP1_QUP1_SPI_APPS_CLK] = &gcc_blsp1_qup1_spi_apps_clk.clkr,
-- 
2.34.1

