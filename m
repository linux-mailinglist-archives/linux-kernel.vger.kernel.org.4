Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75DE6CFF15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC3Iu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjC3IuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:50:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D77A82;
        Thu, 30 Mar 2023 01:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7CA5B81D7A;
        Thu, 30 Mar 2023 08:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A1AC433EF;
        Thu, 30 Mar 2023 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680166206;
        bh=KEK5moVX0SHU97cua/KWwyNRaSV84QY94bnoxXMtLwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaC7ibN4tH6VpjOuLAvrGigDLPSOAB8W8LMtNMsXBPSk1ZCWPYcW+6x5gniNjvwFt
         WOH7b51Q4/xpuJ90NpL4FofFmTYXiRiEYkQQKe1XK/Rm8g9eCrEYefep/Z903kHspk
         KkmfIxgi8FlB5b5TiMG3gx+/tWUrVqiV29GOrua8TiZoKCLYj37h+daENcrUXPi4Re
         666CrAxy7HTg9l7ziGyn3h3kNyYSxfCBl8cCgENAczNfxq2HLf21Qb4/AeSueJtsEz
         7qVpeMabXNcXpp9obcMxceAIwfpLiQfWsnptrsDARXgFKCn1lzMlAOPJrLzmIPS0PD
         xSTieu1G8QF4A==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 2/3] arm64: dts: ti: k3-am625: Enable Type-C port for USB0
Date:   Thu, 30 Mar 2023 11:49:53 +0300
Message-Id: <20230330084954.49763-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330084954.49763-1-rogerq@kernel.org>
References: <20230330084954.49763-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB0 is a Type-C port with dual data role and power sink.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        |  2 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 35 ++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index cdc0858dd1b2..467e17e28916 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -150,7 +150,7 @@ exp1: gpio@22 {
 				   "UART1_FET_BUF_EN", "WL_LT_EN",
 				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
 				   "CSI_GPIO2", "PRU_3V3_EN",
-				   "HDMI_INTn", "TEST_GPIO2",
+				   "HDMI_INTn", "PD_I2C_IRQ",
 				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
 				   "MCASP1_FET_SEL", "UART1_FET_SEL",
 				   "TSINT#", "IO_EXP_TEST_LED";
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 80e8b9b9a5f5..db7fa20e8fe2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -198,6 +198,30 @@ &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+
+	typec_pd0: tps6598x@3f {
+		compatible = "ti,tps6598x";
+		reg = <0x3f>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usb_con_hs: endpoint {
+						remote-endpoint = <&usb0_hs_ep>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &main_i2c1 {
@@ -265,7 +289,16 @@ &usbss1 {
 };
 
 &usb0 {
-	dr_mode = "peripheral";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	usb-role-switch;
+
+	port@0 {
+		reg = <0>;
+		usb0_hs_ep: endpoint {
+		    remote-endpoint = <&usb_con_hs>;
+	       };
+	};
 };
 
 &usb1 {
-- 
2.34.1

