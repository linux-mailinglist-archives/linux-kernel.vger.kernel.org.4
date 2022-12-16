Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8264EA73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiLPLaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiLPLaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:30:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C15C774;
        Fri, 16 Dec 2022 03:30:14 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGAU6js012202;
        Fri, 16 Dec 2022 11:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eO9tJ+sOHm8csCMqmAek613rWc3qmqB+k/bvtCllRIg=;
 b=h8eokYaRlgRCyEurF69bSZNnxb2ycqVrly4YPxrV3PTzmH7j2jNBv1+3RpntOkRUJeUZ
 2sphjzY9jVP9chHOvw9iFkphrFamYnZYCtF/icEobnxBVJT6J0uPPCEjAPbQb65fTC0f
 eTn0NEEM6ENz4MVkyGftfXRkr9eam3bazu6EEVQvvT7ADDGMLC4GvekDI2PmoXhd6Es3
 yOGQWWJZ0TV/DFzID5ppfrbW61tsGSLLsoElaTsIS2CYjr4E/qgFoWYXoOIJgab2au0f
 r+a/0Wrutu6aAUFcML1msgTsw+G8IbsMctLSV07qxQiUGU4JQqHy+Syx8Q5m21Bmkjx5 Ng== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg2894097-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 11:30:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGBU98A024920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 11:30:09 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 03:30:05 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v4 2/2] arm64: dts: qcom: sc7280: Add a herobrine CRD Pro SKU
Date:   Fri, 16 Dec 2022 16:59:18 +0530
Message-ID: <20221216112918.1243-2-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221216112918.1243-1-quic_rjendra@quicinc.com>
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5nP_s860p_75eVnM5f_bGliQCgTVCdny
X-Proofpoint-ORIG-GUID: 5nP_s860p_75eVnM5f_bGliQCgTVCdny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_07,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=795
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the qualcomm qcard based herobrine devices can come with
a Pro variant of the chipset on the qcard. Such Pro qcards have
the smps9 from pm8350c ganged up with smps7 and smps8, so add a
.dtsi for pro skus that deletes the smps9 node and include it from
the new dts for the CRD Pro

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v4 changes:
Added the zoglin-sku1536 compatible along with hoglin-sku1536.
Zoglin is same as the Hoglin variant, with the SPI Flash reduced
from 64MB to 8MB

 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-crd-pro.dts     | 14 ++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi    |  8 ++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d7669a7cee9f..0d0ed0d06e4a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -104,6 +104,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd-pro.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
new file mode 100644
index 000000000000..4ee5f0b0a5de
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
+	compatible = "google,zoglin-sku1536", "google,hoglin-sku1536", "qcom,sc7280";
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

