Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D46D1DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCaKXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCaKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:22:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EE4200;
        Fri, 31 Mar 2023 03:20:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so24885999pjb.4;
        Fri, 31 Mar 2023 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680258031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iroPs3Tzxhb3uDNnYPCpKdvQDYF4fC/2T9DVsvbbzuw=;
        b=pGsj4eMHRk3mWSnIJKzQxeELGSKKbfipQn/gHIRSwiCwyEu41gcBgwTlqb5+tJEYvR
         ifDRAKqrBlSobfQfLGhikm4sENM8cN1BlbKYXTkRwHTqXfye67PqHgZZt6SpIC24J3f9
         5zLzyitOtsELsfDbP9kkpFrmx96c6Hu9PRg7aUUTBV+eAC6rsPpgkefMWRZNspAZCvxp
         AqZredMfjxX0y3YSkvetW2rI43Pdrxw2u5poxNNyWXSqFx/EhYewKga1ROgsaP0eLBR/
         NhmKu8B95kPlAhfuXe9ea3j9LL3HmqlX6MOTvSx1Y2CkBCwrlS2oDM6CeXvv5SsQKgd5
         QH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680258031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iroPs3Tzxhb3uDNnYPCpKdvQDYF4fC/2T9DVsvbbzuw=;
        b=or2XTsA0sKMZ7CnEzjM6M0TNASLb69dnvG3ahAxMnFTjXxJ2S9ACA0yrIVwbVRFSH2
         UaZ7JZQdFsNiIJAjrhmqdbXaLadcfkXjTVOxLyob8+82R+emAzy0ACW8VdmLidlrJIf/
         l744o0e49ADaIOuTKFV1BePuZFEoofNRWMGW4YwtMHXikcTXkkz2CeFpnyv+FNMP4WDm
         c+z80VJ5kU9aAdwAlYUMQY3Z+2GT/mq5ZdHgkn2+zQhtp1LMmuByG+4tjsHu2ij0n3Dm
         v1RHAzfj3cXvC2hVNbIF5+QcFckUKiibhNm02Yc6gv92ouAYbooHj5m0uXnpx/7wPqA8
         uj2w==
X-Gm-Message-State: AAQBX9dStJ6UDR/GrnWqzIPFvdCwQD9Lh4d36Jn+0rG/ZohdqYUQiAwf
        nanhN4Qodaui3VP9vrNWY9oeBzpq79D1BgbevuU=
X-Google-Smtp-Source: AKy350YbjTyKbvV4p2G4IJ4kAA2KwSj60PKSOWkLg3dX6r8aVfMmVICcz9SLv9uE7/xFotqeKA7vLA==
X-Received: by 2002:a17:90b:4b4e:b0:23f:7e2e:fe13 with SMTP id mi14-20020a17090b4b4e00b0023f7e2efe13mr29872628pjb.0.1680258031298;
        Fri, 31 Mar 2023 03:20:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.203])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a858100b0023af8a3cf6esm4614808pjn.48.2023.03.31.03.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:20:30 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] crypto: hisilicon/trng - add support for HiSTB TRNG
Date:   Fri, 31 Mar 2023 18:19:34 +0800
Message-Id: <20230331101943.831347-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSTB TRNG are found on some HiSilicon STB SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2: fix typo
v3: add option for post process depth, adjust timeout
v4: do not case to __iomem, as requested
 drivers/crypto/hisilicon/Kconfig         |   7 +
 drivers/crypto/hisilicon/Makefile        |   2 +-
 drivers/crypto/hisilicon/trng/Makefile   |   3 +
 drivers/crypto/hisilicon/trng/trng-stb.c | 186 +++++++++++++++++++++++
 4 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/hisilicon/trng/trng-stb.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 4137a8bf131f..e8690c223584 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -82,3 +82,10 @@ config CRYPTO_DEV_HISI_TRNG
 	select CRYPTO_RNG
 	help
 	  Support for HiSilicon TRNG Driver.
+
+config CRYPTO_DEV_HISTB_TRNG
+	tristate "Support for HiSTB TRNG Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	select HW_RANDOM
+	help
+	  Support for HiSTB TRNG Driver.
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 8595a5a5d228..fc51e0edec69 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
 hisi_qm-objs = qm.o sgl.o debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
-obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += trng/
+obj-y += trng/
diff --git a/drivers/crypto/hisilicon/trng/Makefile b/drivers/crypto/hisilicon/trng/Makefile
index d909079f351c..cf20b057c66b 100644
--- a/drivers/crypto/hisilicon/trng/Makefile
+++ b/drivers/crypto/hisilicon/trng/Makefile
@@ -1,2 +1,5 @@
 obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += hisi-trng-v2.o
 hisi-trng-v2-objs = trng.o
+
+obj-$(CONFIG_CRYPTO_DEV_HISTB_TRNG) += histb-trng.o
+histb-trng-objs += trng-stb.o
diff --git a/drivers/crypto/hisilicon/trng/trng-stb.c b/drivers/crypto/hisilicon/trng/trng-stb.c
new file mode 100644
index 000000000000..239f3451c2a1
--- /dev/null
+++ b/drivers/crypto/hisilicon/trng/trng-stb.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device driver for True RNG in HiSTB SoCs
+ *
+ * Copyright (c) 2023 David Yang
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#define HISTB_TRNG_CTRL		0x0
+#define  RNG_SOURCE			GENMASK(1, 0)
+#define  DROP_ENABLE			BIT(5)
+#define  POST_PROCESS_ENABLE		BIT(7)
+#define  POST_PROCESS_DEPTH		GENMASK(15, 8)
+#define HISTB_TRNG_NUMBER	0x4
+#define HISTB_TRNG_STAT		0x8
+#define  DATA_COUNT			GENMASK(2, 0)	/* max 4 */
+
+struct histb_trng_priv {
+	void __iomem *base;
+};
+
+/*
+ * Observed:
+ * depth = 1 -> ~1ms
+ * depth = 255 -> ~16ms
+ */
+static int histb_trng_wait(struct hwrng *rng)
+{
+	struct histb_trng_priv *priv = (struct histb_trng_priv *) rng->priv;
+	void __iomem *base = priv->base;
+	u32 val;
+
+	return readl_relaxed_poll_timeout(base + HISTB_TRNG_STAT,
+					  val, val & DATA_COUNT,
+					  1000, 30 * 1000);
+}
+
+static void histb_trng_init(struct hwrng *rng, unsigned int depth)
+{
+	struct histb_trng_priv *priv = (struct histb_trng_priv *) rng->priv;
+	void __iomem *base = priv->base;
+	u32 val;
+
+	val = readl_relaxed(base + HISTB_TRNG_CTRL);
+
+	val &= ~RNG_SOURCE;
+	val |= 2;
+
+	val &= ~POST_PROCESS_DEPTH;
+	val |= min(depth, 0xffu) << 8;
+
+	val |= POST_PROCESS_ENABLE;
+	val |= DROP_ENABLE;
+
+	writel_relaxed(val, base + HISTB_TRNG_CTRL);
+}
+
+static int histb_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	struct histb_trng_priv *priv = (struct histb_trng_priv *) rng->priv;
+	void __iomem *base = priv->base;
+	size_t i;
+
+	for (i = 0; i < max; i += sizeof(u32)) {
+		if (!(readl_relaxed(base + HISTB_TRNG_STAT) & DATA_COUNT)) {
+			if (!wait)
+				break;
+			if (histb_trng_wait(rng)) {
+				pr_err("failed to generate random number, generated %zu\n",
+				       i);
+				if (i)
+					break;
+				return -ETIMEDOUT;
+			}
+		}
+		*(u32 *) (data + i) = readl_relaxed(base + HISTB_TRNG_NUMBER);
+	}
+
+	return i;
+}
+
+static unsigned int histb_trng_get_depth(struct hwrng *rng)
+{
+	struct histb_trng_priv *priv = (struct histb_trng_priv *) rng->priv;
+	void __iomem *base = priv->base;
+	u32 val = readl_relaxed(base + HISTB_TRNG_CTRL);
+
+	return (val & POST_PROCESS_DEPTH) >> 8;
+}
+
+static ssize_t
+depth_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hwrng *rng = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", histb_trng_get_depth(rng));
+}
+
+static ssize_t
+depth_store(struct device *dev, struct device_attribute *attr,
+	    const char *buf, size_t count)
+{
+	struct hwrng *rng = dev_get_drvdata(dev);
+	unsigned int depth;
+
+	if (kstrtouint(buf, 0, &depth))
+		return -ERANGE;
+
+	histb_trng_init(rng, depth);
+	return count;
+}
+
+static DEVICE_ATTR_RW(depth);
+
+static struct attribute *histb_trng_attrs[] = {
+	&dev_attr_depth.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(histb_trng);
+
+static int histb_trng_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hwrng *rng;
+	struct histb_trng_priv *priv;
+	int ret;
+
+	rng = devm_kzalloc(dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return -ENOMEM;
+
+	rng->priv = (unsigned long) priv;
+
+	histb_trng_init(rng, 144);
+	if (histb_trng_wait(rng))
+		return -ENODEV;
+
+	rng->name = KBUILD_MODNAME;
+	rng->read = histb_trng_read;
+
+	ret = devm_hwrng_register(dev, rng);
+	if (ret) {
+		dev_err(dev, "failed to register %s (%d)\n", rng->name, ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, rng);
+	dev_set_drvdata(dev, rng);
+	return 0;
+}
+
+static const struct of_device_id histb_trng_of_match[] = {
+	{ .compatible = "hisilicon,histb-trng", },
+	{ }
+};
+
+static struct platform_driver histb_trng_driver = {
+	.probe = histb_trng_probe,
+	.driver = {
+		.name = "histb-trng",
+		.of_match_table = histb_trng_of_match,
+		.dev_groups = histb_trng_groups,
+	},
+};
+
+module_platform_driver(histb_trng_driver);
+
+MODULE_DESCRIPTION("HiSTB True RNG");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-- 
2.39.2

