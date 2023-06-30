Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1402743BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjF3MMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjF3MMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:12:10 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBFF3C07;
        Fri, 30 Jun 2023 05:11:14 -0700 (PDT)
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 30 Jun 2023
 20:11:11 +0800
From:   zelong dong <zelong.dong@amlogic.com>
To:     <narmstrong@baylibre.com>, <p.zabel@pengutronix.de>,
        <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>, <kelvin.zhang@amlogic.com>,
        Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 3/3] arm64: dts: meson: add reset controller for Meson-C3 SoC
Date:   Fri, 30 Jun 2023 20:10:59 +0800
Message-ID: <20230630121059.28748-4-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230630121059.28748-1-zelong.dong@amlogic.com>
References: <20230630121059.28748-1-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.69]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelong Dong <zelong.dong@amlogic.com>

Add the reset controller device of Meson-C3 SoC family

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index 60ad4f3eef9d..62684b7a684c 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/reset/amlogic,meson-c3-reset.h>
 
 / {
 	cpus {
@@ -82,6 +83,12 @@ uart_b: serial@7a000 {
 				clock-names = "xtal", "pclk", "baud";
 			};
 
+			reset: reset-controller@0x2000 {
+				compatible = "amlogic,meson-c3-reset";
+				reg = <0x0 0x2000 0x0 0x98>;
+				#reset-cells = <1>;
+			};
+
 		};
 	};
 };
-- 
2.35.1

