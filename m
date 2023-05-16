Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8E704F42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjEPN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjEPN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:26:43 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08168659A;
        Tue, 16 May 2023 06:26:23 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GCKMkA014940;
        Tue, 16 May 2023 15:25:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=48xQ3jHuHrthkR0MZeDcOtVGqF4b40uu1aXxGwQD9ec=;
 b=2mVVwc6oaLU6wts8YtDB8KPLVdw8iWpFd9VT+Qm0Z7AmyQoE1Kq7OfYZ2xZbZVlRIETt
 XvZVz8+Y+34sEbeiu1bjawl33zH6/ndKXdUgc0Y4xoxa/hjd+x2nsq3G/uaj/ndgsuqz
 L/I64SsAdfD0VBDlfPL+Fa5tzTrKG90Rv6BWICKbDbRPBbPEPf3sckf7XmpJVHqgFZ8e
 enG4lPyhoJ/fj2Jnk+G+XZ+LHz55Ush36sw6c8TG7AMYftKA2xCwM+XiD9+AYitY1xZ0
 3fNBrEZvHSOMDqBOYGk3x1nCBqwU9aP5wFA9dB3LUZ6mVY51OrMo/2OS4NxXjDBB/E3g /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qkhp0h0rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 15:25:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB7AC10002A;
        Tue, 16 May 2023 15:25:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD4BB22A6D1;
        Tue, 16 May 2023 15:25:50 +0200 (CEST)
Received: from localhost (10.129.178.75) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 16 May
 2023 15:25:50 +0200
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH] ARM: dts: stm32: fix several DT warnings on stm32mp15
Date:   Tue, 16 May 2023 15:25:42 +0200
Message-ID: <20230516132542.27298-1-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.75]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several warnings regarding LTDC and DSI on stm32mp15* device-trees remains.

Those concern:
  * "#size-cells" and "#address-cells" wrongly used
  * residual "reg" property appearing on endpoints where it could be
    avoided

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi                         | 5 -----
 arch/arm/boot/dts/stm32mp157.dtsi                         | 7 -------
 .../boot/dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts  | 6 ++++--
 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts | 6 ++++--
 .../dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts | 3 +--
 arch/arm/boot/dts/stm32mp157c-dk2.dts                     | 8 ++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts                     | 8 ++++++--
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts                 | 3 +--
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi        | 6 +-----
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                    | 3 +--
 10 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 664825418c32..0dc46fd9c269 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1529,11 +1529,6 @@ ltdc: display-controller@5a001000 {
 			clock-names = "lcd";
 			resets = <&rcc LTDC_R>;
 			status = "disabled";
-
-			port {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
 		};
 
 		iwdg2: watchdog@5a002000 {
diff --git a/arch/arm/boot/dts/stm32mp157.dtsi b/arch/arm/boot/dts/stm32mp157.dtsi
index 54e73ccea446..5e733cd16ff9 100644
--- a/arch/arm/boot/dts/stm32mp157.dtsi
+++ b/arch/arm/boot/dts/stm32mp157.dtsi
@@ -24,14 +24,7 @@ dsi: dsi@5a000000 {
 			clock-names = "pclk", "ref", "px_clk";
 			resets = <&rcc DSI_R>;
 			reset-names = "apb";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts
index 9a2a4bc7d079..4279b26547df 100644
--- a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts
+++ b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts
@@ -49,6 +49,9 @@ &dsi {
 	phy-dsi-supply = <&reg18>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		port@0 {
 			reg = <0>;
 			dsi_in: endpoint {
@@ -104,8 +107,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts
index 390ee8c05754..efba54289820 100644
--- a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts
+++ b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts
@@ -49,6 +49,9 @@ &dsi {
 	phy-dsi-supply = <&reg18>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		port@0 {
 			reg = <0>;
 			dsi_in_ltdc: endpoint {
@@ -104,8 +107,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		ltdc_out_dsi: endpoint@0 {
-			reg = <0>;
+		ltdc_out_dsi: endpoint {
 			remote-endpoint = <&dsi_in_ltdc>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
index 0d7560ba2950..5116a7785201 100644
--- a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
+++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
@@ -81,8 +81,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&panel_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
index ab13e340f4ef..4bef2300ed7c 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
@@ -31,10 +31,15 @@ &cryp1 {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	phy-dsi-supply = <&reg18>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		port@0 {
 			reg = <0>;
 			dsi_in: endpoint {
@@ -82,6 +87,9 @@ &ltdc {
 	status = "okay";
 
 	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		ltdc_ep1_out: endpoint@1 {
 			reg = <1>;
 			remote-endpoint = <&dsi_in>;
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index ba8e9d9a42fa..961e85b07a5e 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -101,9 +101,14 @@ dcmi_0: endpoint {
 
 &dsi {
 	phy-dsi-supply = <&reg18>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		port@0 {
 			reg = <0>;
 			dsi_in: endpoint {
@@ -239,8 +244,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
index 407ed3952f75..eada9cf257be 100644
--- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
@@ -161,8 +161,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&panel_input>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
index 50af4a27d6be..a564063b8f5a 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
@@ -330,11 +330,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&adv7513_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 0f1110e42c93..a6e2e20f12fa 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -457,8 +457,7 @@ &ltdc {
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&sii9022_in>;
 		};
 	};
-- 
2.25.1

