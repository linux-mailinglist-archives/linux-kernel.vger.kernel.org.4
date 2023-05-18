Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0F7085D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjERQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjERQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:18:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D4F13E;
        Thu, 18 May 2023 09:18:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso3491211a12.0;
        Thu, 18 May 2023 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684426680; x=1687018680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVuUzhjr+2NlfNCMwyqYcJUkzoS2xm3xsSK+vysljqE=;
        b=YVCinwZm3Gpv165ZjZWCIZri/1QZyYQIn49J9Kna/LVRhk/XIwcv1WY5QUr8Q9Icu3
         cMb/ONAZxrlMVXZhp/YyKT2rQHoS2qKCMR8BoJNraCeeEmshi/25pkRvIp4XFU3Tr9yH
         p0lXXjLx4UNsmdPhM6//okX+LaoS5s1KjaekoR/um3vqF5YXO9SuLE2zAr9SBnI4WUkD
         JUWN8p0E8yvngOA+LoUY6arbd8uxvmJ1MAtaGxgBPSGzKg26Bwp0VWc1cV/uzfSXsK/p
         bR0hdNi2GsR/srkw+Xl/Z85XnlldRR2c0NwmFl06UVo/9ZA0P893nrJ5yFsCcJFXzDPH
         8KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426680; x=1687018680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVuUzhjr+2NlfNCMwyqYcJUkzoS2xm3xsSK+vysljqE=;
        b=egpNzWzZWM/NubZnNGuiwMj+u1HDBLnbWYOlbjjo2lgaHHpo79LnGTdsTAMN+y0NYW
         kp/N+fjB69xkBE0pGh5JeMSnZy1CTirvQPuFGIpBjhHebkI3ncylBgdh0GwGLdHK7woW
         bILF2SHNfabgLy4Xax7glF+COJog/q/4zpqxtLawkRwsgirJb8BkOrTaXx5NEc8rkl45
         JhzHFPzltNTTeC7ix2Z4sjU/ONjmmEa0gejjWGQQ40Hl6LUFT6xDOMMwpqVfLU3ZWi4/
         6zlmz/D9KoTGeL0VxGLDl8l/5tuUNd7c6SzM9cFF7B/24LjVg+YPRu6OIDSkjQDDVqne
         f7gA==
X-Gm-Message-State: AC+VfDyFVd1wdr242DLfjVP9+R8NDZzXEnyPqa1b8+tDTGb+6zLW3gd5
        ZSB/axLcety77X/0ol7PlXU3SE27ogQ=
X-Google-Smtp-Source: ACHHUZ4SCXgMWbeecxLrsOOUibPYuErb/E+Wn+uaw1/dOF9iex4ZUNGyodWojXCBkYT4U1FrcdWZaA==
X-Received: by 2002:a05:6402:53:b0:4fa:b302:84d4 with SMTP id f19-20020a056402005300b004fab30284d4mr5088857edu.13.1684426680518;
        Thu, 18 May 2023 09:18:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-73e5-9e00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:73e5:9e00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020aa7c74e000000b0050bc13e5aa9sm756307eds.63.2023.05.18.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:18:00 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
Date:   Thu, 18 May 2023 18:17:49 +0200
Message-Id: <20230518161749.1311949-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up RTL8723DS chipset support using the rtw88 SDIO HCI code as well
as the existing RTL8723D chipset code.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig    | 11 +++++
 drivers/net/wireless/realtek/rtw88/Makefile   |  3 ++
 .../net/wireless/realtek/rtw88/rtw8723ds.c    | 41 +++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723ds.c

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 29eb2f8e0eb7..cffad1c01249 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -111,6 +111,17 @@ config RTW88_8723DE
 
 	  802.11n PCIe wireless network adapter
 
+config RTW88_8723DS
+	tristate "Realtek 8723DS SDIO wireless network adapter"
+	depends on MMC
+	select RTW88_CORE
+	select RTW88_SDIO
+	select RTW88_8723D
+	help
+	  Select this option will enable support for 8723DS chipset
+
+	  802.11n SDIO wireless network adapter
+
 config RTW88_8723DU
 	tristate "Realtek 8723DU USB wireless network adapter"
 	depends on USB
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 82979b30ae8d..fd212c09d88a 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -50,6 +50,9 @@ rtw88_8723d-objs		:= rtw8723d.o rtw8723d_table.o
 obj-$(CONFIG_RTW88_8723DE)	+= rtw88_8723de.o
 rtw88_8723de-objs		:= rtw8723de.o
 
+obj-$(CONFIG_RTW88_8723DS)	+= rtw88_8723ds.o
+rtw88_8723ds-objs		:= rtw8723ds.o
+
 obj-$(CONFIG_RTW88_8723DU)	+= rtw88_8723du.o
 rtw88_8723du-objs		:= rtw8723du.o
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
new file mode 100644
index 000000000000..e5b6960ba0a0
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ */
+
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/module.h>
+#include "main.h"
+#include "rtw8723d.h"
+#include "sdio.h"
+
+static const struct sdio_device_id rtw_8723ds_id_table[] =  {
+	{
+		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
+			    SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT),
+		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec,
+	},
+	{
+		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
+			    SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT),
+		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(sdio, rtw_8723ds_id_table);
+
+static struct sdio_driver rtw_8723ds_driver = {
+	.name = "rtw_8723ds",
+	.probe = rtw_sdio_probe,
+	.remove = rtw_sdio_remove,
+	.id_table = rtw_8723ds_id_table,
+	.drv = {
+		.pm = &rtw_sdio_pm_ops,
+		.shutdown = rtw_sdio_shutdown,
+	}
+};
+module_sdio_driver(rtw_8723ds_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Realtek 802.11n wireless 8723ds driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.40.1

