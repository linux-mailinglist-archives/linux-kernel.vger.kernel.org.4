Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996BB699444
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBPMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjBPMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:25:33 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF357774;
        Thu, 16 Feb 2023 04:25:26 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r3so1339857pfh.4;
        Thu, 16 Feb 2023 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2AvMjaSjaeMLAOmSRivE95PUspyvUwC1tbdchn+oFU=;
        b=mn9w/Vo93CWNQGIZzLIYp25j8xvCDa+5o4BDRmpm1EKFxSwOhSBmkNZzg22msNe82C
         H0UOKJ/dAcfSORpOkqdg5YgqOF3wHy/PABxrpzXJFAstvcHLWy8ey33tRDKFU5NO8+KN
         4+FtL4bo0U4sAoH6FNka/U//56nXRUjLQo81JUxrhNbndc1qFyuR13SkgH3xw+wSSXtZ
         DpVAnTUsgmJjholFDFDxaZmg51S4MIErg3EtgxfDkY24SJ5yrGiNkoKpUrqC4OqjcWvN
         8F8ynhlIBQztYY8/CLn1ybFnNHGDUHbnXHbQbu+JZT6sDXbwEMAFTbghtxbVBN7nFY6h
         22bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2AvMjaSjaeMLAOmSRivE95PUspyvUwC1tbdchn+oFU=;
        b=wSJCZHxP3eEtKw07WcY7tFvES7ppQQsAtLcES613fdUwCDjlPYgxfK0eYDk7SoD+U2
         x0xkHtAXJfU2UvGEtCkwws4cjEeGud29Uaq+t49jsoGQIASzX9Bj4WRhA00+umybL2Kc
         za5mnKJh5ilZSlqEJLYgwgidtOQj4w9pYLSn77QFmeUX1wB48ILqvG62eOD+uugUcs32
         P1QxnhJga8nupgWuzGefWw08nKwnWP6PmLAOEfsIS5WMOssydU+zfSeqHy1JmZQ7BzbV
         rpg743kaXGTaTrsR26Yx44k0MgZpjf0ajbMarERyZMgDhFYb1UjjL4pGMhzYdodB+qvG
         oheQ==
X-Gm-Message-State: AO0yUKWcZqZoRPAnwdHgbrhu01LJqq7HuXWBQliz3wV3t6py8IXS9rmx
        uOZeb5XFUZ/m4idjke3ffSY=
X-Google-Smtp-Source: AK7set/+0XnpVFS509aOCMDxbXFMg3/XhApG2p8hx0rRuuD6IATKDEntRagUavEPsG/1NKtLGVxAAw==
X-Received: by 2002:a05:6a00:348d:b0:5a8:ac15:534d with SMTP id cp13-20020a056a00348d00b005a8ac15534dmr1735784pfb.13.1676550325747;
        Thu, 16 Feb 2023 04:25:25 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b005a909290425sm1224055pfn.172.2023.02.16.04.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:25:25 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v2 4/5] apple-gmux: support MMIO gmux on T2 Macs
Date:   Thu, 16 Feb 2023 23:23:42 +1100
Message-Id: <20230216122342.5918-5-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216122342.5918-1-orlandoch.dev@gmail.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some newer dual gpu MacBooks, gmux is controlled by the T2 security
chip, and acessed with MMIO. Add support for these gmux controllers

Interestingly, the ACPI table only allocates 8 bytes for GMUX, but we
actually need 16, and as such we request 16 with request_mem_region.

Reading and writing from ports:
    16 bytes from 0xfe0b0200 are used. 0x0 to 0x4 are where data
    to read appears, and where data to write goes. Writing to 0xe
    sets the gmux port being accessed, and writing to 0xf sends commands.

    These commands are 0x40 & data_length for write, and data_length for
    read, where data_length is 1, 2 or 4. Once byte base+0xf is 0, the
    command is done.

Issues:
    As with other retina models, we can't switch DDC lines so
    switching at runtime doesn't work if the inactive gpu driver
    already disabled eDP due to it not being connected when that
    driver loaded.

    Additionally, turning on the dgpu back on the MacBookPro16,1 does
    not work.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v1->v2: Document some chips present, and clarify which chips aren't
present on MMIO gmux laptops.
 drivers/platform/x86/apple-gmux.c | 142 +++++++++++++++++++++++++++---
 include/linux/apple-gmux.h        |  40 ++++++---
 2 files changed, 158 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 12a93fc49c36..5bac6dcfada0 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -28,15 +28,17 @@
  * DOC: Overview
  *
  * gmux is a microcontroller built into the MacBook Pro to support dual GPUs:
- * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on retinas.
+ * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on pre-T2 retinas.
+ * The chip used on T2 Macs is not known.
  *
  * (The MacPro6,1 2013 also has a gmux, however it is unclear why since it has
  * dual GPUs but no built-in display.)
  *
  * gmux is connected to the LPC bus of the southbridge. Its I/O ports are
  * accessed differently depending on the microcontroller: Driver functions
- * to access a pre-retina gmux are infixed ``_pio_``, those for a retina gmux
- * are infixed ``_index_``.
+ * to access a pre-retina gmux are infixed ``_pio_``, those for a pre-T2
+ * retina gmux are infixed ``_index_``, and those on T2 Macs are infixed
+ * with ``_mmio_``.
  *
  * .. _Lattice XP2:
  *     http://www.latticesemi.com/en/Products/FPGAandCPLD/LatticeXP2.aspx
@@ -47,6 +49,7 @@
 struct apple_gmux_config;
 
 struct apple_gmux_data {
+	u8 *__iomem iomem_base;
 	unsigned long iostart;
 	unsigned long iolen;
 	const struct apple_gmux_config *config;
@@ -209,6 +212,79 @@ static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
 	mutex_unlock(&gmux_data->index_lock);
 }
 
+static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
+{
+	int i = 200;
+	u8 gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+
+	while (i && gwr) {
+		gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		udelay(100);
+		i--;
+	}
+
+	return !!i;
+}
+
+static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
+{
+	u8 val;
+
+	mutex_lock(&gmux_data->index_lock);
+	gmux_mmio_wait(gmux_data);
+	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_READ | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	gmux_mmio_wait(gmux_data);
+	val = ioread8(gmux_data->iomem_base);
+	mutex_unlock(&gmux_data->index_lock);
+
+	return val;
+}
+
+static void gmux_mmio_write8(struct apple_gmux_data *gmux_data, int port,
+			      u8 val)
+{
+	mutex_lock(&gmux_data->index_lock);
+	gmux_mmio_wait(gmux_data);
+	iowrite8(val, gmux_data->iomem_base);
+
+	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+
+	gmux_mmio_wait(gmux_data);
+	mutex_unlock(&gmux_data->index_lock);
+}
+
+static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
+{
+	u32 val;
+
+	mutex_lock(&gmux_data->index_lock);
+	gmux_mmio_wait(gmux_data);
+	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_READ | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	gmux_mmio_wait(gmux_data);
+	val = be32_to_cpu(ioread32(gmux_data->iomem_base));
+	mutex_unlock(&gmux_data->index_lock);
+
+	return val;
+}
+
+static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
+			       u32 val)
+{
+	mutex_lock(&gmux_data->index_lock);
+	iowrite32(cpu_to_be32(val), gmux_data->iomem_base);
+	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	gmux_mmio_wait(gmux_data);
+	mutex_unlock(&gmux_data->index_lock);
+}
+
 static u8 gmux_read8(struct apple_gmux_data *gmux_data, int port)
 {
 	return gmux_data->config->read8(gmux_data, port);
@@ -237,8 +313,8 @@ static void gmux_write32(struct apple_gmux_data *gmux_data, int port,
  * the GPU. On dual GPU MacBook Pros by contrast, either GPU may be suspended
  * to conserve energy. Hence the PWM signal needs to be generated by a separate
  * backlight driver which is controlled by gmux. The earliest generation
- * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. All newer models
- * use a `TI LP8545`_.
+ * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. Newer models
+ * use a `TI LP8545`_ or a TI LP8548.
  *
  * .. _TI LP8543: https://www.ti.com/lit/ds/symlink/lp8543.pdf
  * .. _TI LP8545: https://www.ti.com/lit/ds/symlink/lp8545.pdf
@@ -302,8 +378,8 @@ static const struct backlight_ops gmux_bl_ops = {
  * connecting it either to the discrete GPU or the Thunderbolt controller.
  * Oddly enough, while the full port is no longer switchable, AUX and HPD
  * are still switchable by way of an `NXP CBTL03062`_ (on pre-retinas
- * MBP8 2011 and MBP9 2012) or two `TI TS3DS10224`_ (on retinas) under the
- * control of gmux. Since the integrated GPU is missing the main link,
+ * MBP8 2011 and MBP9 2012) or two `TI TS3DS10224`_ (on pre-t2 retinas) under
+ * the control of gmux. Since the integrated GPU is missing the main link,
  * external displays appear to it as phantoms which fail to link-train.
  *
  * gmux receives the HPD signal of all display connectors and sends an
@@ -506,6 +582,20 @@ static const struct apple_gmux_config apple_gmux_index = {
 	.name = "indexed"
 };
 
+static const struct apple_gmux_config apple_gmux_mmio = {
+	.read8 = &gmux_mmio_read8,
+	.write8 = &gmux_mmio_write8,
+	.read32 = &gmux_mmio_read32,
+	.write32 = &gmux_mmio_write32,
+	.gmux_handler = &gmux_handler_no_ddc,
+	.handler_flags = VGA_SWITCHEROO_NEEDS_EDP_CONFIG,
+	.resource_type = IORESOURCE_MEM,
+	.read_version_as_u32 = true,
+	.use_acpi_gmsp = true,
+	.name = "T2"
+};
+
+
 /**
  * DOC: Interrupt
  *
@@ -637,6 +727,25 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	pnp_set_drvdata(pnp, gmux_data);
 
 	switch (type) {
+	case APPLE_GMUX_TYPE_MMIO:
+		gmux_data->config = &apple_gmux_mmio;
+		mutex_init(&gmux_data->index_lock);
+
+		res = pnp_get_resource(pnp, IORESOURCE_MEM, 0);
+		gmux_data->iostart = res->start;
+		/* Although the ACPI table only allocates 8 bytes, we need 16. */
+		gmux_data->iolen = 16;
+		if (!request_mem_region(gmux_data->iostart, gmux_data->iolen,
+					"Apple gmux")) {
+			pr_err("gmux I/O already in use\n");
+			goto err_free;
+		}
+		gmux_data->iomem_base = ioremap(gmux_data->iostart, gmux_data->iolen);
+		if (!gmux_data->iomem_base) {
+			pr_err("couldn't remap gmux mmio region");
+			goto err_release;
+		}
+		goto get_version;
 	case APPLE_GMUX_TYPE_INDEXED:
 		gmux_data->config = &apple_gmux_index;
 		mutex_init(&gmux_data->index_lock);
@@ -656,6 +765,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_free;
 	}
 
+get_version:
 	if (gmux_data->config->read_version_as_u32) {
 		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
 		ver_major = (version >> 24) & 0xff;
@@ -686,7 +796,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 					 gmux_data, &gmux_bl_ops, &props);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
-		goto err_release;
+		goto err_unmap;
 	}
 
 	gmux_data->bdev = bdev;
@@ -753,7 +863,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
-	 * pre-retinas by having an "indexed" gmux.
+	 * pre-retinas by having an "indexed" or "T2" gmux.
 	 *
 	 * Pre-retina MacBook Pros can switch the panel's DDC separately.
 	 */
@@ -778,8 +888,14 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 					   &gmux_notify_handler);
 err_notify:
 	backlight_device_unregister(bdev);
+err_unmap:
+	if (gmux_data->iomem_base)
+		iounmap(gmux_data->iomem_base);
 err_release:
-	release_region(gmux_data->iostart, gmux_data->iolen);
+	if (gmux_data->config->resource_type == IORESOURCE_MEM)
+		release_mem_region(gmux_data->iostart, gmux_data->iolen);
+	else
+		release_region(gmux_data->iostart, gmux_data->iolen);
 err_free:
 	kfree(gmux_data);
 	return ret;
@@ -800,7 +916,11 @@ static void gmux_remove(struct pnp_dev *pnp)
 
 	backlight_device_unregister(gmux_data->bdev);
 
-	release_region(gmux_data->iostart, gmux_data->iolen);
+	if (gmux_data->iomem_base) {
+		iounmap(gmux_data->iomem_base);
+		release_mem_region(gmux_data->iostart, gmux_data->iolen);
+	} else
+		release_region(gmux_data->iostart, gmux_data->iolen);
 	apple_gmux_data = NULL;
 	kfree(gmux_data);
 
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 5f658439f7f8..b7532f26b756 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -34,11 +34,18 @@
 #define GMUX_PORT_READ			0xd0
 #define GMUX_PORT_WRITE			0xd4
 
+#define GMUX_MMIO_PORT_SELECT		0x0e
+#define GMUX_MMIO_COMMAND_SEND		0x0f
+
+#define GMUX_MMIO_READ			0x00
+#define GMUX_MMIO_WRITE			0x40
+
 #define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
 
 enum apple_gmux_type {
 	APPLE_GMUX_TYPE_PIO,
-	APPLE_GMUX_TYPE_INDEXED
+	APPLE_GMUX_TYPE_INDEXED,
+	APPLE_GMUX_TYPE_MMIO
 };
 
 #if IS_ENABLED(CONFIG_APPLE_GMUX)
@@ -93,19 +100,24 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, enum apple_gmux_ty
 	}
 
 	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
-	if (!res || resource_size(res) < GMUX_MIN_IO_LEN)
-		goto out;
-
-	/*
-	 * Invalid version information may indicate either that the gmux
-	 * device isn't present or that it's a new one that uses indexed io.
-	 */
-	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
-	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
-	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
-	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
-		if (apple_gmux_is_indexed(res->start))
-			type = APPLE_GMUX_TYPE_INDEXED;
+	if (res && resource_size(res) >= GMUX_MIN_IO_LEN) {
+		/*
+		 * Invalid version information may indicate either that the gmux
+		 * device isn't present or that it's a new one that uses indexed io.
+		 */
+		ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
+		ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
+		ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
+		if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
+			if (apple_gmux_is_indexed(res->start))
+				type = APPLE_GMUX_TYPE_INDEXED;
+			else
+				goto out;
+		}
+	} else {
+		res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
+		if (res)
+			type = APPLE_GMUX_TYPE_MMIO;
 		else
 			goto out;
 	}
-- 
2.39.1
