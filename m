Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE974BCA1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjGHHbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:31:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78D26B8;
        Sat,  8 Jul 2023 00:30:23 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687SDo6027631;
        Sat, 8 Jul 2023 07:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=xJ42iUl/L3jnRRWYqyKnSfgXaTYywmYE7vBErWATdRI=;
 b=AKLrSMEdNupKyz2aq03TXzJ+ZozYTxU8GNCq4u/mSl/M8sVwG7ehBUlleUscjgf8oaat
 +/Bbvvdv8Rgb90F6FMufu5MS7OM0bzobNHYh14K7gposBi1bqvgNNO0kW3cFvMrSExJd
 Hqd3co6Eijc+rjLyszxTY4XSjr7oerdfSEomHPyAaE8m1c5LPH32Izl4V59xSiT6xOHk
 lSEU+WtFjae1d9/arW+Xmd41wBjXyO6o8b7NGAXALsrAJpDt2KyLcR/yy73nB0U/3Aw8
 ZaiWAUkQCz/4s5sioAgzRFqrCxy+sXJimEaLpm+UVatLYWXGZWjtvfaFm9J3BHIcnM01 IA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpy4rr88r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:29:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687Tc7J018393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:29:38 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:29:29 -0700
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
Subject: [PATCH 04/11] iio: adc: Update bindings to remove support for ADC7 name used on QCOM PMICs
Date:   Sat, 8 Jul 2023 12:58:28 +0530
Message-ID: <20230708072835.3035398-5-quic_jprakash@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VfrJhO8TqiQaRXM-dh2shEAVvPJFUu2Y
X-Proofpoint-GUID: VfrJhO8TqiQaRXM-dh2shEAVvPJFUu2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that usage of "ADC7" name has been replaced with usage of "ADC5
Gen2" name everywhere, remove all support for "ADC7" name.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  5 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  1 -
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   | 63 -------------
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350b.h  | 88 -------------------
 .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  | 46 ----------
 .../dt-bindings/iio/qcom,spmi-adc7-pmr735a.h  | 28 ------
 .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  | 28 ------
 include/dt-bindings/iio/qcom,spmi-vadc.h      | 76 ----------------
 8 files changed, 1 insertion(+), 334 deletions(-)
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index f886977de165..eb7d16e385ad 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -26,7 +26,6 @@ properties:
           - qcom,spmi-vadc
           - qcom,spmi-adc5
           - qcom,spmi-adc-rev2
-          - qcom,spmi-adc7
           - qcom,spmi-adc5-gen2
 
   reg:
@@ -214,9 +213,7 @@ allOf:
       properties:
         compatible:
           contains:
-            enum :
-                - qcom,spmi-adc7
-                - qcom,spmi-adc5-gen2
+            const: qcom,spmi-adc5-gen2
 
     then:
       patternProperties:
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 01d57f13d254..019f18a2b9e7 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -13,7 +13,6 @@ properties:
     enum:
       - qcom,spmi-adc-tm5
       - qcom,spmi-adc-tm5-gen2
-      - qcom,adc-tm7 # Incomplete / subject to change
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
deleted file mode 100644
index 09fd169ad18e..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
-
-/* ADC channels for PM8350_ADC for PMIC7 */
-#define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | 0x0)
-#define PM8350_ADC7_1P25VREF(sid)			((sid) << 8 | 0x01)
-#define PM8350_ADC7_VREF_VADC(sid)			((sid) << 8 | 0x02)
-#define PM8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | 0x03)
-
-#define PM8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | 0x04)
-#define PM8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | 0x05)
-#define PM8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | 0x06)
-#define PM8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | 0x07)
-#define PM8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | 0x08)
-#define PM8350_ADC7_GPIO1(sid)				((sid) << 8 | 0x0a)
-#define PM8350_ADC7_GPIO2(sid)				((sid) << 8 | 0x0b)
-#define PM8350_ADC7_GPIO3(sid)				((sid) << 8 | 0x0c)
-#define PM8350_ADC7_GPIO4(sid)				((sid) << 8 | 0x0d)
-
-/* 30k pull-up1 */
-#define PM8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
-#define PM8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
-#define PM8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
-#define PM8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
-#define PM8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
-#define PM8350_ADC7_GPIO1_30K_PU(sid)			((sid) << 8 | 0x2a)
-#define PM8350_ADC7_GPIO2_30K_PU(sid)			((sid) << 8 | 0x2b)
-#define PM8350_ADC7_GPIO3_30K_PU(sid)			((sid) << 8 | 0x2c)
-#define PM8350_ADC7_GPIO4_30K_PU(sid)			((sid) << 8 | 0x2d)
-
-/* 100k pull-up2 */
-#define PM8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
-#define PM8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
-#define PM8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
-#define PM8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
-#define PM8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
-#define PM8350_ADC7_GPIO1_100K_PU(sid)			((sid) << 8 | 0x4a)
-#define PM8350_ADC7_GPIO2_100K_PU(sid)			((sid) << 8 | 0x4b)
-#define PM8350_ADC7_GPIO3_100K_PU(sid)			((sid) << 8 | 0x4c)
-#define PM8350_ADC7_GPIO4_100K_PU(sid)			((sid) << 8 | 0x4d)
-
-/* 400k pull-up3 */
-#define PM8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
-#define PM8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
-#define PM8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
-#define PM8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
-#define PM8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
-#define PM8350_ADC7_GPIO1_400K_PU(sid)			((sid) << 8 | 0x6a)
-#define PM8350_ADC7_GPIO2_400K_PU(sid)			((sid) << 8 | 0x6b)
-#define PM8350_ADC7_GPIO3_400K_PU(sid)			((sid) << 8 | 0x6c)
-#define PM8350_ADC7_GPIO4_400K_PU(sid)			((sid) << 8 | 0x6d)
-
-/* 1/3 Divider */
-#define PM8350_ADC7_GPIO4_DIV3(sid)			((sid) << 8 | 0x8d)
-
-#define PM8350_ADC7_VPH_PWR(sid)			((sid) << 8 | 0x8e)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
deleted file mode 100644
index dc2497c27e16..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
-
-#ifndef PM8350B_SID
-#define PM8350B_SID					3
-#endif
-
-/* ADC channels for PM8350B_ADC for PMIC7 */
-#define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | 0x0)
-#define PM8350B_ADC7_1P25VREF			(PM8350B_SID << 8 | 0x01)
-#define PM8350B_ADC7_VREF_VADC			(PM8350B_SID << 8 | 0x02)
-#define PM8350B_ADC7_DIE_TEMP			(PM8350B_SID << 8 | 0x03)
-
-#define PM8350B_ADC7_AMUX_THM1			(PM8350B_SID << 8 | 0x04)
-#define PM8350B_ADC7_AMUX_THM2			(PM8350B_SID << 8 | 0x05)
-#define PM8350B_ADC7_AMUX_THM3			(PM8350B_SID << 8 | 0x06)
-#define PM8350B_ADC7_AMUX_THM4			(PM8350B_SID << 8 | 0x07)
-#define PM8350B_ADC7_AMUX_THM5			(PM8350B_SID << 8 | 0x08)
-#define PM8350B_ADC7_AMUX_THM6			(PM8350B_SID << 8 | 0x09)
-#define PM8350B_ADC7_GPIO1			(PM8350B_SID << 8 | 0x0a)
-#define PM8350B_ADC7_GPIO2			(PM8350B_SID << 8 | 0x0b)
-#define PM8350B_ADC7_GPIO3			(PM8350B_SID << 8 | 0x0c)
-#define PM8350B_ADC7_GPIO4			(PM8350B_SID << 8 | 0x0d)
-
-#define PM8350B_ADC7_CHG_TEMP			(PM8350B_SID << 8 | 0x10)
-#define PM8350B_ADC7_USB_IN_V_16		(PM8350B_SID << 8 | 0x11)
-#define PM8350B_ADC7_VDC_16			(PM8350B_SID << 8 | 0x12)
-#define PM8350B_ADC7_CC1_ID			(PM8350B_SID << 8 | 0x13)
-#define PM8350B_ADC7_VREF_BAT_THERM		(PM8350B_SID << 8 | 0x15)
-#define PM8350B_ADC7_IIN_FB			(PM8350B_SID << 8 | 0x17)
-
-/* 30k pull-up1 */
-#define PM8350B_ADC7_AMUX_THM1_30K_PU		(PM8350B_SID << 8 | 0x24)
-#define PM8350B_ADC7_AMUX_THM2_30K_PU		(PM8350B_SID << 8 | 0x25)
-#define PM8350B_ADC7_AMUX_THM3_30K_PU		(PM8350B_SID << 8 | 0x26)
-#define PM8350B_ADC7_AMUX_THM4_30K_PU		(PM8350B_SID << 8 | 0x27)
-#define PM8350B_ADC7_AMUX_THM5_30K_PU		(PM8350B_SID << 8 | 0x28)
-#define PM8350B_ADC7_AMUX_THM6_30K_PU		(PM8350B_SID << 8 | 0x29)
-#define PM8350B_ADC7_GPIO1_30K_PU		(PM8350B_SID << 8 | 0x2a)
-#define PM8350B_ADC7_GPIO2_30K_PU		(PM8350B_SID << 8 | 0x2b)
-#define PM8350B_ADC7_GPIO3_30K_PU		(PM8350B_SID << 8 | 0x2c)
-#define PM8350B_ADC7_GPIO4_30K_PU		(PM8350B_SID << 8 | 0x2d)
-#define PM8350B_ADC7_CC1_ID_30K_PU		(PM8350B_SID << 8 | 0x33)
-
-/* 100k pull-up2 */
-#define PM8350B_ADC7_AMUX_THM1_100K_PU		(PM8350B_SID << 8 | 0x44)
-#define PM8350B_ADC7_AMUX_THM2_100K_PU		(PM8350B_SID << 8 | 0x45)
-#define PM8350B_ADC7_AMUX_THM3_100K_PU		(PM8350B_SID << 8 | 0x46)
-#define PM8350B_ADC7_AMUX_THM4_100K_PU		(PM8350B_SID << 8 | 0x47)
-#define PM8350B_ADC7_AMUX_THM5_100K_PU		(PM8350B_SID << 8 | 0x48)
-#define PM8350B_ADC7_AMUX_THM6_100K_PU		(PM8350B_SID << 8 | 0x49)
-#define PM8350B_ADC7_GPIO1_100K_PU		(PM8350B_SID << 8 | 0x4a)
-#define PM8350B_ADC7_GPIO2_100K_PU		(PM8350B_SID << 8 | 0x4b)
-#define PM8350B_ADC7_GPIO3_100K_PU		(PM8350B_SID << 8 | 0x4c)
-#define PM8350B_ADC7_GPIO4_100K_PU		(PM8350B_SID << 8 | 0x4d)
-#define PM8350B_ADC7_CC1_ID_100K_PU		(PM8350B_SID << 8 | 0x53)
-
-/* 400k pull-up3 */
-#define PM8350B_ADC7_AMUX_THM1_400K_PU		(PM8350B_SID << 8 | 0x64)
-#define PM8350B_ADC7_AMUX_THM2_400K_PU		(PM8350B_SID << 8 | 0x65)
-#define PM8350B_ADC7_AMUX_THM3_400K_PU		(PM8350B_SID << 8 | 0x66)
-#define PM8350B_ADC7_AMUX_THM4_400K_PU		(PM8350B_SID << 8 | 0x67)
-#define PM8350B_ADC7_AMUX_THM5_400K_PU		(PM8350B_SID << 8 | 0x68)
-#define PM8350B_ADC7_AMUX_THM6_400K_PU		(PM8350B_SID << 8 | 0x69)
-#define PM8350B_ADC7_GPIO1_400K_PU		(PM8350B_SID << 8 | 0x6a)
-#define PM8350B_ADC7_GPIO2_400K_PU		(PM8350B_SID << 8 | 0x6b)
-#define PM8350B_ADC7_GPIO3_400K_PU		(PM8350B_SID << 8 | 0x6c)
-#define PM8350B_ADC7_GPIO4_400K_PU		(PM8350B_SID << 8 | 0x6d)
-#define PM8350B_ADC7_CC1_ID_400K_PU		(PM8350B_SID << 8 | 0x73)
-
-/* 1/3 Divider */
-#define PM8350B_ADC7_GPIO1_DIV3			(PM8350B_SID << 8 | 0x8a)
-#define PM8350B_ADC7_GPIO2_DIV3			(PM8350B_SID << 8 | 0x8b)
-#define PM8350B_ADC7_GPIO3_DIV3			(PM8350B_SID << 8 | 0x8c)
-#define PM8350B_ADC7_GPIO4_DIV3			(PM8350B_SID << 8 | 0x8d)
-
-#define PM8350B_ADC7_VPH_PWR			(PM8350B_SID << 8 | 0x8e)
-#define PM8350B_ADC7_VBAT_SNS			(PM8350B_SID << 8 | 0x8f)
-
-#define PM8350B_ADC7_SBUx			(PM8350B_SID << 8 | 0x94)
-#define PM8350B_ADC7_VBAT_2S_MID		(PM8350B_SID << 8 | 0x96)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
deleted file mode 100644
index 6c296870e95b..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
-
-#ifndef PMK8350_SID
-#define PMK8350_SID					0
-#endif
-
-/* ADC channels for PMK8350_ADC for PMIC7 */
-#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | 0x0)
-#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | 0x01)
-#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | 0x02)
-#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
-
-#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
-#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
-#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
-#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
-#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
-
-/* 30k pull-up1 */
-#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
-#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
-#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
-#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
-#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
-
-/* 100k pull-up2 */
-#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
-#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
-#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
-#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
-#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
-
-/* 400k pull-up3 */
-#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
-#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
-#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
-#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
-#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
deleted file mode 100644
index d6df1b19e5ff..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
-
-#ifndef PMR735A_SID
-#define PMR735A_SID					4
-#endif
-
-/* ADC channels for PMR735A_ADC for PMIC7 */
-#define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | 0x0)
-#define PMR735A_ADC7_1P25VREF			(PMR735A_SID << 8 | 0x01)
-#define PMR735A_ADC7_VREF_VADC			(PMR735A_SID << 8 | 0x02)
-#define PMR735A_ADC7_DIE_TEMP			(PMR735A_SID << 8 | 0x03)
-
-#define PMR735A_ADC7_GPIO1			(PMR735A_SID << 8 | 0x0a)
-#define PMR735A_ADC7_GPIO2			(PMR735A_SID << 8 | 0x0b)
-#define PMR735A_ADC7_GPIO3			(PMR735A_SID << 8 | 0x0c)
-
-/* 100k pull-up2 */
-#define PMR735A_ADC7_GPIO1_100K_PU		(PMR735A_SID << 8 | 0x4a)
-#define PMR735A_ADC7_GPIO2_100K_PU		(PMR735A_SID << 8 | 0x4b)
-#define PMR735A_ADC7_GPIO3_100K_PU		(PMR735A_SID << 8 | 0x4c)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
deleted file mode 100644
index 8da0e7dab315..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
-
-#ifndef PMR735B_SID
-#define PMR735B_SID					5
-#endif
-
-/* ADC channels for PMR735B_ADC for PMIC7 */
-#define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | 0x0)
-#define PMR735B_ADC7_1P25VREF			(PMR735B_SID << 8 | 0x01)
-#define PMR735B_ADC7_VREF_VADC			(PMR735B_SID << 8 | 0x02)
-#define PMR735B_ADC7_DIE_TEMP			(PMR735B_SID << 8 | 0x03)
-
-#define PMR735B_ADC7_GPIO1			(PMR735B_SID << 8 | 0x0a)
-#define PMR735B_ADC7_GPIO2			(PMR735B_SID << 8 | 0x0b)
-#define PMR735B_ADC7_GPIO3			(PMR735B_SID << 8 | 0x0c)
-
-/* 100k pull-up2 */
-#define PMR735B_ADC7_GPIO1_100K_PU		(PMR735B_SID << 8 | 0x4a)
-#define PMR735B_ADC7_GPIO2_100K_PU		(PMR735B_SID << 8 | 0x4b)
-#define PMR735B_ADC7_GPIO3_100K_PU		(PMR735B_SID << 8 | 0x4c)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 92a064ada796..b1413c62ad27 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -222,82 +222,6 @@
 
 #define ADC5_MAX_CHANNEL			0xc0
 
-/* ADC channels for ADC for PMIC7 */
-
-#define ADC7_REF_GND				0x00
-#define ADC7_1P25VREF				0x01
-#define ADC7_VREF_VADC				0x02
-#define ADC7_DIE_TEMP				0x03
-
-#define ADC7_AMUX_THM1				0x04
-#define ADC7_AMUX_THM2				0x05
-#define ADC7_AMUX_THM3				0x06
-#define ADC7_AMUX_THM4				0x07
-#define ADC7_AMUX_THM5				0x08
-#define ADC7_AMUX_THM6				0x09
-#define ADC7_GPIO1				0x0a
-#define ADC7_GPIO2				0x0b
-#define ADC7_GPIO3				0x0c
-#define ADC7_GPIO4				0x0d
-
-#define ADC7_CHG_TEMP				0x10
-#define ADC7_USB_IN_V_16			0x11
-#define ADC7_VDC_16				0x12
-#define ADC7_CC1_ID				0x13
-#define ADC7_VREF_BAT_THERM			0x15
-#define ADC7_IIN_FB				0x17
-
-/* 30k pull-up1 */
-#define ADC7_AMUX_THM1_30K_PU			0x24
-#define ADC7_AMUX_THM2_30K_PU			0x25
-#define ADC7_AMUX_THM3_30K_PU			0x26
-#define ADC7_AMUX_THM4_30K_PU			0x27
-#define ADC7_AMUX_THM5_30K_PU			0x28
-#define ADC7_AMUX_THM6_30K_PU			0x29
-#define ADC7_GPIO1_30K_PU			0x2a
-#define ADC7_GPIO2_30K_PU			0x2b
-#define ADC7_GPIO3_30K_PU			0x2c
-#define ADC7_GPIO4_30K_PU			0x2d
-#define ADC7_CC1_ID_30K_PU			0x33
-
-/* 100k pull-up2 */
-#define ADC7_AMUX_THM1_100K_PU			0x44
-#define ADC7_AMUX_THM2_100K_PU			0x45
-#define ADC7_AMUX_THM3_100K_PU			0x46
-#define ADC7_AMUX_THM4_100K_PU			0x47
-#define ADC7_AMUX_THM5_100K_PU			0x48
-#define ADC7_AMUX_THM6_100K_PU			0x49
-#define ADC7_GPIO1_100K_PU			0x4a
-#define ADC7_GPIO2_100K_PU			0x4b
-#define ADC7_GPIO3_100K_PU			0x4c
-#define ADC7_GPIO4_100K_PU			0x4d
-#define ADC7_CC1_ID_100K_PU			0x53
-
-/* 400k pull-up3 */
-#define ADC7_AMUX_THM1_400K_PU			0x64
-#define ADC7_AMUX_THM2_400K_PU			0x65
-#define ADC7_AMUX_THM3_400K_PU			0x66
-#define ADC7_AMUX_THM4_400K_PU			0x67
-#define ADC7_AMUX_THM5_400K_PU			0x68
-#define ADC7_AMUX_THM6_400K_PU			0x69
-#define ADC7_GPIO1_400K_PU			0x6a
-#define ADC7_GPIO2_400K_PU			0x6b
-#define ADC7_GPIO3_400K_PU			0x6c
-#define ADC7_GPIO4_400K_PU			0x6d
-#define ADC7_CC1_ID_400K_PU			0x73
-
-/* 1/3 Divider */
-#define ADC7_GPIO1_DIV3				0x8a
-#define ADC7_GPIO2_DIV3				0x8b
-#define ADC7_GPIO3_DIV3				0x8c
-#define ADC7_GPIO4_DIV3				0x8d
-
-#define ADC7_VPH_PWR				0x8e
-#define ADC7_VBAT_SNS				0x8f
-
-#define ADC7_SBUx				0x94
-#define ADC7_VBAT_2S_MID			0x96
-
 /* ADC channels for ADC for PMIC5 Gen2 */
 
 #define ADC5_GEN2_REF_GND				0x00
-- 
2.25.1

