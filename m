Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051905F061C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiI3H4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiI3H4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:56:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87621129343;
        Fri, 30 Sep 2022 00:56:10 -0700 (PDT)
X-QQ-mid: bizesmtp66t1664524436t6e292ex
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 15:53:54 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: ZTnzshg2nJZqmliBeRNueqPWEdXdgHJCgeesknqnTxWetQZKfd5/Y0w6CQcL/
        uZJ+Y/q0/+stBlFaI11fiKedF60zP1rH+Acx9y1tkepzWLmV2sR8yoEsksgoa6NTs45V8q/
        io2rZ72MB0eR79fMOMl2SDhlRn53ZAJMdVRLJDks89eZA0M0o6o/YLRcBfEf7pP3jS8Cp0Y
        VTZ00zbXxZ9oPyG4bsYkZuM27ln7wNn0E02C2kIRJXqleGgBhEJOj+e5S68zi/Yw29G9yxx
        Ov9CSp1IQkndh2R2qGcX8ci6/OUHZskpc4+yMnjmd63Ktcjo3kKk1r8OQVc8GMq1ad9kHeo
        lcb57S8w93OaHlv/2Vnn1h2JEi4BZiYTEAqJOeLQs4x+9RVe4Q+B8TYftIDylLpllh+Co/G
        FOeyz1IdO5U=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 28/30] RISC-V: Add StarFive JH7110 VisionFive2 board device tree
Date:   Fri, 30 Sep 2022 15:53:53 +0800
Message-Id: <20220930075353.6842-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add a minimal device tree for StarFive JH7110 VisionFive2 board.
Support booting and basic clock/reset/pinctrl/uart drivers.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../jh7110-starfive-visionfive-v2.dts         | 91 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 0ea1bc15ab30..e1237dbc6aac 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
+dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-v2.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
new file mode 100644
index 000000000000..6b9fe32c7eac
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh7110.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
+
+/ {
+	model = "StarFive VisionFive V2";
+	compatible = "starfive,visionfive-v2", "starfive,jh7110";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpus {
+		timebase-frequency = <4000000>;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x1 0x0>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x20000000>;
+			alignment = <0x0 0x1000>;
+			alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
+			linux,cma-default;
+		};
+
+		e24_mem: e24@c0000000 {
+			reg = <0x0 0xc0110000 0x0 0xf0000>;
+			no-map;
+		};
+
+		xrp_reserved: xrpbuffer@f0000000 {
+			reg = <0x0 0xf0000000 0x0 0x01ffffff>,
+			      <0x0 0xf2000000 0x0 0x00001000>,
+			      <0x0 0xf2001000 0x0 0x00fff000>,
+			      <0x0 0xf3000000 0x0 0x00001000>;
+		};
+
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
+		priority = <224>;
+	};
+};
+
+&gpio {
+	uart0_pins: uart0-pins {
+		uart0-pins-tx {
+			starfive,pins = <PAD_GPIO5>;
+			starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_DS(3))>;
+			starfive,pin-gpio-dout = <GPO_UART0_SOUT>;
+			starfive,pin-gpio-doen = <OEN_LOW>;
+		};
+
+		uart0-pins-rx {
+			starfive,pins = <PAD_GPIO6>;
+			starfive,pinmux = <PAD_GPIO6_FUNC_SEL 0>;
+			starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_PU(1))>;
+			starfive,pin-gpio-doen = <OEN_HIGH>;
+			starfive,pin-gpio-din =  <GPI_UART0_SIN>;
+		};
+	};
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
-- 
2.17.1

