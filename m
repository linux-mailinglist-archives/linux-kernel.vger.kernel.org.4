Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541A9631939
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKUEfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUEfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:35:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC02D2655B;
        Sun, 20 Nov 2022 20:35:09 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL3rkCY025130;
        Mon, 21 Nov 2022 04:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NlidtyNwcdpcn9H8LCmxKi7lHBlW6WGfW5O0lZJRpPI=;
 b=Z1Q5eT89qBSW0h5lW1WX/+HtsydpuPtxwLOiVG1RNzqB3iva18N64bqdlGIy0t5ex9LB
 jQIGtw4vsXZMS9X3kqgqymG0YHikJuugvWwhlA1QvYeRepIRA+LpPUBuIdbbbTaC2CbS
 LaYzZg5wHWHt3COU0CRhsSdenlR7Aap42O/h+6wiSnzuQhW2P1mtkgn/FqY2Pc9xLeTH
 pEinewZ9i3YDfeE1ajnAvuMiivgOnbVTcBB20vmPbPa/Spm9TGxCQ6OT0luqowQHUQTp
 KmqnXqV3l5NR+mvHeccdgsOPbZhYbx/EvhZocBA/6tIoUjUSsf08NFY4GIxrrAoE6Tw0 kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrkv3ebs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:35:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL4Z5MY003862
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:35:05 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 20 Nov 2022 20:35:01 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add a herobrine CRD Pro SKU
Date:   Mon, 21 Nov 2022 10:04:37 +0530
Message-ID: <20221121043437.21925-2-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121043437.21925-1-quic_rjendra@quicinc.com>
References: <20221121043437.21925-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CQTf6d-JAHvKIOvHeNQ4mLMYHSFMlbco
X-Proofpoint-ORIG-GUID: CQTf6d-JAHvKIOvHeNQ4mLMYHSFMlbco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=780 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the qualcomm qcard based herobrine devices can come with
a Pro variant of the chipset on the qcard.
Such Pro qcards have the smps9 from pm8350c ganged up with smps7 and
smps8, so Add a .dtsi for pro skus that deletes the
smps9 node and include it from the new dts for the CRD Pro

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-crd-pro.dts     | 14 ++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi    |  8 ++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index afe496a93f94..c5ac51c3a383 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -108,6 +108,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd-pro.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
new file mode 100644
index 000000000000..f2013af82caa
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * sc7280 CRD 3+ Pro board device tree source
+ *
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "sc7280-herobrine-crd.dts"
+#include "sc7280-herobrine-pro-sku.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. sc7280 CRD Pro platform (rev5+)";
+	compatible = "google,hoglin-sku1536", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi
new file mode 100644
index 000000000000..fb4bbe8aeda0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Google Herobrine dts fragment for PRO SKUs
+ *
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/delete-node/ &vreg_s9c_0p676;
-- 
2.17.1

