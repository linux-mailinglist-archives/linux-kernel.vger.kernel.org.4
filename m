Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57F74BC93
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjGHH3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjGHH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:29:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287F210C;
        Sat,  8 Jul 2023 00:29:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687PrUQ022632;
        Sat, 8 Jul 2023 07:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GRkhApRe4hiDdHUz/jt+9XYqISK6l7UU9XJ3gGb9sQk=;
 b=TBQQr8lORyP3K+5YWeMYXDBivR1XSKeLFHmwP5+NlRqRIUQt/tBl+07zURe19i7s9wcH
 YVz16VlQXbFZLKr+KxjEUCjv6nHLKiANq6DKzzCO52mB7kj/pCjTu8FJXsh1vKuLQLXO
 ClP/qrgWEVGV7BbBdGOChiKcnlDL6zoUbkmyGThhU/b+nMCcisOpfAwrvw4V8V8kxOWU
 77PkdIehbF2h2++yJVUHzJIIGqZ4u22in3/8uqDPlh99cmFCDKxio/dkE30LvxVbxafY
 KOSctNwS9nImWN/Z8VZ3zXfNolq2edP+j1Qv5LWPZ/LrGuzdfHXeFtUOaR/YYBuPbrds gw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpxry093s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:29:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687T9ii023714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:29:09 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:28:59 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
Subject: [PATCH 01/11] iio: adc: Update bindings for ADC7 name used on QCOM PMICs
Date:   Sat, 8 Jul 2023 12:58:25 +0530
Message-ID: <20230708072835.3035398-2-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mZHkkGtPTjzkNBUw3mznvacL07FSDXGn
X-Proofpoint-GUID: mZHkkGtPTjzkNBUw3mznvacL07FSDXGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307080065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name used initially for this version of Qualcomm Technologies, Inc.
PMIC ADC was ADC7, following the convention of calling the PMIC generation
PMIC7. However, the names were later amended internally to ADC5 Gen2 and
PMIC5 Gen2. In addition, the latest PMIC generation now is known as
PMIC5 Gen3 with ADC5 Gen3 supported on it. With this addition, it makes more
sense to correct the name for this version of ADCs to ADC5 Gen2 from ADC7.
Since this affects ADC devices across some PMICs, update the names accordingly.

In order to avoid breaking the existing implementations of ADC7, add
support for ADC5 Gen2 first now and remove the ADC7 support in a later
patch.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 21 +++--
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 16 ++--
 .../iio/qcom,spmi-adc5-gen2-pm8350.h          | 64 +++++++++++++
 .../iio/qcom,spmi-adc5-gen2-pm8350b.h         | 89 +++++++++++++++++++
 .../iio/qcom,spmi-adc5-gen2-pmk8350.h         | 47 ++++++++++
 .../iio/qcom,spmi-adc5-gen2-pmr735a.h         | 29 ++++++
 .../iio/qcom,spmi-adc5-gen2-pmr735b.h         | 28 ++++++
 include/dt-bindings/iio/qcom,spmi-vadc.h      | 77 ++++++++++++++++
 8 files changed, 354 insertions(+), 17 deletions(-)
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index ad7d6fc49de5..f886977de165 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -13,7 +13,7 @@ maintainers:
 description: |
   SPMI PMIC voltage ADC (VADC) provides interface to clients to read
   voltage. The VADC is a 15-bit sigma-delta ADC.
-  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
+  SPMI PMIC5/PMIC5 Gen2 voltage ADC (ADC) provides interface to clients to read
   voltage. The VADC is a 16-bit sigma-delta ADC.
 
 properties:
@@ -27,6 +27,7 @@ properties:
           - qcom,spmi-adc5
           - qcom,spmi-adc-rev2
           - qcom,spmi-adc7
+          - qcom,spmi-adc5-gen2
 
   reg:
     description: VADC base address in the SPMI PMIC register map
@@ -71,7 +72,7 @@ patternProperties:
         description: |
           ADC channel number.
           See include/dt-bindings/iio/qcom,spmi-vadc.h
-          For PMIC7 ADC, the channel numbers are specified separately per PMIC
+          For PMIC5 Gen2 ADC, the channel numbers are specified separately per PMIC
           in the PMIC-specific files in include/dt-bindings/iio/.
 
       label:
@@ -114,7 +115,7 @@ patternProperties:
               channel calibration. If property is not found, channel will be
               calibrated with 0.625V and 1.25V reference channels, also
               known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
+            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc5-gen2" and
               "qcom,spmi-adc-rev2", if this property is specified VADC will use
               the VDD reference (1.875V) and GND for channel calibration. If
               property is not found, channel will be calibrated with 0V and 1.25V
@@ -213,7 +214,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,spmi-adc7
+            enum :
+                - qcom,spmi-adc7
+                - qcom,spmi-adc5-gen2
 
     then:
       patternProperties:
@@ -277,8 +280,8 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     spmi {
@@ -286,21 +289,21 @@ examples:
         #size-cells = <0>;
         adc@3100 {
             reg = <0x3100>;
-            compatible = "qcom,spmi-adc7";
+            compatible = "qcom,spmi-adc5-gen2";
             #address-cells = <1>;
             #size-cells = <0>;
             #io-channel-cells = <1>;
 
             /* Other properties are omitted */
             channel@44 {
-                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                reg = <PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
                 label = "xo_therm";
             };
 
             channel@47 {
-                reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+                reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
                 label = "conn_therm";
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 3c81def03c84..01d57f13d254 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -204,29 +204,29 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spmi_bus {
         #address-cells = <1>;
         #size-cells = <0>;
         pmk8350_vadc: adc@3100 {
             reg = <0x3100>;
-            compatible = "qcom,spmi-adc7";
+            compatible = "qcom,spmi-adc5-gen2";
             #address-cells = <1>;
             #size-cells = <0>;
             #io-channel-cells = <1>;
 
             /* Other properties are omitted */
             channel@44 {
-                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                reg = <PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
                 label = "xo_therm";
             };
 
             channel@147 {
-                reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+                reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
                 label = "conn_therm";
@@ -241,9 +241,9 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
-            pmk8350-xo-therm@0 {
+            xo-therm@0 {
                 reg = <0>;
-                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                io-channels = <&pmk8350_vadc PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU>;
                 qcom,decimation = <340>;
                 qcom,ratiometric;
                 qcom,hw-settle-time-us = <200>;
@@ -251,7 +251,7 @@ examples:
 
             conn-therm@1 {
                 reg = <1>;
-                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+                io-channels = <&pmk8350_vadc PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
                 qcom,avg-samples = <2>;
                 qcom,ratiometric;
                 qcom,hw-settle-time-us = <200>;
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h
new file mode 100644
index 000000000000..77259beaf6e9
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
+
+/* ADC channels for PM8350_ADC for PMIC5 Gen2 */
+#define PM8350_ADC5_GEN2_REF_GND(sid)		((sid) << 8 | 0x0)
+#define PM8350_ADC5_GEN2_1P25VREF(sid)		((sid) << 8 | 0x01)
+#define PM8350_ADC5_GEN2_VREF_VADC(sid)		((sid) << 8 | 0x02)
+#define PM8350_ADC5_GEN2_DIE_TEMP(sid)		((sid) << 8 | 0x03)
+
+#define PM8350_ADC5_GEN2_AMUX_THM1(sid)		((sid) << 8 | 0x04)
+#define PM8350_ADC5_GEN2_AMUX_THM2(sid)		((sid) << 8 | 0x05)
+#define PM8350_ADC5_GEN2_AMUX_THM3(sid)	((sid) << 8 | 0x06)
+#define PM8350_ADC5_GEN2_AMUX_THM4(sid)		((sid) << 8 | 0x07)
+#define PM8350_ADC5_GEN2_AMUX_THM5(sid)	((sid) << 8 | 0x08)
+#define PM8350_ADC5_GEN2_GPIO1(sid)		((sid) << 8 | 0x0a)
+#define PM8350_ADC5_GEN2_GPIO2(sid)		((sid) << 8 | 0x0b)
+#define PM8350_ADC5_GEN2_GPIO3(sid)		((sid) << 8 | 0x0c)
+#define PM8350_ADC5_GEN2_GPIO4(sid)		((sid) << 8 | 0x0d)
+
+/* 30k pull-up1 */
+#define PM8350_ADC5_GEN2_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
+#define PM8350_ADC5_GEN2_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
+#define PM8350_ADC5_GEN2_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
+#define PM8350_ADC5_GEN2_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
+#define PM8350_ADC5_GEN2_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
+#define PM8350_ADC5_GEN2_GPIO1_30K_PU(sid)		((sid) << 8 | 0x2a)
+#define PM8350_ADC5_GEN2_GPIO2_30K_PU(sid)		((sid) << 8 | 0x2b)
+#define PM8350_ADC5_GEN2_GPIO3_30K_PU(sid)		((sid) << 8 | 0x2c)
+#define PM8350_ADC5_GEN2_GPIO4_30K_PU(sid)		((sid) << 8 | 0x2d)
+
+/* 100k pull-up2 */
+#define PM8350_ADC5_GEN2_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
+#define PM8350_ADC5_GEN2_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
+#define PM8350_ADC5_GEN2_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
+#define PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
+#define PM8350_ADC5_GEN2_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
+#define PM8350_ADC5_GEN2_GPIO1_100K_PU(sid)		((sid) << 8 | 0x4a)
+#define PM8350_ADC5_GEN2_GPIO2_100K_PU(sid)		((sid) << 8 | 0x4b)
+#define PM8350_ADC5_GEN2_GPIO3_100K_PU(sid)		((sid) << 8 | 0x4c)
+#define PM8350_ADC5_GEN2_GPIO4_100K_PU(sid)		((sid) << 8 | 0x4d)
+
+/* 400k pull-up3 */
+#define PM8350_ADC5_GEN2_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
+#define PM8350_ADC5_GEN2_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
+#define PM8350_ADC5_GEN2_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
+#define PM8350_ADC5_GEN2_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
+#define PM8350_ADC5_GEN2_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
+#define PM8350_ADC5_GEN2_GPIO1_400K_PU(sid)		((sid) << 8 | 0x6a)
+#define PM8350_ADC5_GEN2_GPIO2_400K_PU(sid)		((sid) << 8 | 0x6b)
+#define PM8350_ADC5_GEN2_GPIO3_400K_PU(sid)		((sid) << 8 | 0x6c)
+#define PM8350_ADC5_GEN2_GPIO4_400K_PU(sid)		((sid) << 8 | 0x6d)
+
+/* 1/3 Divider */
+#define PM8350_ADC5_GEN2_GPIO4_DIV3(sid)		((sid) << 8 | 0x8d)
+
+#define PM8350_ADC5_GEN2_VPH_PWR(sid)		((sid) << 8 | 0x8e)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h
new file mode 100644
index 000000000000..c7bb54e0b6a6
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
+
+#ifndef PM8350B_SID
+#define PM8350B_SID					3
+#endif
+
+/* ADC channels for PM8350B_ADC for PMIC5 Gen2 */
+#define PM8350B_ADC5_GEN2_REF_GND			(PM8350B_SID << 8 | 0x0)
+#define PM8350B_ADC5_GEN2_1P25VREF			(PM8350B_SID << 8 | 0x01)
+#define PM8350B_ADC5_GEN2_VREF_VADC			(PM8350B_SID << 8 | 0x02)
+#define PM8350B_ADC5_GEN2_DIE_TEMP			(PM8350B_SID << 8 | 0x03)
+
+#define PM8350B_ADC5_GEN2_AMUX_THM1			(PM8350B_SID << 8 | 0x04)
+#define PM8350B_ADC5_GEN2_AMUX_THM2			(PM8350B_SID << 8 | 0x05)
+#define PM8350B_ADC5_GEN2_AMUX_THM3			(PM8350B_SID << 8 | 0x06)
+#define PM8350B_ADC5_GEN2_AMUX_THM4			(PM8350B_SID << 8 | 0x07)
+#define PM8350B_ADC5_GEN2_AMUX_THM5			(PM8350B_SID << 8 | 0x08)
+#define PM8350B_ADC5_GEN2_AMUX_THM6			(PM8350B_SID << 8 | 0x09)
+#define PM8350B_ADC5_GEN2_GPIO1			(PM8350B_SID << 8 | 0x0a)
+#define PM8350B_ADC5_GEN2_GPIO2			(PM8350B_SID << 8 | 0x0b)
+#define PM8350B_ADC5_GEN2_GPIO3			(PM8350B_SID << 8 | 0x0c)
+#define PM8350B_ADC5_GEN2_GPIO4			(PM8350B_SID << 8 | 0x0d)
+
+#define PM8350B_ADC5_GEN2_CHG_TEMP			(PM8350B_SID << 8 | 0x10)
+#define PM8350B_ADC5_GEN2_USB_IN_V_16		(PM8350B_SID << 8 | 0x11)
+#define PM8350B_ADC5_GEN2_VDC_16			(PM8350B_SID << 8 | 0x12)
+#define PM8350B_ADC5_GEN2_CC1_ID			(PM8350B_SID << 8 | 0x13)
+#define PM8350B_ADC5_GEN2_VREF_BAT_THERM		(PM8350B_SID << 8 | 0x15)
+#define PM8350B_ADC5_GEN2_IIN_FB			(PM8350B_SID << 8 | 0x17)
+
+/* 30k pull-up1 */
+#define PM8350B_ADC5_GEN2_AMUX_THM1_30K_PU		(PM8350B_SID << 8 | 0x24)
+#define PM8350B_ADC5_GEN2_AMUX_THM2_30K_PU		(PM8350B_SID << 8 | 0x25)
+#define PM8350B_ADC5_GEN2_AMUX_THM3_30K_PU		(PM8350B_SID << 8 | 0x26)
+#define PM8350B_ADC5_GEN2_AMUX_THM4_30K_PU		(PM8350B_SID << 8 | 0x27)
+#define PM8350B_ADC5_GEN2_AMUX_THM5_30K_PU		(PM8350B_SID << 8 | 0x28)
+#define PM8350B_ADC5_GEN2_AMUX_THM6_30K_PU		(PM8350B_SID << 8 | 0x29)
+#define PM8350B_ADC5_GEN2_GPIO1_30K_PU		(PM8350B_SID << 8 | 0x2a)
+#define PM8350B_ADC5_GEN2_GPIO2_30K_PU		(PM8350B_SID << 8 | 0x2b)
+#define PM8350B_ADC5_GEN2_GPIO3_30K_PU		(PM8350B_SID << 8 | 0x2c)
+#define PM8350B_ADC5_GEN2_GPIO4_30K_PU		(PM8350B_SID << 8 | 0x2d)
+#define PM8350B_ADC5_GEN2_CC1_ID_30K_PU		(PM8350B_SID << 8 | 0x33)
+
+/* 100k pull-up2 */
+#define PM8350B_ADC5_GEN2_AMUX_THM1_100K_PU		(PM8350B_SID << 8 | 0x44)
+#define PM8350B_ADC5_GEN2_AMUX_THM2_100K_PU		(PM8350B_SID << 8 | 0x45)
+#define PM8350B_ADC5_GEN2_AMUX_THM3_100K_PU		(PM8350B_SID << 8 | 0x46)
+#define PM8350B_ADC5_GEN2_AMUX_THM4_100K_PU		(PM8350B_SID << 8 | 0x47)
+#define PM8350B_ADC5_GEN2_AMUX_THM5_100K_PU		(PM8350B_SID << 8 | 0x48)
+#define PM8350B_ADC5_GEN2_AMUX_THM6_100K_PU		(PM8350B_SID << 8 | 0x49)
+#define PM8350B_ADC5_GEN2_GPIO1_100K_PU		(PM8350B_SID << 8 | 0x4a)
+#define PM8350B_ADC5_GEN2_GPIO2_100K_PU		(PM8350B_SID << 8 | 0x4b)
+#define PM8350B_ADC5_GEN2_GPIO3_100K_PU		(PM8350B_SID << 8 | 0x4c)
+#define PM8350B_ADC5_GEN2_GPIO4_100K_PU		(PM8350B_SID << 8 | 0x4d)
+#define PM8350B_ADC5_GEN2_CC1_ID_100K_PU		(PM8350B_SID << 8 | 0x53)
+
+/* 400k pull-up3 */
+#define PM8350B_ADC5_GEN2_AMUX_THM1_400K_PU		(PM8350B_SID << 8 | 0x64)
+#define PM8350B_ADC5_GEN2_AMUX_THM2_400K_PU		(PM8350B_SID << 8 | 0x65)
+#define PM8350B_ADC5_GEN2_AMUX_THM3_400K_PU		(PM8350B_SID << 8 | 0x66)
+#define PM8350B_ADC5_GEN2_AMUX_THM4_400K_PU		(PM8350B_SID << 8 | 0x67)
+#define PM8350B_ADC5_GEN2_AMUX_THM5_400K_PU		(PM8350B_SID << 8 | 0x68)
+#define PM8350B_ADC5_GEN2_AMUX_THM6_400K_PU		(PM8350B_SID << 8 | 0x69)
+#define PM8350B_ADC5_GEN2_GPIO1_400K_PU		(PM8350B_SID << 8 | 0x6a)
+#define PM8350B_ADC5_GEN2_GPIO2_400K_PU		(PM8350B_SID << 8 | 0x6b)
+#define PM8350B_ADC5_GEN2_GPIO3_400K_PU		(PM8350B_SID << 8 | 0x6c)
+#define PM8350B_ADC5_GEN2_GPIO4_400K_PU		(PM8350B_SID << 8 | 0x6d)
+#define PM8350B_ADC5_GEN2_CC1_ID_400K_PU		(PM8350B_SID << 8 | 0x73)
+
+/* 1/3 Divider */
+#define PM8350B_ADC5_GEN2_GPIO1_DIV3			(PM8350B_SID << 8 | 0x8a)
+#define PM8350B_ADC5_GEN2_GPIO2_DIV3			(PM8350B_SID << 8 | 0x8b)
+#define PM8350B_ADC5_GEN2_GPIO3_DIV3			(PM8350B_SID << 8 | 0x8c)
+#define PM8350B_ADC5_GEN2_GPIO4_DIV3			(PM8350B_SID << 8 | 0x8d)
+
+#define PM8350B_ADC5_GEN2_VPH_PWR			(PM8350B_SID << 8 | 0x8e)
+#define PM8350B_ADC5_GEN2_VBAT_SNS			(PM8350B_SID << 8 | 0x8f)
+
+#define PM8350B_ADC5_GEN2_SBUx			(PM8350B_SID << 8 | 0x94)
+#define PM8350B_ADC5_GEN2_VBAT_2S_MID		(PM8350B_SID << 8 | 0x96)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h
new file mode 100644
index 000000000000..8de4ee86f875
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
+
+#ifndef PMK8350_SID
+#define PMK8350_SID					0
+#endif
+
+/* ADC channels for PMK8350_ADC for PMIC5 Gen2 */
+#define PMK8350_ADC5_GEN2_REF_GND			(PMK8350_SID << 8 | 0x0)
+#define PMK8350_ADC5_GEN2_1P25VREF			(PMK8350_SID << 8 | 0x01)
+#define PMK8350_ADC5_GEN2_VREF_VADC			(PMK8350_SID << 8 | 0x02)
+#define PMK8350_ADC5_GEN2_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
+
+#define PMK8350_ADC5_GEN2_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
+#define PMK8350_ADC5_GEN2_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
+#define PMK8350_ADC5_GEN2_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
+#define PMK8350_ADC5_GEN2_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
+#define PMK8350_ADC5_GEN2_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
+
+/* 30k pull-up1 */
+#define PMK8350_ADC5_GEN2_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
+#define PMK8350_ADC5_GEN2_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
+#define PMK8350_ADC5_GEN2_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
+#define PMK8350_ADC5_GEN2_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
+#define PMK8350_ADC5_GEN2_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
+
+/* 100k pull-up2 */
+#define PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
+#define PMK8350_ADC5_GEN2_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
+#define PMK8350_ADC5_GEN2_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
+#define PMK8350_ADC5_GEN2_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
+#define PMK8350_ADC5_GEN2_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
+
+/* 400k pull-up3 */
+#define PMK8350_ADC5_GEN2_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
+#define PMK8350_ADC5_GEN2_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
+#define PMK8350_ADC5_GEN2_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
+#define PMK8350_ADC5_GEN2_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
+#define PMK8350_ADC5_GEN2_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h
new file mode 100644
index 000000000000..0f8ad745845b
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
+
+#ifndef PMR735A_SID
+#define PMR735A_SID					4
+#endif
+
+/* ADC channels for PMR735A_ADC for PMIC5 Gen2 */
+#define PMR735A_ADC5_GEN2_REF_GND			(PMR735A_SID << 8 | 0x0)
+#define PMR735A_ADC5_GEN2_1P25VREF			(PMR735A_SID << 8 | 0x01)
+#define PMR735A_ADC5_GEN2_VREF_VADC			(PMR735A_SID << 8 | 0x02)
+#define PMR735A_ADC5_GEN2_DIE_TEMP			(PMR735A_SID << 8 | 0x03)
+
+#define PMR735A_ADC5_GEN2_GPIO1			(PMR735A_SID << 8 | 0x0a)
+#define PMR735A_ADC5_GEN2_GPIO2			(PMR735A_SID << 8 | 0x0b)
+#define PMR735A_ADC5_GEN2_GPIO3			(PMR735A_SID << 8 | 0x0c)
+
+/* 100k pull-up2 */
+#define PMR735A_ADC5_GEN2_GPIO1_100K_PU		(PMR735A_SID << 8 | 0x4a)
+#define PMR735A_ADC5_GEN2_GPIO2_100K_PU		(PMR735A_SID << 8 | 0x4b)
+#define PMR735A_ADC5_GEN2_GPIO3_100K_PU		(PMR735A_SID << 8 | 0x4c)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h
new file mode 100644
index 000000000000..d05d057276e3
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
+
+#ifndef PMR735B_SID
+#define PMR735B_SID					5
+#endif
+
+/* ADC channels for PMR735B_ADC for PMIC5 Gen2 */
+#define PMR735B_ADC5_GEN2_REF_GND			(PMR735B_SID << 8 | 0x0)
+#define PMR735B_ADC5_GEN2_1P25VREF			(PMR735B_SID << 8 | 0x01)
+#define PMR735B_ADC5_GEN2_VREF_VADC			(PMR735B_SID << 8 | 0x02)
+#define PMR735B_ADC5_GEN2_DIE_TEMP			(PMR735B_SID << 8 | 0x03)
+
+#define PMR735B_ADC5_GEN2_GPIO1			(PMR735B_SID << 8 | 0x0a)
+#define PMR735B_ADC5_GEN2_GPIO2			(PMR735B_SID << 8 | 0x0b)
+#define PMR735B_ADC5_GEN2_GPIO3			(PMR735B_SID << 8 | 0x0c)
+
+/* 100k pull-up2 */
+#define PMR735B_ADC5_GEN2_GPIO1_100K_PU		(PMR735B_SID << 8 | 0x4a)
+#define PMR735B_ADC5_GEN2_GPIO2_100K_PU		(PMR735B_SID << 8 | 0x4b)
+#define PMR735B_ADC5_GEN2_GPIO3_100K_PU		(PMR735B_SID << 8 | 0x4c)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 08adfe25964c..92a064ada796 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
@@ -297,4 +298,80 @@
 #define ADC7_SBUx				0x94
 #define ADC7_VBAT_2S_MID			0x96
 
+/* ADC channels for ADC for PMIC5 Gen2 */
+
+#define ADC5_GEN2_REF_GND				0x00
+#define ADC5_GEN2_1P25VREF				0x01
+#define ADC5_GEN2_VREF_VADC				0x02
+#define ADC5_GEN2_DIE_TEMP				0x03
+
+#define ADC5_GEN2_AMUX_THM1				0x04
+#define ADC5_GEN2_AMUX_THM2				0x05
+#define ADC5_GEN2_AMUX_THM3				0x06
+#define ADC5_GEN2_AMUX_THM4				0x07
+#define ADC5_GEN2_AMUX_THM5				0x08
+#define ADC5_GEN2_AMUX_THM6				0x09
+#define ADC5_GEN2_GPIO1				0x0a
+#define ADC5_GEN2_GPIO2				0x0b
+#define ADC5_GEN2_GPIO3				0x0c
+#define ADC5_GEN2_GPIO4				0x0d
+
+#define ADC5_GEN2_CHG_TEMP				0x10
+#define ADC5_GEN2_USB_IN_V_16			0x11
+#define ADC5_GEN2_VDC_16				0x12
+#define ADC5_GEN2_CC1_ID				0x13
+#define ADC5_GEN2_VREF_BAT_THERM			0x15
+#define ADC5_GEN2_IIN_FB				0x17
+
+/* 30k pull-up1 */
+#define ADC5_GEN2_AMUX_THM1_30K_PU			0x24
+#define ADC5_GEN2_AMUX_THM2_30K_PU			0x25
+#define ADC5_GEN2_AMUX_THM3_30K_PU			0x26
+#define ADC5_GEN2_AMUX_THM4_30K_PU			0x27
+#define ADC5_GEN2_AMUX_THM5_30K_PU			0x28
+#define ADC5_GEN2_AMUX_THM6_30K_PU			0x29
+#define ADC5_GEN2_GPIO1_30K_PU			0x2a
+#define ADC5_GEN2_GPIO2_30K_PU			0x2b
+#define ADC5_GEN2_GPIO3_30K_PU			0x2c
+#define ADC5_GEN2_GPIO4_30K_PU			0x2d
+#define ADC5_GEN2_CC1_ID_30K_PU			0x33
+
+/* 100k pull-up2 */
+#define ADC5_GEN2_AMUX_THM1_100K_PU			0x44
+#define ADC5_GEN2_AMUX_THM2_100K_PU			0x45
+#define ADC5_GEN2_AMUX_THM3_100K_PU			0x46
+#define ADC5_GEN2_AMUX_THM4_100K_PU			0x47
+#define ADC5_GEN2_AMUX_THM5_100K_PU			0x48
+#define ADC5_GEN2_AMUX_THM6_100K_PU			0x49
+#define ADC5_GEN2_GPIO1_100K_PU			0x4a
+#define ADC5_GEN2_GPIO2_100K_PU			0x4b
+#define ADC5_GEN2_GPIO3_100K_PU			0x4c
+#define ADC5_GEN2_GPIO4_100K_PU			0x4d
+#define ADC5_GEN2_CC1_ID_100K_PU			0x53
+
+/* 400k pull-up3 */
+#define ADC5_GEN2_AMUX_THM1_400K_PU			0x64
+#define ADC5_GEN2_AMUX_THM2_400K_PU			0x65
+#define ADC5_GEN2_AMUX_THM3_400K_PU			0x66
+#define ADC5_GEN2_AMUX_THM4_400K_PU			0x67
+#define ADC5_GEN2_AMUX_THM5_400K_PU			0x68
+#define ADC5_GEN2_AMUX_THM6_400K_PU			0x69
+#define ADC5_GEN2_GPIO1_400K_PU			0x6a
+#define ADC5_GEN2_GPIO2_400K_PU			0x6b
+#define ADC5_GEN2_GPIO3_400K_PU			0x6c
+#define ADC5_GEN2_GPIO4_400K_PU			0x6d
+#define ADC5_GEN2_CC1_ID_400K_PU			0x73
+
+/* 1/3 Divider */
+#define ADC5_GEN2_GPIO1_DIV3				0x8a
+#define ADC5_GEN2_GPIO2_DIV3				0x8b
+#define ADC5_GEN2_GPIO3_DIV3				0x8c
+#define ADC5_GEN2_GPIO4_DIV3				0x8d
+
+#define ADC5_GEN2_VPH_PWR				0x8e
+#define ADC5_GEN2_VBAT_SNS				0x8f
+
+#define ADC5_GEN2_SBUx				0x94
+#define ADC5_GEN2_VBAT_2S_MID			0x96
+
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
-- 
2.25.1

