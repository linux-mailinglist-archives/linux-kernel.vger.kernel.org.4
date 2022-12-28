Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BCD65743D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiL1Iod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiL1Ina (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:43:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC78010050;
        Wed, 28 Dec 2022 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672216963; x=1703752963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yvP/Kpb34IpodRlx2V4r+vgRTyIqZNZX80kgm1NhNyI=;
  b=PUOr+Tfg7w/6wyhJQe4df5Lx/vuIsb1m1MXgyqenzYquyqSf2PXFE7Hc
   /VMIiFIORefA0d7prgfORlYc7mWoaFq8P0odVoILpuw4z8vgUplv8xC+O
   kqJ5A5RDTvon2AVUQaLx26wIe+5RxHyA8R6+p9swmUUP2Yn9gaSsRrc9C
   KM2mYp69KM41URKbq9PrBLQqHGc5Fse/fGWI0Bim5fjifdSnr6sJRKmF/
   Pl0zC7iyPX+DEThE8/OJgKkej9sP1EH7drCXtGPVDcbBDnIWgL5/Lv2ba
   MXTE/kcCNG2nUkam3xdemOnQOKwE2DwXK+TNCc4FSyoVCN8LunFAggUmE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322070118"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322070118"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 00:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="982039689"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="982039689"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Dec 2022 00:42:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7755D159; Wed, 28 Dec 2022 10:43:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] pinctrl: nomadik: Add missing header(s)
Date:   Wed, 28 Dec 2022 10:43:10 +0200
Message-Id: <20221228084310.85210-1-andriy.shevchenko@linux.intel.com>
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
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/nomadik/pinctrl-ab8500.c      |  3 +-
 drivers/pinctrl/nomadik/pinctrl-ab8505.c      |  3 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c      | 32 +++++++++++--------
 drivers/pinctrl/nomadik/pinctrl-abx500.h      |  4 +++
 .../pinctrl/nomadik/pinctrl-nomadik-db8500.c  |  3 ++
 .../pinctrl/nomadik/pinctrl-nomadik-stn8815.c |  3 ++
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     | 30 +++++++++--------
 drivers/pinctrl/nomadik/pinctrl-nomadik.h     |  5 +++
 8 files changed, 54 insertions(+), 29 deletions(-)

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
index f7d02513d8cc..22637cafebce 100644
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

