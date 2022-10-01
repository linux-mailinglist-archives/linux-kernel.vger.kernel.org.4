Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0065F194A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiJADKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiJADHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073915FC7C;
        Fri, 30 Sep 2022 20:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593638; x=1696129638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9EGXyuzyM1GHjD0OfKb2LSMEXhfW/qDrLskMaoQYEk=;
  b=LgORxQ7nmHOxJ9LFxvkt/yum8VFUXaaMfAaFkaWJmFprTeGXJ0uo/E0g
   C03bpAoG/eSxoosA3JmL90wQ+ambcYpnC+GvmA57d+HsEvXLQH/UIfrTk
   spQydm/Tpzj+OPCJ84Drnuu4Ob3A5v7hpi3yHMFKupRNbuDQFAQ7Cqf5s
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Sep 2022 20:07:14 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 20:07:14 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:14 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 08/19] arm64: dts: qcom: qru1000-idp: Add RPMH regulators nodes
Date:   Fri, 30 Sep 2022 20:06:45 -0700
Message-ID: <20221001030656.29365-9-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030656.29365-1-quic_molvera@quicinc.com>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMH regulators for the QRU1000 IDP platform.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 200 +++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
index ddb4ea17f7d2..8d27923dc470 100644
--- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "qru1000.dtsi"
 
 / {
@@ -19,6 +20,205 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	ppvar_sys: ppvar-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&ppvar_sys>;
+	};
+};
+
+&apps_rsc {
+	pm8150-rpmh-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vph_pwr>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
+		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
+		vdd-l13-l16-l17-supply = <&vph_pwr>;
+
+		vreg_s2a_0p5: smps2 {
+			regulator-name = "vreg_s2a_0p5";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <570000>;
+		};
+
+		vreg_s3a_1p05: smps3 {
+			regulator-name = "vreg_s3a_1p05";
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1170000>;
+		};
+
+		vreg_s4a_1p8: smps4 {
+			regulator-name = "vreg_s4a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_s5a_2p0: smps5 {
+			regulator-name = "vreg_s5a_2p0";
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-name = "vreg_s6a_0p9";
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_s7a_1p2: smps7 {
+			regulator-name = "vreg_s7a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_s8a_1p3: smps8 {
+			regulator-name = "vreg_s8a_1p3";
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1a_0p91: ldo1 {
+			regulator-name = "vreg_l1a_0p91";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l2a_2p3: ldo2 {
+			regulator-name = "vreg_l2a_2p3";
+			regulator-min-microvolt = <2970000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l3a_1p2: ldo3 {
+			regulator-name = "vreg_l3a_1p2";
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l5a_0p8: ldo5 {
+			regulator-name = "vreg_l5a_0p8";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l6a_0p91: ldo6 {
+			regulator-name = "vreg_l6a_0p91";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-name = "vreg_l7a_1p8";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+
+		};
+
+		vreg_l8a_0p91: ldo8 {
+			regulator-name = "vreg_l8a_0p91";
+			regulator-min-microvolt = <888000>;
+			regulator-max-microvolt = <925000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l9a_0p91: ldo9 {
+			regulator-name = "vreg_l8a_0p91";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l10a_2p95: ldo10 {
+			regulator-name = "vreg_l10a_2p95";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l11a_0p91: ldo11 {
+			regulator-name = "vreg_l11a_0p91";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-name = "vreg_l12a_1p8";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-name = "vreg_l14a_1p8";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l15a_1p8: ldo15 {
+			regulator-name = "vreg_l15a_1p8";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l16a_1p8: ldo16 {
+			regulator-name = "vreg_l16a_1p8";
+			regulator-min-microvolt = <1710000>;
+			regulator-max-microvolt = <1890000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l17a_3p3: ldo17 {
+			regulator-name = "vreg_l17a_3p3";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l18a_1p2: ldo18 {
+			regulator-name = "vreg_l18a_1p2";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+	};
 };
 
 &qupv3_id_0 {
-- 
2.37.3

