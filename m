Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A816AD753
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCGGXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCGGXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:23:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A5B469;
        Mon,  6 Mar 2023 22:23:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3276Fcui002777;
        Tue, 7 Mar 2023 06:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=I9vAV7t/Oy+1Jz4lubj0Pxq5DOaUmbmSY8lOuwdUcmQ=;
 b=oNEjqWi7N1XMpE+AGCQLXsBHRzv2zuplyHfVhvmGkYf1FkzpGb5a+1EczQkwZzv6k9+j
 XGkDTB5SxiksiUKvd/Lyo90LVlNMKu9BZe1dPrHcNXPp8HkOpDMY6FpU/+TeqeU52/nz
 oC+YW8BnDZHKAyLSbsFPyv94+m7FvzNIsBc5RD4hmQ7ZcW5n9gB/3KigMBxh+0ejK0iI
 VXVfPADyYEkEuTe7f1fPCtWzmjT/7rfUAQnb1OdAHzqLiO6o7XY61QWwGj7TaKumG0Bn
 9RayKniLGHjORGi4F1/avo2Un+4MQfIi/Fpizoi24pb6p4NfA426ziJP6nexgt+XaBdl gQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p418774ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:23:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3276N8CU001810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 06:23:08 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 22:23:01 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V6 2/9] clk: qcom: Add STROMER PLUS PLL type for IPQ5332
Date:   Tue, 7 Mar 2023 11:52:25 +0530
Message-ID: <20230307062232.4889-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307062232.4889-1-quic_kathirav@quicinc.com>
References: <20230307062232.4889-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0H7n_IouHcFdYo6KF1omWzlbnWv5BlHm
X-Proofpoint-ORIG-GUID: 0H7n_IouHcFdYo6KF1omWzlbnWv5BlHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_01,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=830 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for stromer plus pll, which is found on the IPQ5332
SoCs. Programming sequence is same as the stromer pll, so we can re-use
the same.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V6:
	- No changes

Changes in V5:
	- No changes

Changes in V4:
	- No changes

Changes in V3:
	- No changes

Changes in V2:
	- Added the Reviewed-by tag

 drivers/clk/qcom/clk-alpha-pll.c | 11 +++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 14f9436b62fc..b9f6535a7ba7 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -216,6 +216,17 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL_U] = 0x34,
 		[PLL_OFF_STATUS] = 0x28,
 	},
+	[CLK_ALPHA_PLL_TYPE_STROMER_PLUS] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_USER_CTL] = 0x08,
+		[PLL_OFF_USER_CTL_U] = 0x0c,
+		[PLL_OFF_CONFIG_CTL] = 0x10,
+		[PLL_OFF_TEST_CTL] = 0x14,
+		[PLL_OFF_TEST_CTL_U] = 0x18,
+		[PLL_OFF_STATUS] = 0x1c,
+		[PLL_OFF_ALPHA_VAL] = 0x24,
+		[PLL_OFF_ALPHA_VAL_U] = 0x28,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index ff25c7f7b43e..d07b17186b90 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -27,6 +27,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
 	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
 	CLK_ALPHA_PLL_TYPE_STROMER,
+	CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
-- 
2.17.1

