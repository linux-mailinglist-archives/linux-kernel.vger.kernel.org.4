Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67375EE94F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiI1WWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiI1WWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:22:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA2F1628;
        Wed, 28 Sep 2022 15:22:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cv6so3435794pjb.5;
        Wed, 28 Sep 2022 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=lGz97QYEJFNBsy5dY0VRqJEEBdi/yXtXeELS9Xem+YU=;
        b=pb7rQIMpcIT2b9PEO0tPbwQE08NdN3twtEDhP7iEfvtJwEnDXmjg9UhIPr8AToejNu
         KwQURpVDeUpwkeUuPbrYAe+W5dTcVjS8ePOlK0LE/Xc7YGVgw/rjPTKs9Zk0hRaz+8U/
         qy5TqU1mqesKNf2nYsoKxdzdhnebXz9VpMdv0Sgfr0uEUU8h+9Uc5V5W1nglBy5GFaGz
         bjPWDbO67hs4hq/l8425BGSS05uFVAE70xvFoc4TTGd8ie3QUxAjJR87FzC1VCq+lGSL
         1WXnuSB0PevlaEF3UpP0Xb4ntgv85z8f6yxdjfNq3PihpfzJSdLP6J85X3rZZcVfAo6F
         04pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=lGz97QYEJFNBsy5dY0VRqJEEBdi/yXtXeELS9Xem+YU=;
        b=xOEanhaK44ZgGFjqlbSut5thUFJUQdGzdnD4N4AhYYmyNcbq0Uw5sA5vbdNCXqdQ/Y
         9i9FdgJ/VHnwGwlht2/DGXCnxtIUDZR/bKFNslCKojZXDtMcVEHwh333trbcOv+R/hSf
         clKBVWF/asp3sZel0x8AxrYSWdhaUOWd/07sFmGLirdBaZo1EAgAwwZStgdjfX1tvvK/
         tZ5+ocqhlEO6/ZDDXwvDoAQ5akY/0PcKFyXQdSHf5ZLLjXCJBn5p95EK/bXAKXBdKp7Z
         DtbdAB7S1iiRiTnr0YaskGNXPiz5BYmzTo4IrzP9kDlhhzoKKtDzqA5KeYl62fmM/CYM
         iDHA==
X-Gm-Message-State: ACrzQf0SkzHPTH1X17JAgQZuvWPcz+j+iyMRmo59/h17Ad+RU9EaCvDF
        AdB3Io2RWgkPkFxOlee8xkM=
X-Google-Smtp-Source: AMsMyM6IzFTHuML+YQrcZf/sqCaiIwvSpFx+BrX9KQsO42GNKkKvy23XsvpyRlC7dbgmyZSSlqYIRg==
X-Received: by 2002:a17:903:234c:b0:17a:a2e:40ce with SMTP id c12-20020a170903234c00b0017a0a2e40cemr118714plh.106.1664403734229;
        Wed, 28 Sep 2022 15:22:14 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id ru21-20020a17090b2bd500b002008a85bac1sm2023694pjb.49.2022.09.28.15.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:22:13 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] wifi: wl1251: drop support for platform data
Date:   Wed, 28 Sep 2022 15:22:09 -0700
Message-Id: <20220928222210.1922758-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

There are no users of wl1251_platform_data left in the mainline kernel,
so let's remove it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../net/wireless/ti/wilink_platform_data.c    | 35 ---------------
 drivers/net/wireless/ti/wl1251/sdio.c         |  8 +---
 drivers/net/wireless/ti/wl1251/spi.c          | 15 ++-----
 include/linux/wl12xx.h                        | 44 -------------------
 4 files changed, 4 insertions(+), 98 deletions(-)
 delete mode 100644 drivers/net/wireless/ti/wilink_platform_data.c
 delete mode 100644 include/linux/wl12xx.h

diff --git a/drivers/net/wireless/ti/wilink_platform_data.c b/drivers/net/wireless/ti/wilink_platform_data.c
deleted file mode 100644
index 1de6a62d526f..000000000000
--- a/drivers/net/wireless/ti/wilink_platform_data.c
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * This file is part of wl12xx
- *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
- */
-
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/wl12xx.h>
-
-static struct wl1251_platform_data *wl1251_platform_data;
-
-int __init wl1251_set_platform_data(const struct wl1251_platform_data *data)
-{
-	if (wl1251_platform_data)
-		return -EBUSY;
-	if (!data)
-		return -EINVAL;
-
-	wl1251_platform_data = kmemdup(data, sizeof(*data), GFP_KERNEL);
-	if (!wl1251_platform_data)
-		return -ENOMEM;
-
-	return 0;
-}
-
-struct wl1251_platform_data *wl1251_get_platform_data(void)
-{
-	if (!wl1251_platform_data)
-		return ERR_PTR(-ENODEV);
-
-	return wl1251_platform_data;
-}
-EXPORT_SYMBOL(wl1251_get_platform_data);
diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
index c9a4e9a43400..301bd0043a43 100644
--- a/drivers/net/wireless/ti/wl1251/sdio.c
+++ b/drivers/net/wireless/ti/wl1251/sdio.c
@@ -12,7 +12,6 @@
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/platform_device.h>
-#include <linux/wl12xx.h>
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
@@ -197,7 +196,6 @@ static int wl1251_sdio_probe(struct sdio_func *func,
 	struct wl1251 *wl;
 	struct ieee80211_hw *hw;
 	struct wl1251_sdio *wl_sdio;
-	const struct wl1251_platform_data *wl1251_board_data;
 	struct device_node *np = func->dev.of_node;
 
 	hw = wl1251_alloc_hw();
@@ -225,11 +223,7 @@ static int wl1251_sdio_probe(struct sdio_func *func,
 	wl->if_priv = wl_sdio;
 	wl->if_ops = &wl1251_sdio_ops;
 
-	wl1251_board_data = wl1251_get_platform_data();
-	if (!IS_ERR(wl1251_board_data)) {
-		wl->irq = wl1251_board_data->irq;
-		wl->use_eeprom = wl1251_board_data->use_eeprom;
-	} else if (np) {
+	if (np) {
 		wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
 		wl->irq = of_irq_get(np, 0);
 		if (wl->irq == -EPROBE_DEFER) {
diff --git a/drivers/net/wireless/ti/wl1251/spi.c b/drivers/net/wireless/ti/wl1251/spi.c
index 9df38726e8b0..08d9814b49c1 100644
--- a/drivers/net/wireless/ti/wl1251/spi.c
+++ b/drivers/net/wireless/ti/wl1251/spi.c
@@ -12,7 +12,6 @@
 #include <linux/swab.h>
 #include <linux/crc7.h>
 #include <linux/spi/spi.h>
-#include <linux/wl12xx.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
@@ -226,16 +225,13 @@ static const struct wl1251_if_operations wl1251_spi_ops = {
 
 static int wl1251_spi_probe(struct spi_device *spi)
 {
-	struct wl1251_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct device_node *np = spi->dev.of_node;
 	struct ieee80211_hw *hw;
 	struct wl1251 *wl;
 	int ret;
 
-	if (!np && !pdata) {
-		wl1251_error("no platform data");
+	if (!np)
 		return -ENODEV;
-	}
 
 	hw = wl1251_alloc_hw();
 	if (IS_ERR(hw))
@@ -259,14 +255,9 @@ static int wl1251_spi_probe(struct spi_device *spi)
 		goto out_free;
 	}
 
-	if (np) {
-		wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
-		wl->power_gpio = of_get_named_gpio(np, "ti,power-gpio", 0);
-	} else if (pdata) {
-		wl->power_gpio = pdata->power_gpio;
-		wl->use_eeprom = pdata->use_eeprom;
-	}
+	wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
 
+	wl->power_gpio = of_get_named_gpio(np, "ti,power-gpio", 0);
 	if (wl->power_gpio == -EPROBE_DEFER) {
 		ret = -EPROBE_DEFER;
 		goto out_free;
diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
deleted file mode 100644
index 03d61f1d23ab..000000000000
--- a/include/linux/wl12xx.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This file is part of wl12xx
- *
- * Copyright (C) 2009 Nokia Corporation
- *
- * Contact: Luciano Coelho <luciano.coelho@nokia.com>
- */
-
-#ifndef _LINUX_WL12XX_H
-#define _LINUX_WL12XX_H
-
-#include <linux/err.h>
-
-struct wl1251_platform_data {
-	int power_gpio;
-	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
-	int irq;
-	bool use_eeprom;
-};
-
-#ifdef CONFIG_WILINK_PLATFORM_DATA
-
-int wl1251_set_platform_data(const struct wl1251_platform_data *data);
-
-struct wl1251_platform_data *wl1251_get_platform_data(void);
-
-#else
-
-static inline
-int wl1251_set_platform_data(const struct wl1251_platform_data *data)
-{
-	return -ENOSYS;
-}
-
-static inline
-struct wl1251_platform_data *wl1251_get_platform_data(void)
-{
-	return ERR_PTR(-ENODATA);
-}
-
-#endif
-
-#endif
-- 
2.38.0.rc1.362.ged0d419d3c-goog

