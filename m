Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB674BC90
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGHH3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGHH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:29:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4D2125;
        Sat,  8 Jul 2023 00:29:38 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36872No5032041;
        Sat, 8 Jul 2023 07:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VmmoJ9c6BEdevnXDrNmLULmLQ+ujIReym3TKv47zGDk=;
 b=mf6f0pgx3B01wZgfC7oAbpTWYWriU4rovvEQLWs8l13Ty/qJdgZfTdCS8F0D36s7juqc
 yVJFninYIjBQXIgxWZ+OcHeIvPiumGDUcMz5fjeLZPGdlG2bWLo/si18+DW8m445zR0c
 lachncEEJylk0BOzBK5VR/0dbtPG2g4O18ftYgjpgYn4oKG3h0j2u1QBoeAiiL8MfB1g
 E6/izkPVBgadkX+r7gudAr/DYrM9olcxe626OOC/VWVRjTbKPFwOwuonhjsAUVw11lcW
 at2ZdEVVAHMLi6XfDjTPRu0DH9tLSXrmQhVA3ZZKTnt5TIWlJdc/yWMBqeNOPLmDPgf1 bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq01dg6f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:29:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687TPCg011655
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:29:25 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:29:18 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
        "Jishnu Prakash" <quic_jprakash@quicinc.com>
Subject: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename for QCOM PMICs
Date:   Sat, 8 Jul 2023 12:58:27 +0530
Message-ID: <20230708072835.3035398-4-quic_jprakash@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GSnIKhcTzNz-171yaDpGkFD0-Sg5mHeQ
X-Proofpoint-GUID: GSnIKhcTzNz-171yaDpGkFD0-Sg5mHeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 mlxlogscore=971
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name "ADC7" needs to be replaced with the name "ADC5_GEN2"
everywhere to match the convention used for these ADC peripherals
on Qualcomm Technologies, Inc. PMICs. Update devicetree files for
the corresponding name change done in bindings and driver.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  4 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  4 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  8 ++--
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 48 +++++++++----------
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  2 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  4 +-
 7 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index bc6297e7253e..149d2bb43d2d 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -50,7 +50,7 @@ pon_resin: resin {
 		};
 
 		pmk8350_vadc: adc@3100 {
-			compatible = "qcom,spmi-adc7";
+			compatible = "qcom,spmi-adc5-gen2";
 			reg = <0x3100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -59,7 +59,7 @@ pmk8350_vadc: adc@3100 {
 		};
 
 		pmk8350_adc_tm: adc-tm@3400 {
-			compatible = "qcom,adc-tm7";
+			compatible = "qcom,spmi-adc-tm5-gen2";
 			reg = <0x3400>;
 			interrupts = <PMK8350_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 15222e92e3f5..bc65e6c6232f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
 
@@ -74,7 +74,7 @@ &nvme_3v3_regulator {
 
 &pmk8350_vadc {
 	pmr735a-die-temp@403 {
-		reg = <PMR735A_ADC7_DIE_TEMP>;
+		reg = <PMR735A_ADC5_GEN2_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 21027042cf13..da413694e230 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
@@ -433,7 +433,7 @@ &pcie1_phy {
 
 &pmk8350_vadc {
 	pmk8350-die-temp@3 {
-		reg = <PMK8350_ADC7_DIE_TEMP>;
+		reg = <PMK8350_ADC5_GEN2_DIE_TEMP>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 9137db066d9e..ed26bff7432d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -11,8 +11,8 @@
  * Copyright 2022 Google LLC.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -384,13 +384,13 @@ &pm8350c_pwm {
 
 &pmk8350_vadc {
 	pmk8350-die-temp@3 {
-		reg = <PMK8350_ADC7_DIE_TEMP>;
+		reg = <PMK8350_ADC5_GEN2_DIE_TEMP>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
 
 	pmr735a-die-temp@403 {
-		reg = <PMR735A_ADC7_DIE_TEMP>;
+		reg = <PMR735A_ADC5_GEN2_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 7cc3028440b6..cfd5dbbacdcb 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -7,9 +7,9 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -747,7 +747,7 @@ &pmk8280_adc_tm {
 
 	sys-therm@0 {
 		reg = <0>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM1_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -755,7 +755,7 @@ sys-therm@0 {
 
 	sys-therm@1 {
 		reg = <1>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM2_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -763,7 +763,7 @@ sys-therm@1 {
 
 	sys-therm@2 {
 		reg = <2>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM3_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -771,7 +771,7 @@ sys-therm@2 {
 
 	sys-therm@3 {
 		reg = <3>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -779,7 +779,7 @@ sys-therm@3 {
 
 	sys-therm@4 {
 		reg = <4>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM1_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -787,7 +787,7 @@ sys-therm@4 {
 
 	sys-therm@5 {
 		reg = <5>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM2_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -795,7 +795,7 @@ sys-therm@5 {
 
 	sys-therm@6 {
 		reg = <6>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM3_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -803,7 +803,7 @@ sys-therm@6 {
 
 	sys-therm@7 {
 		reg = <7>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
+		io-channels = <&pmk8280_vadc PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -837,88 +837,88 @@ &pmk8280_vadc {
 	status = "okay";
 
 	pmic-die-temp@3 {
-		reg = <PMK8350_ADC7_DIE_TEMP>;
+		reg = <PMK8350_ADC5_GEN2_DIE_TEMP>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmk8350_die_temp";
 	};
 
 	xo-therm@44 {
-		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		reg = <PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "pmk8350_xo_therm";
 	};
 
 	pmic-die-temp@103 {
-		reg = <PM8350_ADC7_DIE_TEMP(1)>;
+		reg = <PM8350_ADC5_GEN2_DIE_TEMP(1)>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmc8280_1_die_temp";
 	};
 
 	sys-therm@144 {
-		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM1_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm1";
 	};
 
 	sys-therm@145 {
-		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM2_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm2";
 	};
 
 	sys-therm@146 {
-		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM3_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm3";
 	};
 
 	sys-therm@147 {
-		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm4";
 	};
 
 	pmic-die-temp@303 {
-		reg = <PM8350_ADC7_DIE_TEMP(3)>;
+		reg = <PM8350_ADC5_GEN2_DIE_TEMP(3)>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmc8280_2_die_temp";
 	};
 
 	sys-therm@344 {
-		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM1_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm5";
 	};
 
 	sys-therm@345 {
-		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM2_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm6";
 	};
 
 	sys-therm@346 {
-		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM3_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm7";
 	};
 
 	sys-therm@347 {
-		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
+		reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm8";
 	};
 
 	pmic-die-temp@403 {
-		reg = <PMR735A_ADC7_DIE_TEMP>;
+		reg = <PMR735A_ADC5_GEN2_DIE_TEMP>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmr735a_die_temp";
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index a0ba535bb6c9..ae9491adaa6a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -78,7 +78,7 @@ pmk8280_pon_resin: resin {
 		};
 
 		pmk8280_vadc: adc@3100 {
-			compatible = "qcom,spmi-adc7";
+			compatible = "qcom,spmi-adc5-gen2";
 			reg = <0x3100>;
 			interrupts-extended = <&spmi_bus 0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index e3dc49951523..52119cc1250e 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -9,7 +9,7 @@
 #define PMK8350_SID 6
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
@@ -517,7 +517,7 @@ &pmk8350_rtc {
 
 &pmk8350_vadc {
 	adc-chan@644 {
-		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		reg = <PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
-- 
2.25.1

