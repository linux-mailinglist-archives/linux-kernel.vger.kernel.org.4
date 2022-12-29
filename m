Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29469658B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiL2KQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiL2KNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:13:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C56479;
        Thu, 29 Dec 2022 02:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672308438; x=1703844438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=paLSuCdEXTeMtOuhafEQtKGV/Qef2iO8sy8oVi1aEGU=;
  b=UfD1OYy7Z9ZjNLgmBXD4uqzag7aRexw97vK7QqnnkI5vyU0HEvWyaF+y
   CcO9jbddeQyqKrYQ/m24P8DVCUP8IDbvwK0j2JLnylsrwRIVd6r69wY3e
   hUJ6NfjJesq9Jpt8mHWX4yXn6sMK5ZWheBCbeDuM6QDHqKIOzUQwCEQz2
   Rh7lZAO2sLivItCBdIFuWBT4o61oXEzLekthxz/h2E6S63/SSAZ+X7mbS
   DSlZHD9jjW5QNA+XD0/1VZZKtlyjGaAd4YnUh23Dmf1w2mciIGteVD0T4
   T8gIOZ3/ePLhcthS1uJRHhwkXOWJbI1gGkYgWSFvvxVM5tngKPabve4X1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="308775654"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="308775654"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 02:07:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="685945234"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="685945234"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 02:07:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 576EC159; Thu, 29 Dec 2022 12:07:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] pinctrl: nomadik: Add missing header(s)
Date:   Thu, 29 Dec 2022 12:07:46 +0200
Message-Id: <20221229100746.35047-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not imply that some of the generic headers may be always included.
Instead, include explicitly what we are direct user of.

While at it, sort headers alphabetically.

Fixes: e5530adc17a7 ("pinctrl: Clean up headers")
Cc: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: removed double inclusion (Randy)

 drivers/pinctrl/nomadik/pinctrl-ab8500.c      |  3 +-
 drivers/pinctrl/nomadik/pinctrl-ab8505.c      |  3 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c      | 32 +++++++++++--------
 drivers/pinctrl/nomadik/pinctrl-abx500.h      |  4 +++
 .../pinctrl/nomadik/pinctrl-nomadik-db8500.c  |  3 ++
 .../pinctrl/nomadik/pinctrl-nomadik-stn8815.c |  3 ++
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     | 32 ++++++++++---------
 drivers/pinctrl/nomadik/pinctrl-nomadik.h     |  5 +++
 8 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-ab8500.c b/drivers/pinctrl/nomadik/pinctrl-ab8500.c
index 3106a21cd277..d7b244df058f 100644
--- a/drivers/pinctrl/nomadik/pinctrl-ab8500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-ab8500.c
@@ -6,9 +6,10 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/gpio/driver.h>
 #include <linux/pinctrl/pinctrl.h>
+
 #include <linux/mfd/abx500/ab8500.h>
+
 #include "pinctrl-abx500.h"
 
 /* All the pins that can be used for GPIO and some other functions */
diff --git a/drivers/pinctrl/nomadik/pinctrl-ab8505.c b/drivers/pinctrl/nomadik/pinctrl-ab8505.c
index b93af1fb37f0..45aa958b573e 100644
--- a/drivers/pinctrl/nomadik/pinctrl-ab8505.c
+++ b/drivers/pinctrl/nomadik/pinctrl-ab8505.c
@@ -6,9 +6,10 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/gpio/driver.h>
 #include <linux/pinctrl/pinctrl.h>
+
 #include <linux/mfd/abx500/ab8500.h>
+
 #include "pinctrl-abx500.h"
 
 /* All the pins that can be used for GPIO and some other functions */
diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 7aa534576a45..28c3403df1b0 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -6,33 +6,37 @@
  *
  * Driver allows to use AxB5xx unused pins to be used as GPIO
  */
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/init.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
 #include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/interrupt.h>
-#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/pinctrl/pinctrl.h>
+
 #include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
 
-#include "pinctrl-abx500.h"
 #include "../core.h"
 #include "../pinconf.h"
 #include "../pinctrl-utils.h"
 
+#include "pinctrl-abx500.h"
+
 /*
  * GPIO registers offset
  * Bank: 0x10
diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.h b/drivers/pinctrl/nomadik/pinctrl-abx500.h
index 90bb12fe8073..d67522084675 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.h
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.h
@@ -2,6 +2,10 @@
 #ifndef PINCTRL_PINCTRL_ABx500_H
 #define PINCTRL_PINCTRL_ABx500_H
 
+#include <linux/types.h>
+
+struct pinctrl_pin_desc;
+
 /* Package definitions */
 #define PINCTRL_AB8500	0
 #define PINCTRL_AB8505	1
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c b/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
index 758d21f0a850..490e0959e8be 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
+#include <linux/types.h>
+
 #include <linux/pinctrl/pinctrl.h>
+
 #include "pinctrl-nomadik.h"
 
 /* All the pins that can be used for GPIO and some other functions */
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c b/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
index c0d7c86d0939..1552222ac68e 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
+#include <linux/types.h>
+
 #include <linux/pinctrl/pinctrl.h>
+
 #include "pinctrl-nomadik.h"
 
 /* All the pins that can be used for GPIO and some other functions */
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index f7d02513d8cc..86a638077a69 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -7,30 +7,34 @@
  *   Rewritten based on work by Prafulla WADASKAR <prafulla.wadaskar@st.com>
  * Copyright (C) 2011-2013 Linus Walleij <linus.walleij@linaro.org>
  */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
-#include <linux/spinlock.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/of_device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/of_address.h>
-#include <linux/bitops.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/* Since we request GPIOs from ourself */
+#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf.h>
-/* Since we request GPIOs from ourself */
-#include <linux/pinctrl/consumer.h>
-#include "pinctrl-nomadik.h"
+
 #include "../core.h"
 #include "../pinctrl-utils.h"
 
+#include "pinctrl-nomadik.h"
+
 /*
  * The GPIO module in the Nomadik family of Systems-on-Chip is an
  * AMBA device, managing 32 pins and alternate functions.  The logic block
@@ -907,8 +911,6 @@ static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
 	return (afunc ? NMK_GPIO_ALT_A : 0) | (bfunc ? NMK_GPIO_ALT_B : 0);
 }
 
-#include <linux/seq_file.h>
-
 static void nmk_gpio_dbg_show_one(struct seq_file *s,
 	struct pinctrl_dev *pctldev, struct gpio_chip *chip,
 	unsigned offset, unsigned gpio)
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.h b/drivers/pinctrl/nomadik/pinctrl-nomadik.h
index 84e297757335..1ef2559bc571 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.h
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.h
@@ -2,6 +2,11 @@
 #ifndef PINCTRL_PINCTRL_NOMADIK_H
 #define PINCTRL_PINCTRL_NOMADIK_H
 
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <linux/pinctrl/pinctrl.h>
+
 /* Package definitions */
 #define PINCTRL_NMK_STN8815	0
 #define PINCTRL_NMK_DB8500	1
-- 
2.35.1

