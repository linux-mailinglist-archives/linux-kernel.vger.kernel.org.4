Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB470881A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjERS5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjERS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435D7E69;
        Thu, 18 May 2023 11:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C667D651AD;
        Thu, 18 May 2023 18:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67568C433A7;
        Thu, 18 May 2023 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436234;
        bh=SPhHXPcnyMrXjaiP7DOxwbB5VjmdUJq9U0kUEmDjQ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kahOTcxTy32CFM9eHd/MHg6lpg/GXB3H9L5itF0hjkwIgLWkXf14++KVJUXdJsHhx
         2hSOWca+EOez7Tsd73O5z396YvhAC2TJwFiUIm51230K1jbg0ts8DXU2EML0wimE7y
         CCuZT5F6PT1KeRQdFIssnO0sC42+p5sG0mCB/Zir3xQvV724B35dt74iEMtLs5x0dP
         Ftg/9JWwfTIpc+GWix2ZSbBX9iA5zYgE7Zk7wmNH5Zdlfp2l2PRENKUKXIsYRjGcng
         FuSLVOCLPMoNgR/FHr5IXiEUe96qyaIzc5zGp2gh3FN+/23CozongCD3Wy2P9YiEnx
         L35M74T2aOEYA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 7/9] riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
Date:   Fri, 19 May 2023 02:45:39 +0800
Message-Id: <20230518184541.2627-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
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

