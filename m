Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBB45B4062
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiIIUPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIIUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:15:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443650068;
        Fri,  9 Sep 2022 13:15:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289JmmZZ004577;
        Fri, 9 Sep 2022 20:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=R20p7lVjOiDZJY8Fx/WoMbIoQZJBnuPaZXmwbRdoxsY=;
 b=lHZPspCpvXkM75/iQsvwjibQRhnJO1mzlkTYJK4TBlIfpm8/f9ddye2nXGSA8j8BWQqx
 Uz6UqczcKbcfjZ/+TPZyTWIz4jVYqcnArRgBPfkGZudI2hK+ELaPi6jF8IAXvGu0XxgX
 aqLPlX1bYo4c1oLAoNFbpVcuSrWPgDWf7EJOvLG8pPKwxJaht4vQWtCSlXRADk6fpcVC
 Ywsxq73vVeY9ZZgJ3+i0GrIvu6LqTvrc35dae4hlkk9Ak+f3zPZiXquhTE1TePCSpFvQ
 TlxaJsOQsxG2DFFxNM4cW37IR3he5g5xVB9nN2b+i15SygYV+ZYANjJ2VI7egrxIsWfb yw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfupqbh6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 20:15:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289KFAS8024487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 20:15:11 GMT
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 13:15:07 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <dianders@chromium.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <swboyd@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: Add Google Herobrine WIFI SKU dts fragment
Date:   Sat, 10 Sep 2022 01:44:56 +0530
Message-ID: <1662754496-31143-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yFZh3XvJJkgsaxZcgfMnlnItyNe2TvIJ
X-Proofpoint-ORIG-GUID: yFZh3XvJJkgsaxZcgfMnlnItyNe2TvIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=802
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Herobrine WIFI SKU can save 256M by not having modem/mba/rmtfs
memory regions defined. Add the dts fragment and mark all the board files
appropriately.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

Depends on:
Add LTE SKUs for Villager: https://patchwork.kernel.org/project/linux-arm-msm/cover/20220830182923.3720287-1-dianders@chromium.org/

Instead of just having remoteproc_mpss node disabled, we go ahead and
delete it on wifi only SKUs. This is done to avoid the dtbs_check
failures that we would end of getting if we delete the memory-region
property present in the node (since it's a required property). I'll
send a follow up patch with IPA node enabled only on LTE SKUs as soon
as I verify that it doesn't have any affects on suspend/resume.


 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi    | 15 ---------------
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts            |  1 +
 .../boot/dts/qcom/sc7280-herobrine-evoker-r0.dts      |  1 +
 .../arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 19 +++++++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts     |  5 ++++-
 .../boot/dts/qcom/sc7280-herobrine-villager-r1.dts    |  1 +
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi      | 11 +++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts              |  1 +
 8 files changed, 38 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 25f31c81b2b7..16fb20369c01 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -39,20 +39,10 @@
 			no-map;
 		};
 
-		mpss_mem: memory@8b800000 {
-			reg = <0x0 0x8b800000 0x0 0xf600000>;
-			no-map;
-		};
-
 		wpss_mem: memory@9ae00000 {
 			reg = <0x0 0x9ae00000 0x0 0x1900000>;
 			no-map;
 		};
-
-		mba_mem: memory@9c700000 {
-			reg = <0x0 0x9c700000 0x0 0x200000>;
-			no-map;
-		};
 	};
 };
 
@@ -88,11 +78,6 @@
 	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
 };
 
-/* Increase the size from 2.5MB to 8MB */
-&rmtfs_mem {
-	reg = <0x0 0x9c900000 0x0 0x800000>;
-};
-
 &wifi {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index 344338ad8a01..480cb88f2154 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-idp.dtsi"
 #include "sc7280-idp-ec-h1.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev3 - 4)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
index ccbe50b6249a..6a2ffaac33bc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-wifi-sku.dtsi"
 
 / {
 	model = "Google Evoker";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index a92eeccd2b2a..ad66e5e9db4e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -6,6 +6,20 @@
  */
 /* Modem setup is different on Chrome setups than typical Qualcomm setup */
 
+/ {
+	reserved-memory {
+		mpss_mem: memory@8b800000 {
+			reg = <0x0 0x8b800000 0x0 0xf600000>;
+			no-map;
+		};
+
+		mba_mem: memory@9c700000 {
+			reg = <0x0 0x9c700000 0x0 0x200000>;
+			no-map;
+		};
+	};
+};
+
 &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
 	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
@@ -15,3 +29,8 @@
 			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
 	status = "okay";
 };
+
+/* Increase the size from 2.5MB to 8MB */
+&rmtfs_mem {
+	reg = <0x0 0x9c900000 0x0 0x800000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
index f1017809e5da..ee3bca264f67 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
@@ -5,7 +5,10 @@
  * Copyright 2022 Google LLC.
  */
 
-#include "sc7280-herobrine-villager-r1.dts"
+/dts-v1/;
+
+#include "sc7280-herobrine-villager.dtsi"
+#include "sc7280-herobrine-audio-wcd9385.dtsi"
 #include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
index d7aa42ece576..023546cc7971 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-herobrine-villager.dtsi"
 #include "sc7280-herobrine-audio-wcd9385.dtsi"
+#include "sc7280-herobrine-wifi-sku.dtsi"
 
 / {
 	model = "Google Villager (rev1+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
new file mode 100644
index 000000000000..2febd6126d4c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Google Herobrine dts fragment for WIFI SKUs
+ *
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* WIFI SKUs save 256M by not having modem/mba/rmtfs memory regions defined. */
+
+/delete-node/ &remoteproc_mpss;
+/delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index d4f7cab17078..8c215d414675 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-idp.dtsi"
 #include "sc7280-idp-ec-h1.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU2 platform";
-- 
2.7.4

