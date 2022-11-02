Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE32A6160FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKBKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiKBKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:36:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302EC28E21;
        Wed,  2 Nov 2022 03:36:39 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2AVIij007709;
        Wed, 2 Nov 2022 10:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bbyGbcPv69KBnDndUmE1GWkfmelIdtGJTSqRZcHwByo=;
 b=hipN0u4glrXabjvYZT7fD/JlOaIr/Ofc3dkbFB4Af4tPDECQltrFrxOHw6XRnSWLMCcG
 6KOre1gfIUhvOTYan4lfhOOACxyJVUVwsn8Z694K16pl536lpcE2B2rDH/5rrNm0dest
 tic5ygyzB9T5iqbZwE0EPC4CIUljgfdhUf3/S4JU00T4RrgoZohV1SbO1yz6akyKg+HP
 4i/WWgw/HnduIwIGcSe9flxAGRZP7d23oyh2V63vmKzj98CuAyxuh1Ys0/buSE/uPmfM
 7ilQSiTOTZlN0Dv3LuLouaAMLAORUBm6o5UX9yuqFkE/TNwRJVFDj+hoJ2SRLlmhEbWU tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk7nfhw8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:32 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2AaVpa013330;
        Wed, 2 Nov 2022 10:36:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3khdpmd5c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:31 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2AaVDw013321;
        Wed, 2 Nov 2022 10:36:31 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 2A2AaVvR013320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:31 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 03:36:27 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Shazad Hussain" <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        "Johan Hovold" <johan@kernel.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v7 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Date:   Wed, 2 Nov 2022 16:05:52 +0530
Message-ID: <20221102103552.29388-3-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102103552.29388-1-quic_ppareek@quicinc.com>
References: <20221102103552.29388-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UkwOl5HR23W_mHiKa9ef2zhtBOy7ehhJ
X-Proofpoint-GUID: UkwOl5HR23W_mHiKa9ef2zhtBOy7ehhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the Qualcomm SA8540P ride automotive platform, also known as
Qdrive-3 development board.

This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
regulators, debug UART, PMICs, remoteprocs and USB.

The SA8540P ride contains four PM8450 PMICs. A separate DTSI file has
been created for PMIC, so that it can be used for future SA8540P based
boards.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Tested-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm64/boot/dts/qcom/Makefile         |   1 +
 arch/arm64/boot/dts/qcom/pm8450a.dtsi     |  77 ++++++++
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 227 ++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8450a.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-ride.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b0558d3389e5..c89d44756791 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
diff --git a/arch/arm64/boot/dts/qcom/pm8450a.dtsi b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
new file mode 100644
index 000000000000..34fc72896761
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pm8450a: pmic@0 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450a_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8450a_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450c: pmic@4 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450c_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8450c_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450e: pmic@8 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x8 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450e_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8450e_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450g: pmic@c {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0xc SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450g_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8450g_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
new file mode 100644
index 000000000000..b480b4927549
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "sa8540p.dtsi"
+#include "pm8450a.dtsi"
+
+/ {
+	model = "Qualcomm SA8540P Ride";
+	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
+
+	aliases {
+		serial0 = &qup2_uart17;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&apps_rsc {
+	pmm8540-a-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_l3a: ldo3 {
+			regulator-name = "vreg_l3a";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a: ldo5 {
+			regulator-name = "vreg_l5a";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a: ldo7 {
+			regulator-name = "vreg_l7a";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a: ldo13 {
+			regulator-name = "vreg_l13a";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pmm8540-c-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_l1c: ldo1 {
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c: ldo2 {
+			regulator-name = "vreg_l2c";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c: ldo4 {
+			regulator-name = "vreg_l4c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6c: ldo6 {
+			regulator-name = "vreg_l6c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7c: ldo7 {
+			regulator-name = "vreg_l7c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17c: ldo17 {
+			regulator-name = "vreg_l17c";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+
+	pmm8540-g-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "g";
+
+		vreg_l3g: ldo3 {
+			regulator-name = "vreg_l3g";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7g: ldo7 {
+			regulator-name = "vreg_l7g";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8g: ldo8 {
+			regulator-name = "vreg_l8g";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&qup2 {
+	status = "okay";
+};
+
+&qup2_uart17 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8540p/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_nsp0 {
+	firmware-name = "qcom/sa8540p/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_nsp1 {
+	firmware-name = "qcom/sa8540p/cdsp1.mbn";
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l6c>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	/* TODO: Define USB-C connector properly */
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7a>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy0 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy0 {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <38400000>;
+};
-- 
2.17.1

