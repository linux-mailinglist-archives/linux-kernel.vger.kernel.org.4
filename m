Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC5734238
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346324AbjFQQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346322AbjFQQ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84C2700;
        Sat, 17 Jun 2023 09:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70D160F71;
        Sat, 17 Jun 2023 16:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAF8C433C0;
        Sat, 17 Jun 2023 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687019236;
        bh=SPhHXPcnyMrXjaiP7DOxwbB5VjmdUJq9U0kUEmDjQ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psdbYLjaspvqgMtuNSkr/BszIFTR4pISYrWxkLOPmv8bPWSIkxY0AgQSBtF3YXC2Y
         +jGPnMEvDbvFIa/9sxjQT/UAYeFa+wwReHYVw57aqO+sjWmRwpM2ZDVjN97UZopvzS
         FIi+hi9aTmhcJp+AN75Xq9S1K2vYHuErHTI48uzdX8Ve6NAKmJLF+c2MBShRNbHHib
         zEy5tjmAC5C1IW29yYSdYBZnGWKzkPPBssM3UJOz3TVk6+/Z9+B4Mjv/u1AGI5NutE
         /643+We1nvOFlB0LnbYkOhVLfxUALGc+3HOqD3jTjwzjkHt+e6Q+TcOVjMkkRD5LzJ
         hkTog+p8XmsLQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 6/8] riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
Date:   Sun, 18 Jun 2023 00:15:27 +0800
Message-Id: <20230617161529.2092-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230617161529.2092-1-jszhang@kernel.org>
References: <20230617161529.2092-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
module which is powered by T-HEAD's TH1520 SoC. Add minimal device
tree files for the core module and the development board.

Support basic uart/gpio/dmac drivers, so supports booting to a basic
shell.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/thead/Makefile            |  2 +
 .../dts/thead/th1520-lichee-module-4a.dtsi    | 38 +++++++++++++++++++
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 32 ++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 arch/riscv/boot/dts/thead/Makefile
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index f0d9f89054f8..1e884868ccba 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -2,6 +2,7 @@
 subdir-y += allwinner
 subdir-y += sifive
 subdir-y += starfive
+subdir-y += thead
 subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/thead/Makefile
new file mode 100644
index 000000000000..e311fc9a5939
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_THEAD) += th1520-lichee-pi-4a.dtb
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
new file mode 100644
index 000000000000..4b0249ac710f
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "th1520.dtsi"
+
+/ {
+	model = "Sipeed Lichee Module 4A";
+	compatible = "sipeed,lichee-module-4a", "thead,th1520";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x2 0x00000000>;
+	};
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&osc_32k {
+	clock-frequency = <32768>;
+};
+
+&apb_clk {
+	clock-frequency = <62500000>;
+};
+
+&uart_sclk {
+	clock-frequency = <100000000>;
+};
+
+&dmac0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
new file mode 100644
index 000000000000..a1248b2ee3a3
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include "th1520-lichee-module-4a.dtsi"
+
+/ {
+	model = "Sipeed Lichee Pi 4A";
+	compatible = "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", "thead,th1520";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.40.0

