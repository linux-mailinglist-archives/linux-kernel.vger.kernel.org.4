Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B2622395
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKIFw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKIFwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:52:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09521EAD1;
        Tue,  8 Nov 2022 21:52:23 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A95ddVN010028;
        Wed, 9 Nov 2022 05:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SnvHB7kZEQoWAqO+fv3jevM7zXHHs+RqEVq32Pctpek=;
 b=KAXo9SCN3OWx9JGIzXzyeYYPBeHxvGJEVDoXFWybeD42TzRqjGuRlF9HLy5v+N1P2s6I
 MXj++0QEnsB8M4fEc0jECTJdrMGeZbF39Ktjki5OFzFt0T5iAGvIte88IHhRW0u3apUg
 GUlXpgQTeVcYeE0xkqKRfA+0/jtrwJ975YL4R0GxvYqcxBRgDjdo3PZorKj73ufwskOC
 RiHB0sKcZs3S6uN5R8GZny2iXKSLW12Zd2Iaa7QXurxFz9wJRHXbMCg2vdWnqe1MlcKB
 bkS7lVfDgwrtCmZ5nefCK+2AO+xQZarOSIq4dERmOIb6bNLidIWd3QeEiH6oxS4eItrc aQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr664r0wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 05:52:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A95qCvA007569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 05:52:12 GMT
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 21:52:08 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <dianders@chromium.org>,
        <jinghung.chen3@hotmail.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Add Google Herobrine WIFI SKU dts fragment
Date:   Wed, 9 Nov 2022 11:21:32 +0530
Message-ID: <20221109055132.609-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109055132.609-1-quic_sibis@quicinc.com>
References: <20221109055132.609-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LgYX4Xi_dxKxwy-w2D-xSgdJsq4HSQYD
X-Proofpoint-ORIG-GUID: LgYX4Xi_dxKxwy-w2D-xSgdJsq4HSQYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_01,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=901
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v2:
 * Mark the WIFI SKUs of Evoker/Villager-r1
 * Misc. Fixes [Doug]

Instead of just having remoteproc_mpss node disabled, we go ahead and
delete it on wifi only SKUs. This is done to avoid the dtbs_check
failures that we would end of getting if we delete the memory-region
property present in the node (since it's a required property). I'll
send a follow up patch with IPA node enabled only on LTE SKUs as soon
as I verify that it doesn't have any impact on suspend/resume.

 .../boot/dts/qcom/sc7280-chrome-common.dtsi   | 15 --------
 .../dts/qcom/sc7280-herobrine-evoker-lte.dts  |  4 +-
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts |  2 +-
 .../dts/qcom/sc7280-herobrine-evoker.dtsi     |  1 +
 .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    | 19 ++++++++++
 .../qcom/sc7280-herobrine-villager-r1-lte.dts |  4 +-
 .../dts/qcom/sc7280-herobrine-villager-r1.dts | 31 +---------------
 .../qcom/sc7280-herobrine-villager-r1.dtsi    | 37 +++++++++++++++++++
 .../dts/qcom/sc7280-herobrine-wifi-sku.dtsi   | 11 ++++++
 9 files changed, 77 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtsi
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
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
index 3af9224a7492..14f20e705869 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
@@ -5,7 +5,9 @@
  * Copyright 2022 Google LLC.
  */
 
-#include "sc7280-herobrine-evoker.dts"
+/dts-v1/;
+
+#include "sc7280-herobrine-evoker.dtsi"
 #include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
index 51f0401b11ed..4f781fe25c9c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine-evoker.dtsi"
-#include "sc7280-herobrine-audio-rt5682-3mic.dtsi"
+#include "sc7280-herobrine-wifi-sku.dtsi"
 
 / {
 	model = "Google Evoker";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
index 706dd82a7013..3d639c70a06e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-audio-rt5682-3mic.dtsi"
 
 /*
  * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
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
index f1017809e5da..d71cc4bbc4b3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
@@ -5,7 +5,9 @@
  * Copyright 2022 Google LLC.
  */
 
-#include "sc7280-herobrine-villager-r1.dts"
+/dts-v1/;
+
+#include "sc7280-herobrine-villager-r1.dtsi"
 #include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
index cfc648726930..edb52f12f0ea 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -7,37 +7,10 @@
 
 /dts-v1/;
 
-#include "sc7280-herobrine-villager.dtsi"
-#include "sc7280-herobrine-audio-wcd9385.dtsi"
+#include "sc7280-herobrine-villager-r1.dtsi"
+#include "sc7280-herobrine-wifi-sku.dtsi"
 
 / {
 	model = "Google Villager (rev1+)";
 	compatible = "google,villager", "qcom,sc7280";
 };
-
-&lpass_va_macro {
-	vdd-micb-supply = <&pp1800_l2c>;
-};
-
-&sound {
-	audio-routing =
-			"IN1_HPHL", "HPHL_OUT",
-			"IN2_HPHR", "HPHR_OUT",
-			"AMIC1", "MIC BIAS1",
-			"AMIC2", "MIC BIAS2",
-			"VA DMIC0", "vdd-micb",
-			"VA DMIC1", "vdd-micb",
-			"VA DMIC2", "vdd-micb",
-			"VA DMIC3", "vdd-micb",
-			"TX SWR_ADC0", "ADC1_OUTPUT",
-			"TX SWR_ADC1", "ADC2_OUTPUT",
-			"TX SWR_ADC2", "ADC3_OUTPUT",
-			"TX SWR_DMIC0", "DMIC1_OUTPUT",
-			"TX SWR_DMIC1", "DMIC2_OUTPUT",
-			"TX SWR_DMIC2", "DMIC3_OUTPUT",
-			"TX SWR_DMIC3", "DMIC4_OUTPUT",
-			"TX SWR_DMIC4", "DMIC5_OUTPUT",
-			"TX SWR_DMIC5", "DMIC6_OUTPUT",
-			"TX SWR_DMIC6", "DMIC7_OUTPUT",
-			"TX SWR_DMIC7", "DMIC8_OUTPUT";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtsi
new file mode 100644
index 000000000000..b25df5a99161
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "sc7280-herobrine-villager.dtsi"
+#include "sc7280-herobrine-audio-wcd9385.dtsi"
+
+&lpass_va_macro {
+	vdd-micb-supply = <&pp1800_l2c>;
+};
+
+&sound {
+	audio-routing =
+			"IN1_HPHL", "HPHL_OUT",
+			"IN2_HPHR", "HPHR_OUT",
+			"AMIC1", "MIC BIAS1",
+			"AMIC2", "MIC BIAS2",
+			"VA DMIC0", "vdd-micb",
+			"VA DMIC1", "vdd-micb",
+			"VA DMIC2", "vdd-micb",
+			"VA DMIC3", "vdd-micb",
+			"TX SWR_ADC0", "ADC1_OUTPUT",
+			"TX SWR_ADC1", "ADC2_OUTPUT",
+			"TX SWR_ADC2", "ADC3_OUTPUT",
+			"TX SWR_DMIC0", "DMIC1_OUTPUT",
+			"TX SWR_DMIC1", "DMIC2_OUTPUT",
+			"TX SWR_DMIC2", "DMIC3_OUTPUT",
+			"TX SWR_DMIC3", "DMIC4_OUTPUT",
+			"TX SWR_DMIC4", "DMIC5_OUTPUT",
+			"TX SWR_DMIC5", "DMIC6_OUTPUT",
+			"TX SWR_DMIC6", "DMIC7_OUTPUT",
+			"TX SWR_DMIC7", "DMIC8_OUTPUT";
+};
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
-- 
2.17.1

