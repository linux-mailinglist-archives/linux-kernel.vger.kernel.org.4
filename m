Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2756D6A82
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjDDRYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbjDDRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F755AD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t10so133439305edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nn6Upx/8lI3MwJj2GpjPhoavYIuxq4AilqaxqKCRx0=;
        b=UnfAlqdR5cf/UygVfOd2H8cn+UiEPU70W94Si7BjJlm0jURmRiuVg1ZrcklHLzZRbL
         7XYMIMSMtMlCX46wR5EQRL8obNGo9PWEhSeauRPOBzrKfmz0s1FqF+ADJSfz/q8cL1q3
         Jghli4f5KjD28anELeVMuahASqmszAf1Ujdqi+4YMq46F4d45RyEEHLXea88Ndc8DYQD
         HwOR4WzpBjoUSM3OUz7h5rOgvRc3kMk9xKKFTgnjVuM23oRp+Giw7R/+2QcuqroOx0Jy
         Lc4m2pJ8B07agCQVcaLm2bWJtP6H/efteGwhQ0HIwJevXcAyNd8zMUcvnUkHZLPkSteP
         LezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nn6Upx/8lI3MwJj2GpjPhoavYIuxq4AilqaxqKCRx0=;
        b=S6ep1DUji/pveRUOFZYs5OFr9ZdcFNNDfOafXUamJyYH2rMWB0weisfocM7VabCdA7
         I9q4f/FfrCIweDKiEfV7zCnkivDzzVef25DUs7DKjKyqakgAGlUb3AUmmtwKiNUHH6gQ
         IlXYoFemiybaAitqnxp8W+vnMi6jQE+jEqGAkGN0z3H+UtRyJENejM3PhiXdJ23JfrAd
         qHHDm6LKbSwMigFG71yjfC+asB0/cik4S4sbpPtp5xzB182W0GqRkA/EyLPoCW8OaVKL
         ZGzXQ0BzWb6T0i6QW7oNf6PFt5ziTQYgh6eKx75ikle8YItIc1sCzhP/3cx90sO8YgV0
         FvOQ==
X-Gm-Message-State: AAQBX9euym7TFiHsx1W8avHU7af7Fx/MG0mxreTQ/2mgTBvXQKtUAFiu
        gRZ2f8dBoyIxFZxt7ZftzFVr9lwUfqLJZugDDMQ=
X-Google-Smtp-Source: AKy350bAxpPz+Dt5ZpMM3PEpnZ6ZR0QuXo7FWEcga3C4XogDeCkKZOLpq90cu4ysxZ35OVceCo6wSQ==
X-Received: by 2002:a17:906:a04c:b0:93d:f7a6:219b with SMTP id bg12-20020a170906a04c00b0093df7a6219bmr270334ejb.65.1680628991274;
        Tue, 04 Apr 2023 10:23:11 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 35/40] nvmem: u-boot-env: post-process "ethaddr" env variable
Date:   Tue,  4 Apr 2023 18:21:43 +0100
Message-Id: <20230404172148.82422-36-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot environment variables are stored in ASCII format so "ethaddr"
requires parsing into binary to make it work with Ethernet interfaces.

This includes support for indexes to support #nvmem-cell-cells = <1>.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig      |  1 +
 drivers/nvmem/u-boot-env.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index a2afba11c890..b291b27048c7 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -340,6 +340,7 @@ config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
 	depends on OF && MTD
 	select CRC32
+	select GENERIC_NET_UTILS
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 29b1d87a3c51..ee9fd9989b6e 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
@@ -70,6 +72,25 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
+						unsigned int offset, void *buf, size_t bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(buf, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	ether_addr_copy(buf, mac);
+
+	return 0;
+}
+
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
@@ -101,6 +122,11 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 		priv->cells[idx].offset = data_offset + value - data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		if (!strcmp(var, "ethaddr")) {
+			priv->cells[idx].raw_len = strlen(value);
+			priv->cells[idx].bytes = ETH_ALEN;
+			priv->cells[idx].read_post_process = u_boot_env_read_post_process_ethaddr;
+		}
 	}
 
 	if (WARN_ON(idx != priv->ncells))
-- 
2.25.1

