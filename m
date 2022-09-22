Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE95E6E54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiIVVUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIVVUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:20:15 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58980895E9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z8b9AhT/nSURE/TV3uWrzdWY2/dP2r9AWOoz9sV+VBk=; b=wZmPxPZX+Vn6J6Ntjuxj5PVf51
        Q54cbHdQzaObVEBpQSxjFOhcEIrObBRJt9MElkBh9uvGz/TjsvxwA8hrp8l6nTuc2nJ91+WP9lwFi
        iRhbTxrnBn675ZiIyp5sKUFfJweAZ7Esdh9ABCr7vBvitvpzSY3jeuu0wb5HPNQvBRiM5W88BocFA
        vbSSFVOPw6DfwLfGcA3Np9DdGxuC5GjueuyeMv4Ckmj89WXCysUujGwbX9khY4mOjTQ6uDN2jRulN
        K7KVnJ/POFVoqDOlLCXoNioqh+DogpP7D7T3wCmFg9sJiW6KezQGFQgx+LL8otOs0tjUut87CeTwR
        R+YV5nUA==;
Received: from a88-85-156-139.mpynet.fi ([88.85.156.139]:50264 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1obSlt-008paI-FV; Thu, 22 Sep 2022 23:26:11 +0300
Received: by localhost (sSMTP sendmail emulation); Thu, 22 Sep 2022 23:26:05 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk
Cc:     pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Thu, 22 Sep 2022 23:24:58 +0300
Message-Id: <20220922202458.7592-4-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922202458.7592-1-maukka@ext.kapsi.fi>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.85.156.139
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Subject: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device Tree
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add D-Link DNS-323 that is based on Device Tree.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
---
changes from v1
 - split patches, this one modifies source code
 - add DT based dns323 board file
 - don't remove any existing code
---
 arch/arm/mach-orion5x/Kconfig        |   7 +
 arch/arm/mach-orion5x/Makefile       |   1 +
 arch/arm/mach-orion5x/board-dns323.c | 208 +++++++++++++++++++++++++++
 arch/arm/mach-orion5x/board-dt.c     |   3 +
 arch/arm/mach-orion5x/common.h       |   6 +
 5 files changed, 225 insertions(+)
 create mode 100644 arch/arm/mach-orion5x/board-dns323.c

diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 0044b2823710..1ee0d7e06828 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -68,6 +68,13 @@ config MACH_DNS323
 	  Say 'Y' here if you want your kernel to support the
 	  D-Link DNS-323 platform.
 
+config MACH_DNS323_DT
+	bool "D-Link DNS-323 (Flattened Device Tree)"
+	select ARCH_ORION5X_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-323 platform.
+
 config MACH_TS209
 	bool "QNAP TS-109/TS-209"
 	depends on ATAGS
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 1a585a62d5e6..2ed6bafa7acb 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -22,5 +22,6 @@ obj-$(CONFIG_MACH_RD88F6183AP_GE)	+= rd88f6183ap-ge-setup.o
 
 obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_D2NET_DT)	+= board-d2net.o
+obj-$(CONFIG_MACH_DNS323_DT)	+= board-dns323.o
 obj-$(CONFIG_MACH_MSS2_DT)	+= board-mss2.o
 obj-$(CONFIG_MACH_RD88F5182_DT)	+= board-rd88f5182.o
diff --git a/arch/arm/mach-orion5x/board-dns323.c b/arch/arm/mach-orion5x/board-dns323.c
new file mode 100644
index 000000000000..72a1f3e228b3
--- /dev/null
+++ b/arch/arm/mach-orion5x/board-dns323.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Mauri Sandberg <maukka@ext.kapsi.fi>
+ *
+ * Flattened Device Tree board initialization
+ *
+ * This is adapted from existing mach files and most of the source code is
+ * originally written by:
+ *  Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
+ *  Copyright (C) 2010 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
+ */
+
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/marvell_phy.h>
+#include <linux/of_net.h>
+#include <linux/clk.h>
+#include "bridge-regs.h"
+
+/* Exposed to userspace, do not change */
+enum {
+	DNS323_REV_A1,	/* 0 */
+	DNS323_REV_B1,	/* 1 */
+	DNS323_REV_C1,	/* 2 */
+};
+
+/****************************************************************************
+ * Fix-ups
+ */
+
+static int dns323c_phy_fixup(struct phy_device *phy)
+{
+	phy->dev_flags |= MARVELL_PHY_M1118_DNS323_LEDS;
+
+	return 0;
+}
+
+/****************************************************************************
+ * Ethernet
+ */
+
+/* dns323_parse_hex_*() taken from tsx09-common.c; should a common copy of these
+ * functions be kept somewhere?
+ */
+static int __init dns323_parse_hex_nibble(char n)
+{
+	if (n >= '0' && n <= '9')
+		return n - '0';
+
+	if (n >= 'A' && n <= 'F')
+		return n - 'A' + 10;
+
+	if (n >= 'a' && n <= 'f')
+		return n - 'a' + 10;
+
+	return -1;
+}
+
+static int __init dns323_parse_hex_byte(const char *b)
+{
+	int hi;
+	int lo;
+
+	hi = dns323_parse_hex_nibble(b[0]);
+	lo = dns323_parse_hex_nibble(b[1]);
+
+	if (hi < 0 || lo < 0)
+		return -1;
+
+	return (hi << 4) | lo;
+}
+
+#define DNS323_NOR_BOOT_BASE 0xf4000000
+
+static int __init dns323_read_mac_addr(u8 *addr)
+{
+	int i;
+	char *mac_page;
+
+	/* MAC address is stored as a regular ol' string in /dev/mtdblock4
+	 * (0x007d0000-0x00800000) starting at offset 196480 (0x2ff80).
+	 */
+	mac_page = ioremap(DNS323_NOR_BOOT_BASE + 0x7d0000 + 196480, 1024);
+	if (!mac_page)
+		return -ENOMEM;
+
+	/* Sanity check the string we're looking at */
+	for (i = 0; i < 5; i++) {
+		if (*(mac_page + (i * 3) + 2) != ':')
+			goto error_fail;
+	}
+
+	for (i = 0; i < ETH_ALEN; i++)	{
+		int byte;
+
+		byte = dns323_parse_hex_byte(mac_page + (i * 3));
+		if (byte < 0)
+			goto error_fail;
+
+		addr[i] = byte;
+	}
+
+	iounmap(mac_page);
+
+	return 0;
+
+error_fail:
+	iounmap(mac_page);
+	return -EINVAL;
+}
+
+static void __init dns323_dt_eth_fixup(void)
+{
+	struct device_node *np;
+	u8 addr[ETH_ALEN];
+	int ret;
+
+	/*
+	 * The ethernet interfaces forget the MAC address assigned by u-boot
+	 * if the clocks are turned off. Usually, u-boot on orion boards
+	 * has no DT support to properly set local-mac-address property.
+	 * As a workaround, we get the MAC address that is stored in flash
+	 * and update the port device node if no valid MAC address is set.
+	 */
+	ret = dns323_read_mac_addr(addr);
+
+	if (ret) {
+		pr_warn("Unable to find MAC address in flash memory\n");
+		return;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,orion-eth-port");
+
+	if (!IS_ERR(np)) {
+		struct device_node *pnp = of_get_parent(np);
+		struct clk *clk;
+		struct property *pmac;
+		u8 tmpmac[ETH_ALEN];
+		u8 *macaddr;
+		int i;
+
+		if (!pnp)
+			return;
+
+		/* skip disabled nodes or nodes with valid MAC address*/
+		if (!of_device_is_available(pnp) ||
+		    !of_get_mac_address(np, tmpmac))
+			goto eth_fixup_skip;
+
+		clk = of_clk_get(pnp, 0);
+		if (IS_ERR(clk))
+			goto eth_fixup_skip;
+
+		/* ensure port clock is not gated to not hang CPU */
+		clk_prepare_enable(clk);
+
+		/* store MAC address register contents in local-mac-address */
+		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
+		if (!pmac)
+			goto eth_fixup_no_mem;
+
+		pmac->value = pmac + 1;
+		pmac->length = ETH_ALEN;
+		pmac->name = kstrdup("local-mac-address", GFP_KERNEL);
+		if (!pmac->name) {
+			kfree(pmac);
+			goto eth_fixup_no_mem;
+		}
+
+		macaddr = pmac->value;
+		for (i = 0; i < ETH_ALEN; i++)
+			macaddr[i] = addr[i];
+
+		of_update_property(np, pmac);
+
+eth_fixup_no_mem:
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+eth_fixup_skip:
+		of_node_put(pnp);
+	}
+}
+
+void __init dns323_init_dt(void)
+{
+	if (of_machine_is_compatible("dlink,dns323a1")) {
+		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
+	} else if (of_machine_is_compatible("dlink,dns323c1") &&
+		IS_BUILTIN(CONFIG_PHYLIB)) {
+		/* Register fixup for the PHY LEDs */
+		phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1118,
+					   MARVELL_PHY_ID_MASK,
+					   dns323c_phy_fixup);
+
+		/* Now, -this- should theorically be done by the sata_mv driver
+		 * once I figure out what's going on there. Maybe the behaviour
+		 * of the LEDs should be somewhat passed via the platform_data.
+		 * for now, just whack the register and make the LEDs happy
+		 *
+		 * Note: AFAIK, rev B1 needs the same treatement but I'll let
+		 * somebody else test it.
+		 */
+		writel(0x5, ORION5X_SATA_VIRT_BASE + 0x2c);
+	}
+
+	dns323_dt_eth_fixup();
+}
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index e3736ffc8347..670bff5e53f6 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -57,6 +57,9 @@ static void __init orion5x_dt_init(void)
 		cpu_idle_poll_ctrl(true);
 	}
 
+	if (of_machine_is_compatible("dlink,dns323"))
+		dns323_init_dt();
+
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index eb96009e21c4..7a21f7216c65 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -75,6 +75,12 @@ extern void mss2_init(void);
 static inline void mss2_init(void) {}
 #endif
 
+#ifdef CONFIG_MACH_DNS323_DT
+extern void dns323_init_dt(void);
+#else
+static inline void dns323_init_dt(void) {}
+#endif
+
 /*****************************************************************************
  * Helpers to access Orion registers
  ****************************************************************************/
-- 
2.25.1

