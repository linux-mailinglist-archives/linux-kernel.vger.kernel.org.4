Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0263226C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiKUMia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKUMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:38:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C700C11C28;
        Mon, 21 Nov 2022 04:38:15 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Cx7Ng1cXtjWxoJAA--.25294S3;
        Mon, 21 Nov 2022 20:38:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuAwcXtjXpkXAA--.61043S2;
        Mon, 21 Nov 2022 20:38:12 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v5 1/3] gpio: loongson2ef: move driver to original location
Date:   Mon, 21 Nov 2022 20:38:01 +0800
Message-Id: <20221121123803.3786-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuAwcXtjXpkXAA--.61043S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gw4DAry5Zw13Jry8WFyxuFg_yoWxKFyfpF
        1fAw4kGrW8WF4fCrZ5CFykurZ8JanxGr9F9F47ur1UuF9rZa4UZr1ktF95Jr4DXrZ8JayI
        9F9a9r12ka1jkwUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07j0zuAUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gpio driver doesn't cover CPU_LOONGSON64 platforms, because
of gpio address was wrong and I don't plan to support it thus
move this driver to arch/mips/loongson2ef/ so that I can drop the
shackles of the legacy driver and add a new driver that supports
dts/acpi to support LoongArch platforms.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 MAINTAINERS                                                 | 2 +-
 arch/loongarch/configs/loongson3_defconfig                  | 1 -
 arch/loongarch/include/asm/loongson.h                       | 6 ------
 arch/mips/configs/lemote2f_defconfig                        | 1 -
 arch/mips/configs/loongson2k_defconfig                      | 1 -
 arch/mips/configs/loongson3_defconfig                       | 1 -
 arch/mips/include/asm/mach-loongson64/loongson.h            | 5 -----
 arch/mips/loongson2ef/common/Makefile                       | 1 +
 .../gpio-loongson.c => arch/mips/loongson2ef/common/gpio.c  | 2 +-
 drivers/gpio/Kconfig                                        | 6 ------
 drivers/gpio/Makefile                                       | 1 -
 11 files changed, 3 insertions(+), 24 deletions(-)
 rename drivers/gpio/gpio-loongson.c => arch/mips/loongson2ef/common/gpio.c (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 916b2d9cffc0..7b80a64b70b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13881,7 +13881,7 @@ M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson2ef/
-F:	arch/mips/loongson2ef/
+F:	arch/mips/loongson2ef/*
 F:	drivers/cpufreq/loongson2_cpufreq.c
 
 MIPS/LOONGSON64 ARCHITECTURE
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 3540e9c0a631..d576d802ffd0 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -601,7 +601,6 @@ CONFIG_I2C_PIIX4=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_LOONGSON=y
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM93=m
 CONFIG_SENSORS_W83795=m
diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch/include/asm/loongson.h
index 00db93edae1b..87587688fab8 100644
--- a/arch/loongarch/include/asm/loongson.h
+++ b/arch/loongarch/include/asm/loongson.h
@@ -29,12 +29,6 @@
 #define LOONGSON_REG_SIZE	0x00100000	/* 1M */
 #define LOONGSON_REG_TOP	(LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
 
-/* GPIO Regs - r/w */
-
-#define LOONGSON_GPIODATA		LOONGSON_REG(0x11c)
-#define LOONGSON_GPIOIE			LOONGSON_REG(0x120)
-#define LOONGSON_REG_GPIO_BASE          (LOONGSON_REG_BASE + 0x11c)
-
 #define MAX_PACKAGES 16
 
 #define xconf_readl(addr) readl(addr)
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 7e598d338979..81264ccaacfc 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -127,7 +127,6 @@ CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_FOURPORT=y
 CONFIG_HW_RANDOM=y
-CONFIG_GPIO_LOONGSON=y
 CONFIG_THERMAL=y
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_FB=y
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 728bef666f7a..f11be40ccb4e 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -230,7 +230,6 @@ CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
-CONFIG_GPIO_LOONGSON=y
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM93=m
 CONFIG_SENSORS_W83627HF=m
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index aca66a5f330d..82de65130722 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -269,7 +269,6 @@ CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
-CONFIG_GPIO_LOONGSON=y
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM93=m
 CONFIG_SENSORS_W83627HF=m
diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index f7c3ab6d724e..51ee80d98742 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -177,11 +177,6 @@ extern int mach_i8259_irq(void);
 #define LOONGSON_PCIMEMBASECFG		LOONGSON_REG(LOONGSON_REGBASE + 0x14)
 #define LOONGSON_PCIMAP_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x18)
 
-/* GPIO Regs - r/w */
-
-#define LOONGSON_GPIODATA		LOONGSON_REG(LOONGSON_REGBASE + 0x1c)
-#define LOONGSON_GPIOIE			LOONGSON_REG(LOONGSON_REGBASE + 0x20)
-
 /* ICU Configuration Regs - r/w */
 
 #define LOONGSON_INTEDGE		LOONGSON_REG(LOONGSON_REGBASE + 0x24)
diff --git a/arch/mips/loongson2ef/common/Makefile b/arch/mips/loongson2ef/common/Makefile
index 30ea8b5ca685..4d4063f90cc5 100644
--- a/arch/mips/loongson2ef/common/Makefile
+++ b/arch/mips/loongson2ef/common/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_LOONGSON_UART_BASE) += serial.o
 obj-$(CONFIG_EARLY_PRINTK) += serial.o
 obj-$(CONFIG_LOONGSON_UART_BASE) += uart_base.o
 obj-$(CONFIG_LOONGSON_MC146818) += rtc.o
+obj-$(CONFIG_GPIOLIB) += gpio.o
 
 #
 # Enable CS5536 Virtual Support Module(VSM) to virtulize the PCI configure
diff --git a/drivers/gpio/gpio-loongson.c b/arch/mips/loongson2ef/common/gpio.c
similarity index 98%
rename from drivers/gpio/gpio-loongson.c
rename to arch/mips/loongson2ef/common/gpio.c
index a42145873cc9..0d3e7aef46d3 100644
--- a/drivers/gpio/gpio-loongson.c
+++ b/arch/mips/loongson2ef/common/gpio.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Loongson-2F/3A/3B GPIO Support
+ *  Loongson-2F GPIO Support
  *
  *  Copyright (c) 2008 Richard Liu,  STMicroelectronics	 <richard.liu@st.com>
  *  Copyright (c) 2008-2010 Arnaud Patard <apatard@mandriva.com>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a01af1180616..bc55b80f212a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -375,12 +375,6 @@ config GPIO_LOGICVC
 	  Say yes here to support GPIO functionality of the Xylon LogiCVC
 	  programmable logic block.
 
-config GPIO_LOONGSON
-	bool "Loongson-2/3 GPIO support"
-	depends on CPU_LOONGSON2EF || CPU_LOONGSON64
-	help
-	  Driver for GPIO functionality on Loongson-2F/3A/3B processors.
-
 config GPIO_LPC18XX
 	tristate "NXP LPC18XX/43XX GPIO support"
 	default y if ARCH_LPC18XX
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 29e3beb6548c..cfd298e00737 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_GPIO_JANZ_TTL)		+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)		+= gpio-kempld.o
 obj-$(CONFIG_GPIO_LOGICVC)		+= gpio-logicvc.o
 obj-$(CONFIG_GPIO_LOONGSON1)		+= gpio-loongson1.o
-obj-$(CONFIG_GPIO_LOONGSON)		+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)		+= gpio-lp3943.o
 obj-$(CONFIG_GPIO_LP873X)		+= gpio-lp873x.o
 obj-$(CONFIG_GPIO_LP87565)		+= gpio-lp87565.o
-- 
2.33.0

