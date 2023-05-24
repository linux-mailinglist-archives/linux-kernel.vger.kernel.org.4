Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762BD70F7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjEXNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjEXNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:40:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D126B0;
        Wed, 24 May 2023 06:40:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ODYnw4009311;
        Wed, 24 May 2023 15:39:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=5tr8+koJbahJlh8pGZf1G18j68F+/fl56MXnG8oEP+c=;
 b=LFU+C6RAtznVJ4PXz1frySK7ptJocWbhoHxNAbBbh4oTvtBY15mbVZ+oTB4Al421tmf8
 RJ76A3gFJ2P4mGC2J8zc9MALGAHlAKYauNqoL3pjBuLNvDTGFRntytdfEWW/rOiFD5xu
 lCoM3coYRak4HYjZwouIMd5Bvo0Ix87Cp6EIj5Bg7X0zj3vgcTsE+cgr9AopnVOJaUFV
 mdxoeiX820OWZvcMeQFPmWb5ma4tnlHMVIvWLCr7o9MoNE1fK0+qcyg28Lle9qHuUYMv
 OpieH0R/hd7kCR6vBBKsrvoev3DIMdWzH9+BUsOJ0yPdhkVObs4LMicIFOO5SDxgns7B jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qru86gkfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 15:39:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6227610002A;
        Wed, 24 May 2023 15:39:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A85F229A88;
        Wed, 24 May 2023 15:39:52 +0200 (CEST)
Received: from localhost (10.252.20.36) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 24 May
 2023 15:39:52 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] ARM: dts: stm32: enable adc on stm32mp15xx-dkx boards
Date:   Wed, 24 May 2023 15:39:13 +0200
Message-ID: <20230524133918.1439516-5-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
References: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.20.36]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 0f1110e42c93..ad46f1b1e1ed 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -93,28 +93,39 @@ vin: vin {
 
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

