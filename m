Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF7701E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjENRJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjENRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:08:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598E4C0D;
        Sun, 14 May 2023 10:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D0861147;
        Sun, 14 May 2023 17:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8C1C433A0;
        Sun, 14 May 2023 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084108;
        bh=BOyxLfrCWvSizG1Nhwu7D7DzYq+zL8tuApgSf+neFXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDyTcj12XWqlEfQ3Lv0lUbrwtVy+ojFxGHoqe8wVFrA6mtSq7WPfP88clO7mgZ3gi
         7BGaNooqq7a4D6qgpX8imo9s6zO79ovmS3gKEo1CEMmJFbEW/iHNmFv1kc3e9S1m5f
         FzEI0bXQaHHq0Nap1NoBQcFyrcm7hRvZ4R/PvaJHcEZsTsB0Jx7In6aBw2Fl/CaNwQ
         kiHEbDlDtGcA9pI+mHZxHW4BuChSNc3Y/IfaQbOCMsjQgmy1/GbTmG1GzpVkJGHMm5
         kR82BJrCkCodw0QqPGG0mhQKqjOC7VY54TcyC+2CaI+4E9RpTm6d7Oo2JuvFmDWLtD
         XvW7BcwH1OFtg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 07/10] riscv: dts: bouffalolab: add the bl808 SoC base device tree
Date:   Mon, 15 May 2023 00:56:48 +0800
Message-Id: <20230514165651.2199-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a baisc dtsi for the bouffalolab bl808 SoC.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi

diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
new file mode 100644
index 000000000000..b1132b8cf9e8
--- /dev/null
+++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "bouffalolab,bl808";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		timebase-frequency = <1000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "thead,c906", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			riscv,isa = "rv64imafdc";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&plic>;
+		dma-noncoherent;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uart3: serial@30002000 {
+			compatible = "bouffalolab,bl808-uart";
+			reg = <0x30002000 0x1000>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&xtal>;
+			status = "disabled";
+		};
+
+		plic: interrupt-controller@e0000000 {
+			compatible = "bouffalolab,bl808-plic", "thead,c900-plic";
+			reg = <0xe0000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <82>;
+		};
+	};
+};
-- 
2.40.0

