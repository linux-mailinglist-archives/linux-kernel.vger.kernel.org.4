Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E650F7149AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjE2Mrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjE2MrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:47:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18413CD;
        Mon, 29 May 2023 05:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685364425; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R1YB+bp0giO0BNhUdGnGcL9Iva4oQyuzqbDoTfWI6ocsfA2aJiZC9zMmEq64/WyCrb
    DMokZYoz13P/UM4rc67FV1XXis/cY2TxFtza/AJF/Sl80fE4+xFZ0mXmGIWCYx7vtFcz
    x/y9LT21ETClh7b9bTmfV49uIIW0cfZrEh2sXaGkPOeECV38UBW/zDFCTZMk1LxmG/xM
    E95tu2nvruls7ZKYYjPC8QdZvpd3BLbfvQKI8T02yHTC3roa7yqs+898TOwS7fA/UjXP
    M/oiDCa1WsBDvk00CVr33Jl8rBpwc1r1DtedhR7geplSM26aHDsKOSbJ9CIwrrPc41CG
    m1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=CSTcyj+JqHppxYOAbdu6RvABYxoBKY4oykvFnZcC9PU=;
    b=jIjagWswO9JZ65oIpBBBAMa5joFUKBalOZ+AIgSHuJIPNE/1pDih34T9EwgTYy7i6W
    K7N/WOKp5kp3G1Eq3qBjAN9o9d3Clb0MY9nISFwuPxIjI7GlCHpEe0j3u9gCfqfQhD37
    cdoWSmmHYMGVZ+D83vEF0zyNGU+UiIxVkX5ouXONosnTVnhN7yfgZD6HUNGGuTDBDfrk
    j6QNO4TVMFzHBIgH0azho5I4pZajXgWWeP9JlE+YJT645wiXoa/ApU7JaBsw2+Ea4pxC
    UDCTMM80KoJuyD2oeece6vjhrTvHLOVfzTBNYbvakMVUteOgKFLd9plTgoOKglWZaGIt
    5tpA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=CSTcyj+JqHppxYOAbdu6RvABYxoBKY4oykvFnZcC9PU=;
    b=CMayYYLQK9Q5/EIrjP+A0dzYUYD3mPEO19HemPvv7Ce4/F3PERBR07T1xwdxFVVEpp
    9UqFwCanz8xTYfU7Nj03vUkO2XX4CDPQbGWMSKbJE3BxpBjWucvBZxSHntZTEAOteJBv
    HsM9z1swZlZ6de3uFVrNG9YfZMjiUPLB1R4SMmU93DAgTr60sSUX7Yk04kQtn0n1HBvQ
    4rkpFlsFJYLndHM1OsukOtBpTjo+ivwlecWkl+d4wBZuOgpNgvtZ5ptNbKxfwZc1MmjZ
    UwKzcnhODsarmz3iHaTciTmlg2POLT3D8GTTxzjjk85IaW38eZu4rQP9nbZk1fFLoSIf
    2iLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=CSTcyj+JqHppxYOAbdu6RvABYxoBKY4oykvFnZcC9PU=;
    b=L+nIymEg7vkndBxHmLz+GdLPv7P9k4MIeJuC8kTen/K5cZ2DgEBOy6BBf+lqB4Wn1A
    iZMX9dDK0GMGjBelqYDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TCl4f8X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 14:47:04 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 29 May 2023 14:47:01 +0200
Subject: [PATCH 4/6] arm64: dts: qcom: msm8916/39: Clean up MDSS labels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-msm8916-labels-v1-4-bec0f5fb46fb@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
In-Reply-To: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now MDSS related definitions cannot be properly grouped together
in board DTs because the labels do not use consistent prefixes. The DSI
PHY label is particularly weird because the DSI number is at the end
(&dsi_phy0) while DSI itself is called &dsi0.

Follow the example of more recent SoCs and give all the MDSS related
nodes a consistent label that allows proper grouping.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 12 +++---
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi       |  4 +-
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 10 ++---
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      |  6 +--
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 26 ++++++------
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi       | 10 ++---
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 46 +++++++++++-----------
 8 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 4f3d837578fd..9081825c9574 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -211,7 +211,7 @@ ports {
 			port@0 {
 				reg = <0>;
 				adv7533_in: endpoint {
-					remote-endpoint = <&dsi0_out>;
+					remote-endpoint = <&mdss_dsi0_out>;
 				};
 			};
 
@@ -301,11 +301,6 @@ ov5640_ep: endpoint {
 	};
 };
 
-&dsi0_out {
-	data-lanes = <0 1 2 3>;
-	remote-endpoint = <&adv7533_in>;
-};
-
 &lpass {
 	status = "okay";
 };
@@ -318,6 +313,11 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&adv7533_in>;
+};
+
 &mpss {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 64d7228bee07..4e7289e6d22d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -15,12 +15,12 @@ &camss {
 	vdda-supply = <&pm8916_l2>;
 };
 
-&dsi0 {
+&mdss_dsi0 {
 	vdda-supply = <&pm8916_l2>;
 	vddio-supply = <&pm8916_l6>;
 };
 
-&dsi_phy0 {
+&mdss_dsi0_phy {
 	vddio-supply = <&pm8916_l6>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 497fc83803ef..b1af9c5d07b2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -237,16 +237,16 @@ &blsp_uart2 {
 	status = "okay";
 };
 
-&dsi0 {
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mdss_default>;
 	pinctrl-1 = <&mdss_sleep>;
 };
 
-&mdss {
-	status = "okay";
-};
-
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 9068aa6f7b29..e5a569698c4f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -85,7 +85,7 @@ &clk_pwm {
 	status = "okay";
 };
 
-&dsi0 {
+&mdss_dsi0 {
 	panel@0 {
 		reg = <0>;
 
@@ -97,13 +97,13 @@ panel@0 {
 
 		port {
 			panel_in: endpoint {
-				remote-endpoint = <&dsi0_out>;
+				remote-endpoint = <&mdss_dsi0_out>;
 			};
 		};
 	};
 };
 
-&dsi0_out {
+&mdss_dsi0_out {
 	data-lanes = <0 1>;
 	remote-endpoint = <&panel_in>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 898722ee86a5..ac39ac6a21c1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -86,7 +86,7 @@ &blsp_uart2 {
 	status = "okay";
 };
 
-/* Remove &dsi_phy0 from clocks to make sure that gcc probes with display disabled */
+/* Remove &mdss_dsi0_phy from clocks to make sure that gcc probes with display disabled */
 &gcc {
 	clocks = <&xo_board>, <&sleep_clk>, <0>, <0>, <0>, <0>, <0>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7e6a60e6edef..0028a405e3ec 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1012,8 +1012,8 @@ gcc: clock-controller@1800000 {
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
-				 <&dsi_phy0 1>,
-				 <&dsi_phy0 0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi0_phy 0>,
 				 <0>,
 				 <0>,
 				 <0>;
@@ -1062,7 +1062,7 @@ mdss: display-subsystem@1a00000 {
 			#size-cells = <1>;
 			ranges;
 
-			mdp: display-controller@1a01000 {
+			mdss_mdp: display-controller@1a01000 {
 				compatible = "qcom,msm8916-mdp5", "qcom,mdp5";
 				reg = <0x01a01000 0x89000>;
 				reg-names = "mdp_phys";
@@ -1087,14 +1087,14 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						mdp5_intf1_out: endpoint {
-							remote-endpoint = <&dsi0_in>;
+						mdss_mdp_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
 						};
 					};
 				};
 			};
 
-			dsi0: dsi@1a98000 {
+			mdss_dsi0: dsi@1a98000 {
 				compatible = "qcom,msm8916-dsi-ctrl",
 					     "qcom,mdss-dsi-ctrl";
 				reg = <0x01a98000 0x25c>;
@@ -1105,8 +1105,8 @@ dsi0: dsi@1a98000 {
 
 				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
 						  <&gcc PCLK0_CLK_SRC>;
-				assigned-clock-parents = <&dsi_phy0 0>,
-							 <&dsi_phy0 1>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
 
 				clocks = <&gcc GCC_MDSS_MDP_CLK>,
 					 <&gcc GCC_MDSS_AHB_CLK>,
@@ -1120,7 +1120,7 @@ dsi0: dsi@1a98000 {
 					      "byte",
 					      "pixel",
 					      "core";
-				phys = <&dsi_phy0>;
+				phys = <&mdss_dsi0_phy>;
 
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1131,20 +1131,20 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						dsi0_in: endpoint {
-							remote-endpoint = <&mdp5_intf1_out>;
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&mdss_mdp_intf1_out>;
 						};
 					};
 
 					port@1 {
 						reg = <1>;
-						dsi0_out: endpoint {
+						mdss_dsi0_out: endpoint {
 						};
 					};
 				};
 			};
 
-			dsi_phy0: phy@1a98300 {
+			mdss_dsi0_phy: phy@1a98300 {
 				compatible = "qcom,dsi-phy-28nm-lp";
 				reg = <0x01a98300 0xd4>,
 				      <0x01a98500 0x280>,
diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
index 24393a159058..33e02f42f5e4 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -3,21 +3,21 @@
 #include "msm8939.dtsi"
 #include "pm8916.dtsi"
 
-&dsi0 {
+&mdss_dsi0 {
 	vdda-supply = <&pm8916_l2>;
 	vddio-supply = <&pm8916_l6>;
 };
 
-&dsi1 {
-	vdda-supply = <&pm8916_l2>;
+&mdss_dsi0_phy {
 	vddio-supply = <&pm8916_l6>;
 };
 
-&dsi_phy0 {
+&mdss_dsi1 {
+	vdda-supply = <&pm8916_l2>;
 	vddio-supply = <&pm8916_l6>;
 };
 
-&dsi_phy1 {
+&mdss_dsi1_phy {
 	vddio-supply = <&pm8916_l6>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 1196a962897f..0d9f8b951b66 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1187,8 +1187,8 @@ gcc: clock-controller@1800000 {
 			reg = <0x01800000 0x80000>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&sleep_clk>,
-				 <&dsi_phy0 1>,
-				 <&dsi_phy0 0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi0_phy 0>,
 				 <0>,
 				 <0>,
 				 <0>;
@@ -1240,7 +1240,7 @@ mdss: display-subsystem@1a00000 {
 
 			status = "disabled";
 
-			mdp: display-controller@1a01000 {
+			mdss_mdp: display-controller@1a01000 {
 				compatible = "qcom,mdp5";
 				reg = <0x01a01000 0x89000>;
 				reg-names = "mdp_phys";
@@ -1269,21 +1269,21 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						mdp5_intf1_out: endpoint {
-							remote-endpoint = <&dsi0_in>;
+						mdss_mdp_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
 						};
 					};
 
 					port@1 {
 						reg = <1>;
-						mdp5_intf2_out: endpoint {
-							remote-endpoint = <&dsi1_in>;
+						mdss_mdp_intf2_out: endpoint {
+							remote-endpoint = <&mdss_dsi1_in>;
 						};
 					};
 				};
 			};
 
-			dsi0: dsi@1a98000 {
+			mdss_dsi0: dsi@1a98000 {
 				compatible = "qcom,msm8916-dsi-ctrl",
 					     "qcom,mdss-dsi-ctrl";
 				reg = <0x01a98000 0x25c>;
@@ -1306,10 +1306,10 @@ dsi0: dsi@1a98000 {
 					      "core";
 				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
 						  <&gcc PCLK0_CLK_SRC>;
-				assigned-clock-parents = <&dsi_phy0 0>,
-							 <&dsi_phy0 1>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
 
-				phys = <&dsi_phy0>;
+				phys = <&mdss_dsi0_phy>;
 				status = "disabled";
 
 				#address-cells = <1>;
@@ -1321,20 +1321,20 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						dsi0_in: endpoint {
-							remote-endpoint = <&mdp5_intf1_out>;
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&mdss_mdp_intf1_out>;
 						};
 					};
 
 					port@1 {
 						reg = <1>;
-						dsi0_out: endpoint {
+						mdss_dsi0_out: endpoint {
 						};
 					};
 				};
 			};
 
-			dsi_phy0: phy@1a98300 {
+			mdss_dsi0_phy: phy@1a98300 {
 				compatible = "qcom,dsi-phy-28nm-lp";
 				reg = <0x01a98300 0xd4>,
 				      <0x01a98500 0x280>,
@@ -1352,7 +1352,7 @@ dsi_phy0: phy@1a98300 {
 				status = "disabled";
 			};
 
-			dsi1: dsi@1aa0000 {
+			mdss_dsi1: dsi@1aa0000 {
 				compatible = "qcom,msm8916-dsi-ctrl",
 					     "qcom,mdss-dsi-ctrl";
 				reg = <0x01aa0000 0x25c>;
@@ -1375,9 +1375,9 @@ dsi1: dsi@1aa0000 {
 					      "core";
 				assigned-clocks = <&gcc BYTE1_CLK_SRC>,
 						  <&gcc PCLK1_CLK_SRC>;
-				assigned-clock-parents = <&dsi_phy0 0>,
-							 <&dsi_phy0 1>;
-				phys = <&dsi_phy1>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
+				phys = <&mdss_dsi1_phy>;
 				status = "disabled";
 
 				ports {
@@ -1386,20 +1386,20 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						dsi1_in: endpoint {
-							remote-endpoint = <&mdp5_intf2_out>;
+						mdss_dsi1_in: endpoint {
+							remote-endpoint = <&mdss_mdp_intf2_out>;
 						};
 					};
 
 					port@1 {
 						reg = <1>;
-						dsi1_out: endpoint {
+						mdss_dsi1_out: endpoint {
 						};
 					};
 				};
 			};
 
-			dsi_phy1: phy@1aa0300 {
+			mdss_dsi1_phy: phy@1aa0300 {
 				compatible = "qcom,dsi-phy-28nm-lp";
 				reg = <0x01aa0300 0xd4>,
 				      <0x01aa0500 0x280>,

-- 
2.40.1

