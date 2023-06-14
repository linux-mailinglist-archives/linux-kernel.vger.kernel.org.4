Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C87161C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjE3N1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjE3N1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDEED9;
        Tue, 30 May 2023 06:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D306302E;
        Tue, 30 May 2023 13:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6572AC433D2;
        Tue, 30 May 2023 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685453261;
        bh=iFrJldEq66XMqGK+CXO7+PDsv7aFdyzdFFWhF5SRUbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt7GTYmcuk+qNB37VLiLNKb8yxcudPWWUCpS9RuNgcKIjYa1HXpQpMhN0APsaPPiN
         l/lDgIxFBLMDV/+Osm5E4j61TUS3xSPYqk8sJwfgGjTvbgxX7MQgTTZUy54HEoZAkE
         /CfLUIsdheAlZdicQq97sfTeWWhpX8gUMUTLoYxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.114
Date:   Tue, 30 May 2023 14:27:32 +0100
Message-Id: <2023053031-defiant-chatty-8b52@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023053031-outlook-calm-6547@gregkh>
References: <2023053031-outlook-calm-6547@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
deleted file mode 100644
index bfb6da0281ec..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Binding for CEVA AHCI SATA Controller
-
-Required properties:
-  - reg: Physical base address and size of the controller's register area.
-  - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
-  - clocks: Input clock specifier. Refer to common clock bindings.
-  - interrupts: Interrupt specifier. Refer to interrupt binding.
-  - ceva,p0-cominit-params: OOB timing value for COMINIT parameter for port 0.
-  - ceva,p1-cominit-params: OOB timing value for COMINIT parameter for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
-			CINMP : COMINIT Negate Minimum Period.
-			CIBGN : COMINIT Burst Gap Nominal.
-			CIBGMX: COMINIT Burst Gap Maximum.
-			CIBGMN: COMINIT Burst Gap Minimum.
-  - ceva,p0-comwake-params: OOB timing value for COMWAKE parameter for port 0.
-  - ceva,p1-comwake-params: OOB timing value for COMWAKE parameter for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
-			CWBGMN: COMWAKE Burst Gap Minimum.
-			CWBGMX: COMWAKE Burst Gap Maximum.
-			CWBGN: COMWAKE Burst Gap Nominal.
-			CWNMP: COMWAKE Negate Minimum Period.
-  - ceva,p0-burst-params: Burst timing value for COM parameter for port 0.
-  - ceva,p1-burst-params: Burst timing value for COM parameter for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
-			BMX: COM Burst Maximum.
-			BNM: COM Burst Nominal.
-			SFD: Signal Failure Detection value.
-			PTST: Partial to Slumber timer value.
-  - ceva,p0-retry-params: Retry interval timing value for port 0.
-  - ceva,p1-retry-params: Retry interval timing value for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
-			RIT:  Retry Interval Timer.
-			RCT:  Rate Change Timer.
-
-Optional properties:
-  - ceva,broken-gen2: limit to gen1 speed instead of gen2.
-  - phys: phandle for the PHY device
-  - resets: phandle to the reset controller for the SATA IP
-
-Examples:
-	ahci@fd0c0000 {
-		compatible = "ceva,ahci-1v84";
-		reg = <0xfd0c0000 0x200>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 133 4>;
-		clocks = <&clkc SATA_CLK_ID>;
-		ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
-		ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
-		ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
-		ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
-
-		ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
-		ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
-		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
-		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
-		ceva,broken-gen2;
-		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
-		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
-	};
diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
new file mode 100644
index 000000000000..71364c6081ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ceva,ahci-1v84.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ceva AHCI SATA Controller
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@xilinx.com>
+
+description: |
+  The Ceva SATA controller mostly conforms to the AHCI interface with some
+  special extensions to add functionality, is a high-performance dual-port
+  SATA host controller with an AHCI compliant command layer which supports
+  advanced features such as native command queuing and frame information
+  structure (FIS) based switching for systems employing port multipliers.
+
+properties:
+  compatible:
+    const: ceva,ahci-1v84
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 4
+
+  power-domains:
+    maxItems: 1
+
+  ceva,p0-cominit-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMINIT parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
+    items:
+      - description: CINMP - COMINIT Negate Minimum Period.
+      - description: CIBGN - COMINIT Burst Gap Nominal.
+      - description: CIBGMX - COMINIT Burst Gap Maximum.
+      - description: CIBGMN - COMINIT Burst Gap Minimum.
+
+  ceva,p0-comwake-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMWAKE parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
+    items:
+      - description: CWBGMN - COMWAKE Burst Gap Minimum.
+      - description: CWBGMX - COMWAKE Burst Gap Maximum.
+      - description: CWBGN - COMWAKE Burst Gap Nominal.
+      - description: CWNMP - COMWAKE Negate Minimum Period.
+
+  ceva,p0-burst-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      Burst timing value for COM parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
+    items:
+      - description: BMX - COM Burst Maximum.
+      - description: BNM - COM Burst Nominal.
+      - description: SFD - Signal Failure Detection value.
+      - description: PTST - Partial to Slumber timer value.
+
+  ceva,p0-retry-params:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    description: |
+      Retry interval timing value for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-retry-params = /bits/ 16 <RIT RCT>;
+    items:
+      - description: RIT - Retry Interval Timer.
+      - description: RCT - Rate Change Timer.
+
+  ceva,p1-cominit-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMINIT parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
+    items:
+      - description: CINMP - COMINIT Negate Minimum Period.
+      - description: CIBGN - COMINIT Burst Gap Nominal.
+      - description: CIBGMX - COMINIT Burst Gap Maximum.
+      - description: CIBGMN - COMINIT Burst Gap Minimum.
+
+  ceva,p1-comwake-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMWAKE parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
+    items:
+      - description: CWBGMN - COMWAKE Burst Gap Minimum.
+      - description: CWBGMX - COMWAKE Burst Gap Maximum.
+      - description: CWBGN - COMWAKE Burst Gap Nominal.
+      - description: CWNMP - COMWAKE Negate Minimum Period.
+
+  ceva,p1-burst-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      Burst timing value for COM parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
+    items:
+      - description: BMX - COM Burst Maximum.
+      - description: BNM - COM Burst Nominal.
+      - description: SFD - Signal Failure Detection value.
+      - description: PTST - Partial to Slumber timer value.
+
+  ceva,p1-retry-params:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    description: |
+      Retry interval timing value for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
+    items:
+      - description: RIT - Retry Interval Timer.
+      - description: RCT - Rate Change Timer.
+
+  ceva,broken-gen2:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      limit to gen1 speed instead of gen2.
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: sata-phy
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - ceva,p0-cominit-params
+  - ceva,p0-comwake-params
+  - ceva,p0-burst-params
+  - ceva,p0-retry-params
+  - ceva,p1-cominit-params
+  - ceva,p1-comwake-params
+  - ceva,p1-burst-params
+  - ceva,p1-retry-params
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/phy/phy.h>
+
+    sata: ahci@fd0c0000 {
+        compatible = "ceva,ahci-1v84";
+        reg = <0xfd0c0000 0x200>;
+        interrupt-parent = <&gic>;
+        interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&zynqmp_clk SATA_REF>;
+        ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+        ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+        ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+        ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
+        ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+        ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+        ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+        ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
+        ceva,broken-gen2;
+        phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
+        resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
+    };
diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index dc9d6ed0781d..5d0bfea2c087 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -64,7 +64,7 @@ properties:
     description:
       size of memory intended as internal memory for endpoints
       buffers expressed in KB
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint16
 
   cdns,phyrst-a-enable:
     description: Enable resetting of PHY if Rx fail is detected
diff --git a/Makefile b/Makefile
index 19f8af8266bb..576636ef2f30 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 113
+SUBLEVEL = 114
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 2ebafe27a865..d3553e0f0187 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1190,7 +1190,7 @@ pins {
 		};
 	};
 
-	sai2a_sleep_pins_c: sai2a-2 {
+	sai2a_sleep_pins_c: sai2a-sleep-2 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 13, ANALOG)>, /* SAI2_SCK_A */
 				 <STM32_PINMUX('D', 11, ANALOG)>, /* SAI2_SD_A */
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index 87b5e23c766f..d053ef302fb8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -98,11 +98,17 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ethphy: ethernet-phy@4 {
+		ethphy: ethernet-phy@4 { /* AR8033 or ADIN1300 */
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <4>;
 			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
+			/*
+			 * Deassert delay:
+			 * ADIN1300 requires 5ms.
+			 * AR8033   requires 1ms.
+			 */
+			reset-deassert-us = <20000>;
 		};
 	};
 };
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 0dea80bf6de4..b44931deb227 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -21,9 +21,10 @@ void copy_highpage(struct page *to, struct page *from)
 
 	copy_page(kto, kfrom);
 
+	page_kasan_tag_reset(to);
+
 	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
 		set_bit(PG_mte_tagged, &to->flags);
-		page_kasan_tag_reset(to);
 		/*
 		 * We need smp_wmb() in between setting the flags and clearing the
 		 * tags because if another thread reads page->flags and builds a
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 74ee1e3013d7..6cc68f29ab13 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -858,11 +858,17 @@ static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *
 }
 
 static inline void __user *
-get_sigframe(struct ksignal *ksig, size_t frame_size)
+get_sigframe(struct ksignal *ksig, struct pt_regs *tregs, size_t frame_size)
 {
 	unsigned long usp = sigsp(rdusp(), ksig);
+	unsigned long gap = 0;
 
-	return (void __user *)((usp - frame_size) & -8UL);
+	if (CPU_IS_020_OR_030 && tregs->format == 0xb) {
+		/* USP is unreliable so use worst-case value */
+		gap = 256;
+	}
+
+	return (void __user *)((usp - gap - frame_size) & -8UL);
 }
 
 static int setup_frame(struct ksignal *ksig, sigset_t *set,
@@ -880,7 +886,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame) + fsize);
+	frame = get_sigframe(ksig, tregs, sizeof(*frame) + fsize);
 
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
@@ -952,7 +958,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame));
+	frame = get_sigframe(ksig, tregs, sizeof(*frame));
 
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index eef0096db5f8..2f4c45f60ae1 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -53,6 +53,11 @@ extern void flush_dcache_page(struct page *page);
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)
+
 
 #define flush_icache_page(vma,page)	do { 		\
 	flush_kernel_dcache_page_addr(page_address(page)); \
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 394e6e14e5c4..c473c2f395a0 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -324,6 +324,7 @@ void flush_dcache_page(struct page *page)
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
 	unsigned long addr, old_addr = 0;
+	unsigned long flags;
 	pgoff_t pgoff;
 
 	if (mapping && !mapping_mapped(mapping)) {
@@ -343,7 +344,7 @@ void flush_dcache_page(struct page *page)
 	 * declared as MAP_PRIVATE or MAP_SHARED), so we only need
 	 * to flush one address here for them all to become coherent */
 
-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		addr = mpnt->vm_start + offset;
@@ -366,7 +367,7 @@ void flush_dcache_page(struct page *page)
 			old_addr = addr;
 		}
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 38ec4ae81239..4f36c16aec86 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -120,13 +120,18 @@ void machine_power_off(void)
 	/* It seems we have no way to power the system off via
 	 * software. The user has to press the button himself. */
 
-	printk(KERN_EMERG "System shut down completed.\n"
-	       "Please power this system off now.");
+	printk("Power off or press RETURN to reboot.\n");
 
 	/* prevent soft lockup/stalled CPU messages for endless loop. */
 	rcu_sysrq_start();
 	lockup_detector_soft_poweroff();
-	for (;;);
+	while (1) {
+		/* reboot if user presses RETURN key */
+		if (pdc_iodc_getc() == 13) {
+			printk("Rebooting...\n");
+			machine_restart(NULL);
+		}
+	}
 }
 
 void (*pm_power_off)(void);
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 70ace3687950..dc1bc77b9fa6 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -305,8 +305,8 @@ static void handle_break(struct pt_regs *regs)
 #endif
 
 #ifdef CONFIG_KGDB
-	if (unlikely(iir == PARISC_KGDB_COMPILED_BREAK_INSN ||
-		iir == PARISC_KGDB_BREAK_INSN)) {
+	if (unlikely((iir == PARISC_KGDB_COMPILED_BREAK_INSN ||
+		iir == PARISC_KGDB_BREAK_INSN)) && !user_mode(regs)) {
 		kgdb_handle_exception(9, SIGTRAP, 0, regs);
 		return;
 	}
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8f371f3cbbd2..935081ddf60b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5822,6 +5822,7 @@ static struct intel_uncore_type spr_uncore_mdf = {
 };
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
+#define UNCORE_SPR_CHA				0
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
 
@@ -6064,12 +6065,22 @@ static int uncore_type_max_boxes(struct intel_uncore_type **types,
 	return max + 1;
 }
 
+#define SPR_MSR_UNC_CBO_CONFIG		0x2FFE
+
 void spr_uncore_cpu_init(void)
 {
+	struct intel_uncore_type *type;
+	u64 num_cbo;
+
 	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
 						UNCORE_SPR_MSR_EXTRA_UNCORES,
 						spr_msr_uncores);
 
+	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
+	if (type) {
+		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
+		type->num_boxes = num_cbo;
+	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index fc12d970a07c..d975c60f863a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -112,6 +112,11 @@
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
+#define INTEL_FAM6_ALDERLAKE_N		0xBE
+
+#define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 5e868b62a7c4..0270925fe013 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -79,7 +79,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
-	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
 }
@@ -109,7 +109,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	c->initial_apicid = edx;
-	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 53de044e5654..92b33c7eaf3f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,7 +195,6 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
-	stack = stack ? : get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -214,9 +213,13 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+	for (stack = stack ?: get_stack_pointer(task, regs);
+	     stack;
+	     stack = stack_info.next_sp) {
 		const char *stack_name;
 
+		stack = PTR_ALIGN(stack, sizeof(long));
+
 		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
 			/*
 			 * We weren't on a valid stack.  It's possible that
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 0e3667e529ab..34a08f6a528e 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -261,6 +262,24 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
+#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
+			      .family  = 6,			\
+			      .model = _model,			\
+			    }
+/*
+ * INVLPG may not properly flush Global entries
+ * on these CPUs when PCIDs are enabled.
+ */
+static const struct x86_cpu_id invlpg_miss_ids[] = {
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	{}
+};
+
 static void setup_pcid(void)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
@@ -269,6 +288,12 @@ static void setup_pcid(void)
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
+	if (x86_match_cpu(invlpg_miss_ids)) {
+		pr_info("Incomplete global flushes, disabling PCID");
+		setup_clear_cpu_cap(X86_FEATURE_PCID);
+		return;
+	}
+
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		/*
 		 * This can't be cr4_set_bits_and_update_boot() -- the
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 641a91819088..edef31c41312 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -15,6 +15,8 @@
 
 #include "common.h"
 
+static DEFINE_IDA(ffa_bus_id);
+
 static int ffa_device_match(struct device *dev, struct device_driver *drv)
 {
 	const struct ffa_device_id *id_table;
@@ -53,7 +55,8 @@ static void ffa_device_remove(struct device *dev)
 {
 	struct ffa_driver *ffa_drv = to_ffa_driver(dev->driver);
 
-	ffa_drv->remove(to_ffa_dev(dev));
+	if (ffa_drv->remove)
+		ffa_drv->remove(to_ffa_dev(dev));
 }
 
 static int ffa_device_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -130,6 +133,7 @@ static void ffa_release_device(struct device *dev)
 {
 	struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
+	ida_free(&ffa_bus_id, ffa_dev->id);
 	kfree(ffa_dev);
 }
 
@@ -169,18 +173,24 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
 {
-	int ret;
+	int id, ret;
 	struct device *dev;
 	struct ffa_device *ffa_dev;
 
+	id = ida_alloc_min(&ffa_bus_id, 1, GFP_KERNEL);
+	if (id < 0)
+		return NULL;
+
 	ffa_dev = kzalloc(sizeof(*ffa_dev), GFP_KERNEL);
-	if (!ffa_dev)
+	if (!ffa_dev) {
+		ida_free(&ffa_bus_id, id);
 		return NULL;
+	}
 
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
-	dev_set_name(&ffa_dev->dev, "arm-ffa-%04x", vm_id);
+	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->vm_id = vm_id;
 	uuid_copy(&ffa_dev->uuid, uuid);
@@ -215,4 +225,5 @@ void arm_ffa_bus_exit(void)
 {
 	ffa_devices_unregister();
 	bus_unregister(&ffa_bus_type);
+	ida_destroy(&ffa_bus_id);
 }
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 814d3bf32489..f53d11eff65e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -451,12 +451,17 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = COMPOSITE_OFFSET(args->nattrs);
+		ep_mem_access->flag = 0;
+		ep_mem_access->reserved = 0;
 	}
+	mem_region->reserved_0 = 0;
+	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
 
 	composite = buffer + COMPOSITE_OFFSET(args->nattrs);
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
 	composite->addr_range_cnt = num_entries;
+	composite->reserved = 0;
 
 	length = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, num_entries);
 	frag_len = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, 0);
@@ -491,6 +496,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 
 		constituents->address = sg_phys(args->sg);
 		constituents->pg_cnt = args->sg->length / FFA_PAGE_SIZE;
+		constituents->reserved = 0;
 		constituents++;
 		frag_len += sizeof(struct ffa_mem_region_addr_range);
 	} while ((args->sg = sg_next(args->sg)));
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 0bded5853c41..5c84dd7880a4 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -368,7 +368,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 		priv->offset = i;
 		priv->desc = gpiochip_get_desc(gc, i);
 
-		debugfs_create_file(name, 0200, chip->dbg_dir, priv,
+		debugfs_create_file(name, 0600, chip->dbg_dir, priv,
 				    &gpio_mockup_debugfs_ops);
 	}
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..0000d0c6068f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -926,7 +926,7 @@ tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
 
 	len = tmc_etr_buf_get_data(etr_buf, offset,
 				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
-	if (WARN_ON(len < CORESIGHT_BARRIER_PKT_SIZE))
+	if (WARN_ON(len < 0 || len < CORESIGHT_BARRIER_PKT_SIZE))
 		return -EINVAL;
 	coresight_insert_barrier_packet(bufp);
 	return offset + CORESIGHT_BARRIER_PKT_SIZE;
diff --git a/drivers/media/radio/radio-shark.c b/drivers/media/radio/radio-shark.c
index 8230da828d0e..127a3be0e0f0 100644
--- a/drivers/media/radio/radio-shark.c
+++ b/drivers/media/radio/radio-shark.c
@@ -316,6 +316,16 @@ static int usb_shark_probe(struct usb_interface *intf,
 {
 	struct shark_device *shark;
 	int retval = -ENOMEM;
+	static const u8 ep_addresses[] = {
+		SHARK_IN_EP | USB_DIR_IN,
+		SHARK_OUT_EP | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_int_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid radioSHARK device\n");
+		return -EINVAL;
+	}
 
 	shark = kzalloc(sizeof(struct shark_device), GFP_KERNEL);
 	if (!shark)
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index d150f12382c6..f1c5c0a6a335 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -282,6 +282,16 @@ static int usb_shark_probe(struct usb_interface *intf,
 {
 	struct shark_device *shark;
 	int retval = -ENOMEM;
+	static const u8 ep_addresses[] = {
+		SHARK_IN_EP | USB_DIR_IN,
+		SHARK_OUT_EP | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_int_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid radioSHARK2 device\n");
+		return -EINVAL;
+	}
 
 	shark = kzalloc(sizeof(struct shark_device), GFP_KERNEL);
 	if (!shark)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 794702e34657..a6aa33dcd2a2 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1568,6 +1568,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	/* HS400/HS400ES require 8 bit bus */
+	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
@@ -1652,10 +1656,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
 	}
 
-	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-	if (err)
-		goto disable_ahb_clk;
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
@@ -1663,15 +1663,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400)
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 		host->mmc->caps2 |= MMC_CAP2_HS400;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
 		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
 		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					esdhc_hs400_enhanced_strobe;
@@ -1693,6 +1691,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto disable_ahb_clk;
 	}
 
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
+	if (err)
+		goto disable_ahb_clk;
+
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2816b6fc1739..a2ce9f0fb43c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3653,7 +3653,11 @@ static int bond_slave_netdev_event(unsigned long event,
 		unblock_netpoll_tx();
 		break;
 	case NETDEV_FEAT_CHANGE:
-		bond_compute_features(bond);
+		if (!bond->notifier_ctx) {
+			bond->notifier_ctx = true;
+			bond_compute_features(bond);
+			bond->notifier_ctx = false;
+		}
 		break;
 	case NETDEV_RESEND_IGMP:
 		/* Propagate to master device */
@@ -5932,6 +5936,8 @@ static int bond_init(struct net_device *bond_dev)
 	if (!bond->wq)
 		return -ENOMEM;
 
+	bond->notifier_ctx = false;
+
 	spin_lock_init(&bond->stats_lock);
 	netdev_lockdep_set_classes(bond_dev);
 
diff --git a/drivers/net/ethernet/3com/3c589_cs.c b/drivers/net/ethernet/3com/3c589_cs.c
index 09816e84314d..0197ef6f1582 100644
--- a/drivers/net/ethernet/3com/3c589_cs.c
+++ b/drivers/net/ethernet/3com/3c589_cs.c
@@ -195,6 +195,7 @@ static int tc589_probe(struct pcmcia_device *link)
 {
 	struct el3_private *lp;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&link->dev, "3c589_attach()\n");
 
@@ -218,7 +219,15 @@ static int tc589_probe(struct pcmcia_device *link)
 
 	dev->ethtool_ops = &netdev_ethtool_ops;
 
-	return tc589_config(link);
+	ret = tc589_config(link);
+	if (ret)
+		goto err_free_netdev;
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static void tc589_detach(struct pcmcia_device *link)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 3f3ec8ffc4dd..d1e3928a24f5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -574,9 +574,7 @@ static void otx2_sqe_add_ext(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
 				htons(ext->lso_sb - skb_network_offset(skb));
 		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6) {
 			ext->lso_format = pfvf->hw.lso_tsov6_idx;
-
-			ipv6_hdr(skb)->payload_len =
-				htons(ext->lso_sb - skb_network_offset(skb));
+			ipv6_hdr(skb)->payload_len = htons(tcp_hdrlen(skb));
 		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
 			__be16 l3_proto = vlan_get_protocol(skb);
 			struct udphdr *udph = udp_hdr(skb);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 833be29170a1..c47c360a5d5e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -150,20 +150,22 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
+	/* budget=0 means we may be in IRQ context, do as little as possible */
+	if (unlikely(!budget))
+		goto out;
+
 	busy |= mlx5e_poll_xdpsq_cq(&c->xdpsq.cq);
 
 	if (c->xdp)
 		busy |= mlx5e_poll_xdpsq_cq(&c->rq_xdpsq.cq);
 
-	if (likely(budget)) { /* budget=0 means: don't poll rx rings */
-		if (xsk_open)
-			work_done = mlx5e_poll_rx_cq(&xskrq->cq, budget);
+	if (xsk_open)
+		work_done = mlx5e_poll_rx_cq(&xskrq->cq, budget);
 
-		if (likely(budget - work_done))
-			work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
+	if (likely(budget - work_done))
+		work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
 
-		busy |= work_done == budget;
-	}
+	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
 	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index bced2efe9bef..abd066e95228 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -110,7 +110,8 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 	priv->devs[idx] = dev;
 	devcom = mlx5_devcom_alloc(priv, idx);
 	if (!devcom) {
-		kfree(priv);
+		if (new_priv)
+			kfree(priv);
 		return ERR_PTR(-ENOMEM);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 485a6a6220f6..d75facc5c503 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -903,7 +903,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 
 	dev->dm = mlx5_dm_create(dev);
 	if (IS_ERR(dev->dm))
-		mlx5_core_warn(dev, "Failed to init device memory%d\n", err);
+		mlx5_core_warn(dev, "Failed to init device memory %ld\n", PTR_ERR(dev->dm));
 
 	dev->tracer = mlx5_fw_tracer_create(dev);
 	dev->hv_vhca = mlx5_hv_vhca_create(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
index 56307283bf9b..fcf705ce421f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -117,6 +117,8 @@ int mlx5dr_cmd_query_device(struct mlx5_core_dev *mdev,
 	caps->gvmi		= MLX5_CAP_GEN(mdev, vhca_id);
 	caps->flex_protocols	= MLX5_CAP_GEN(mdev, flex_parser_protocols);
 	caps->sw_format_ver	= MLX5_CAP_GEN(mdev, steering_format_version);
+	caps->roce_caps.fl_rc_qp_when_roce_disabled =
+		MLX5_CAP_GEN(mdev, fl_rc_qp_when_roce_disabled);
 
 	if (MLX5_CAP_GEN(mdev, roce)) {
 		err = dr_cmd_query_nic_vport_roce_en(mdev, 0, &roce_en);
@@ -124,7 +126,7 @@ int mlx5dr_cmd_query_device(struct mlx5_core_dev *mdev,
 			return err;
 
 		caps->roce_caps.roce_en = roce_en;
-		caps->roce_caps.fl_rc_qp_when_roce_disabled =
+		caps->roce_caps.fl_rc_qp_when_roce_disabled |=
 			MLX5_CAP_ROCE(mdev, fl_rc_qp_when_roce_disabled);
 		caps->roce_caps.fl_rc_qp_when_roce_enabled =
 			MLX5_CAP_ROCE(mdev, fl_rc_qp_when_roce_enabled);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
index 01246a1ae7d1..5faf9fb1061c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
@@ -15,7 +15,8 @@ static u32 dr_ste_crc32_calc(const void *input_data, size_t length)
 {
 	u32 crc = crc32(0, input_data, length);
 
-	return (__force u32)htonl(crc);
+	return (__force u32)((crc >> 24) & 0xff) | ((crc << 8) & 0xff0000) |
+			    ((crc >> 8) & 0xff00) | ((crc << 24) & 0xff000000);
 }
 
 bool mlx5dr_ste_supp_ttl_cs_recalc(struct mlx5dr_cmd_caps *caps)
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index ef3fb4cc90af..d350c1ef9e0b 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6129,6 +6129,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	return 0;
 
 out_error:
+	nv_mgmt_release_sema(dev);
 	if (phystate_orig)
 		writel(phystate|NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
 out_freering:
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index f2e3a67198dd..74f3aa752724 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2664,6 +2664,7 @@ static struct phy_driver vsc85xx_driver[] = {
 module_phy_driver(vsc85xx_driver);
 
 static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
+	{ PHY_ID_VSC8502, 0xfffffff0, },
 	{ PHY_ID_VSC8504, 0xfffffff0, },
 	{ PHY_ID_VSC8514, 0xfffffff0, },
 	{ PHY_ID_VSC8530, 0xfffffff0, },
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index ab8f5097d3b0..d9386d614a94 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1624,6 +1624,7 @@ static int team_init(struct net_device *dev)
 
 	team->dev = dev;
 	team_set_no_mode(team);
+	team->notifier_ctx = false;
 
 	team->pcpu_stats = netdev_alloc_pcpu_stats(struct team_pcpu_stats);
 	if (!team->pcpu_stats)
@@ -3016,7 +3017,11 @@ static int team_device_event(struct notifier_block *unused,
 		team_del_slave(port->team->dev, dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
-		team_compute_features(port->team);
+		if (!port->team->notifier_ctx) {
+			port->team->notifier_ctx = true;
+			team_compute_features(port->team);
+			port->team->notifier_ctx = false;
+		}
 		break;
 	case NETDEV_PRECHANGEMTU:
 		/* Forbid to change mtu of underlaying device */
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 15f91d691bba..dd7469d310c3 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -180,9 +180,12 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 	else
 		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth32);
 
-	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
-	if (max == 0)
+	if (le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize) == 0)
 		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
+	else
+		max = clamp_t(u32, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize),
+			      USB_CDC_NCM_NTB_MIN_OUT_SIZE,
+			      CDC_NCM_NTB_MAX_SIZE_TX);
 
 	/* some devices set dwNtbOutMaxSize too low for the above default */
 	min = min(min, max);
@@ -1243,6 +1246,9 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			 * further.
 			 */
 			if (skb_out == NULL) {
+				/* If even the smallest allocation fails, abort. */
+				if (ctx->tx_curr_size == USB_CDC_NCM_NTB_MIN_OUT_SIZE)
+					goto alloc_failed;
 				ctx->tx_low_mem_max_cnt = min(ctx->tx_low_mem_max_cnt + 1,
 							      (unsigned)CDC_NCM_LOW_MEM_MAX_CNT);
 				ctx->tx_low_mem_val = ctx->tx_low_mem_max_cnt;
@@ -1261,13 +1267,8 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			skb_out = alloc_skb(ctx->tx_curr_size, GFP_ATOMIC);
 
 			/* No allocation possible so we will abort */
-			if (skb_out == NULL) {
-				if (skb != NULL) {
-					dev_kfree_skb_any(skb);
-					dev->net->stats.tx_dropped++;
-				}
-				goto exit_no_skb;
-			}
+			if (!skb_out)
+				goto alloc_failed;
 			ctx->tx_low_mem_val--;
 		}
 		if (ctx->is_ndp16) {
@@ -1460,6 +1461,11 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 
 	return skb_out;
 
+alloc_failed:
+	if (skb) {
+		dev_kfree_skb_any(skb);
+		dev->net->stats.tx_dropped++;
+	}
 exit_no_skb:
 	/* Start timer, if there is a remaining non-empty skb */
 	if (ctx->tx_curr_skb != NULL && n > 0)
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index c2c9b0d3244c..be967d797c28 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1348,9 +1348,8 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 
 	for (i = 0; i < pmc->total_blocks; ++i) {
 		if (strstr(pmc->block_name[i], "tile")) {
-			ret = sscanf(pmc->block_name[i], "tile%d", &tile_num);
-			if (ret < 0)
-				return ret;
+			if (sscanf(pmc->block_name[i], "tile%d", &tile_num) != 1)
+				return -EINVAL;
 
 			if (tile_num >= pmc->tile_count)
 				continue;
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7e5e24b585d8..7334a8b8007e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1755,7 +1755,7 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
-void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_ci_flag = di->opts & BQ27XXX_O_HAS_CI;
@@ -1806,6 +1806,16 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 		di->cache = cache;
 
 	di->last_update = jiffies;
+
+	if (!di->removed && poll_interval > 0)
+		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
+}
+
+void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+{
+	mutex_lock(&di->lock);
+	bq27xxx_battery_update_unlocked(di);
+	mutex_unlock(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
 
@@ -1816,9 +1826,6 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 				     work.work);
 
 	bq27xxx_battery_update(di);
-
-	if (poll_interval > 0)
-		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
 
 static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
@@ -1839,7 +1846,8 @@ static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
 static int bq27xxx_battery_current_and_status(
 	struct bq27xxx_device_info *di,
 	union power_supply_propval *val_curr,
-	union power_supply_propval *val_status)
+	union power_supply_propval *val_status,
+	struct bq27xxx_reg_cache *cache)
 {
 	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
 	int curr;
@@ -1851,10 +1859,14 @@ static int bq27xxx_battery_current_and_status(
 		return curr;
 	}
 
-	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
-	if (flags < 0) {
-		dev_err(di->dev, "error reading flags\n");
-		return flags;
+	if (cache) {
+		flags = cache->flags;
+	} else {
+		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
+		if (flags < 0) {
+			dev_err(di->dev, "error reading flags\n");
+			return flags;
+		}
 	}
 
 	if (di->opts & BQ27XXX_O_ZERO) {
@@ -1991,10 +2003,8 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
 	mutex_lock(&di->lock);
-	if (time_is_before_jiffies(di->last_update + 5 * HZ)) {
-		cancel_delayed_work_sync(&di->work);
-		bq27xxx_battery_poll(&di->work.work);
-	}
+	if (time_is_before_jiffies(di->last_update + 5 * HZ))
+		bq27xxx_battery_update_unlocked(di);
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
@@ -2002,7 +2012,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = bq27xxx_battery_current_and_status(di, NULL, val);
+		ret = bq27xxx_battery_current_and_status(di, NULL, val, NULL);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
@@ -2011,7 +2021,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		val->intval = di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = bq27xxx_battery_current_and_status(di, val, NULL);
+		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
@@ -2133,22 +2143,18 @@ EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
 
 void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 {
-	/*
-	 * power_supply_unregister call bq27xxx_battery_get_property which
-	 * call bq27xxx_battery_poll.
-	 * Make sure that bq27xxx_battery_poll will not call
-	 * schedule_delayed_work again after unregister (which cause OOPS).
-	 */
-	poll_interval = 0;
-
-	cancel_delayed_work_sync(&di->work);
-
-	power_supply_unregister(di->bat);
-
 	mutex_lock(&bq27xxx_list_lock);
 	list_del(&di->list);
 	mutex_unlock(&bq27xxx_list_lock);
 
+	/* Set removed to avoid bq27xxx_battery_update() re-queuing the work */
+	mutex_lock(&di->lock);
+	di->removed = true;
+	mutex_unlock(&di->lock);
+
+	cancel_delayed_work_sync(&di->work);
+
+	power_supply_unregister(di->bat);
 	mutex_destroy(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index cf38cbfe13e9..b722ee2d7e14 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -179,7 +179,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, di);
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = request_threaded_irq(client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
 				IRQF_ONESHOT,
 				di->name, di);
@@ -209,6 +209,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
+	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index 3abaa72e0668..f1248faf5905 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -799,7 +799,9 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)
diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index d69880cc3593..b7a2778f878d 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -34,8 +34,9 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_FULL);
-		led_trigger_event(psy->charging_blink_full_solid_trig,
-			LED_FULL);
+		/* Going from blink to LED on requires a LED_OFF event to stop blink */
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index b08f7d0c4181..bc927c0ddd34 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -24,7 +24,7 @@
 #define SBS_CHARGER_REG_STATUS			0x13
 #define SBS_CHARGER_REG_ALARM_WARNING		0x16
 
-#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
+#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(0)
 #define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
 #define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
 #define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index de3b0462832c..f94f87c5407a 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -951,9 +951,12 @@ static int mt6359_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
 	struct mt6359_regulator_info *mt6359_info;
-	int i, hw_ver;
+	int i, hw_ver, ret;
+
+	ret = regmap_read(mt6397->regmap, MT6359P_HWCID, &hw_ver);
+	if (ret)
+		return ret;
 
-	regmap_read(mt6397->regmap, MT6359P_HWCID, &hw_ver);
 	if (hw_ver >= MT6359P_CHIP_VER)
 		mt6359_info = mt6359p_regulators;
 	else
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 64e5f5f0cc84..556074d7fe24 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -256,7 +256,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -494,7 +494,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index ee905880769e..7832ce330b29 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/byteorder/generic.h>
 
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-lib.h"
@@ -120,6 +121,21 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 		mspi->rx_dma = mspi->dma_dummy_rx;
 		mspi->map_rx_dma = 0;
 	}
+	if (t->bits_per_word == 16 && t->tx_buf) {
+		const u16 *src = t->tx_buf;
+		u16 *dst;
+		int i;
+
+		dst = kmalloc(t->len, GFP_KERNEL);
+		if (!dst)
+			return -ENOMEM;
+
+		for (i = 0; i < t->len >> 1; i++)
+			dst[i] = cpu_to_le16p(src + i);
+
+		mspi->tx = dst;
+		mspi->map_tx_dma = 1;
+	}
 
 	if (mspi->map_tx_dma) {
 		void *nonconst_tx = (void *)mspi->tx; /* shut up gcc */
@@ -173,6 +189,13 @@ void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
 	if (mspi->map_rx_dma)
 		dma_unmap_single(dev, mspi->rx_dma, t->len, DMA_FROM_DEVICE);
 	mspi->xfer_in_progress = NULL;
+
+	if (t->bits_per_word == 16 && t->rx_buf) {
+		int i;
+
+		for (i = 0; i < t->len; i += 2)
+			le16_to_cpus(t->rx_buf + i);
+	}
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_bufs_complete);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 1bad0ceac81b..63302e21e574 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -203,26 +203,6 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	return bits_per_word;
 }
 
-static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
-				struct spi_device *spi,
-				int bits_per_word)
-{
-	/* CPM/QE uses Little Endian for words > 8
-	 * so transform 16 and 32 bits words into 8 bits
-	 * Unfortnatly that doesn't work for LSB so
-	 * reject these for now */
-	/* Note: 32 bits word, LSB works iff
-	 * tfcr/rfcr is set to CPMFCR_GBL */
-	if (spi->mode & SPI_LSB_FIRST &&
-	    bits_per_word > 8)
-		return -EINVAL;
-	if (bits_per_word <= 8)
-		return bits_per_word;
-	if (bits_per_word == 16 || bits_per_word == 32)
-		return 8; /* pretend its 8 bits */
-	return -EINVAL;
-}
-
 static int fsl_spi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -250,9 +230,6 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else
-		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
-							  bits_per_word);
 
 	if (bits_per_word < 0)
 		return bits_per_word;
@@ -370,14 +347,30 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	 * In CPU mode, optimize large byte transfers to use larger
 	 * bits_per_word values to reduce number of interrupts taken.
 	 */
-	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
-		list_for_each_entry(t, &m->transfers, transfer_list) {
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
 			if (t->len < 256 || t->bits_per_word != 8)
 				continue;
 			if ((t->len & 3) == 0)
 				t->bits_per_word = 32;
 			else if ((t->len & 1) == 0)
 				t->bits_per_word = 16;
+		} else {
+			/*
+			 * CPM/QE uses Little Endian for words > 8
+			 * so transform 16 and 32 bits words into 8 bits
+			 * Unfortnatly that doesn't work for LSB so
+			 * reject these for now
+			 * Note: 32 bits word, LSB works iff
+			 * tfcr/rfcr is set to CPMFCR_GBL
+			 */
+			if (m->spi->mode & SPI_LSB_FIRST && t->bits_per_word > 8)
+				return -EINVAL;
+			if (t->bits_per_word == 16 || t->bits_per_word == 32)
+				t->bits_per_word = 8; /* pretend its 8 bits */
+			if (t->bits_per_word == 8 && t->len >= 256 &&
+			    (mpc8xxx_spi->flags & SPI_CPM1))
+				t->bits_per_word = 16;
 		}
 	}
 
@@ -635,8 +628,14 @@ static struct spi_master *fsl_spi_probe(struct device *dev,
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
 		fsl_spi_grlib_probe(dev);
 
-	master->bits_per_word_mask =
-		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
+	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32));
+	else
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32));
+
+	master->bits_per_word_mask &=
 		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index cc36f9f22814..ec8e003f5941 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -206,6 +206,82 @@ int usb_find_common_endpoints_reverse(struct usb_host_interface *alt,
 }
 EXPORT_SYMBOL_GPL(usb_find_common_endpoints_reverse);
 
+/**
+ * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
+ * usb_host_endpoint structure in an interface's current altsetting.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addr: the endpoint address (number and direction) to find
+ *
+ * Search the altsetting's list of endpoints for one with the specified address.
+ *
+ * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
+ */
+static const struct usb_host_endpoint *usb_find_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	int n;
+	const struct usb_host_endpoint *ep;
+
+	n = intf->cur_altsetting->desc.bNumEndpoints;
+	ep = intf->cur_altsetting->endpoint;
+	for (; n > 0; (--n, ++ep)) {
+		if (ep->desc.bEndpointAddress == ep_addr)
+			return ep;
+	}
+	return NULL;
+}
+
+/**
+ * usb_check_bulk_endpoints - Check whether an interface's current altsetting
+ * contains a set of bulk endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are bulk, %false otherwise.
+ */
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_bulk(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_bulk_endpoints);
+
+/**
+ * usb_check_int_endpoints - Check whether an interface's current altsetting
+ * contains a set of interrupt endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are interrupt,
+ * %false otherwise.
+ */
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_int(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_int_endpoints);
+
 /**
  * usb_find_alt_setting() - Given a configuration, find the alternate setting
  * for the given interface.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 725653711411..84cdac33cb35 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1085,6 +1085,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1298,6 +1299,7 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		suspended:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7ff77a0de515..e42d50e4aba3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3694,6 +3694,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 {
 	int			reg;
 
+	dwc->suspended = false;
+
 	dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RX_DET);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -3714,6 +3716,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	dwc->suspended = false;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -3919,6 +3923,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 {
+	dwc->suspended = false;
+
 	/*
 	 * TODO take core out of low power mode when that's
 	 * implemented.
@@ -4034,8 +4040,10 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
 
-	if (dwc->link_state != next && next == DWC3_LINK_STATE_U3)
+	if (!dwc->suspended && next == DWC3_LINK_STATE_U3) {
+		dwc->suspended = true;
 		dwc3_suspend_gadget(dwc);
+	}
 
 	dwc->link_state = next;
 }
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 553382ce3837..0886cff9aa1c 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -498,6 +498,19 @@ static u8 encode_bMaxPower(enum usb_device_speed speed,
 		return min(val, 900U) / 8;
 }
 
+void check_remote_wakeup_config(struct usb_gadget *g,
+				struct usb_configuration *c)
+{
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes) {
+		/* Reset the rw bit if gadget is not capable of it */
+		if (!g->wakeup_capable && g->ops->set_remote_wakeup) {
+			WARN(c->cdev, "Clearing wakeup bit for config c.%d\n",
+			     c->bConfigurationValue);
+			c->bmAttributes &= ~USB_CONFIG_ATT_WAKEUP;
+		}
+	}
+}
+
 static int config_buf(struct usb_configuration *config,
 		enum usb_device_speed speed, void *buf, u8 type)
 {
@@ -945,6 +958,11 @@ static int set_config(struct usb_composite_dev *cdev,
 		power = min(power, 500U);
 	else
 		power = min(power, 900U);
+
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
+		usb_gadget_set_remote_wakeup(gadget, 1);
+	else
+		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
 	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
 		usb_gadget_set_selfpowered(gadget);
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 5cbf4084daed..528b9ec1d9e8 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1384,6 +1384,9 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		if (gadget_is_otg(gadget))
 			c->descriptors = otg_desc;
 
+		/* Properly configure the bmAttributes wakeup bit */
+		check_remote_wakeup_config(gadget, c);
+
 		cfg = container_of(c, struct config_usb_cfg, c);
 		if (!list_empty(&cfg->string_list)) {
 			i = 0;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 61099f2d057d..6c05a3a9b542 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -508,6 +508,33 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
 
+/**
+ * usb_gadget_set_remote_wakeup - configures the device remote wakeup feature.
+ * @gadget:the device being configured for remote wakeup
+ * @set:value to be configured.
+ *
+ * set to one to enable remote wakeup feature and zero to disable it.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
+{
+	int ret = 0;
+
+	if (!gadget->ops->set_remote_wakeup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->set_remote_wakeup(gadget, set);
+
+out:
+	trace_usb_gadget_set_remote_wakeup(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_set_remote_wakeup);
+
 /**
  * usb_gadget_set_selfpowered - sets the device selfpowered feature.
  * @gadget:the device being declared as self-powered
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 98584f6b6c66..428819311afb 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -91,6 +91,11 @@ DEFINE_EVENT(udc_log_gadget, usb_gadget_wakeup,
 	TP_ARGS(g, ret)
 );
 
+DEFINE_EVENT(udc_log_gadget, usb_gadget_set_remote_wakeup,
+	TP_PROTO(struct usb_gadget *g, int ret),
+	TP_ARGS(g, ret)
+);
+
 DEFINE_EVENT(udc_log_gadget, usb_gadget_set_selfpowered,
 	TP_PROTO(struct usb_gadget *g, int ret),
 	TP_ARGS(g, ret)
diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index f08de33d9ff3..8ed803c4a251 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -3014,6 +3014,20 @@ static int sisusb_probe(struct usb_interface *intf,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct sisusb_usb_data *sisusb;
 	int retval = 0, i;
+	static const u8 ep_addresses[] = {
+		SISUSB_EP_GFX_IN | USB_DIR_IN,
+		SISUSB_EP_GFX_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_BULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_LBULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_BRIDGE_IN | USB_DIR_IN,
+		SISUSB_EP_BRIDGE_OUT | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_bulk_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid USB2VGA device\n");
+		return -EINVAL;
+	}
 
 	dev_info(&dev->dev, "USB2VGA dongle found at address %d\n",
 			dev->devnum);
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index d9eec1b60e66..0de7b867714a 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -27,6 +27,8 @@
 #include <video/udlfb.h>
 #include "edid.h"
 
+#define OUT_EP_NUM	1	/* The endpoint number we will use */
+
 static const struct fb_fix_screeninfo dlfb_fix = {
 	.id =           "udlfb",
 	.type =         FB_TYPE_PACKED_PIXELS,
@@ -1651,7 +1653,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	struct fb_info *info;
 	int retval;
 	struct usb_device *usbdev = interface_to_usbdev(intf);
-	struct usb_endpoint_descriptor *out;
+	static u8 out_ep[] = {OUT_EP_NUM + USB_DIR_OUT, 0};
 
 	/* usb initialization */
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
@@ -1665,9 +1667,9 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	dlfb->udev = usb_get_dev(usbdev);
 	usb_set_intfdata(intf, dlfb);
 
-	retval = usb_find_common_endpoints(intf->cur_altsetting, NULL, &out, NULL, NULL);
-	if (retval) {
-		dev_err(&intf->dev, "Device should have at lease 1 bulk endpoint!\n");
+	if (!usb_check_bulk_endpoints(intf, out_ep)) {
+		dev_err(&intf->dev, "Invalid DisplayLink device!\n");
+		retval = -EINVAL;
 		goto error;
 	}
 
@@ -1926,7 +1928,8 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dlfb, int count, size_t size)
 		}
 
 		/* urb->transfer_buffer_length set to actual before submit */
-		usb_fill_bulk_urb(urb, dlfb->udev, usb_sndbulkpipe(dlfb->udev, 1),
+		usb_fill_bulk_urb(urb, dlfb->udev,
+			usb_sndbulkpipe(dlfb->udev, OUT_EP_NUM),
 			buf, size, dlfb_urb_completion, unode);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 4afc468d8ed1..1e327fb1ad20 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -108,6 +108,10 @@ static int tco_timer_start(struct watchdog_device *wdd)
 	val |= SP5100_WDT_START_STOP_BIT;
 	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
 
+	/* This must be a distinct write. */
+	val |= SP5100_WDT_TRIGGER_BIT;
+	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
+
 	return 0;
 }
 
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index e18df9aea531..a1e8b6eab69d 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -321,8 +321,10 @@ static struct sock_mapping *pvcalls_new_active_socket(
 	void *page;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (map == NULL)
+	if (map == NULL) {
+		sock_release(sock);
 		return NULL;
+	}
 
 	map->fedata = fedata;
 	map->sock = sock;
@@ -414,10 +416,8 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 					req->u.connect.ref,
 					req->u.connect.evtchn,
 					sock);
-	if (!map) {
+	if (!map)
 		ret = -EFAULT;
-		sock_release(sock);
-	}
 
 out:
 	rsp = RING_GET_RESPONSE(&fedata->ring, fedata->ring.rsp_prod_pvt++);
@@ -558,7 +558,6 @@ static void __pvcalls_back_accept(struct work_struct *work)
 					sock);
 	if (!map) {
 		ret = -EFAULT;
-		sock_release(sock);
 		goto out_error;
 	}
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a4bfa5acaf9f..c3d046fc85bd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4796,7 +4796,11 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 		 */
 		inode = igrab(&btrfs_inode->vfs_inode);
 		if (inode) {
+			unsigned int nofs_flag;
+
+			nofs_flag = memalloc_nofs_save();
 			invalidate_inode_pages2(inode->i_mapping);
+			memalloc_nofs_restore(nofs_flag);
 			iput(inode);
 		}
 		spin_lock(&root->delalloc_lock);
@@ -4901,7 +4905,12 @@ static void btrfs_cleanup_bg_io(struct btrfs_block_group *cache)
 
 	inode = cache->io_ctl.inode;
 	if (inode) {
+		unsigned int nofs_flag;
+
+		nofs_flag = memalloc_nofs_save();
 		invalidate_inode_pages2(inode->i_mapping);
+		memalloc_nofs_restore(nofs_flag);
+
 		BTRFS_I(inode)->generation = 0;
 		cache->io_ctl.inode = NULL;
 		iput(inode);
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 8455db6a26f5..6347e759b5cc 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -884,6 +884,14 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			ctx->sfu_remap = false; /* disable SFU mapping */
 		}
 		break;
+	case Opt_mapchars:
+		if (result.negated)
+			ctx->sfu_remap = false;
+		else {
+			ctx->sfu_remap = true;
+			ctx->remap = false; /* disable SFM (mapposix) mapping */
+		}
+		break;
 	case Opt_user_xattr:
 		if (result.negated)
 			ctx->no_xattr = 1;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 5b8237ceb8cc..3c24eceeb4ff 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
 	int want_meta = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota_inode = 0;
@@ -1805,6 +1806,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
 	int want_clusters = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota = 0, did_quota_inode = 0;
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index dd784eb0cd7c..c101a71a52ae 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
 static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 		     void *fs_info)
 {
+	struct ocfs2_security_xattr_info *si = fs_info;
 	const struct xattr *xattr;
 	int err = 0;
 
+	if (si) {
+		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
+				    GFP_KERNEL);
+		if (!si->value)
+			return -ENOMEM;
+
+		si->name = xattr_array->name;
+		si->value_len = xattr_array->value_len;
+		return 0;
+	}
+
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
 				      xattr->name, xattr->value,
@@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
 			    const struct qstr *qstr,
 			    struct ocfs2_security_xattr_info *si)
 {
+	int ret;
+
 	/* check whether ocfs2 support feature xattr */
 	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
 		return -EOPNOTSUPP;
-	if (si)
-		return security_old_inode_init_security(inode, dir, qstr,
-							&si->name, &si->value,
-							&si->value_len);
+	if (si) {
+		ret = security_inode_init_security(inode, dir, qstr,
+						   &ocfs2_initxattrs, si);
+		/*
+		 * security_inode_init_security() does not return -EOPNOTSUPP,
+		 * we have to check the xattr ourselves.
+		 */
+		if (!ret && !si->name)
+			si->enable = 0;
+
+		return ret;
+	}
 
 	return security_inode_init_security(inode, dir, qstr,
 					    &ocfs2_initxattrs, NULL);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 505c679b6a9b..99e212765632 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -13,6 +13,7 @@
 
 /* FFA Bus/Device/Driver related */
 struct ffa_device {
+	u32 id;
 	int vm_id;
 	bool mode_32bit;
 	uuid_t uuid;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 23ecfecdc450..c0dd2794e1ba 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1398,29 +1398,29 @@ extern int send_sigurg(struct fown_struct *fown);
  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
  * represented in both.
  */
-#define SB_RDONLY	 1	/* Mount read-only */
-#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
-#define SB_NODEV	 4	/* Disallow access to device special files */
-#define SB_NOEXEC	 8	/* Disallow program execution */
-#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
-#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
-#define SB_NOATIME	1024	/* Do not update access times. */
-#define SB_NODIRATIME	2048	/* Do not update directory access times */
-#define SB_SILENT	32768
-#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
-#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
-#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+#define SB_RDONLY       BIT(0)	/* Mount read-only */
+#define SB_NOSUID       BIT(1)	/* Ignore suid and sgid bits */
+#define SB_NODEV        BIT(2)	/* Disallow access to device special files */
+#define SB_NOEXEC       BIT(3)	/* Disallow program execution */
+#define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
+#define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
+#define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchronous */
+#define SB_NOATIME      BIT(10)	/* Do not update access times. */
+#define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
+#define SB_SILENT       BIT(15)
+#define SB_POSIXACL     BIT(16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT  BIT(17)	/* Use blk-crypto for encrypted files */
+#define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
+#define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
+#define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
-#define SB_SUBMOUNT     (1<<26)
-#define SB_FORCE    	(1<<27)
-#define SB_NOSEC	(1<<28)
-#define SB_BORN		(1<<29)
-#define SB_ACTIVE	(1<<30)
-#define SB_NOUSER	(1<<31)
+#define SB_SUBMOUNT     BIT(26)
+#define SB_FORCE        BIT(27)
+#define SB_NOSEC        BIT(28)
+#define SB_BORN         BIT(29)
+#define SB_ACTIVE       BIT(30)
+#define SB_NOUSER       BIT(31)
 
 /* These flags relate to encoding and casefolding */
 #define SB_ENC_STRICT_MODE_FL	(1 << 0)
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index add607943c95..5dd1657947b7 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -208,6 +208,7 @@ struct team {
 	bool queue_override_enabled;
 	struct list_head *qom_lists; /* array of queue override mapping lists */
 	bool port_mtu_change_allowed;
+	bool notifier_ctx;
 	struct {
 		unsigned int count;
 		unsigned int interval; /* in ms */
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 442b6ac8a66c..b89992e8a3c8 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1513,7 +1513,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         rc[0x1];
 
 	u8         uar_4k[0x1];
-	u8         reserved_at_241[0x9];
+	u8         reserved_at_241[0x7];
+	u8         fl_rc_qp_when_roce_disabled[0x1];
+	u8         regexp_params[0x1];
 	u8         uar_sz[0x6];
 	u8         reserved_at_248[0x2];
 	u8         umem_uid_0[0x1];
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index a1aa68141d0b..e3322dad9c85 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -68,6 +68,7 @@ struct bq27xxx_device_info {
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
+	bool removed;
 	unsigned long last_update;
 	struct delayed_work work;
 	struct power_supply *bat;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 89f58d070470..987550fd46fa 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -279,6 +279,11 @@ void usb_put_intf(struct usb_interface *intf);
 #define USB_MAXINTERFACES	32
 #define USB_MAXIADS		(USB_MAXINTERFACES/2)
 
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+
 /*
  * USB Resume Timer: Every Host controller driver should drive the resume
  * signalling on the bus for the amount of time defined by this macro.
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 9d2762279286..0399d1226323 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -426,6 +426,8 @@ extern int composite_dev_prepare(struct usb_composite_driver *composite,
 extern int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 					 struct usb_ep *ep0);
 void composite_dev_cleanup(struct usb_composite_dev *cdev);
+void check_remote_wakeup_config(struct usb_gadget *g,
+				struct usb_configuration *c);
 
 static inline struct usb_composite_driver *to_cdriver(
 		struct usb_gadget_driver *gdrv)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 10fe57cf40be..c5bc739266ed 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -311,6 +311,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*set_remote_wakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
 	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
@@ -385,6 +386,8 @@ struct usb_gadget_ops {
  * @connected: True if gadget is connected.
  * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
  *	indicates that it supports LPM as per the LPM ECN & errata.
+ * @wakeup_capable: True if gadget is capable of sending remote wakeup.
+ * @wakeup_armed: True if gadget is armed by the host for remote wakeup.
  * @irq: the interrupt number for device controller.
  *
  * Gadgets have a mostly-portable "gadget driver" implementing device
@@ -445,6 +448,8 @@ struct usb_gadget {
 	unsigned			deactivated:1;
 	unsigned			connected:1;
 	unsigned			lpm_capable:1;
+	unsigned			wakeup_capable:1;
+	unsigned			wakeup_armed:1;
 	int				irq;
 };
 #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
@@ -600,6 +605,7 @@ static inline int gadget_is_otg(struct usb_gadget *g)
 #if IS_ENABLED(CONFIG_USB_GADGET)
 int usb_gadget_frame_number(struct usb_gadget *gadget);
 int usb_gadget_wakeup(struct usb_gadget *gadget);
+int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set);
 int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_vbus_connect(struct usb_gadget *gadget);
@@ -615,6 +621,8 @@ static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_wakeup(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
+{ return 0; }
 static inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 8c18c6b01634..de0bdcc7dc7f 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -214,6 +214,7 @@ struct bonding {
 	struct   bond_up_slave __rcu *usable_slaves;
 	struct   bond_up_slave __rcu *all_slaves;
 	bool     force_primary;
+	bool     notifier_ctx;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
 	int     (*recv_probe)(const struct sk_buff *, struct bonding *,
 			      struct slave *);
diff --git a/include/uapi/sound/skl-tplg-interface.h b/include/uapi/sound/skl-tplg-interface.h
index a93c0decfdd5..215ce16b37d2 100644
--- a/include/uapi/sound/skl-tplg-interface.h
+++ b/include/uapi/sound/skl-tplg-interface.h
@@ -66,7 +66,8 @@ enum skl_ch_cfg {
 	SKL_CH_CFG_DUAL_MONO = 9,
 	SKL_CH_CFG_I2S_DUAL_STEREO_0 = 10,
 	SKL_CH_CFG_I2S_DUAL_STEREO_1 = 11,
-	SKL_CH_CFG_4_CHANNEL = 12,
+	SKL_CH_CFG_7_1 = 12,
+	SKL_CH_CFG_4_CHANNEL = SKL_CH_CFG_7_1,
 	SKL_CH_CFG_INVALID
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0db1c7e2645..27fd331aefe5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12391,7 +12391,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 								(1ULL << size * 8) - 1);
 			}
 		}
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 824337ec36aa..4c39678c03ee 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -129,7 +129,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 
 static void fill_pool(void)
 {
-	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4b25d6fd01d..f3850c88cdda 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4961,8 +4961,10 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	} else {
 		skb = skb_clone(orig_skb, GFP_ATOMIC);
 
-		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
+		if (skb_orphan_frags_rx(skb, GFP_ATOMIC)) {
+			kfree_skb(skb);
 			return;
+		}
 	}
 	if (!skb)
 		return;
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index bf597acef8dc..03382c11c162 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -61,6 +61,8 @@ struct proto 	udplite_prot = {
 	.get_port	   = udp_v4_get_port,
 	.memory_allocated  = &udp_memory_allocated,
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp_sock),
 	.h.udp_table	   = &udplite_table,
 };
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index da46c4284676..49e31e4ae7b7 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -143,6 +143,8 @@ int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 			optlen = 1;
 			break;
 		default:
+			if (len < 2)
+				goto bad;
 			optlen = nh[offset + 1] + 2;
 			if (optlen > len)
 				goto bad;
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index b6482e04dad0..26199f743791 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -57,6 +57,8 @@ struct proto udplitev6_prot = {
 	.get_port	   = udp_v6_get_port,
 	.memory_allocated  = &udp_memory_allocated,
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp6_sock),
 	.h.udp_table	   = &udplite_table,
 };
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 133f1719bf1b..d1add537beaa 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -331,9 +331,12 @@ bool sctp_transport_pl_recv(struct sctp_transport *t)
 		t->pl.probe_size += SCTP_PL_BIG_STEP;
 	} else if (t->pl.state == SCTP_PL_SEARCH) {
 		if (!t->pl.probe_high) {
-			t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_BIG_STEP,
-					       SCTP_MAX_PLPMTU);
-			return false;
+			if (t->pl.probe_size < SCTP_MAX_PLPMTU) {
+				t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_BIG_STEP,
+						       SCTP_MAX_PLPMTU);
+				return false;
+			}
+			t->pl.probe_high = SCTP_MAX_PLPMTU;
 		}
 		t->pl.probe_size += SCTP_PL_MIN_STEP;
 		if (t->pl.probe_size >= t->pl.probe_high) {
@@ -348,7 +351,7 @@ bool sctp_transport_pl_recv(struct sctp_transport *t)
 	} else if (t->pl.state == SCTP_PL_COMPLETE && t->pl.raise_count == 30) {
 		/* Raise probe_size again after 30 * interval in Search Complete */
 		t->pl.state = SCTP_PL_SEARCH; /* Search Complete -> Search */
-		t->pl.probe_size += SCTP_PL_MIN_STEP;
+		t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_MIN_STEP, SCTP_MAX_PLPMTU);
 	}
 
 	return t->pl.state == SCTP_PL_COMPLETE;
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index b7e5032b61c9..bfd858577676 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
 int snd_hdac_keep_power_up(struct hdac_device *codec)
 {
 	if (!atomic_inc_not_zero(&codec->in_pm)) {
-		int ret = pm_runtime_get_if_in_use(&codec->dev);
+		int ret = pm_runtime_get_if_active(&codec->dev, true);
 		if (!ret)
 			return -1;
 		if (ret < 0)
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2646663e0342..fab7c329acbe 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1306,6 +1306,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ac0ccfd73f69..4ef66ebe4cac 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11274,6 +11274,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 35d148e60c33..4377e91733b8 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -743,6 +743,8 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
 	val = ucontrol->value.enumerated.item[0];
+	if (val >= e->items)
+		return -EINVAL;
 
 	switch (e->reg) {
 	case CDC_TX_INP_MUX_ADC_MUX0_CFG0:
@@ -769,6 +771,9 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 	case CDC_TX_INP_MUX_ADC_MUX7_CFG0:
 		mic_sel_reg = CDC_TX7_TX_PATH_CFG0;
 		break;
+	default:
+		dev_err(component->dev, "Error in configuration!!\n");
+		return -EINVAL;
 	}
 
 	if (val != 0) {
diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 3d2d7c9ce66d..efb014051245 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -268,7 +268,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5682_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5682", rt5682);
-		if (ret)
+		if (!ret)
+			rt5682->irq = i2c->irq;
+		else
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 	}
 
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 8a9e1a4fa03e..468ce5b22156 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2951,6 +2951,9 @@ static int rt5682_suspend(struct snd_soc_component *component)
 	if (rt5682->is_sdw)
 		return 0;
 
+	if (rt5682->irq)
+		disable_irq(rt5682->irq);
+
 	cancel_delayed_work_sync(&rt5682->jack_detect_work);
 	cancel_delayed_work_sync(&rt5682->jd_check_work);
 	if (rt5682->hs_jack && (rt5682->jack_type & SND_JACK_HEADSET) == SND_JACK_HEADSET) {
@@ -3019,6 +3022,9 @@ static int rt5682_resume(struct snd_soc_component *component)
 	mod_delayed_work(system_power_efficient_wq,
 		&rt5682->jack_detect_work, msecs_to_jiffies(0));
 
+	if (rt5682->irq)
+		enable_irq(rt5682->irq);
+
 	return 0;
 }
 #else
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 52ff0d9c36c5..5fd798eac40d 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1462,6 +1462,7 @@ struct rt5682_priv {
 	int pll_out[RT5682_PLLS];
 
 	int jack_type;
+	int irq;
 	int irq_work_delay_time;
 };
 
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index be675002f918..93798c8c5d54 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -22,6 +22,7 @@
 #include <linux/falloc.h>
 #include <fcntl.h>
 #include <linux/memfd.h>
+#include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index c64b0b121762..6b7c255da5c2 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -68,7 +68,7 @@ setup()
 cleanup()
 {
 	$IP link del dev dummy0 &> /dev/null
-	ip netns del ns1
+	ip netns del ns1 &> /dev/null
 	ip netns del ns2 &> /dev/null
 }
 
