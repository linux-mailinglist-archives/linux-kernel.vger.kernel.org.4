Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A88639B15
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiK0Nfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiK0NfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC910FD0;
        Sun, 27 Nov 2022 05:35:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E22B80AF9;
        Sun, 27 Nov 2022 13:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3AAC433D7;
        Sun, 27 Nov 2022 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669556098;
        bh=KdlxQOc6nYzqZnDtcA2yP2/SDiF4cqIL6oaqqCIa6EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cljbwijob+PHPYTH2utatqZN3tz5GV5LegXlFAdq3KXxkGYpwGuIYvYKjipLwENYT
         bNY2XOdW1k6Rmz2wRxD2yGMozi1X/YcgtdT/G5dluEbdUKp8ehuEvot7u9BRUJLn3Y
         u55WZeUt/8H1Gu7cre0DUbEGfYvyHyyoTmXMVjSoUfyCLaF4NM3aezr7VTSKxagHlO
         WrrXT2beikz2uUPgDoBhmcFWLktXOrYLV9z/f2H5obOYin+lOEDJvk3b/CAMDq1lG6
         TKOpAtv1n77Mfc8x/Q/IWmE3f4DCRZUP0vSidXFpbzqp+nhu35HwgI0LFz5Cw1uzqu
         2Wdsyj01CuIkA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 6/9] riscv: dts: bouffalolab: add the bl808 SoC base device tree
Date:   Sun, 27 Nov 2022 21:24:45 +0800
Message-Id: <20221127132448.4034-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221127132448.4034-1-jszhang@kernel.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a baisc dtsi for the bouffalolab bl808 SoC.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi

diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
new file mode 100644
index 000000000000..f4b170ccc32e
--- /dev/null
+++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
@@ -0,0 +1,74 @@
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
+		uart0: serial@30002000 {
+			compatible = "bouffalolab,bl808-uart";
+			reg = <0x30002000 0x1000>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&xtal>;
+			status = "disabled";
+		};
+
+		plic: interrupt-controller@e0000000 {
+			compatible = "thead,c900-plic";
+			reg = <0xe0000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 0xffffffff>,
+					      <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <64>;
+		};
+	};
+};
-- 
2.38.1

