Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474735FF019
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJNORX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJNORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:17:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388B10F883;
        Fri, 14 Oct 2022 07:17:03 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EBBwfs019805;
        Fri, 14 Oct 2022 16:16:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=38jsmKZyCQx5HcAiDEChsb7RscCtBxm2gGkUNsDi/Qw=;
 b=YSdHEDFs++Po2rL7E3Fd0nDdgcayNJNSLIC/ZNfFnZbm6qt6zvCrhZ9W+oE3mU+4YOS0
 OMWXPWv8CfQkb3BGrVHyjuUk1aR8Vi9pDHKCoDrRegE8TTgTNmtfRu7ED8eRQoioPdl9
 XY5XncrjdfQHkbCEHnbQy+GeaFYvjifCuDJ8jmhxRItrQ0i8YbCtZUJhHHsBpgDO/vg9
 bH3S3lDqCWkU9uovA0Wu4+pLVfGVDbFQjbeamWAarzvvKPnoNVJHawbvvAkIDbRqxNva
 4DWrEWHqTJm60PMp5bukUPt3KaqhhmxUY+wi9X9ATGKDUYM6THwFejvy6lZ9DsiasYit xA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k5v4n9g7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 16:16:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5693410002A;
        Fri, 14 Oct 2022 16:16:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51F8E231505;
        Fri, 14 Oct 2022 16:16:51 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:16:50 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 09/10] ARM: dts: stm32: enable USB OTG in dual role mode on stm32mp135f-dk
Date:   Fri, 14 Oct 2022 16:15:08 +0200
Message-ID: <20221014141509.211149-10-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
References: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
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
Changes in v2: adopt "typec" generic node name
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index 02ff2bc664da..b8a4f1a8820d 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -95,6 +95,28 @@ &i2c1 {
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
+
+	typec@53 {
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

