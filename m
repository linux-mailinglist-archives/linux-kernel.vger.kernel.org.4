Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FBC6E5FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDRLcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjDRLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:32:35 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA10861AB;
        Tue, 18 Apr 2023 04:32:33 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 046FD5FD7C;
        Tue, 18 Apr 2023 14:16:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681816586;
        bh=lYTwixrqbd9SStEuaH+MOse4j7UjK4ooo6t7FaqVmeA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Svh2dtABfLv0A4s8N8XedVQorPjq21MkbnzYzqGr0rE7B7n9umg+kH5gWc/yfHSxG
         I6if+KKBejBAY8kxAT35VX8E6ePwaDSYCg9APOXYUTEcf+YTGq+sTMsW1m535JjJJZ
         maO427TZfHXgh0eMipZMNELzwSsHvujFt9J6lbj8/lmYIsses3X6j8hyVgIzfEGY7w
         KHroZFMv6imEBXB138tczGBWFym21BusY/Irq0Fl/7qA5FDUxrUYztnLs7qwN5pLfP
         YAfl2lJeIKU0+N0tenqO5E9AidpMhA92sNKKaEeQ2alWPsyl02QvJSCU8DdA0PRhqw
         Osjt1945IdDHA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 14:16:25 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <mturquette@baylibre.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <hminas@synopsys.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <yue.wang@amlogic.com>, <hanjie.lin@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2 5/5] arm64: dts: meson: a1: support USB controller in OTG mode
Date:   Tue, 18 Apr 2023 14:16:12 +0300
Message-ID: <20230418111612.19479-6-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 05:44:00 #21123121
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic A1 SoC family has USB2.0 controller based on dwc2 and dwc3
heads. It supports otg/host/peripheral modes.

Signed-off-by: Yue Wang <yue.wang@amlogic.com>
Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 59 +++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index ae7d39cff07a..02af0aac6780 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/gpio/meson-a1-gpio.h>
 #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-clkc.h>
+#include <dt-bindings/power/meson-a1-power.h>
+#include <dt-bindings/reset/amlogic,meson-a1-reset.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -169,6 +171,17 @@ gpio_intc: interrupt-controller@0440 {
 				amlogic,channel-interrupts =
 					<49 50 51 52 53 54 55 56>;
 			};
+
+			usb2_phy1: phy@4000 {
+				compatible = "amlogic,a1-usb2-phy";
+				clocks = <&clkc CLKID_USB_PHY_IN>;
+				clock-names = "xtal";
+				reg = <0x0 0x4000 0x0 0x60>;
+				resets = <&reset RESET_USBPHY>;
+				reset-names = "phy";
+				#phy-cells = <0>;
+				power-domains = <&pwrc PWRC_USB_ID>;
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
@@ -192,6 +205,52 @@ spifc: spi@fd000400 {
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		usb: usb@fe004400 {
+			status = "disabled";
+			compatible = "amlogic,meson-a1-usb-ctrl";
+			reg = <0x0 0xfe004400 0x0 0xa0>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB_CTRL>,
+				 <&clkc CLKID_USB_BUS>,
+				 <&clkc CLKID_USB_CTRL_IN>;
+			clock-names = "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
+			resets = <&reset RESET_USBCTRL>;
+			reset-name = "usb_ctrl";
+
+			dr_mode = "otg";
+
+			phys = <&usb2_phy1>;
+			phy-names = "usb2-phy1";
+
+			dwc2: usb@ff500000 {
+				compatible = "amlogic,meson-a1-usb", "snps,dwc2";
+				reg = <0x0 0xff500000 0x0 0x40000>;
+				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy1>;
+				phy-names = "usb2_phy";
+				clocks = <&clkc CLKID_USB_PHY>;
+				clock-names = "otg";
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+
+			dwc3: usb@ff400000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff400000 0x0 0x100000>;
+				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,dis_u2_susphy_quirk;
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,parkmode-disable-ss-quirk;
+			};
+		};
 	};
 
 	timer {
-- 
2.36.0

