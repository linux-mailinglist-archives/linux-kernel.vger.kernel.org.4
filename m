Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2128F7151B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjE2WQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjE2WQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:16:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B411F;
        Mon, 29 May 2023 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685398566; x=1716934566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxGmo102AnFebW7BplsrcPsTKI6SgAEjRaqKEH+ORTc=;
  b=DZZ+bcyN/B+DXSJcKxlf1eP6utPAHCBge4d8grbnVSY37u4ialPri5N7
   x2i5oNGlKZAV19DejE3upPLhYzntTc+ZjjLAuljra6J21f5QlHCgUzOqZ
   Z30GX9uMhRnyMXqB7aFbh/o0Bywvrz+eIW2qa4tRsq0eikErcxVyR5A4v
   GbOHaCkCdk91Kl6+SGhThbQGUlEqlluY1nfdD3BBss/WAQBwS/8ZSF1Xu
   agQ0prDGdHiiVz0AcPJzFo6t8pfV0ZzoDR75IqeFwss9Xf53ot7W0JUTl
   ALET8Jq6tuJKkC7aubnJF27REwZ9h9LKLV5+qBgfxnfCl5mcQbt60oz3I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="353615855"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="353615855"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 15:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700382383"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="700382383"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 May 2023 15:14:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82245350; Tue, 30 May 2023 01:14:51 +0300 (EEST)
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
Subject: [PATCH v2 2/2] gpiolib: Kill unused GPIOF_OPEN_*
Date:   Tue, 30 May 2023 01:14:46 +0300
Message-Id: <20230529221446.87785-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230529221446.87785-1-andriy.shevchenko@linux.intel.com>
References: <20230529221446.87785-1-andriy.shevchenko@linux.intel.com>
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

There is no use of the GPIOF_OPEN_* in the kernel. Kill it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new change
 Documentation/driver-api/gpio/legacy.rst         | 16 ----------------
 .../zh_CN/driver-api/gpio/legacy.rst             | 14 --------------
 Documentation/translations/zh_TW/gpio.txt        | 14 --------------
 drivers/gpio/gpiolib-legacy.c                    |  6 ------
 include/linux/gpio.h                             |  6 ------
 5 files changed, 56 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index c5f98a78499f..9eda54811faa 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -319,8 +319,6 @@ where 'flags' is currently defined to specify the following properties:
 
 	* GPIOF_INIT_LOW	- as output, set initial level to LOW
 	* GPIOF_INIT_HIGH	- as output, set initial level to HIGH
-	* GPIOF_OPEN_DRAIN	- gpio pin is open drain type.
-	* GPIOF_OPEN_SOURCE	- gpio pin is open source type.
 
 since GPIOF_INIT_* are only valid when configured as output, so group valid
 combinations as:
@@ -329,20 +327,6 @@ combinations as:
 	* GPIOF_OUT_INIT_LOW	- configured as output, initial level LOW
 	* GPIOF_OUT_INIT_HIGH	- configured as output, initial level HIGH
 
-When setting the flag as GPIOF_OPEN_DRAIN then it will assume that pins is
-open drain type. Such pins will not be driven to 1 in output mode. It is
-require to connect pull-up on such pins. By enabling this flag, gpio lib will
-make the direction to input when it is asked to set value of 1 in output mode
-to make the pin HIGH. The pin is make to LOW by driving value 0 in output mode.
-
-When setting the flag as GPIOF_OPEN_SOURCE then it will assume that pins is
-open source type. Such pins will not be driven to 0 in output mode. It is
-require to connect pull-down on such pin. By enabling this flag, gpio lib will
-make the direction to input when it is asked to set value of 0 in output mode
-to make the pin LOW. The pin is make to HIGH by driving value 1 in output mode.
-
-In the future, these flags can be extended to support more properties.
-
 Further more, to ease the claim/release of multiple GPIOs, 'struct gpio' is
 introduced to encapsulate all three fields as::
 
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
index 8720970393fb..1bddecf73670 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
@@ -294,8 +294,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
 
 	* GPIOF_INIT_LOW	- 在作为输出时,初始值为低电平
 	* GPIOF_INIT_HIGH	- 在作为输出时,初始值为高电平
-	* GPIOF_OPEN_DRAIN	- gpio引脚为开漏信号
-	* GPIOF_OPEN_SOURCE	- gpio引脚为源极开路信号
 
 因为 GPIOF_INIT_* 仅有在配置为输出的时候才存在,所以有效的组合为:
 
@@ -303,18 +301,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
 	* GPIOF_OUT_INIT_LOW	- 配置为输出,并初始化为低电平
 	* GPIOF_OUT_INIT_HIGH	- 配置为输出,并初始化为高电平
 
-当设置 flag 为 GPIOF_OPEN_DRAIN 时，则假设引脚是开漏信号。这样的引脚
-将不会在输出模式下置1。这样的引脚需要连接上拉电阻。通过使能这个标志，gpio库
-将会在被要求输出模式下置1时将引脚变为输入状态来使引脚置高。引脚在输出模式下
-通过置0使其输出低电平。
-
-当设置 flag 为 GPIOF_OPEN_SOURCE 时，则假设引脚为源极开路信号。这样的引脚
-将不会在输出模式下置0。这样的引脚需要连接下拉电阻。通过使能这个标志，gpio库
-将会在被要求输出模式下置0时将引脚变为输入状态来使引脚置低。引脚在输出模式下
-通过置1使其输出高电平。
-
-将来这些标志可能扩展到支持更多的属性。
-
 更进一步,为了更简单地声明/释放多个 GPIO,'struct gpio'被引进来封装所有
 这三个领域::
 
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index e0b96d897fa7..66bc7f2bbe53 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -300,8 +300,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
 
 	* GPIOF_INIT_LOW	- 在作爲輸出時,初始值爲低電平
 	* GPIOF_INIT_HIGH	- 在作爲輸出時,初始值爲高電平
-	* GPIOF_OPEN_DRAIN	- gpio引腳爲開漏信號
-	* GPIOF_OPEN_SOURCE	- gpio引腳爲源極開路信號
 
 因爲 GPIOF_INIT_* 僅有在配置爲輸出的時候才存在,所以有效的組合爲:
 
@@ -309,18 +307,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
 	* GPIOF_OUT_INIT_LOW	- 配置爲輸出,並初始化爲低電平
 	* GPIOF_OUT_INIT_HIGH	- 配置爲輸出,並初始化爲高電平
 
-當設置 flag 爲 GPIOF_OPEN_DRAIN 時，則假設引腳是開漏信號。這樣的引腳
-將不會在輸出模式下置1。這樣的引腳需要連接上拉電阻。通過使能這個標誌，gpio庫
-將會在被要求輸出模式下置1時將引腳變爲輸入狀態來使引腳置高。引腳在輸出模式下
-通過置0使其輸出低電平。
-
-當設置 flag 爲 GPIOF_OPEN_SOURCE 時，則假設引腳爲源極開路信號。這樣的引腳
-將不會在輸出模式下置0。這樣的引腳需要連接下拉電阻。通過使能這個標誌，gpio庫
-將會在被要求輸出模式下置0時將引腳變爲輸入狀態來使引腳置低。引腳在輸出模式下
-通過置1使其輸出高電平。
-
-將來這些標誌可能擴展到支持更多的屬性。
-
 更進一步,爲了更簡單地聲明/釋放多個 GPIO,'struct gpio'被引進來封裝所有
 這三個領域:
 
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index 969f737012f6..87537657d040 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -32,12 +32,6 @@ int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 	if (err)
 		return err;
 
-	if (flags & GPIOF_OPEN_DRAIN)
-		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
-
-	if (flags & GPIOF_OPEN_SOURCE)
-		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
-
 	if (flags & GPIOF_ACTIVE_LOW)
 		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
 
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 86963a00b018..88efac969754 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -32,12 +32,6 @@ struct device;
 /* Gpio pin is active-low */
 #define GPIOF_ACTIVE_LOW        (1 << 2)
 
-/* Gpio pin is open drain */
-#define GPIOF_OPEN_DRAIN	(1 << 3)
-
-/* Gpio pin is open source */
-#define GPIOF_OPEN_SOURCE	(1 << 4)
-
 /**
  * struct gpio - a structure describing a GPIO with configuration
  * @gpio:	the GPIO number
-- 
2.40.0.1.gaa8946217a0b

