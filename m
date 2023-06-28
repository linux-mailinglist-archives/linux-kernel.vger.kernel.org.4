Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF039740D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjF1Jea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:34:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:21786 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233660AbjF1J30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:29:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S7pbeQ009653;
        Wed, 28 Jun 2023 09:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=LM6gXSpRzTncrjxysNX3sJppNHeXx482q07I5WDoc5Q=;
 b=cUrdaEChrYrNW94BNkR1Q21QWLemiIQ7/4+4uW0wZUgf9wLcrW//X6R66ZGv1DunPeyI
 gGgjvt9vMT/RiDKo1k+UKITscVVPW5+ZI0y8no4ndMcl6eFs7U+o4DI6KZicoYpWGDh7
 fS82NSEtLW4YsKEhEEIeNx3MHD6zFN/zeuF0OFYHouFnvlZJUCI87M6H9WQ6qE0y0CWQ
 441txDjFUypALJRw4SbaZaefEUZSY85fmhi8PkO760HiVlEXjDX+GBe4NSd4RZRru04X
 +d4Jg+6fG/W4jvm9AEyWCzTEeALFgl7L+Juh4WeSg6w+D1zYb15zkBSCPmUTzNrR7wKH Fg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetpghk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:21 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S9TK5e028827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:20 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 02:29:14 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 3/5] clk: qcom: gcc-qdu1000: Update GCC clocks as per the latest hw version
Date:   Wed, 28 Jun 2023 14:58:35 +0530
Message-ID: <20230628092837.3090801-4-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 35YqLzCXHC29oZz6jcL5PEdjWNiRjaOX
X-Proofpoint-GUID: 35YqLzCXHC29oZz6jcL5PEdjWNiRjaOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for gcc_ddrss_ecpri_gsi_clk and update the GCC clkref clocks
as per the latest hardware version of QDU1000 and QRU100 SoCs.

Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
Changes since v1:
 - Newly added

 drivers/clk/qcom/gcc-qdu1000.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index c00d26a3e6df..991fb2bc97e9 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -1131,6 +1131,26 @@ static struct clk_branch gcc_ddrss_ecpri_dma_clk = {
 	},
 };
 
+static struct clk_branch gcc_ddrss_ecpri_gsi_clk = {
+	.halt_reg = 0x54298,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x54298,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x54298,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ddrss_ecpri_gsi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ecpri_ahb_clk = {
 	.halt_reg = 0x3a008,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -1447,14 +1467,13 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
 
 static struct clk_branch gcc_pcie_0_clkref_en = {
 	.halt_reg = 0x9c004,
-	.halt_bit = 31,
-	.halt_check = BRANCH_HALT_ENABLE,
+	.halt_check = BRANCH_HALT,
 	.clkr = {
 		.enable_reg = 0x9c004,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_clkref_en",
-			.ops = &clk_branch_ops,
+			.ops = &clk_branch2_ops,
 		},
 	},
 };
@@ -2274,14 +2293,13 @@ static struct clk_branch gcc_tsc_etu_clk = {
 
 static struct clk_branch gcc_usb2_clkref_en = {
 	.halt_reg = 0x9c008,
-	.halt_bit = 31,
-	.halt_check = BRANCH_HALT_ENABLE,
+	.halt_check = BRANCH_HALT,
 	.clkr = {
 		.enable_reg = 0x9c008,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb2_clkref_en",
-			.ops = &clk_branch_ops,
+			.ops = &clk_branch2_ops,
 		},
 	},
 };
@@ -2523,6 +2541,8 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
 	[GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
 	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
 	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
+	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
+	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_qdu1000_resets[] = {
-- 
2.25.1

