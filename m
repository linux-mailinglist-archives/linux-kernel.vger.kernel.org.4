Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C1711203
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjEYRWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjEYRWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:22:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E8189;
        Thu, 25 May 2023 10:22:32 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PGiqSQ023932;
        Thu, 25 May 2023 17:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=/zufWKsA1MqbTnMWec/9SKZnDTzI/ixiZmFaCTIQyoE=;
 b=l4AzVXbCOp9Jv1PYIz7ACPxnWEv34KTfEcH1eDBcxiX+15/EojbuzTUHdiar0Jtcw8ek
 K7KjTL67485BBFAy9rfPmZzmurkqqjqIeR8nd4pCpAQ98+NEYbpkGhmXuXTNF2dXBDka
 gbpGejcAvA3KW1AGRMWB5u6hK4euqOD7hUsG/aSSYAusn1gNWL/CRJvKwMl6t4AOvUbs
 fcWTjoLgNaAXFAOwRemc96+V2AIt4iLP4JhFfZ/9C8YdlHqoxNrFuSXGqS2szTHpK1/W
 q1SW8JeSo3JrfMzo1ul/jdF+g66V8KT+o89SQIn4PlLU/WuCqFte8s+Bc8TOAKcGoOIV IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsuc226t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:22:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PHM8Cj021031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:22:28 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 25 May 2023 10:22:10 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 2/6] clk: qcom: Update l value configuration for lucid ole and evo plls
Date:   Thu, 25 May 2023 22:51:38 +0530
Message-ID: <20230525172142.9039-3-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525172142.9039-1-quic_jkona@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O4lQhXM0uonknpHWYPbJtUfIQjXfWFUx
X-Proofpoint-GUID: O4lQhXM0uonknpHWYPbJtUfIQjXfWFUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_10,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For lucid evo and ole pll's the CAL_L, RING_OSC_CAL_L and L_VAL
are part of the same register, hence update the l configuration
value to include these fields across all the chipsets.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
Changes since V1:
 - Newly added.

 drivers/clk/qcom/camcc-sm8450.c  | 24 ++++++++++++++++--------
 drivers/clk/qcom/dispcc-sm8450.c | 10 ++++++----
 drivers/clk/qcom/dispcc-sm8550.c |  6 ++++--
 drivers/clk/qcom/gpucc-sa8775p.c |  6 ++++--
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
index 51338a2884d2..6a5a08f88598 100644
--- a/drivers/clk/qcom/camcc-sm8450.c
+++ b/drivers/clk/qcom/camcc-sm8450.c
@@ -57,7 +57,8 @@ static const struct pll_vco rivian_evo_vco[] = {
 static const struct clk_parent_data pll_parent_data_tcxo = { .index = DT_BI_TCXO };
 
 static const struct alpha_pll_config cam_cc_pll0_config = {
-	.l = 0x3e,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044003e,
 	.alpha = 0x8000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -128,7 +129,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
 };
 
 static const struct alpha_pll_config cam_cc_pll1_config = {
-	.l = 0x25,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x00440025,
 	.alpha = 0xeaaa,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -199,7 +201,8 @@ static struct clk_alpha_pll cam_cc_pll2 = {
 };
 
 static const struct alpha_pll_config cam_cc_pll3_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -247,7 +250,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll3_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll4_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -295,7 +299,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll4_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll5_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -343,7 +348,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll5_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll6_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -391,7 +397,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll6_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll7_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -439,7 +446,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll7_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll8_config = {
-	.l = 0x32,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x00440032,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index adbfd30bfc96..b0f86bd40a80 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -76,11 +76,12 @@ static struct pll_vco lucid_evo_vco[] = {
 };
 
 static const struct alpha_pll_config disp_cc_pll0_config = {
-	.l = 0xD,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044000d,
 	.alpha = 0x6492,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
-	.config_ctl_hi1_val = 0x32AA299C,
+	.config_ctl_hi1_val = 0x32aa299c,
 	.user_ctl_val = 0x00000000,
 	.user_ctl_hi_val = 0x00000805,
 };
@@ -103,11 +104,12 @@ static struct clk_alpha_pll disp_cc_pll0 = {
 };
 
 static const struct alpha_pll_config disp_cc_pll1_config = {
-	.l = 0x1F,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044001f,
 	.alpha = 0x4000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
-	.config_ctl_hi1_val = 0x32AA299C,
+	.config_ctl_hi1_val = 0x32aa299c,
 	.user_ctl_val = 0x00000000,
 	.user_ctl_hi_val = 0x00000805,
 };
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1e5a11081860..b0d4c623731d 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -76,7 +76,8 @@ static struct pll_vco lucid_ole_vco[] = {
 };
 
 static const struct alpha_pll_config disp_cc_pll0_config = {
-	.l = 0xd,
+	/* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
+	.l = 0x4444000d,
 	.alpha = 0x6492,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -103,7 +104,8 @@ static struct clk_alpha_pll disp_cc_pll0 = {
 };
 
 static const struct alpha_pll_config disp_cc_pll1_config = {
-	.l = 0x1f,
+	/* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
+	.l = 0x4444001f,
 	.alpha = 0x4000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa8775p.c
index 18d23be8d435..153bf6ecb795 100644
--- a/drivers/clk/qcom/gpucc-sa8775p.c
+++ b/drivers/clk/qcom/gpucc-sa8775p.c
@@ -46,7 +46,8 @@ static const struct pll_vco lucid_evo_vco[] = {
 
 /* 810MHz configuration */
 static struct alpha_pll_config gpu_cc_pll0_config = {
-	.l = 0x2a,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002a,
 	.alpha = 0x3000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -72,7 +73,8 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
 
 /* 1000MHz configuration */
 static struct alpha_pll_config gpu_cc_pll1_config = {
-	.l = 0x34,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x00440034,
 	.alpha = 0x1555,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
-- 
2.40.1

