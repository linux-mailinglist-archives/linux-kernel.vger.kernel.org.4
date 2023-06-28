Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B40740DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF1JsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjF1J0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D451530E4;
        Wed, 28 Jun 2023 02:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB6F61295;
        Wed, 28 Jun 2023 09:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BAEC433C9;
        Wed, 28 Jun 2023 09:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944348;
        bh=+bRLO9bQkMPY01k/KZerCIyNHFY1n4iW3ZGM826euyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLoduHikIkQtfFprpOtzkWOJj7WtrHhY4yQMddiyQwqUQiOSXNTS+xQNZ+R9q3/qu
         Zb0oX+jo9qvZFv6ay368IzFn1ArNurUrNSy+N1RygEcm9rgUJo/2gz63ssDN53AqDB
         FQSw78q+2yo+5hNZlPyvFBx8NvF+v3Bnrz8WwitM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.249
Date:   Wed, 28 Jun 2023 11:25:34 +0200
Message-ID: <2023062834-steep-grievance-80d2@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023062833-charity-tutu-d5f8@gregkh>
References: <2023062833-charity-tutu-d5f8@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 100787c4e6bd..26a05e73de78 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 248
+SUBLEVEL = 249
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index e86d4795e024..e542a9f59e93 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -527,7 +527,7 @@
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <31 0>;
-		pendown-gpio = <&gpio1 31 0>;
+		pendown-gpio = <&gpio1 31 GPIO_ACTIVE_LOW>;
 
 
 		ti,x-min = /bits/ 16 <0x0>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index c4ef74fea97c..ee90ea09e781 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -156,7 +156,7 @@
 					compatible = "ti,ads7843";
 					interrupts-extended = <&pioC 2 IRQ_TYPE_EDGE_BOTH>;
 					spi-max-frequency = <3000000>;
-					pendown-gpio = <&pioC 2 GPIO_ACTIVE_HIGH>;
+					pendown-gpio = <&pioC 2 GPIO_ACTIVE_LOW>;
 
 					ti,x-min = /bits/ 16 <150>;
 					ti,x-max = /bits/ 16 <3830>;
diff --git a/arch/arm/boot/dts/imx7d-pico-hobbit.dts b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
index d917dc4f2f22..6ad39dca7009 100644
--- a/arch/arm/boot/dts/imx7d-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
@@ -64,7 +64,7 @@
 		interrupt-parent = <&gpio2>;
 		interrupts = <7 0>;
 		spi-max-frequency = <1000000>;
-		pendown-gpio = <&gpio2 7 0>;
+		pendown-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&reg_3p3v>;
 		ti,x-min = /bits/ 16 <0>;
 		ti,x-max = /bits/ 16 <4095>;
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 363d1f57a608..88e62801b82e 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -176,7 +176,7 @@
 		pinctrl-0 = <&pinctrl_tsc2046_pendown>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <29 0>;
-		pendown-gpio = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;
 		touchscreen-max-pressure = <255>;
 		wakeup-source;
 	};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index cdb632df152a..11ae18944195 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -227,7 +227,7 @@
 
 		interrupt-parent = <&gpio2>;
 		interrupts = <25 0>;		/* gpio_57 */
-		pendown-gpio = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio2 25 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index 3decc2d78a6c..a7f99ae0c1fe 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -54,7 +54,7 @@
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <27 0>;		/* gpio_27 */
-		pendown-gpio = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index c22833d4e568..fba69b3f79c2 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -311,7 +311,7 @@
 		interrupt-parent = <&gpio1>;
 		interrupts = <8 0>;   /* boot6 / gpio_8 */
 		spi-max-frequency = <1000000>;
-		pendown-gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&reg_vcc3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tsc2048_pins>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index 185ce53de0ec..0523a369a4d7 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -149,7 +149,7 @@
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
index 7fe0f9148232..d340eb722f12 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -160,7 +160,7 @@
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 150d5be42d27..4ea5656825de 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -651,7 +651,7 @@
 		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <30 IRQ_TYPE_NONE>;	/* GPIO_94 */
-		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&vaux4>;
 
 		ti,x-min = /bits/ 16 <0>;
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index e78d3718f145..d38781025eef 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -354,7 +354,7 @@
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <15 0>;			/* gpio1_wk15 */
-		pendown-gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 15 GPIO_ACTIVE_LOW>;
 
 
 		ti,x-min = /bits/ 16 <0x0>;
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5b3bdad66b27..1ff93878c813 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -102,8 +102,14 @@
 #define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
+#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
+#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
+#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
 
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 032a00e5d9fa..76c80e191a1b 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -97,7 +97,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index dc6182eecefa..a37c2873fdb5 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -182,11 +182,11 @@ static void __meminit init_trampoline_pud(void)
 		set_p4d(p4d_tramp,
 			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
 	} else {
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }
 
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 969d2b2eb7d7..8309e230aeed 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index fcee33a43aca..2df04de7f435 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1332,7 +1332,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 	/* Let the runqueue know that there is work to do. */
 	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
 
-	if (runqueue_node->async)
+	if (req->async)
 		goto out;
 
 	wait_for_completion(&runqueue_node->complete);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 65b891cb9c50..d882a22dfd6e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -483,8 +483,6 @@ static int vidi_remove(struct platform_device *pdev)
 	if (ctx->raw_edid != (struct edid *)fake_edid_info) {
 		kfree(ctx->raw_edid);
 		ctx->raw_edid = NULL;
-
-		return -EINVAL;
 	}
 
 	component_del(&pdev->dev, &vidi_component_ops);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index b2b076606f54..e164b3c7a234 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -384,7 +384,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -397,13 +396,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put_unlocked(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a93070f5b214..36cb456709ed 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2419,8 +2419,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
+		if (error) {
+			hid_err(hdev, "hw open failed\n");
+			goto fail_quirks;
+		}
+	}
 
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3adf4fae452a..3eb27f33e1fb 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -802,11 +802,22 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+			/*
+			 * In a CoCo VM the synic_message_page is not allocated
+			 * in hv_synic_alloc(). Instead it is set/cleared in
+			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * such that it is set only when the CPU is online. If
+			 * not all present CPUs are online, the message page
+			 * might be NULL, so skip such CPUs.
+			 */
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -840,11 +851,14 @@ static void vmbus_wait_for_unload(void)
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 4fac2591b661..89faef6f013b 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -206,8 +206,8 @@ static void lpi2c_imx_stop(struct lpi2c_imx_struct *lpi2c_imx)
 /* CLKLO = I2C_CLK_RATIO * CLKHI, SETHOLD = CLKHI, DATAVD = CLKHI/2 */
 static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	u8 prescale, filt, sethold, clkhi, clklo, datavd;
-	unsigned int clk_rate, clk_cycle;
+	u8 prescale, filt, sethold, datavd;
+	unsigned int clk_rate, clk_cycle, clkhi, clklo;
 	enum lpi2c_imx_pincfg pincfg;
 	unsigned int temp;
 
diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index c665f7d20c44..4c1770b8128c 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -1077,7 +1077,8 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	mutex_lock(&adap->lock);
 	dprintk(2, "%s: %*ph\n", __func__, msg->len, msg->msg);
 
-	adap->last_initiator = 0xff;
+	if (!adap->transmit_in_progress)
+		adap->last_initiator = 0xff;
 
 	/* Check if this message was for us (directed or broadcast). */
 	if (!cec_msg_is_broadcast(msg))
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 454301149a8f..31b299ced3c1 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -37,6 +37,7 @@
 #include <media/tuner.h>
 
 static DEFINE_MUTEX(dvbdev_mutex);
+static LIST_HEAD(dvbdevfops_list);
 static int dvbdev_debug;
 
 module_param(dvbdev_debug, int, 0644);
@@ -462,14 +463,15 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			enum dvb_device_type type, int demux_sink_pads)
 {
 	struct dvb_device *dvbdev;
-	struct file_operations *dvbdevfops;
+	struct file_operations *dvbdevfops = NULL;
+	struct dvbdevfops_node *node = NULL, *new_node = NULL;
 	struct device *clsdev;
 	int minor;
 	int id, ret;
 
 	mutex_lock(&dvbdev_register_lock);
 
-	if ((id = dvbdev_get_free_id (adap, type)) < 0){
+	if ((id = dvbdev_get_free_id (adap, type)) < 0) {
 		mutex_unlock(&dvbdev_register_lock);
 		*pdvbdev = NULL;
 		pr_err("%s: couldn't find free device id\n", __func__);
@@ -477,18 +479,45 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	*pdvbdev = dvbdev = kzalloc(sizeof(*dvbdev), GFP_KERNEL);
-
 	if (!dvbdev){
 		mutex_unlock(&dvbdev_register_lock);
 		return -ENOMEM;
 	}
 
-	dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+	/*
+	 * When a device of the same type is probe()d more than once,
+	 * the first allocated fops are used. This prevents memory leaks
+	 * that can occur when the same device is probe()d repeatedly.
+	 */
+	list_for_each_entry(node, &dvbdevfops_list, list_head) {
+		if (node->fops->owner == adap->module &&
+				node->type == type &&
+				node->template == template) {
+			dvbdevfops = node->fops;
+			break;
+		}
+	}
 
-	if (!dvbdevfops){
-		kfree (dvbdev);
-		mutex_unlock(&dvbdev_register_lock);
-		return -ENOMEM;
+	if (dvbdevfops == NULL) {
+		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+		if (!dvbdevfops) {
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node = kzalloc(sizeof(struct dvbdevfops_node), GFP_KERNEL);
+		if (!new_node) {
+			kfree(dvbdevfops);
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node->fops = dvbdevfops;
+		new_node->type = type;
+		new_node->template = template;
+		list_add_tail (&new_node->list_head, &dvbdevfops_list);
 	}
 
 	memcpy(dvbdev, template, sizeof(struct dvb_device));
@@ -499,19 +528,20 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	dvbdev->priv = priv;
 	dvbdev->fops = dvbdevfops;
 	init_waitqueue_head (&dvbdev->wait_queue);
-
 	dvbdevfops->owner = adap->module;
-
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
-
 	down_write(&minor_rwsem);
 #ifdef CONFIG_DVB_DYNAMIC_MINORS
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
 		if (dvb_minors[minor] == NULL)
 			break;
-
 	if (minor == MAX_DVB_MINORS) {
-		kfree(dvbdevfops);
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
+		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
@@ -520,36 +550,47 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 #else
 	minor = nums2minor(adap->num, type, id);
 #endif
-
 	dvbdev->minor = minor;
 	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
-
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
 		pr_err("%s: dvb_register_media_device failed to create the mediagraph\n",
 		      __func__);
-
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		dvb_media_device_free(dvbdev);
-		kfree(dvbdevfops);
+		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
 
-	mutex_unlock(&dvbdev_register_lock);
-
 	clsdev = device_create(dvb_class, adap->device,
 			       MKDEV(DVB_MAJOR, minor),
 			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
+		dvb_media_device_free(dvbdev);
+		list_del (&dvbdev->list_head);
+		kfree(dvbdev);
+		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
+	mutex_unlock(&dvbdev_register_lock);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_register_device);
@@ -578,7 +619,6 @@ static void dvb_free_device(struct kref *ref)
 {
 	struct dvb_device *dvbdev = container_of(ref, struct dvb_device, ref);
 
-	kfree (dvbdev->fops);
 	kfree (dvbdev);
 }
 
@@ -1084,9 +1124,17 @@ static int __init init_dvbdev(void)
 
 static void __exit exit_dvbdev(void)
 {
+	struct dvbdevfops_node *node, *next;
+
 	class_destroy(dvb_class);
 	cdev_del(&dvb_device_cdev);
 	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
+
+	list_for_each_entry_safe(node, next, &dvbdevfops_list, list_head) {
+		list_del (&node->list_head);
+		kfree(node->fops);
+		kfree(node);
+	}
 }
 
 subsys_initcall(init_dvbdev);
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 95a8ba4cf3da..35bdca9384d5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -973,11 +973,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
-		if (meson_mmc_bounce_buf_read(data) ||
-		    meson_mmc_get_next_command(cmd))
-			ret = IRQ_WAKE_THREAD;
-		else
-			ret = IRQ_HANDLED;
+
+		return IRQ_WAKE_THREAD;
 	}
 
 out:
@@ -989,9 +986,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		writel(start, host->regs + SD_EMMC_START);
 	}
 
-	if (ret == IRQ_HANDLED)
-		meson_mmc_request_done(host->mmc, cmd->mrq);
-
 	return ret;
 }
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 1254a5650cff..2673890c7690 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2249,7 +2249,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		ret = -EINVAL;
+		ret = host->irq;
 		goto host_free;
 	}
 
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 74a0a7fbbf7f..0dfcf7bea9ff 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -696,17 +696,15 @@ static int mvsd_probe(struct platform_device *pdev)
 	struct mmc_host *mmc = NULL;
 	struct mvsd_host *host = NULL;
 	const struct mbus_dram_target_info *dram;
-	struct resource *r;
 	int ret, irq;
 
 	if (!np) {
 		dev_err(&pdev->dev, "no DT node\n");
 		return -ENODEV;
 	}
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (!r || irq < 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
 	if (!mmc) {
@@ -758,7 +756,7 @@ static int mvsd_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
-	host->base = devm_ioremap_resource(&pdev->dev, r);
+	host->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->base)) {
 		ret = PTR_ERR(host->base);
 		goto out;
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index d74e73c95fdf..80574040d8fb 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1344,7 +1344,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->virt_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ee9edf817a32..aef2253ed5c8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1843,9 +1843,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (res == NULL || irq < 0)
+	if (!res)
 		return -ENXIO;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 0dc8eafdc81d..a02f3538d561 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -835,7 +835,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		err = -EINVAL;
+		err = host->irq;
 		goto err_free;
 	}
 
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 98c575de43c7..ed18c233c786 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1395,7 +1395,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq_optional(pdev, 1);
 	if (irq[0] < 0)
-		return -ENXIO;
+		return irq[0];
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, res);
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 96b0f81a2032..56d131183c1e 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1743,8 +1743,10 @@ static int usdhi6_probe(struct platform_device *pdev)
 	irq_cd = platform_get_irq_byname(pdev, "card detect");
 	irq_sd = platform_get_irq_byname(pdev, "data");
 	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
-	if (irq_sd < 0 || irq_sdio < 0)
-		return -ENODEV;
+	if (irq_sd < 0)
+		return irq_sd;
+	if (irq_sdio < 0)
+		return irq_sdio;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
 	if (!mmc)
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index baa994b7f78b..935004f5f5fe 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -644,7 +644,7 @@ mt7530_cpu_port_enable(struct mt7530_priv *priv,
 	mt7530_rmw(priv, MT7530_MFC, UNM_FFP_MASK, UNM_FFP(BIT(port)));
 
 	/* Set CPU port number */
-	if (priv->id == ID_MT7621)
+	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
 
 	/* CPU port gets connected to all user ports of
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 552877590a8a..f1cce7636722 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1137,8 +1137,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	eth_hdr_len = ntohs(skb->protocol) == ETH_P_8021Q ?
 						VLAN_ETH_HLEN : ETH_HLEN;
 	if (skb->len <= 60 &&
-	    (lancer_chip(adapter) || skb_vlan_tag_present(skb)) &&
-	    is_ipv4_pkt(skb)) {
+	    (lancer_chip(adapter) || BE3_chip(adapter) ||
+	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
 		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
 	}
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 15591ad5fe4e..db6817de24a1 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -574,8 +574,7 @@ qcaspi_spi_thread(void *data)
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if ((qca->intr_req == qca->intr_svc) &&
-		    (qca->txr.skb[qca->txr.head] == NULL) &&
-		    (qca->sync == QCASPI_SYNC_READY))
+		    !qca->txr.skb[qca->txr.head])
 			schedule();
 
 		set_current_state(TASK_RUNNING);
diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1d181eff0c29..4028cbe275d6 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -522,7 +522,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 {
 	struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
-	struct hwsim_edge_info *einfo;
+	struct hwsim_edge_info *einfo, *einfo_old;
 	struct hwsim_phy *phy_v0;
 	struct hwsim_edge *e;
 	u32 v0, v1;
@@ -560,8 +560,10 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	list_for_each_entry_rcu(e, &phy_v0->edges, list) {
 		if (e->endpoint->idx == v1) {
 			einfo->lqi = lqi;
-			rcu_assign_pointer(e->info, einfo);
+			einfo_old = rcu_replace_pointer(e->info, einfo,
+							lockdep_is_held(&hwsim_phys_lock));
 			rcu_read_unlock();
+			kfree_rcu(einfo_old, rcu);
 			mutex_unlock(&hwsim_phys_lock);
 			return 0;
 		}
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index c7d91415a436..1375beb3cf83 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -476,7 +476,7 @@ static int dp83867_phy_reset(struct phy_device *phydev)
 {
 	int err;
 
-	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESTART);
+	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESET);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index dd27c85190d3..b42d386350b7 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -336,10 +336,6 @@ static struct dentry *nfcsim_debugfs_root;
 static void nfcsim_debugfs_init(void)
 {
 	nfcsim_debugfs_root = debugfs_create_dir("nfcsim", NULL);
-
-	if (!nfcsim_debugfs_root)
-		pr_err("Could not create debugfs entry\n");
-
 }
 
 static void nfcsim_debugfs_remove(void)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 3d48fa685aaa..f66f07b8eebd 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2739,6 +2739,24 @@ static int hv_pci_query_relations(struct hv_device *hdev)
 	if (!ret)
 		ret = wait_for_response(hdev, &comp);
 
+	/*
+	 * In the case of fast device addition/removal, it's possible that
+	 * vmbus_sendpacket() or wait_for_response() returns -ENODEV but we
+	 * already got a PCI_BUS_RELATIONS* message from the host and the
+	 * channel callback already scheduled a work to hbus->wq, which can be
+	 * running pci_devices_present_work() -> survey_child_resources() ->
+	 * complete(&hbus->survey_event), even after hv_pci_query_relations()
+	 * exits and the stack variable 'comp' is no longer valid; as a result,
+	 * a hang or a page fault may happen when the complete() calls
+	 * raw_spin_lock_irqsave(). Flush hbus->wq before we exit from
+	 * hv_pci_query_relations() to avoid the issues. Note: if 'ret' is
+	 * -ENODEV, there can't be any more work item scheduled to hbus->wq
+	 * after the flush_workqueue(): see vmbus_onoffer_rescind() ->
+	 * vmbus_reset_channel_cb(), vmbus_rescind_cleanup() ->
+	 * channel->rescind = true.
+	 */
+	flush_workqueue(hbus->wq);
+
 	return ret;
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 23e9227e60fd..d7ca75efb49f 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1385,6 +1385,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1417,7 +1418,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1479,6 +1480,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1512,6 +1514,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		if (cdev->private->flags.resuming) {
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index e32d93b92742..4017464a5909 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1053,6 +1053,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1122,7 +1123,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1139,9 +1139,11 @@ int iscsi_target_locate_portal(
 		 * Serialize access across the discovery struct iscsi_portal_group to
 		 * process login attempt.
 		 */
+		conn->tpg = iscsit_global->discovery_tpg;
 		if (iscsit_access_np(np, conn->tpg) < 0) {
 			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE);
+			conn->tpg = NULL;
 			ret = -1;
 			goto out;
 		}
diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index 362284057d30..a3d15c3fb82a 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -171,6 +171,9 @@ static int udc_pci_probe(
 		retval = -ENODEV;
 		goto err_probe;
 	}
+
+	udc = dev;
+
 	return 0;
 
 err_probe:
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index cf6cec59696c..cf9267cf42e7 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -22,67 +22,69 @@
 
 #include "dfs_cache.h"
 
-#define DFS_CACHE_HTABLE_SIZE 32
-#define DFS_CACHE_MAX_ENTRIES 64
+#define CACHE_HTABLE_SIZE 32
+#define CACHE_MAX_ENTRIES 64
 
 #define IS_INTERLINK_SET(v) ((v) & (DFSREF_REFERRAL_SERVER | \
 				    DFSREF_STORAGE_SERVER))
 
-struct dfs_cache_tgt {
-	char *t_name;
-	struct list_head t_list;
+struct cache_dfs_tgt {
+	char *name;
+	struct list_head list;
 };
 
-struct dfs_cache_entry {
-	struct hlist_node ce_hlist;
-	const char *ce_path;
-	int ce_ttl;
-	int ce_srvtype;
-	int ce_flags;
-	struct timespec64 ce_etime;
-	int ce_path_consumed;
-	int ce_numtgts;
-	struct list_head ce_tlist;
-	struct dfs_cache_tgt *ce_tgthint;
-	struct rcu_head ce_rcu;
+struct cache_entry {
+	struct hlist_node hlist;
+	const char *path;
+	int ttl;
+	int srvtype;
+	int flags;
+	struct timespec64 etime;
+	int path_consumed;
+	int numtgts;
+	struct list_head tlist;
+	struct cache_dfs_tgt *tgthint;
+	struct rcu_head rcu;
 };
 
-static struct kmem_cache *dfs_cache_slab __read_mostly;
-
-struct dfs_cache_vol_info {
-	char *vi_fullpath;
-	struct smb_vol vi_vol;
-	char *vi_mntdata;
-	struct list_head vi_list;
+struct vol_info {
+	char *fullpath;
+	spinlock_t smb_vol_lock;
+	struct smb_vol smb_vol;
+	char *mntdata;
+	struct list_head list;
+	struct list_head rlist;
+	struct kref refcnt;
 };
 
-struct dfs_cache {
-	struct mutex dc_lock;
-	struct nls_table *dc_nlsc;
-	struct list_head dc_vol_list;
-	int dc_ttl;
-	struct delayed_work dc_refresh;
-};
+static struct kmem_cache *cache_slab __read_mostly;
+static struct workqueue_struct *dfscache_wq __read_mostly;
+
+static int cache_ttl;
+static DEFINE_SPINLOCK(cache_ttl_lock);
 
-static struct dfs_cache dfs_cache;
+static struct nls_table *cache_nlsc;
 
 /*
  * Number of entries in the cache
  */
-static size_t dfs_cache_count;
+static size_t cache_count;
 
-static DEFINE_MUTEX(dfs_cache_list_lock);
-static struct hlist_head dfs_cache_htable[DFS_CACHE_HTABLE_SIZE];
+static struct hlist_head cache_htable[CACHE_HTABLE_SIZE];
+static DEFINE_MUTEX(list_lock);
+
+static LIST_HEAD(vol_list);
+static DEFINE_SPINLOCK(vol_list_lock);
 
 static void refresh_cache_worker(struct work_struct *work);
 
-static inline bool is_path_valid(const char *path)
-{
-	return path && (strchr(path + 1, '\\') || strchr(path + 1, '/'));
-}
+static DECLARE_DELAYED_WORK(refresh_task, refresh_cache_worker);
 
-static inline int get_normalized_path(const char *path, char **npath)
+static int get_normalized_path(const char *path, char **npath)
 {
+	if (!path || strlen(path) < 3 || (*path != '\\' && *path != '/'))
+		return -EINVAL;
+
 	if (*path == '\\') {
 		*npath = (char *)path;
 	} else {
@@ -100,42 +102,42 @@ static inline void free_normalized_path(const char *path, char *npath)
 		kfree(npath);
 }
 
-static inline bool cache_entry_expired(const struct dfs_cache_entry *ce)
+static inline bool cache_entry_expired(const struct cache_entry *ce)
 {
 	struct timespec64 ts;
 
 	ktime_get_coarse_real_ts64(&ts);
-	return timespec64_compare(&ts, &ce->ce_etime) >= 0;
+	return timespec64_compare(&ts, &ce->etime) >= 0;
 }
 
-static inline void free_tgts(struct dfs_cache_entry *ce)
+static inline void free_tgts(struct cache_entry *ce)
 {
-	struct dfs_cache_tgt *t, *n;
+	struct cache_dfs_tgt *t, *n;
 
-	list_for_each_entry_safe(t, n, &ce->ce_tlist, t_list) {
-		list_del(&t->t_list);
-		kfree(t->t_name);
+	list_for_each_entry_safe(t, n, &ce->tlist, list) {
+		list_del(&t->list);
+		kfree(t->name);
 		kfree(t);
 	}
 }
 
 static void free_cache_entry(struct rcu_head *rcu)
 {
-	struct dfs_cache_entry *ce = container_of(rcu, struct dfs_cache_entry,
-						  ce_rcu);
-	kmem_cache_free(dfs_cache_slab, ce);
+	struct cache_entry *ce = container_of(rcu, struct cache_entry, rcu);
+
+	kmem_cache_free(cache_slab, ce);
 }
 
-static inline void flush_cache_ent(struct dfs_cache_entry *ce)
+static inline void flush_cache_ent(struct cache_entry *ce)
 {
-	if (hlist_unhashed(&ce->ce_hlist))
+	if (hlist_unhashed(&ce->hlist))
 		return;
 
-	hlist_del_init_rcu(&ce->ce_hlist);
-	kfree_const(ce->ce_path);
+	hlist_del_init_rcu(&ce->hlist);
+	kfree(ce->path);
 	free_tgts(ce);
-	dfs_cache_count--;
-	call_rcu(&ce->ce_rcu, free_cache_entry);
+	cache_count--;
+	call_rcu(&ce->rcu, free_cache_entry);
 }
 
 static void flush_cache_ents(void)
@@ -143,11 +145,11 @@ static void flush_cache_ents(void)
 	int i;
 
 	rcu_read_lock();
-	for (i = 0; i < DFS_CACHE_HTABLE_SIZE; i++) {
-		struct hlist_head *l = &dfs_cache_htable[i];
-		struct dfs_cache_entry *ce;
+	for (i = 0; i < CACHE_HTABLE_SIZE; i++) {
+		struct hlist_head *l = &cache_htable[i];
+		struct cache_entry *ce;
 
-		hlist_for_each_entry_rcu(ce, l, ce_hlist)
+		hlist_for_each_entry_rcu(ce, l, hlist)
 			flush_cache_ent(ce);
 	}
 	rcu_read_unlock();
@@ -159,35 +161,35 @@ static void flush_cache_ents(void)
 static int dfscache_proc_show(struct seq_file *m, void *v)
 {
 	int bucket;
-	struct dfs_cache_entry *ce;
-	struct dfs_cache_tgt *t;
+	struct cache_entry *ce;
+	struct cache_dfs_tgt *t;
 
 	seq_puts(m, "DFS cache\n---------\n");
 
-	mutex_lock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
 
 	rcu_read_lock();
-	hash_for_each_rcu(dfs_cache_htable, bucket, ce, ce_hlist) {
+	hash_for_each_rcu(cache_htable, bucket, ce, hlist) {
 		seq_printf(m,
 			   "cache entry: path=%s,type=%s,ttl=%d,etime=%ld,"
 			   "interlink=%s,path_consumed=%d,expired=%s\n",
-			   ce->ce_path,
-			   ce->ce_srvtype == DFS_TYPE_ROOT ? "root" : "link",
-			   ce->ce_ttl, ce->ce_etime.tv_nsec,
-			   IS_INTERLINK_SET(ce->ce_flags) ? "yes" : "no",
-			   ce->ce_path_consumed,
+			   ce->path,
+			   ce->srvtype == DFS_TYPE_ROOT ? "root" : "link",
+			   ce->ttl, ce->etime.tv_nsec,
+			   IS_INTERLINK_SET(ce->flags) ? "yes" : "no",
+			   ce->path_consumed,
 			   cache_entry_expired(ce) ? "yes" : "no");
 
-		list_for_each_entry(t, &ce->ce_tlist, t_list) {
+		list_for_each_entry(t, &ce->tlist, list) {
 			seq_printf(m, "  %s%s\n",
-				   t->t_name,
-				   ce->ce_tgthint == t ? " (target hint)" : "");
+				   t->name,
+				   ce->tgthint == t ? " (target hint)" : "");
 		}
 
 	}
 	rcu_read_unlock();
 
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_unlock(&list_lock);
 	return 0;
 }
 
@@ -205,9 +207,9 @@ static ssize_t dfscache_proc_write(struct file *file, const char __user *buffer,
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clearing dfs cache");
-	mutex_lock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
 	flush_cache_ents();
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_unlock(&list_lock);
 
 	return count;
 }
@@ -226,25 +228,25 @@ const struct file_operations dfscache_proc_fops = {
 };
 
 #ifdef CONFIG_CIFS_DEBUG2
-static inline void dump_tgts(const struct dfs_cache_entry *ce)
+static inline void dump_tgts(const struct cache_entry *ce)
 {
-	struct dfs_cache_tgt *t;
+	struct cache_dfs_tgt *t;
 
 	cifs_dbg(FYI, "target list:\n");
-	list_for_each_entry(t, &ce->ce_tlist, t_list) {
-		cifs_dbg(FYI, "  %s%s\n", t->t_name,
-			 ce->ce_tgthint == t ? " (target hint)" : "");
+	list_for_each_entry(t, &ce->tlist, list) {
+		cifs_dbg(FYI, "  %s%s\n", t->name,
+			 ce->tgthint == t ? " (target hint)" : "");
 	}
 }
 
-static inline void dump_ce(const struct dfs_cache_entry *ce)
+static inline void dump_ce(const struct cache_entry *ce)
 {
 	cifs_dbg(FYI, "cache entry: path=%s,type=%s,ttl=%d,etime=%ld,"
-		 "interlink=%s,path_consumed=%d,expired=%s\n", ce->ce_path,
-		 ce->ce_srvtype == DFS_TYPE_ROOT ? "root" : "link", ce->ce_ttl,
-		 ce->ce_etime.tv_nsec,
-		 IS_INTERLINK_SET(ce->ce_flags) ? "yes" : "no",
-		 ce->ce_path_consumed,
+		 "interlink=%s,path_consumed=%d,expired=%s\n", ce->path,
+		 ce->srvtype == DFS_TYPE_ROOT ? "root" : "link", ce->ttl,
+		 ce->etime.tv_nsec,
+		 IS_INTERLINK_SET(ce->flags) ? "yes" : "no",
+		 ce->path_consumed,
 		 cache_entry_expired(ce) ? "yes" : "no");
 	dump_tgts(ce);
 }
@@ -284,25 +286,33 @@ static inline void dump_refs(const struct dfs_info3_param *refs, int numrefs)
  */
 int dfs_cache_init(void)
 {
+	int rc;
 	int i;
 
-	dfs_cache_slab = kmem_cache_create("cifs_dfs_cache",
-					   sizeof(struct dfs_cache_entry), 0,
-					   SLAB_HWCACHE_ALIGN, NULL);
-	if (!dfs_cache_slab)
+	dfscache_wq = alloc_workqueue("cifs-dfscache",
+				      WQ_FREEZABLE | WQ_MEM_RECLAIM, 1);
+	if (!dfscache_wq)
 		return -ENOMEM;
 
-	for (i = 0; i < DFS_CACHE_HTABLE_SIZE; i++)
-		INIT_HLIST_HEAD(&dfs_cache_htable[i]);
+	cache_slab = kmem_cache_create("cifs_dfs_cache",
+				       sizeof(struct cache_entry), 0,
+				       SLAB_HWCACHE_ALIGN, NULL);
+	if (!cache_slab) {
+		rc = -ENOMEM;
+		goto out_destroy_wq;
+	}
 
-	INIT_LIST_HEAD(&dfs_cache.dc_vol_list);
-	mutex_init(&dfs_cache.dc_lock);
-	INIT_DELAYED_WORK(&dfs_cache.dc_refresh, refresh_cache_worker);
-	dfs_cache.dc_ttl = -1;
-	dfs_cache.dc_nlsc = load_nls_default();
+	for (i = 0; i < CACHE_HTABLE_SIZE; i++)
+		INIT_HLIST_HEAD(&cache_htable[i]);
+
+	cache_nlsc = load_nls_default();
 
 	cifs_dbg(FYI, "%s: initialized DFS referral cache\n", __func__);
 	return 0;
+
+out_destroy_wq:
+	destroy_workqueue(dfscache_wq);
+	return rc;
 }
 
 static inline unsigned int cache_entry_hash(const void *data, int size)
@@ -310,7 +320,7 @@ static inline unsigned int cache_entry_hash(const void *data, int size)
 	unsigned int h;
 
 	h = jhash(data, size, 0);
-	return h & (DFS_CACHE_HTABLE_SIZE - 1);
+	return h & (CACHE_HTABLE_SIZE - 1);
 }
 
 /* Check whether second path component of @path is SYSVOL or NETLOGON */
@@ -325,11 +335,11 @@ static inline bool is_sysvol_or_netlogon(const char *path)
 }
 
 /* Return target hint of a DFS cache entry */
-static inline char *get_tgt_name(const struct dfs_cache_entry *ce)
+static inline char *get_tgt_name(const struct cache_entry *ce)
 {
-	struct dfs_cache_tgt *t = ce->ce_tgthint;
+	struct cache_dfs_tgt *t = ce->tgthint;
 
-	return t ? t->t_name : ERR_PTR(-ENOENT);
+	return t ? t->name : ERR_PTR(-ENOENT);
 }
 
 /* Return expire time out of a new entry's TTL */
@@ -346,19 +356,19 @@ static inline struct timespec64 get_expire_time(int ttl)
 }
 
 /* Allocate a new DFS target */
-static inline struct dfs_cache_tgt *alloc_tgt(const char *name)
+static inline struct cache_dfs_tgt *alloc_tgt(const char *name)
 {
-	struct dfs_cache_tgt *t;
+	struct cache_dfs_tgt *t;
 
 	t = kmalloc(sizeof(*t), GFP_KERNEL);
 	if (!t)
 		return ERR_PTR(-ENOMEM);
-	t->t_name = kstrndup(name, strlen(name), GFP_KERNEL);
-	if (!t->t_name) {
+	t->name = kstrndup(name, strlen(name), GFP_KERNEL);
+	if (!t->name) {
 		kfree(t);
 		return ERR_PTR(-ENOMEM);
 	}
-	INIT_LIST_HEAD(&t->t_list);
+	INIT_LIST_HEAD(&t->list);
 	return t;
 }
 
@@ -367,63 +377,63 @@ static inline struct dfs_cache_tgt *alloc_tgt(const char *name)
  * target hint.
  */
 static int copy_ref_data(const struct dfs_info3_param *refs, int numrefs,
-			 struct dfs_cache_entry *ce, const char *tgthint)
+			 struct cache_entry *ce, const char *tgthint)
 {
 	int i;
 
-	ce->ce_ttl = refs[0].ttl;
-	ce->ce_etime = get_expire_time(ce->ce_ttl);
-	ce->ce_srvtype = refs[0].server_type;
-	ce->ce_flags = refs[0].ref_flag;
-	ce->ce_path_consumed = refs[0].path_consumed;
+	ce->ttl = refs[0].ttl;
+	ce->etime = get_expire_time(ce->ttl);
+	ce->srvtype = refs[0].server_type;
+	ce->flags = refs[0].ref_flag;
+	ce->path_consumed = refs[0].path_consumed;
 
 	for (i = 0; i < numrefs; i++) {
-		struct dfs_cache_tgt *t;
+		struct cache_dfs_tgt *t;
 
 		t = alloc_tgt(refs[i].node_name);
 		if (IS_ERR(t)) {
 			free_tgts(ce);
 			return PTR_ERR(t);
 		}
-		if (tgthint && !strcasecmp(t->t_name, tgthint)) {
-			list_add(&t->t_list, &ce->ce_tlist);
+		if (tgthint && !strcasecmp(t->name, tgthint)) {
+			list_add(&t->list, &ce->tlist);
 			tgthint = NULL;
 		} else {
-			list_add_tail(&t->t_list, &ce->ce_tlist);
+			list_add_tail(&t->list, &ce->tlist);
 		}
-		ce->ce_numtgts++;
+		ce->numtgts++;
 	}
 
-	ce->ce_tgthint = list_first_entry_or_null(&ce->ce_tlist,
-						  struct dfs_cache_tgt, t_list);
+	ce->tgthint = list_first_entry_or_null(&ce->tlist,
+					       struct cache_dfs_tgt, list);
 
 	return 0;
 }
 
 /* Allocate a new cache entry */
-static struct dfs_cache_entry *
-alloc_cache_entry(const char *path, const struct dfs_info3_param *refs,
-		  int numrefs)
+static struct cache_entry *alloc_cache_entry(const char *path,
+					     const struct dfs_info3_param *refs,
+					     int numrefs)
 {
-	struct dfs_cache_entry *ce;
+	struct cache_entry *ce;
 	int rc;
 
-	ce = kmem_cache_zalloc(dfs_cache_slab, GFP_KERNEL);
+	ce = kmem_cache_zalloc(cache_slab, GFP_KERNEL);
 	if (!ce)
 		return ERR_PTR(-ENOMEM);
 
-	ce->ce_path = kstrdup_const(path, GFP_KERNEL);
-	if (!ce->ce_path) {
-		kmem_cache_free(dfs_cache_slab, ce);
+	ce->path = kstrndup(path, strlen(path), GFP_KERNEL);
+	if (!ce->path) {
+		kmem_cache_free(cache_slab, ce);
 		return ERR_PTR(-ENOMEM);
 	}
-	INIT_HLIST_NODE(&ce->ce_hlist);
-	INIT_LIST_HEAD(&ce->ce_tlist);
+	INIT_HLIST_NODE(&ce->hlist);
+	INIT_LIST_HEAD(&ce->tlist);
 
 	rc = copy_ref_data(refs, numrefs, ce, NULL);
 	if (rc) {
-		kfree_const(ce->ce_path);
-		kmem_cache_free(dfs_cache_slab, ce);
+		kfree(ce->path);
+		kmem_cache_free(cache_slab, ce);
 		ce = ERR_PTR(rc);
 	}
 	return ce;
@@ -432,13 +442,13 @@ alloc_cache_entry(const char *path, const struct dfs_info3_param *refs,
 static void remove_oldest_entry(void)
 {
 	int bucket;
-	struct dfs_cache_entry *ce;
-	struct dfs_cache_entry *to_del = NULL;
+	struct cache_entry *ce;
+	struct cache_entry *to_del = NULL;
 
 	rcu_read_lock();
-	hash_for_each_rcu(dfs_cache_htable, bucket, ce, ce_hlist) {
-		if (!to_del || timespec64_compare(&ce->ce_etime,
-						  &to_del->ce_etime) < 0)
+	hash_for_each_rcu(cache_htable, bucket, ce, hlist) {
+		if (!to_del || timespec64_compare(&ce->etime,
+						  &to_del->etime) < 0)
 			to_del = ce;
 	}
 	if (!to_del) {
@@ -453,94 +463,96 @@ static void remove_oldest_entry(void)
 }
 
 /* Add a new DFS cache entry */
-static inline struct dfs_cache_entry *
+static inline struct cache_entry *
 add_cache_entry(unsigned int hash, const char *path,
 		const struct dfs_info3_param *refs, int numrefs)
 {
-	struct dfs_cache_entry *ce;
+	struct cache_entry *ce;
 
 	ce = alloc_cache_entry(path, refs, numrefs);
 	if (IS_ERR(ce))
 		return ce;
 
-	hlist_add_head_rcu(&ce->ce_hlist, &dfs_cache_htable[hash]);
+	hlist_add_head_rcu(&ce->hlist, &cache_htable[hash]);
 
-	mutex_lock(&dfs_cache.dc_lock);
-	if (dfs_cache.dc_ttl < 0) {
-		dfs_cache.dc_ttl = ce->ce_ttl;
-		queue_delayed_work(cifsiod_wq, &dfs_cache.dc_refresh,
-				   dfs_cache.dc_ttl * HZ);
+	spin_lock(&cache_ttl_lock);
+	if (!cache_ttl) {
+		cache_ttl = ce->ttl;
+		queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
 	} else {
-		dfs_cache.dc_ttl = min_t(int, dfs_cache.dc_ttl, ce->ce_ttl);
-		mod_delayed_work(cifsiod_wq, &dfs_cache.dc_refresh,
-				 dfs_cache.dc_ttl * HZ);
+		cache_ttl = min_t(int, cache_ttl, ce->ttl);
+		mod_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
 	}
-	mutex_unlock(&dfs_cache.dc_lock);
+	spin_unlock(&cache_ttl_lock);
 
 	return ce;
 }
 
-static struct dfs_cache_entry *__find_cache_entry(unsigned int hash,
-						  const char *path)
+/*
+ * Find a DFS cache entry in hash table and optionally check prefix path against
+ * @path.
+ * Use whole path components in the match.
+ * Return ERR_PTR(-ENOENT) if the entry is not found.
+ */
+static struct cache_entry *lookup_cache_entry(const char *path,
+					      unsigned int *hash)
 {
-	struct dfs_cache_entry *ce;
+	struct cache_entry *ce;
+	unsigned int h;
 	bool found = false;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(ce, &dfs_cache_htable[hash], ce_hlist) {
-		if (!strcasecmp(path, ce->ce_path)) {
-#ifdef CONFIG_CIFS_DEBUG2
-			char *name = get_tgt_name(ce);
+	h = cache_entry_hash(path, strlen(path));
 
-			if (IS_ERR(name)) {
-				rcu_read_unlock();
-				return ERR_CAST(name);
-			}
-			cifs_dbg(FYI, "%s: cache hit\n", __func__);
-			cifs_dbg(FYI, "%s: target hint: %s\n", __func__, name);
-#endif
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(ce, &cache_htable[h], hlist) {
+		if (!strcasecmp(path, ce->path)) {
 			found = true;
+			dump_ce(ce);
 			break;
 		}
 	}
 	rcu_read_unlock();
-	return found ? ce : ERR_PTR(-ENOENT);
-}
 
-/*
- * Find a DFS cache entry in hash table and optionally check prefix path against
- * @path.
- * Use whole path components in the match.
- * Return ERR_PTR(-ENOENT) if the entry is not found.
- */
-static inline struct dfs_cache_entry *find_cache_entry(const char *path,
-						       unsigned int *hash)
-{
-	*hash = cache_entry_hash(path, strlen(path));
-	return __find_cache_entry(*hash, path);
+	if (!found)
+		ce = ERR_PTR(-ENOENT);
+	if (hash)
+		*hash = h;
+
+	return ce;
 }
 
 static inline void destroy_slab_cache(void)
 {
 	rcu_barrier();
-	kmem_cache_destroy(dfs_cache_slab);
+	kmem_cache_destroy(cache_slab);
 }
 
-static inline void free_vol(struct dfs_cache_vol_info *vi)
+static void __vol_release(struct vol_info *vi)
 {
-	list_del(&vi->vi_list);
-	kfree(vi->vi_fullpath);
-	kfree(vi->vi_mntdata);
-	cifs_cleanup_volume_info_contents(&vi->vi_vol);
+	kfree(vi->fullpath);
+	kfree(vi->mntdata);
+	cifs_cleanup_volume_info_contents(&vi->smb_vol);
 	kfree(vi);
 }
 
+static void vol_release(struct kref *kref)
+{
+	struct vol_info *vi = container_of(kref, struct vol_info, refcnt);
+
+	spin_lock(&vol_list_lock);
+	list_del(&vi->list);
+	spin_unlock(&vol_list_lock);
+	__vol_release(vi);
+}
+
 static inline void free_vol_list(void)
 {
-	struct dfs_cache_vol_info *vi, *nvi;
+	struct vol_info *vi, *nvi;
 
-	list_for_each_entry_safe(vi, nvi, &dfs_cache.dc_vol_list, vi_list)
-		free_vol(vi);
+	list_for_each_entry_safe(vi, nvi, &vol_list, list) {
+		list_del_init(&vi->list);
+		__vol_release(vi);
+	}
 }
 
 /**
@@ -548,40 +560,38 @@ static inline void free_vol_list(void)
  */
 void dfs_cache_destroy(void)
 {
-	cancel_delayed_work_sync(&dfs_cache.dc_refresh);
-	unload_nls(dfs_cache.dc_nlsc);
+	cancel_delayed_work_sync(&refresh_task);
+	unload_nls(cache_nlsc);
 	free_vol_list();
-	mutex_destroy(&dfs_cache.dc_lock);
-
 	flush_cache_ents();
 	destroy_slab_cache();
-	mutex_destroy(&dfs_cache_list_lock);
+	destroy_workqueue(dfscache_wq);
 
 	cifs_dbg(FYI, "%s: destroyed DFS referral cache\n", __func__);
 }
 
-static inline struct dfs_cache_entry *
+static inline struct cache_entry *
 __update_cache_entry(const char *path, const struct dfs_info3_param *refs,
 		     int numrefs)
 {
 	int rc;
 	unsigned int h;
-	struct dfs_cache_entry *ce;
+	struct cache_entry *ce;
 	char *s, *th = NULL;
 
-	ce = find_cache_entry(path, &h);
+	ce = lookup_cache_entry(path, &h);
 	if (IS_ERR(ce))
 		return ce;
 
-	if (ce->ce_tgthint) {
-		s = ce->ce_tgthint->t_name;
+	if (ce->tgthint) {
+		s = ce->tgthint->name;
 		th = kstrndup(s, strlen(s), GFP_KERNEL);
 		if (!th)
 			return ERR_PTR(-ENOMEM);
 	}
 
 	free_tgts(ce);
-	ce->ce_numtgts = 0;
+	ce->numtgts = 0;
 
 	rc = copy_ref_data(refs, numrefs, ce, th);
 	kfree(th);
@@ -593,10 +603,10 @@ __update_cache_entry(const char *path, const struct dfs_info3_param *refs,
 }
 
 /* Update an expired cache entry by getting a new DFS referral from server */
-static struct dfs_cache_entry *
+static struct cache_entry *
 update_cache_entry(const unsigned int xid, struct cifs_ses *ses,
 		   const struct nls_table *nls_codepage, int remap,
-		   const char *path, struct dfs_cache_entry *ce)
+		   const char *path, struct cache_entry *ce)
 {
 	int rc;
 	struct dfs_info3_param *refs = NULL;
@@ -636,20 +646,20 @@ update_cache_entry(const unsigned int xid, struct cifs_ses *ses,
  * For interlinks, __cifs_dfs_mount() and expand_dfs_referral() are supposed to
  * handle them properly.
  */
-static struct dfs_cache_entry *
+static struct cache_entry *
 do_dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 		  const struct nls_table *nls_codepage, int remap,
 		  const char *path, bool noreq)
 {
 	int rc;
 	unsigned int h;
-	struct dfs_cache_entry *ce;
+	struct cache_entry *ce;
 	struct dfs_info3_param *nrefs;
 	int numnrefs;
 
 	cifs_dbg(FYI, "%s: search path: %s\n", __func__, path);
 
-	ce = find_cache_entry(path, &h);
+	ce = lookup_cache_entry(path, &h);
 	if (IS_ERR(ce)) {
 		cifs_dbg(FYI, "%s: cache miss\n", __func__);
 		/*
@@ -690,9 +700,9 @@ do_dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 
 		cifs_dbg(FYI, "%s: new cache entry\n", __func__);
 
-		if (dfs_cache_count >= DFS_CACHE_MAX_ENTRIES) {
+		if (cache_count >= CACHE_MAX_ENTRIES) {
 			cifs_dbg(FYI, "%s: reached max cache size (%d)",
-				 __func__, DFS_CACHE_MAX_ENTRIES);
+				 __func__, CACHE_MAX_ENTRIES);
 			remove_oldest_entry();
 		}
 		ce = add_cache_entry(h, path, nrefs, numnrefs);
@@ -701,7 +711,7 @@ do_dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 		if (IS_ERR(ce))
 			return ce;
 
-		dfs_cache_count++;
+		cache_count++;
 	}
 
 	dump_ce(ce);
@@ -723,7 +733,7 @@ do_dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 }
 
 /* Set up a new DFS referral from a given cache entry */
-static int setup_ref(const char *path, const struct dfs_cache_entry *ce,
+static int setup_ref(const char *path, const struct cache_entry *ce,
 		     struct dfs_info3_param *ref, const char *tgt)
 {
 	int rc;
@@ -736,7 +746,7 @@ static int setup_ref(const char *path, const struct dfs_cache_entry *ce,
 	if (!ref->path_name)
 		return -ENOMEM;
 
-	ref->path_consumed = ce->ce_path_consumed;
+	ref->path_consumed = ce->path_consumed;
 
 	ref->node_name = kstrndup(tgt, strlen(tgt), GFP_KERNEL);
 	if (!ref->node_name) {
@@ -744,9 +754,9 @@ static int setup_ref(const char *path, const struct dfs_cache_entry *ce,
 		goto err_free_path;
 	}
 
-	ref->ttl = ce->ce_ttl;
-	ref->server_type = ce->ce_srvtype;
-	ref->ref_flag = ce->ce_flags;
+	ref->ttl = ce->ttl;
+	ref->server_type = ce->srvtype;
+	ref->ref_flag = ce->flags;
 
 	return 0;
 
@@ -757,25 +767,25 @@ static int setup_ref(const char *path, const struct dfs_cache_entry *ce,
 }
 
 /* Return target list of a DFS cache entry */
-static int get_tgt_list(const struct dfs_cache_entry *ce,
+static int get_tgt_list(const struct cache_entry *ce,
 			struct dfs_cache_tgt_list *tl)
 {
 	int rc;
 	struct list_head *head = &tl->tl_list;
-	struct dfs_cache_tgt *t;
+	struct cache_dfs_tgt *t;
 	struct dfs_cache_tgt_iterator *it, *nit;
 
 	memset(tl, 0, sizeof(*tl));
 	INIT_LIST_HEAD(head);
 
-	list_for_each_entry(t, &ce->ce_tlist, t_list) {
+	list_for_each_entry(t, &ce->tlist, list) {
 		it = kzalloc(sizeof(*it), GFP_KERNEL);
 		if (!it) {
 			rc = -ENOMEM;
 			goto err_free_it;
 		}
 
-		it->it_name = kstrndup(t->t_name, strlen(t->t_name),
+		it->it_name = kstrndup(t->name, strlen(t->name),
 				       GFP_KERNEL);
 		if (!it->it_name) {
 			kfree(it);
@@ -783,12 +793,12 @@ static int get_tgt_list(const struct dfs_cache_entry *ce,
 			goto err_free_it;
 		}
 
-		if (ce->ce_tgthint == t)
+		if (ce->tgthint == t)
 			list_add(&it->it_list, head);
 		else
 			list_add_tail(&it->it_list, head);
 	}
-	tl->tl_numtgts = ce->ce_numtgts;
+	tl->tl_numtgts = ce->numtgts;
 
 	return 0;
 
@@ -829,16 +839,13 @@ int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 {
 	int rc;
 	char *npath;
-	struct dfs_cache_entry *ce;
-
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
+	struct cache_entry *ce;
 
 	rc = get_normalized_path(path, &npath);
 	if (rc)
 		return rc;
 
-	mutex_lock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
 	ce = do_dfs_cache_find(xid, ses, nls_codepage, remap, npath, false);
 	if (!IS_ERR(ce)) {
 		if (ref)
@@ -850,7 +857,7 @@ int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 	} else {
 		rc = PTR_ERR(ce);
 	}
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_unlock(&list_lock);
 	free_normalized_path(path, npath);
 	return rc;
 }
@@ -876,16 +883,13 @@ int dfs_cache_noreq_find(const char *path, struct dfs_info3_param *ref,
 {
 	int rc;
 	char *npath;
-	struct dfs_cache_entry *ce;
-
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
+	struct cache_entry *ce;
 
 	rc = get_normalized_path(path, &npath);
 	if (rc)
 		return rc;
 
-	mutex_lock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
 	ce = do_dfs_cache_find(0, NULL, NULL, 0, npath, true);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
@@ -899,7 +903,7 @@ int dfs_cache_noreq_find(const char *path, struct dfs_info3_param *ref,
 	if (!rc && tgt_list)
 		rc = get_tgt_list(ce, tgt_list);
 out:
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_unlock(&list_lock);
 	free_normalized_path(path, npath);
 	return rc;
 }
@@ -929,11 +933,8 @@ int dfs_cache_update_tgthint(const unsigned int xid, struct cifs_ses *ses,
 {
 	int rc;
 	char *npath;
-	struct dfs_cache_entry *ce;
-	struct dfs_cache_tgt *t;
-
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
+	struct cache_entry *ce;
+	struct cache_dfs_tgt *t;
 
 	rc = get_normalized_path(path, &npath);
 	if (rc)
@@ -941,7 +942,7 @@ int dfs_cache_update_tgthint(const unsigned int xid, struct cifs_ses *ses,
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, npath);
 
-	mutex_lock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
 	ce = do_dfs_cache_find(xid, ses, nls_codepage, remap, npath, false);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
@@ -950,14 +951,14 @@ int dfs_cache_update_tgthint(const unsigned int xid, struct cifs_ses *ses,
 
 	rc = 0;
 
-	t = ce->ce_tgthint;
+	t = ce->tgthint;
 
-	if (likely(!strcasecmp(it->it_name, t->t_name)))
+	if (likely(!strcasecmp(it->it_name, t->name)))
 		goto out;
 
-	list_for_each_entry(t, &ce->ce_tlist, t_list) {
-		if (!strcasecmp(t->t_name, it->it_name)) {
-			ce->ce_tgthint = t;
+	list_for_each_entry(t, &ce->tlist, list) {
+		if (!strcasecmp(t->name, it->it_name)) {
+			ce->tgthint = t;
 			cifs_dbg(FYI, "%s: new target hint: %s\n", __func__,
 				 it->it_name);
 			break;
@@ -965,7 +966,7 @@ int dfs_cache_update_tgthint(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 out:
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_unlock(&list_lock);
 	free_normalized_path(path, npath);
 	return rc;
 }
@@ -989,10 +990,10 @@ int dfs_cache_noreq_update_tgthint(const char *path,
 {
 	int rc;
 	char *npath;
-	struct dfs_cache_entry *ce;
-	struct dfs_cache_tgt *t;
+	struct cache_entry *ce;
+	struct cache_dfs_tgt *t;
 
-	if (unlikely(!is_path_valid(path)) || !it)
+	if (!it)
 		return -EINVAL;
 
 	rc = get_normalized_path(path, &npath);
@@ -1001,7 +1002,7 @@ int dfs_cache_noreq_update_tgthint(const char *path,
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, npath);
 
-	mutex_lock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
 
 	ce = do_dfs_cache_find(0, NULL, NULL, 0, npath, true);
 	if (IS_ERR(ce)) {
@@ -1011,14 +1012,14 @@ int dfs_cache_noreq_update_tgthint(const char *path,
 
 	rc = 0;
 
-	t = ce->ce_tgthint;
+	t = ce->tgthint;
 
-	if (unlikely(!strcasecmp(it->it_name, t->t_name)))
+	if (unlikely(!strcasecmp(it->it_name, t->name)))
 		goto out;
 
-	list_for_each_entry(t, &ce->ce_tlist, t_list) {
-		if (!strcasecmp(t->t_name, it->it_name)) {
-			ce->ce_tgthint = t;
+	list_for_each_entry(t, &ce->tlist, list) {
+		if (!strcasecmp(t->name, it->it_name)) {
+			ce->tgthint = t;
 			cifs_dbg(FYI, "%s: new target hint: %s\n", __func__,
 				 it->it_name);
 			break;
@@ -1026,7 +1027,7 @@ int dfs_cache_noreq_update_tgthint(const char *path,
 	}
 
 out:
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_unlock(&list_lock);
 	free_normalized_path(path, npath);
 	return rc;
 }
@@ -1047,13 +1048,11 @@ int dfs_cache_get_tgt_referral(const char *path,
 {
 	int rc;
 	char *npath;
-	struct dfs_cache_entry *ce;
+	struct cache_entry *ce;
 	unsigned int h;
 
 	if (!it || !ref)
 		return -EINVAL;
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
 
 	rc = get_normalized_path(path, &npath);
 	if (rc)
@@ -1061,9 +1060,9 @@ int dfs_cache_get_tgt_referral(const char *path,
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, npath);
 
-	mutex_lock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
 
-	ce = find_cache_entry(npath, &h);
+	ce = lookup_cache_entry(npath, &h);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
 		goto out;
@@ -1074,7 +1073,7 @@ int dfs_cache_get_tgt_referral(const char *path,
 	rc = setup_ref(path, ce, ref, it->it_name);
 
 out:
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_unlock(&list_lock);
 	free_normalized_path(path, npath);
 	return rc;
 }
@@ -1085,7 +1084,7 @@ static int dup_vol(struct smb_vol *vol, struct smb_vol *new)
 
 	if (vol->username) {
 		new->username = kstrndup(vol->username, strlen(vol->username),
-					GFP_KERNEL);
+					 GFP_KERNEL);
 		if (!new->username)
 			return -ENOMEM;
 	}
@@ -1103,7 +1102,7 @@ static int dup_vol(struct smb_vol *vol, struct smb_vol *new)
 	}
 	if (vol->domainname) {
 		new->domainname = kstrndup(vol->domainname,
-					  strlen(vol->domainname), GFP_KERNEL);
+					   strlen(vol->domainname), GFP_KERNEL);
 		if (!new->domainname)
 			goto err_free_unc;
 	}
@@ -1150,7 +1149,7 @@ static int dup_vol(struct smb_vol *vol, struct smb_vol *new)
 int dfs_cache_add_vol(char *mntdata, struct smb_vol *vol, const char *fullpath)
 {
 	int rc;
-	struct dfs_cache_vol_info *vi;
+	struct vol_info *vi;
 
 	if (!vol || !fullpath || !mntdata)
 		return -EINVAL;
@@ -1161,38 +1160,41 @@ int dfs_cache_add_vol(char *mntdata, struct smb_vol *vol, const char *fullpath)
 	if (!vi)
 		return -ENOMEM;
 
-	vi->vi_fullpath = kstrndup(fullpath, strlen(fullpath), GFP_KERNEL);
-	if (!vi->vi_fullpath) {
+	vi->fullpath = kstrndup(fullpath, strlen(fullpath), GFP_KERNEL);
+	if (!vi->fullpath) {
 		rc = -ENOMEM;
 		goto err_free_vi;
 	}
 
-	rc = dup_vol(vol, &vi->vi_vol);
+	rc = dup_vol(vol, &vi->smb_vol);
 	if (rc)
 		goto err_free_fullpath;
 
-	vi->vi_mntdata = mntdata;
+	vi->mntdata = mntdata;
+	spin_lock_init(&vi->smb_vol_lock);
+	kref_init(&vi->refcnt);
+
+	spin_lock(&vol_list_lock);
+	list_add_tail(&vi->list, &vol_list);
+	spin_unlock(&vol_list_lock);
 
-	mutex_lock(&dfs_cache.dc_lock);
-	list_add_tail(&vi->vi_list, &dfs_cache.dc_vol_list);
-	mutex_unlock(&dfs_cache.dc_lock);
 	return 0;
 
 err_free_fullpath:
-	kfree(vi->vi_fullpath);
+	kfree(vi->fullpath);
 err_free_vi:
 	kfree(vi);
 	return rc;
 }
 
-static inline struct dfs_cache_vol_info *find_vol(const char *fullpath)
+/* Must be called with vol_list_lock held */
+static struct vol_info *find_vol(const char *fullpath)
 {
-	struct dfs_cache_vol_info *vi;
+	struct vol_info *vi;
 
-	list_for_each_entry(vi, &dfs_cache.dc_vol_list, vi_list) {
-		cifs_dbg(FYI, "%s: vi->vi_fullpath: %s\n", __func__,
-			 vi->vi_fullpath);
-		if (!strcasecmp(vi->vi_fullpath, fullpath))
+	list_for_each_entry(vi, &vol_list, list) {
+		cifs_dbg(FYI, "%s: vi->fullpath: %s\n", __func__, vi->fullpath);
+		if (!strcasecmp(vi->fullpath, fullpath))
 			return vi;
 	}
 	return ERR_PTR(-ENOENT);
@@ -1208,30 +1210,31 @@ static inline struct dfs_cache_vol_info *find_vol(const char *fullpath)
  */
 int dfs_cache_update_vol(const char *fullpath, struct TCP_Server_Info *server)
 {
-	int rc;
-	struct dfs_cache_vol_info *vi;
+	struct vol_info *vi;
 
 	if (!fullpath || !server)
 		return -EINVAL;
 
 	cifs_dbg(FYI, "%s: fullpath: %s\n", __func__, fullpath);
 
-	mutex_lock(&dfs_cache.dc_lock);
-
+	spin_lock(&vol_list_lock);
 	vi = find_vol(fullpath);
 	if (IS_ERR(vi)) {
-		rc = PTR_ERR(vi);
-		goto out;
+		spin_unlock(&vol_list_lock);
+		return PTR_ERR(vi);
 	}
+	kref_get(&vi->refcnt);
+	spin_unlock(&vol_list_lock);
 
 	cifs_dbg(FYI, "%s: updating volume info\n", __func__);
-	memcpy(&vi->vi_vol.dstaddr, &server->dstaddr,
-	       sizeof(vi->vi_vol.dstaddr));
-	rc = 0;
+	spin_lock(&vi->smb_vol_lock);
+	memcpy(&vi->smb_vol.dstaddr, &server->dstaddr,
+	       sizeof(vi->smb_vol.dstaddr));
+	spin_unlock(&vi->smb_vol_lock);
 
-out:
-	mutex_unlock(&dfs_cache.dc_lock);
-	return rc;
+	kref_put(&vi->refcnt, vol_release);
+
+	return 0;
 }
 
 /**
@@ -1241,18 +1244,18 @@ int dfs_cache_update_vol(const char *fullpath, struct TCP_Server_Info *server)
  */
 void dfs_cache_del_vol(const char *fullpath)
 {
-	struct dfs_cache_vol_info *vi;
+	struct vol_info *vi;
 
 	if (!fullpath || !*fullpath)
 		return;
 
 	cifs_dbg(FYI, "%s: fullpath: %s\n", __func__, fullpath);
 
-	mutex_lock(&dfs_cache.dc_lock);
+	spin_lock(&vol_list_lock);
 	vi = find_vol(fullpath);
-	if (!IS_ERR(vi))
-		free_vol(vi);
-	mutex_unlock(&dfs_cache.dc_lock);
+	spin_unlock(&vol_list_lock);
+
+	kref_put(&vi->refcnt, vol_release);
 }
 
 /* Get all tcons that are within a DFS namespace and can be refreshed */
@@ -1280,7 +1283,7 @@ static void get_tcons(struct TCP_Server_Info *server, struct list_head *head)
 	spin_unlock(&cifs_tcp_ses_lock);
 }
 
-static inline bool is_dfs_link(const char *path)
+static bool is_dfs_link(const char *path)
 {
 	char *s;
 
@@ -1290,7 +1293,7 @@ static inline bool is_dfs_link(const char *path)
 	return !!strchr(s + 1, '\\');
 }
 
-static inline char *get_dfs_root(const char *path)
+static char *get_dfs_root(const char *path)
 {
 	char *s, *npath;
 
@@ -1309,9 +1312,34 @@ static inline char *get_dfs_root(const char *path)
 	return npath;
 }
 
+static inline void put_tcp_server(struct TCP_Server_Info *server)
+{
+	cifs_put_tcp_session(server, 0);
+}
+
+static struct TCP_Server_Info *get_tcp_server(struct smb_vol *vol)
+{
+	struct TCP_Server_Info *server;
+
+	server = cifs_find_tcp_session(vol);
+	if (IS_ERR_OR_NULL(server))
+		return NULL;
+
+	spin_lock(&GlobalMid_Lock);
+	if (server->tcpStatus != CifsGood) {
+		spin_unlock(&GlobalMid_Lock);
+		put_tcp_server(server);
+		return NULL;
+	}
+	spin_unlock(&GlobalMid_Lock);
+
+	return server;
+}
+
 /* Find root SMB session out of a DFS link path */
-static struct cifs_ses *find_root_ses(struct dfs_cache_vol_info *vi,
-				      struct cifs_tcon *tcon, const char *path)
+static struct cifs_ses *find_root_ses(struct vol_info *vi,
+				      struct cifs_tcon *tcon,
+				      const char *path)
 {
 	char *rpath;
 	int rc;
@@ -1333,8 +1361,7 @@ static struct cifs_ses *find_root_ses(struct dfs_cache_vol_info *vi,
 		goto out;
 	}
 
-	mdata = cifs_compose_mount_options(vi->vi_mntdata, rpath, &ref,
-					   &devname);
+	mdata = cifs_compose_mount_options(vi->mntdata, rpath, &ref, &devname);
 	free_dfs_info_param(&ref);
 
 	if (IS_ERR(mdata)) {
@@ -1351,13 +1378,8 @@ static struct cifs_ses *find_root_ses(struct dfs_cache_vol_info *vi,
 		goto out;
 	}
 
-	server = cifs_find_tcp_session(&vol);
-	if (IS_ERR_OR_NULL(server)) {
-		ses = ERR_PTR(-EHOSTDOWN);
-		goto out;
-	}
-	if (server->tcpStatus != CifsGood) {
-		cifs_put_tcp_session(server, 0);
+	server = get_tcp_server(&vol);
+	if (!server) {
 		ses = ERR_PTR(-EHOSTDOWN);
 		goto out;
 	}
@@ -1373,14 +1395,13 @@ static struct cifs_ses *find_root_ses(struct dfs_cache_vol_info *vi,
 }
 
 /* Refresh DFS cache entry from a given tcon */
-static void do_refresh_tcon(struct dfs_cache *dc, struct dfs_cache_vol_info *vi,
-			    struct cifs_tcon *tcon)
+static void refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
 {
 	int rc = 0;
 	unsigned int xid;
 	char *path, *npath;
 	unsigned int h;
-	struct dfs_cache_entry *ce;
+	struct cache_entry *ce;
 	struct dfs_info3_param *refs = NULL;
 	int numrefs = 0;
 	struct cifs_ses *root_ses = NULL, *ses;
@@ -1393,9 +1414,9 @@ static void do_refresh_tcon(struct dfs_cache *dc, struct dfs_cache_vol_info *vi,
 	if (rc)
 		goto out;
 
-	mutex_lock(&dfs_cache_list_lock);
-	ce = find_cache_entry(npath, &h);
-	mutex_unlock(&dfs_cache_list_lock);
+	mutex_lock(&list_lock);
+	ce = lookup_cache_entry(npath, &h);
+	mutex_unlock(&list_lock);
 
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
@@ -1421,12 +1442,12 @@ static void do_refresh_tcon(struct dfs_cache *dc, struct dfs_cache_vol_info *vi,
 		rc = -EOPNOTSUPP;
 	} else {
 		rc = ses->server->ops->get_dfs_refer(xid, ses, path, &refs,
-						     &numrefs, dc->dc_nlsc,
+						     &numrefs, cache_nlsc,
 						     tcon->remap);
 		if (!rc) {
-			mutex_lock(&dfs_cache_list_lock);
+			mutex_lock(&list_lock);
 			ce = __update_cache_entry(npath, refs, numrefs);
-			mutex_unlock(&dfs_cache_list_lock);
+			mutex_unlock(&list_lock);
 			dump_refs(refs, numrefs);
 			free_dfs_info_array(refs, numrefs);
 			if (IS_ERR(ce))
@@ -1448,30 +1469,52 @@ static void do_refresh_tcon(struct dfs_cache *dc, struct dfs_cache_vol_info *vi,
  */
 static void refresh_cache_worker(struct work_struct *work)
 {
-	struct dfs_cache *dc = container_of(work, struct dfs_cache,
-					    dc_refresh.work);
-	struct dfs_cache_vol_info *vi;
+	struct vol_info *vi, *nvi;
 	struct TCP_Server_Info *server;
-	LIST_HEAD(list);
+	LIST_HEAD(vols);
+	LIST_HEAD(tcons);
 	struct cifs_tcon *tcon, *ntcon;
 
-	mutex_lock(&dc->dc_lock);
-
-	list_for_each_entry(vi, &dc->dc_vol_list, vi_list) {
-		server = cifs_find_tcp_session(&vi->vi_vol);
-		if (IS_ERR_OR_NULL(server))
+	/*
+	 * Find SMB volumes that are eligible (server->tcpStatus == CifsGood)
+	 * for refreshing.
+	 */
+	spin_lock(&vol_list_lock);
+	list_for_each_entry(vi, &vol_list, list) {
+		server = get_tcp_server(&vi->smb_vol);
+		if (!server)
 			continue;
-		if (server->tcpStatus != CifsGood)
-			goto next;
-		get_tcons(server, &list);
-		list_for_each_entry_safe(tcon, ntcon, &list, ulist) {
-			do_refresh_tcon(dc, vi, tcon);
+
+		kref_get(&vi->refcnt);
+		list_add_tail(&vi->rlist, &vols);
+		put_tcp_server(server);
+	}
+	spin_unlock(&vol_list_lock);
+
+	/* Walk through all TCONs and refresh any expired cache entry */
+	list_for_each_entry_safe(vi, nvi, &vols, rlist) {
+		spin_lock(&vi->smb_vol_lock);
+		server = get_tcp_server(&vi->smb_vol);
+		spin_unlock(&vi->smb_vol_lock);
+
+		if (!server)
+			goto next_vol;
+
+		get_tcons(server, &tcons);
+		list_for_each_entry_safe(tcon, ntcon, &tcons, ulist) {
+			refresh_tcon(vi, tcon);
 			list_del_init(&tcon->ulist);
 			cifs_put_tcon(tcon);
 		}
-next:
-		cifs_put_tcp_session(server, 0);
+
+		put_tcp_server(server);
+
+next_vol:
+		list_del_init(&vi->rlist);
+		kref_put(&vi->refcnt, vol_release);
 	}
-	queue_delayed_work(cifsiod_wq, &dc->dc_refresh, dc->dc_ttl * HZ);
-	mutex_unlock(&dc->dc_lock);
+
+	spin_lock(&cache_ttl_lock);
+	queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
+	spin_unlock(&cache_ttl_lock);
 }
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 877f9f61a4e8..8c0e94183186 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1814,7 +1814,11 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
-	list_del_init(&wq_entry->entry);
+	/*
+	 * Pairs with list_empty_careful in ep_poll, and ensures future loop
+	 * iterations see the cause of this wakeup.
+	 */
+	list_del_init_careful(&wq_entry->entry);
 	return ret;
 }
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 98d21ad9a073..108e4528fccd 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -370,7 +370,15 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
+
+			/*
+			 * This page may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(page->mapping == mapping))
+				nilfs_clear_dirty_page(page, silent);
+
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 20c479b5e41b..e72466fc8ca9 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -101,6 +101,12 @@ int nilfs_segbuf_extend_segsum(struct nilfs_segment_buffer *segbuf)
 	if (unlikely(!bh))
 		return -ENOMEM;
 
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		memset(bh->b_data, 0, bh->b_size);
+		set_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 	nilfs_segbuf_add_segsum_buffer(segbuf, bh);
 	return 0;
 }
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 3091d1a3edde..d9e0b2b2b555 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -984,10 +984,13 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	unsigned int isz, srsz;
 
 	bh_sr = NILFS_LAST_SEGBUF(&sci->sc_segbufs)->sb_super_root;
+
+	lock_buffer(bh_sr);
 	raw_sr = (struct nilfs_super_root *)bh_sr->b_data;
 	isz = nilfs->ns_inode_size;
 	srsz = NILFS_SR_BYTES(isz);
 
+	raw_sr->sr_sum = 0;  /* Ensure initialization within this update */
 	raw_sr->sr_bytes = cpu_to_le16(srsz);
 	raw_sr->sr_nongc_ctime
 		= cpu_to_le64(nilfs_doing_gc() ?
@@ -1001,6 +1004,8 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1778,6 +1783,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1789,6 +1795,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 94cf515ec602..2263ebedf9d5 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -367,10 +367,31 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 		goto out;
 	}
 	nsbp = (void *)nsbh->b_data + offset;
-	memset(nsbp, 0, nilfs->ns_blocksize);
 
+	lock_buffer(nsbh);
 	if (sb2i >= 0) {
+		/*
+		 * The position of the second superblock only changes by 4KiB,
+		 * which is larger than the maximum superblock data size
+		 * (= 1KiB), so there is no need to use memmove() to allow
+		 * overlap between source and destination.
+		 */
 		memcpy(nsbp, nilfs->ns_sbp[sb2i], nilfs->ns_sbsize);
+
+		/*
+		 * Zero fill after copy to avoid overwriting in case of move
+		 * within the same block.
+		 */
+		memset(nsbh->b_data, 0, offset);
+		memset((void *)nsbp + nilfs->ns_sbsize, 0,
+		       nsbh->b_size - offset - nilfs->ns_sbsize);
+	} else {
+		memset(nsbh->b_data, 0, nsbh->b_size);
+	}
+	set_buffer_uptodate(nsbh);
+	unlock_buffer(nsbh);
+
+	if (sb2i >= 0) {
 		brelse(nilfs->ns_sbh[sb2i]);
 		nilfs->ns_sbh[sb2i] = nsbh;
 		nilfs->ns_sbp[sb2i] = nsbp;
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 24f626e7d012..d550a564645e 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -375,6 +375,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 				  100));
 }
 
+/**
+ * nilfs_max_segment_count - calculate the maximum number of segments
+ * @nilfs: nilfs object
+ */
+static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
+{
+	u64 max_count = U64_MAX;
+
+	do_div(max_count, nilfs->ns_blocks_per_segment);
+	return min_t(u64, max_count, ULONG_MAX);
+}
+
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 {
 	nilfs->ns_nsegments = nsegs;
@@ -384,6 +396,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_msg(nilfs->ns_sb, KERN_ERR,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -430,7 +444,35 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+			  "segment count %llu exceeds upper limit (%llu segments)",
+			  (unsigned long long)nsegments,
+			  (unsigned long long)nilfs_max_segment_count(nilfs));
+		return -EINVAL;
+	}
+
+	nblocks = (u64)i_size_read(nilfs->ns_sb->s_bdev->bd_inode) >>
+		nilfs->ns_sb->s_blocksize_bits;
+	if (nblocks) {
+		u64 min_block_count = nsegments * nilfs->ns_blocks_per_segment;
+		/*
+		 * To avoid failing to mount early device images without a
+		 * second superblock, exclude that block count from the
+		 * "min_block_count" calculation.
+		 */
+
+		if (nblocks < min_block_count) {
+			nilfs_msg(nilfs->ns_sb, KERN_ERR,
+				  "total number of segment blocks %llu exceeds device size (%llu blocks)",
+				  (unsigned long long)min_block_count,
+				  (unsigned long long)nblocks);
+			return -EINVAL;
+		}
+	}
+
+	nilfs_set_nsegments(nilfs, nsegments);
 	nilfs->ns_crc_seed = le32_to_cpu(sbp->s_crc_seed);
 	return 0;
 }
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 84f6c8628db5..d9b906d75dfa 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2783,6 +2783,16 @@ xlog_recover_buffer_pass2(
 	if (lsn && lsn != -1 && XFS_LSN_CMP(lsn, current_lsn) >= 0) {
 		trace_xfs_log_recover_buf_skip(log, buf_f);
 		xlog_recover_validate_buf_type(mp, bp, buf_f, NULLCOMMITLSN);
+
+		/*
+		 * We're skipping replay of this buffer log item due to the log
+		 * item LSN being behind the ondisk buffer.  Verify the buffer
+		 * contents since we aren't going to run the write verifier.
+		 */
+		if (bp->b_ops) {
+			bp->b_ops->verify_read(bp);
+			error = bp->b_error;
+		}
 		goto out_release;
 	}
 
diff --git a/include/linux/list.h b/include/linux/list.h
index ce19c6b632a5..231ff089f7d1 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -268,6 +268,24 @@ static inline int list_empty(const struct list_head *head)
 	return READ_ONCE(head->next) == head;
 }
 
+/**
+ * list_del_init_careful - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ *
+ * This is the same as list_del_init(), except designed to be used
+ * together with list_empty_careful() in a way to guarantee ordering
+ * of other memory operations.
+ *
+ * Any memory operations done before a list_del_init_careful() are
+ * guaranteed to be visible after a list_empty_careful() test.
+ */
+static inline void list_del_init_careful(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	entry->prev = entry;
+	smp_store_release(&entry->next, entry);
+}
+
 /**
  * list_empty_careful - tests whether a list is empty and not being modified
  * @head: the list to test
@@ -283,7 +301,7 @@ static inline int list_empty(const struct list_head *head)
  */
 static inline int list_empty_careful(const struct list_head *head)
 {
-	struct list_head *next = head->next;
+	struct list_head *next = smp_load_acquire(&head->next);
 	return (next == head) && (next == head->prev);
 }
 
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 09e6ac4b669b..c75b38ba4a72 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -384,6 +384,24 @@ do {									      \
 		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
 } while (0)
 
+/**
+ * rcu_replace_pointer() - replace an RCU pointer, returning its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
+ * @ptr: regular pointer
+ * @c: the lockdep conditions under which the dereference will take place
+ *
+ * Perform a replacement, where @rcu_ptr is an RCU-annotated
+ * pointer and @c is the lockdep argument that is passed to the
+ * rcu_dereference_protected() call used to read that pointer.  The old
+ * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
+ */
+#define rcu_replace_pointer(rcu_ptr, ptr, c)				\
+({									\
+	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
+	rcu_assign_pointer((rcu_ptr), (ptr));				\
+	__tmp;								\
+})
+
 /**
  * rcu_swap_protected() - swap an RCU and a regular pointer
  * @rcu_ptr: RCU pointer
diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
index 73c1df584a14..3745a13f6e08 100644
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -189,6 +189,21 @@ struct dvb_device {
 	void *priv;
 };
 
+/**
+ * struct dvbdevfops_node - fops nodes registered in dvbdevfops_list
+ *
+ * @fops:		Dynamically allocated fops for ->owner registration
+ * @type:		type of dvb_device
+ * @template:		dvb_device used for registration
+ * @list_head:		list_head for dvbdevfops_list
+ */
+struct dvbdevfops_node {
+	struct file_operations *fops;
+	enum dvb_device_type type;
+	const struct dvb_device *template;
+	struct list_head list_head;
+};
+
 /**
  * dvb_device_get - Increase dvb_device reference
  *
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6f75a84b47de..8d063e23aa40 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -374,9 +374,11 @@ static inline int ip_tunnel_encap(struct sk_buff *skb, struct ip_tunnel *t,
 static inline u8 ip_tunnel_get_dsfield(const struct iphdr *iph,
 				       const struct sk_buff *skb)
 {
-	if (skb->protocol == htons(ETH_P_IP))
+	__be16 payload_protocol = skb_protocol(skb, true);
+
+	if (payload_protocol == htons(ETH_P_IP))
 		return iph->tos;
-	else if (skb->protocol == htons(ETH_P_IPV6))
+	else if (payload_protocol == htons(ETH_P_IPV6))
 		return ipv6_get_dsfield((const struct ipv6hdr *)iph);
 	else
 		return 0;
@@ -385,9 +387,11 @@ static inline u8 ip_tunnel_get_dsfield(const struct iphdr *iph,
 static inline u8 ip_tunnel_get_ttl(const struct iphdr *iph,
 				       const struct sk_buff *skb)
 {
-	if (skb->protocol == htons(ETH_P_IP))
+	__be16 payload_protocol = skb_protocol(skb, true);
+
+	if (payload_protocol == htons(ETH_P_IP))
 		return iph->ttl;
-	else if (skb->protocol == htons(ETH_P_IPV6))
+	else if (payload_protocol == htons(ETH_P_IPV6))
 		return ((const struct ipv6hdr *)iph)->hop_limit;
 	else
 		return 0;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 011e8faa608b..b70c32e4a491 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_page_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
 					 NULL), 32);
-		__entry->ino = mapping ? mapping->host->i_ino : 0;
+		__entry->ino = (mapping && mapping->host) ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
 	),
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d14575c0e464..62a7a5075014 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1723,7 +1723,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -1767,7 +1767,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
@@ -1785,9 +1786,22 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+					 e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/*
+			 * all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration.
+			 * since the iterator is always advanced right away and
+			 * finished when it->cset_pos meets it->cset_head, so only
+			 * update it->cset_head is enough here.
+			 */
+			list_for_each_entry(it, &cset->task_iters, iters_node)
+				if (it->cset_head == &scgrp->e_csets[ss->id])
+					it->cset_head = &dcgrp->e_csets[ss->id];
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		/* default hierarchy doesn't enable controllers by default */
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 7d668b31dbc6..c76fe1d4d91e 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -384,7 +384,7 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
 	if (ret)
-		list_del_init(&wq_entry->entry);
+		list_del_init_careful(&wq_entry->entry);
 
 	return ret;
 }
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 2b7448ae5b47..e883d12dcb0d 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -216,19 +216,8 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			ktime_t next_p;
-			u32 rem;
-
 			tick_do_timer_cpu = cpu;
-
-			next_p = ktime_get();
-			div_u64_rem(next_p, TICK_NSEC, &rem);
-			if (rem) {
-				next_p -= rem;
-				next_p += TICK_NSEC;
-			}
-
-			tick_next_period = next_p;
+			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a70c611df137..5093cff93273 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -129,8 +129,19 @@ static ktime_t tick_init_jiffy_update(void)
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
-	if (last_jiffies_update == 0)
+	if (last_jiffies_update == 0) {
+		u32 rem;
+
+		/*
+		 * Ensure that the tick is aligned to a multiple of
+		 * TICK_NSEC.
+		 */
+		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
+		if (rem)
+			tick_next_period += TICK_NSEC - rem;
+
 		last_jiffies_update = tick_next_period;
+	}
 	period = last_jiffies_update;
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d068124815bc..219cd2c81936 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1931,10 +1931,12 @@ void tracing_reset_online_cpus(struct trace_buffer *buf)
 }
 
 /* Must have trace_types_lock held */
-void tracing_reset_all_online_cpus(void)
+void tracing_reset_all_online_cpus_unlocked(void)
 {
 	struct trace_array *tr;
 
+	lockdep_assert_held(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (!tr->clear_trace)
 			continue;
@@ -1946,6 +1948,13 @@ void tracing_reset_all_online_cpus(void)
 	}
 }
 
+void tracing_reset_all_online_cpus(void)
+{
+	mutex_lock(&trace_types_lock);
+	tracing_reset_all_online_cpus_unlocked();
+	mutex_unlock(&trace_types_lock);
+}
+
 /*
  * The tgid_map array maps from pid to tgid; i.e. the value stored at index i
  * is the tgid last observed corresponding to pid=i.
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f2ff39353e03..edc17a640ab3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -677,6 +677,7 @@ int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct trace_buffer *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
+void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 8f2cbc9ebb6e..a0675ecc8142 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2440,7 +2440,7 @@ static void trace_module_remove_events(struct module *mod)
 	 * over from this module may be passed to the new module events and
 	 * unexpected results may occur.
 	 */
-	tracing_reset_all_online_cpus();
+	tracing_reset_all_online_cpus_unlocked();
 }
 
 static int trace_module_notify(struct notifier_block *self,
diff --git a/mm/filemap.c b/mm/filemap.c
index c094103191a6..adc27af737c6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1046,6 +1046,7 @@ struct wait_page_queue {
 
 static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
 {
+	int ret;
 	struct wait_page_key *key = arg;
 	struct wait_page_queue *wait_page
 		= container_of(wait, struct wait_page_queue, wait);
@@ -1058,17 +1059,35 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 		return 0;
 
 	/*
-	 * Stop walking if it's locked.
-	 * Is this safe if put_and_wait_on_page_locked() is in use?
-	 * Yes: the waker must hold a reference to this page, and if PG_locked
-	 * has now already been set by another task, that task must also hold
-	 * a reference to the *same usage* of this page; so there is no need
-	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
+	 * If it's an exclusive wait, we get the bit for it, and
+	 * stop walking if we can't.
+	 *
+	 * If it's a non-exclusive wait, then the fact that this
+	 * wake function was called means that the bit already
+	 * was cleared, and we don't care if somebody then
+	 * re-took it.
 	 */
-	if (test_bit(key->bit_nr, &key->page->flags))
-		return -1;
+	ret = 0;
+	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
+		if (test_and_set_bit(key->bit_nr, &key->page->flags))
+			return -1;
+		ret = 1;
+	}
+	wait->flags |= WQ_FLAG_WOKEN;
 
-	return autoremove_wake_function(wait, mode, sync, key);
+	wake_up_state(wait->private, mode);
+
+	/*
+	 * Ok, we have successfully done what we're waiting for,
+	 * and we can unconditionally remove the wait entry.
+	 *
+	 * Note that this has to be the absolute last thing we do,
+	 * since after list_del_init(&wait->entry) the wait entry
+	 * might be de-allocated and the process might even have
+	 * exited.
+	 */
+	list_del_init_careful(&wait->entry);
+	return ret;
 }
 
 static void wake_up_page_bit(struct page *page, int bit_nr)
@@ -1147,16 +1166,31 @@ enum behavior {
 			 */
 };
 
+/*
+ * Attempt to check (or get) the page bit, and mark the
+ * waiter woken if successful.
+ */
+static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
+					struct wait_queue_entry *wait)
+{
+	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
+		if (test_and_set_bit(bit_nr, &page->flags))
+			return false;
+	} else if (test_bit(bit_nr, &page->flags))
+		return false;
+
+	wait->flags |= WQ_FLAG_WOKEN;
+	return true;
+}
+
 static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	struct page *page, int bit_nr, int state, enum behavior behavior)
 {
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
-	bool bit_is_set;
 	bool thrashing = false;
 	bool delayacct = false;
 	unsigned long pflags;
-	int ret = 0;
 
 	if (bit_nr == PG_locked &&
 	    !PageUptodate(page) && PageWorkingset(page)) {
@@ -1174,48 +1208,47 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	wait_page.page = page;
 	wait_page.bit_nr = bit_nr;
 
-	for (;;) {
-		spin_lock_irq(&q->lock);
+	/*
+	 * Do one last check whether we can get the
+	 * page bit synchronously.
+	 *
+	 * Do the SetPageWaiters() marking before that
+	 * to let any waker we _just_ missed know they
+	 * need to wake us up (otherwise they'll never
+	 * even go to the slow case that looks at the
+	 * page queue), and add ourselves to the wait
+	 * queue if we need to sleep.
+	 *
+	 * This part needs to be done under the queue
+	 * lock to avoid races.
+	 */
+	spin_lock_irq(&q->lock);
+	SetPageWaiters(page);
+	if (!trylock_page_bit_common(page, bit_nr, wait))
+		__add_wait_queue_entry_tail(q, wait);
+	spin_unlock_irq(&q->lock);
 
-		if (likely(list_empty(&wait->entry))) {
-			__add_wait_queue_entry_tail(q, wait);
-			SetPageWaiters(page);
-		}
+	/*
+	 * From now on, all the logic will be based on
+	 * the WQ_FLAG_WOKEN flag, and the and the page
+	 * bit testing (and setting) will be - or has
+	 * already been - done by the wake function.
+	 *
+	 * We can drop our reference to the page.
+	 */
+	if (behavior == DROP)
+		put_page(page);
 
+	for (;;) {
 		set_current_state(state);
 
-		spin_unlock_irq(&q->lock);
-
-		bit_is_set = test_bit(bit_nr, &page->flags);
-		if (behavior == DROP)
-			put_page(page);
-
-		if (likely(bit_is_set))
-			io_schedule();
-
-		if (behavior == EXCLUSIVE) {
-			if (!test_and_set_bit_lock(bit_nr, &page->flags))
-				break;
-		} else if (behavior == SHARED) {
-			if (!test_bit(bit_nr, &page->flags))
-				break;
-		}
-
-		if (signal_pending_state(state, current)) {
-			ret = -EINTR;
+		if (signal_pending_state(state, current))
 			break;
-		}
 
-		if (behavior == DROP) {
-			/*
-			 * We can no longer safely access page->flags:
-			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
-			 * there is a risk of waiting forever on a page reused
-			 * for something that keeps it locked indefinitely.
-			 * But best check for -EINTR above before breaking.
-			 */
+		if (wait->flags & WQ_FLAG_WOKEN)
 			break;
-		}
+
+		io_schedule();
 	}
 
 	finish_wait(q, wait);
@@ -1234,7 +1267,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * bother with signals either.
 	 */
 
-	return ret;
+	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
 void wait_on_page_bit(struct page *page, int bit_nr)
@@ -1355,11 +1388,19 @@ void end_page_writeback(struct page *page)
 		rotate_reclaimable_page(page);
 	}
 
+	/*
+	 * Writeback does not hold a page reference of its own, relying
+	 * on truncation to wait for the clearing of PG_writeback.
+	 * But here we must make sure that the page is not freed and
+	 * reused before the wake_up_page().
+	 */
+	get_page(page);
 	if (!test_clear_page_writeback(page))
 		BUG();
 
 	smp_mb__after_atomic();
 	wake_up_page(page, PG_writeback);
+	put_page(page);
 }
 EXPORT_SYMBOL(end_page_writeback);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2d658b208319..5cc892b26339 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2746,12 +2746,6 @@ int test_clear_page_writeback(struct page *page)
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
-	/*
-	 * NOTE: Page might be free now! Writeback doesn't hold a page
-	 * reference on its own, it relies on truncation to wait for
-	 * the clearing of PG_writeback. The below can only access
-	 * page state that is static across allocation cycles.
-	 */
 	if (ret) {
 		dec_lruvec_state(lruvec, NR_WRITEBACK);
 		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
@@ -2817,7 +2811,7 @@ EXPORT_SYMBOL(__test_set_page_writeback);
  */
 void wait_on_page_writeback(struct page *page)
 {
-	if (PageWriteback(page)) {
+	while (PageWriteback(page)) {
 		trace_wait_on_page_writeback(page, page_mapping(page));
 		wait_on_page_bit(page, PG_writeback);
 	}
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 8c0af30fb067..5cd219d7e746 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -283,6 +283,9 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 1c532638b2ad..e19c1844276f 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -314,6 +314,9 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index cefc39878b1a..43ef3e25ea7d 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1231,6 +1231,7 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->transport_header = skb->network_header;
 
 	skb_set_inner_ipproto(skb, next_protocol);
+	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));
 
 	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		bool check = false;
@@ -1379,6 +1380,7 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->transport_header = skb->network_header;
 
 	skb_set_inner_ipproto(skb, next_protocol);
+	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));
 
 	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		bool check = false;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 909076ef157e..914fbd9ecef9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4804,7 +4804,8 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
@@ -4987,7 +4988,9 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	set = nft_set_lookup(ctx.table, nla[NFTA_SET_ELEM_LIST_SET], genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 51e3953b414c..9dbaa5ce24e5 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -440,3 +440,4 @@ module_init(nfnl_osf_init);
 module_exit(nfnl_osf_fini);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index e1990baf3a3b..dc9485854002 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -71,4 +71,3 @@ MODULE_AUTHOR("Evgeniy Polyakov <zbr@ioremap.net>");
 MODULE_DESCRIPTION("Passive OS fingerprint matching.");
 MODULE_ALIAS("ipt_osf");
 MODULE_ALIAS("ip6t_osf");
-MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 1802f134aa40..69034c8cc3b8 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -969,6 +969,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
 	old_loss_model = q->loss_model;
@@ -977,7 +978,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
-			return ret;
+			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
@@ -1044,6 +1045,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
+unlock:
+	sch_tree_unlock(sch);
 	return ret;
 
 get_table_failure:
@@ -1053,7 +1056,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	 */
 	q->clg = old_clg;
 	q->loss_model = old_loss_model;
-	return ret;
+
+	goto unlock;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index a95fe3fff1db..9b22219a7693 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1896,6 +1896,30 @@ static const struct dmi_system_id nau8824_quirk_table[] = {
 		},
 		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
 	},
+	{
+		/* Positivo CW14Q01P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo K1424G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "K1424G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo N14ZP74G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "N14ZP74G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
 	{}
 };
 
