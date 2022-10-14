Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F445FEBAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJNJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJNJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:29:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240991C5A64;
        Fri, 14 Oct 2022 02:29:18 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E8qFPY008750;
        Fri, 14 Oct 2022 11:29:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=P6m2JY12zXf3SvML5KKo6ZvZ5nqDLMovk9Fujc6i660=;
 b=PUToUXvrAuW3Q1aMxOOyHcV+9WPc1EtCRFYq3aGmNygKm/136O2IUT8xGG+cTNixfyju
 8FwjZ3YIQuDRbC2TCa07PY2HlF5vBUDZEMJM7uJ7Nh92iCTq/cizq8un2rbdPCZXFM+x
 rpLI074jbsTXryT84YfX5BCPqUqaVGY/YnbIjS8tO0cmg12klNIue7bPKk5De3Ox/YWR
 Wp/CIUEo5NQYEKomwhlIOlsqLpl3D4GpJ+cY0iS3tL+qjrwdHlkD+0jfwx/z5qDwnScy
 eNkPCviY+Cyg2kZ5QXbTN4BCMRWMT75HteOdMo/BKNCzYElrgoGIrlSwM4pN2+v98EVa kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k6h7v7gu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 11:29:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4D7410002A;
        Fri, 14 Oct 2022 11:29:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D097D21A907;
        Fri, 14 Oct 2022 11:29:04 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 11:29:03 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 09/10] ARM: dts: stm32: enable USB OTG in dual role mode on stm32mp135f-dk
Date:   Fri, 14 Oct 2022 11:26:50 +0200
Message-ID: <20221014092651.25202-10-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
References: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB OTG controller provides the USB data available on stm32mp135f-dk,
on the Type-C connector. Data role is determined by "usb-role-switch".

A STM32G0 provides the USB Type-C and Power Delivery connectivity.
It controls dual role power and dual role data through UCSI protocol over
I2C. It's wired on I2C1, with an interrupt pin on PI2 GPIO.
Its firmware maybe updated over I2C, so use the optional firmware-name
to enable firmware update.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index 02ff2bc664da..1c92bf096397 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -95,6 +95,28 @@ &i2c1 {
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
+
+	stm32g0@53 {
+		compatible = "st,stm32g0-typec";
+		reg = <0x53>;
+		/* Alert pin on PI2 */
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpioi>;
+		/* Internal pull-up on PI2 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&stm32g0_intn_pins_a>;
+		firmware-name = "stm32g0-ucsi.mp135f-dk.fw";
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+
+			port {
+				con_usb_c_g0_ep: endpoint {
+					remote-endpoint = <&usbotg_hs_ep>;
+				};
+			};
+		};
+	};
 };
 
 &i2c5 {
@@ -158,6 +180,18 @@ hub@1 {
 	};
 };
 
+&usbotg_hs {
+	phys = <&usbphyc_port1 0>;
+	phy-names = "usb2-phy";
+	usb-role-switch;
+	status = "okay";
+	port {
+		usbotg_hs_ep: endpoint {
+			remote-endpoint = <&con_usb_c_g0_ep>;
+		};
+	};
+};
+
 &usbphyc {
 	status = "okay";
 };
-- 
2.25.1

