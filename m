Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CAE72B23B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjFKOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjFKOF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1033AB4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30ae141785bso3190117f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492252; x=1689084252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHzDZma34BfIceFW3Cdq8kZ/UQYKFOT8ltQbh1tX8Q4=;
        b=UFoFBrFDFp6l6vMBT7MPrIkKnwGOgNocRLb7R85KWQmc7N7TsUwbK5I45FXPi+y7KZ
         uHUh+z6cgOQPM57s8qAhaXq82BWLmSB+RUZOAQHDdZdTag5QISLB7U7Mgxe9GiqYIVlP
         TDE2CmwskbwXyX2fR0UBwBxo3kc+Gf6iNrxqAjYWn2c8UCGbkmAwdq7R4s2exBw7tD0f
         IeX0pPdAbq0+MjWx0AwA8WaqiR/iBBLMdw/Sr/zqvc5fNBdI7/uc+Bj1eSGclg86NkYQ
         omCt89WMxUUqPPsiU5TSV5QWHQZRQfTRmSavv5bkPjgZYohLi7ChxLcBz6JN9G7z80X1
         2ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492252; x=1689084252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHzDZma34BfIceFW3Cdq8kZ/UQYKFOT8ltQbh1tX8Q4=;
        b=BiEyBGgnK2tkJT4iF2oYTDEuIabzz5xTe4xbvCrUOdKxh49sDmHA+S9M03V80FNwha
         eo2Y/KRF2x8+pyiZ+9d5/2o1ZjLT6LRkN4PJnssJrTyfseiG44SUjdMcNYOuITHmaFJ/
         FgN3ebDsIVo3hE6e/psi5MCbk3pWETkWS3UvIQCSwudmzYAr0tcmirKgb2JhTKg4qYOY
         HkU0vsjCQ1aZqnZKWsKS5uu+2ecATWvdLioFOk7j6Z1OPLCpsn06Cz2MkUzPQLLLGkCg
         FQwOW3EYW6WMYekdIn1LAfXmgqpoOwBRgjmAgZywMYlu6CszdstFGiLueGKxKTixoRDA
         IZcg==
X-Gm-Message-State: AC+VfDzbf5EptrBFE+nIJsuDyO3RCQ+maizV3vu7OEZF+1vpR1v8JLtp
        /lLM/odaBHJPhRHk5iLAZR2Dlg==
X-Google-Smtp-Source: ACHHUZ6O6QBS8rx2CjH3lieRFACG+7GcdjuvxoLJWZCBgn7YDo1A1o9gymrgwVaJHQgpWqwIPV4iZA==
X-Received: by 2002:adf:d08e:0:b0:30f:c195:2176 with SMTP id y14-20020adfd08e000000b0030fc1952176mr313623wrh.59.1686492252319;
        Sun, 11 Jun 2023 07:04:12 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 21/26] nvmem: imx: support i.MX93 OCOTP
Date:   Sun, 11 Jun 2023 15:03:25 +0100
Message-Id: <20230611140330.154222-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 OCOTP support. i.MX93 OCOTP has two parts: Fuse shadow
block(fsb) and fuse managed by ELE. The FSB part could be directly
accessed with MMIO, the ELE could only be accessed with ELE API.

Currently the ELE API is not ready, so NULL function callback is used,
but it was tested with downstream ELE API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig         |   9 ++
 drivers/nvmem/Makefile        |   2 +
 drivers/nvmem/imx-ocotp-ele.c | 175 ++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/nvmem/imx-ocotp-ele.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 688b70ba4826..da9befa3d6c4 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -83,6 +83,15 @@ config NVMEM_IMX_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-imx-ocotp.
 
+config NVMEM_IMX_OCOTP_ELE
+	tristate "i.MX On-Chip OTP Controller support"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	help
+	  This is a driver for the On-Chip OTP Controller (OCOTP)
+	  available on i.MX SoCs which has ELE.
+
 config NVMEM_IMX_OCOTP_SCU
 	tristate "i.MX8 SCU On-Chip OTP Controller support"
 	depends on IMX_SCU
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index f82431ec8aef..cc23ce4ffb1f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_NVMEM_IMX_IIM)		+= nvmem-imx-iim.o
 nvmem-imx-iim-y				:= imx-iim.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y			:= imx-ocotp.o
+obj-$(CONFIG_NVMEM_IMX_OCOTP_ELE)	+= nvmem-imx-ocotp-ele.o
+nvmem-imx-ocotp-ele-y			:= imx-ocotp-ele.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
 nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
 obj-$(CONFIG_NVMEM_JZ4780_EFUSE)	+= nvmem_jz4780_efuse.o
diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
new file mode 100644
index 000000000000..f1cbbc9afeb8
--- /dev/null
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * i.MX9 OCOTP fusebox driver
+ *
+ * Copyright 2023 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum fuse_type {
+	FUSE_FSB = 1,
+	FUSE_ELE = 2,
+	FUSE_INVALID = -1
+};
+
+struct ocotp_map_entry {
+	u32 start; /* start word */
+	u32 num; /* num words */
+	enum fuse_type type;
+};
+
+struct ocotp_devtype_data {
+	u32 reg_off;
+	char *name;
+	u32 size;
+	u32 num_entry;
+	u32 flag;
+	nvmem_reg_read_t reg_read;
+	struct ocotp_map_entry entry[];
+};
+
+struct imx_ocotp_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct nvmem_config config;
+	struct mutex lock;
+	const struct ocotp_devtype_data *data;
+};
+
+static enum fuse_type imx_ocotp_fuse_type(void *context, u32 index)
+{
+	struct imx_ocotp_priv *priv = context;
+	const struct ocotp_devtype_data *data = priv->data;
+	u32 start, end;
+	int i;
+
+	for (i = 0; i < data->num_entry; i++) {
+		start = data->entry[i].start;
+		end = data->entry[i].start + data->entry[i].num;
+
+		if (index >= start && index < end)
+			return data->entry[i].type;
+	}
+
+	return FUSE_INVALID;
+}
+
+static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct imx_ocotp_priv *priv = context;
+	void __iomem *reg = priv->base + priv->data->reg_off;
+	u32 count, index, num_bytes;
+	enum fuse_type type;
+	u32 *buf;
+	void *p;
+	int i;
+
+	index = offset;
+	num_bytes = round_up(bytes, 4);
+	count = num_bytes >> 2;
+
+	if (count > ((priv->data->size >> 2) - index))
+		count = (priv->data->size >> 2) - index;
+
+	p = kzalloc(num_bytes, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	mutex_lock(&priv->lock);
+
+	buf = p;
+
+	for (i = index; i < (index + count); i++) {
+		type = imx_ocotp_fuse_type(context, i);
+		if (type == FUSE_INVALID || type == FUSE_ELE) {
+			*buf++ = 0;
+			continue;
+		}
+
+		*buf++ = readl_relaxed(reg + (i << 2));
+	}
+
+	memcpy(val, (u8 *)p, bytes);
+
+	mutex_unlock(&priv->lock);
+
+	kfree(p);
+
+	return 0;
+};
+
+static int imx_ele_ocotp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_ocotp_priv *priv;
+	struct nvmem_device *nvmem;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = of_device_get_match_data(dev);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->config.dev = dev;
+	priv->config.name = "ELE-OCOTP";
+	priv->config.id = NVMEM_DEVID_AUTO;
+	priv->config.owner = THIS_MODULE;
+	priv->config.size = priv->data->size;
+	priv->config.reg_read = priv->data->reg_read;
+	priv->config.word_size = 4;
+	priv->config.stride = 1;
+	priv->config.priv = priv;
+	priv->config.read_only = true;
+	mutex_init(&priv->lock);
+
+	nvmem = devm_nvmem_register(dev, &priv->config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	return 0;
+}
+
+static const struct ocotp_devtype_data imx93_ocotp_data = {
+	.reg_off = 0x8000,
+	.reg_read = imx_ocotp_reg_read,
+	.size = 2048,
+	.num_entry = 6,
+	.entry = {
+		{ 0, 52, FUSE_FSB },
+		{ 63, 1, FUSE_ELE},
+		{ 128, 16, FUSE_ELE },
+		{ 182, 1, FUSE_ELE },
+		{ 188, 1, FUSE_ELE },
+		{ 312, 200, FUSE_FSB }
+	},
+};
+
+static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
+	{ .compatible = "fsl,imx93-ocotp", .data = &imx93_ocotp_data, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx_ele_ocotp_dt_ids);
+
+static struct platform_driver imx_ele_ocotp_driver = {
+	.driver = {
+		.name = "imx_ele_ocotp",
+		.of_match_table = imx_ele_ocotp_dt_ids,
+	},
+	.probe = imx_ele_ocotp_probe,
+};
+module_platform_driver(imx_ele_ocotp_driver);
+
+MODULE_DESCRIPTION("i.MX OCOTP/ELE driver");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

