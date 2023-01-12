Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D01667045
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjALKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjALKya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:54:30 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964DC5D8B2;
        Thu, 12 Jan 2023 02:45:52 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C7taCG003671;
        Thu, 12 Jan 2023 11:45:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=YlwGMexYBoWgLY+IXf0t36MXaoLetV81lCvSQEz0d3w=;
 b=VLubzurXoDC2BTYcv+WOcuh46/TVBIwERFibRozFGF36CVyScMjHU8pmFAOnM8PRcEAr
 AbINWXlw6LZD6VGJ/adsQWXYuoDopMNFYEJEv6iIwIKtGekN9heM1w+NDdyKQ/R/GEWa
 jQOTH8TxGv65oQDo2HdHkkE1rwuFQ4NC0c2S4Yh4UlsQ+b3wv6Gh7UZ1w8duXo4pedDX
 NYOsYlHyeC4wLwwEaqNhnzPqwceXPsczQDI3n1E2Em6E0q/oWvEo1b95S0Nirrz3/VP8
 Lhsow2oSHkLtrqicoEoN3d0pyRfYU0IBKxOYoDflAYN00o68gPGiil4W9YfWRFcn5JP3 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n1k64j6xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:45:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FD0510002A;
        Thu, 12 Jan 2023 11:45:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78432214B11;
        Thu, 12 Jan 2023 11:45:08 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 12 Jan
 2023 11:45:08 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/10] ARM: dts: stm32: enable adc on stm32mp15xx-dkx boards
Date:   Thu, 12 Jan 2023 11:44:39 +0100
Message-ID: <20230112104446.1140551-5-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
References: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_06,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-Boot enables ADC1&2 to support USB power measurement and ADC
calibration on STM32MP15x Disco boards.
When leaving U-boot the ADCs do not return to power down state
to keep ADC linear calibration available for kernel.
Enable ADC1&2 by default on STM32MP15xx-DKx boards to align kernel
DT with Uboot. This avoids to shutdown the ADCs VDDA, while the
ADCs are not in power down.

Use STM32 ADC generic bindings instead of legacy bindings on
STM32MP15xx-DKx boards.

The ADC pins on Arduino connector are not set by default.
These pins are added in A7 Disco example DTs only.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 29 ++++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 11370ae0d868..6f88e9b1af90 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -92,28 +92,39 @@ vin: vin {
 
 &adc {
 	pinctrl-names = "default";
-	pinctrl-0 = <&adc12_ain_pins_a>, <&adc12_usb_cc_pins_a>;
+	pinctrl-0 = <&adc12_usb_cc_pins_a>;
 	vdd-supply = <&vdd>;
 	vdda-supply = <&vdd>;
 	vref-supply = <&vrefbuf>;
-	status = "disabled";
+	status = "okay";
 	adc1: adc@0 {
+		status = "okay";
 		/*
 		 * Type-C USB_PWR_CC1 & USB_PWR_CC2 on in18 & in19.
 		 * Use at least 5 * RC time, e.g. 5 * (Rp + Rd) * C:
 		 * 5 * (56 + 47kOhms) * 5pF => 2.5us.
 		 * Use arbitrary margin here (e.g. 5us).
 		 */
-		st,min-sample-time-nsecs = <5000>;
-		/* AIN connector, USB Type-C CC1 & CC2 */
-		st,adc-channels = <0 1 6 13 18 19>;
-		status = "okay";
+		channel@18 {
+			reg = <18>;
+			st,min-sample-time-ns = <5000>;
+		};
+		channel@19 {
+			reg = <19>;
+			st,min-sample-time-ns = <5000>;
+		};
 	};
 	adc2: adc@100 {
-		/* AIN connector, USB Type-C CC1 & CC2 */
-		st,adc-channels = <0 1 2 6 18 19>;
-		st,min-sample-time-nsecs = <5000>;
 		status = "okay";
+		/* USB Type-C CC1 & CC2 */
+		channel@18 {
+			reg = <18>;
+			st,min-sample-time-ns = <5000>;
+		};
+		channel@19 {
+			reg = <19>;
+			st,min-sample-time-ns = <5000>;
+		};
 	};
 };
 
-- 
2.25.1

