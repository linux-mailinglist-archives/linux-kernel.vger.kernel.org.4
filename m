Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A103713A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjE1OVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE1OVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:21:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3EEC7;
        Sun, 28 May 2023 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685283692; x=1716819692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZTkM6DTM94DRGqgS0Z6YEGqsq7Toa2hLcyOuCPilzRU=;
  b=E9jdJlVRUlgZcuqYvLWva6ubop3k2zh5sM5ynuri/8LSC9gVUEhS6y7r
   hQkmGGmOQPNVVlR7pjRtKGPdEr0v0mVEchwpCZGw6zbGoXXbcTXqMBrU+
   F+nyO8T9dyJY+IIduhD3/5d9Rq4jZ4x9Nq73N4ArzACtMhQQfiE4Awex2
   M1TKKS6cr0H9qrGdES8sXEd+LwW4Ge2X4txDnt0PXznNxqANdOZl8Ayh3
   HeVn9FC492bgLT3xD6ULIcpBpfKVwX4OwUSc79EwKAGpUpeR+XRgi1T00
   7CyKMqrT3qtvigT5qseNzDBVgsNrQXLaziZcwKuJgF0CNZ2RDRcdMpTW/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357767880"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="357767880"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 07:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1035915909"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="1035915909"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 May 2023 07:21:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B4FEA24F; Sun, 28 May 2023 17:21:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH v1 1/1] gpiolib: Kill unused GPIOF_EXPORT and Co
Date:   Sun, 28 May 2023 17:21:27 +0300
Message-Id: <20230528142127.37330-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no use of the  GPIOF_EXPORT in the kernel. Kill it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/legacy.rst                    | 3 ---
 Documentation/translations/zh_CN/driver-api/gpio/legacy.rst | 3 ---
 Documentation/translations/zh_TW/gpio.txt                   | 3 ---
 drivers/gpio/gpiolib-legacy.c                               | 6 ------
 include/linux/gpio.h                                        | 5 -----
 5 files changed, 20 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index 78372853c6d4..c5f98a78499f 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -322,9 +322,6 @@ where 'flags' is currently defined to specify the following properties:
 	* GPIOF_OPEN_DRAIN	- gpio pin is open drain type.
 	* GPIOF_OPEN_SOURCE	- gpio pin is open source type.
 
-	* GPIOF_EXPORT_DIR_FIXED	- export gpio to sysfs, keep direction
-	* GPIOF_EXPORT_DIR_CHANGEABLE	- also export, allow changing direction
-
 since GPIOF_INIT_* are only valid when configured as output, so group valid
 combinations as:
 
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
index 84ce2322fdba..8720970393fb 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
@@ -297,9 +297,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
 	* GPIOF_OPEN_DRAIN	- gpio引脚为开漏信号
 	* GPIOF_OPEN_SOURCE	- gpio引脚为源极开路信号
 
-	* GPIOF_EXPORT_DIR_FIXED	- 将 gpio 导出到 sysfs，并保持方向
-	* GPIOF_EXPORT_DIR_CHANGEABLE	- 同样是导出, 但允许改变方向
-
 因为 GPIOF_INIT_* 仅有在配置为输出的时候才存在,所以有效的组合为:
 
 	* GPIOF_IN		- 配置为输入
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index 62e560ffe628..e0b96d897fa7 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -303,9 +303,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
 	* GPIOF_OPEN_DRAIN	- gpio引腳爲開漏信號
 	* GPIOF_OPEN_SOURCE	- gpio引腳爲源極開路信號
 
-	* GPIOF_EXPORT_DIR_FIXED	- 將 gpio 導出到 sysfs，並保持方向
-	* GPIOF_EXPORT_DIR_CHANGEABLE	- 同樣是導出, 但允許改變方向
-
 因爲 GPIOF_INIT_* 僅有在配置爲輸出的時候才存在,所以有效的組合爲:
 
 	* GPIOF_IN		- 配置爲輸入
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index 028f7f504209..969f737012f6 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -50,12 +50,6 @@ int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 	if (err)
 		goto free_gpio;
 
-	if (flags & GPIOF_EXPORT) {
-		err = gpiod_export(desc, flags & GPIOF_EXPORT_CHANGEABLE);
-		if (err)
-			goto free_gpio;
-	}
-
 	return 0;
 
  free_gpio:
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 8528353e073b..86963a00b018 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -38,11 +38,6 @@ struct device;
 /* Gpio pin is open source */
 #define GPIOF_OPEN_SOURCE	(1 << 4)
 
-#define GPIOF_EXPORT		(1 << 5)
-#define GPIOF_EXPORT_CHANGEABLE	(1 << 6)
-#define GPIOF_EXPORT_DIR_FIXED	(GPIOF_EXPORT)
-#define GPIOF_EXPORT_DIR_CHANGEABLE (GPIOF_EXPORT | GPIOF_EXPORT_CHANGEABLE)
-
 /**
  * struct gpio - a structure describing a GPIO with configuration
  * @gpio:	the GPIO number
-- 
2.40.0.1.gaa8946217a0b

