Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48568650B89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiLSM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiLSM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C320E015;
        Mon, 19 Dec 2022 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452791; x=1702988791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zilVtHbfodZnwooRd4T6k5LxB22pVeGuYh06DKiLmLA=;
  b=WuhvliGRg3wPgrHsz6bhT2lYVTUS8g9ViL3PlMJr9cLZ4EdhpitPY1g6
   6nATNwr4GJVDMJ6dDhH0HgbtP5mLx6WQ0sFHud3xNpQ0+JNuTFV4XDO2j
   FKfkWaX5Cb9DQVWT/bG9QkDEc+uRaaa6KhSjGVoYYVOyKIXLYtVscdXRc
   AaK7lwBwMq27gvuNJ1a9X0Kv0CEjcQ1uzUAGgGp9SVZqlQ9vvdRrZcowZ
   3tSu47MzhZXroRpLX8UFOQCKR+K4BNXdVKr8esKNGnjJ49uPo9tfCFv7U
   qtZOY54RfLp1AOZRKMYlthl3bRDIJOQ4Le6TwlcKOh6Kj9lpG8QsDsK/q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382674"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382674"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283706"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283706"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 319FC6F9; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 15/17] pinctrl: tigerlake: Replace TGL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:41 +0200
Message-Id: <20221219122643.3513-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INTEL_COMMUNITY_GPPS() common macro instead custom TGL_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-tigerlake.c | 30 ++++++++---------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tigerlake.c b/drivers/pinctrl/intel/pinctrl-tigerlake.c
index 431352fa2ab5..6e3a651d1241 100644
--- a/drivers/pinctrl/intel/pinctrl-tigerlake.c
+++ b/drivers/pinctrl/intel/pinctrl-tigerlake.c
@@ -15,13 +15,17 @@
 
 #include "pinctrl-intel.h"
 
-#define TGL_PAD_OWN		0x020
+#define TGL_LP_PAD_OWN		0x020
 #define TGL_LP_PADCFGLOCK	0x080
-#define TGL_H_PADCFGLOCK	0x090
 #define TGL_LP_HOSTSW_OWN	0x0b0
+#define TGL_LP_GPI_IS		0x100
+#define TGL_LP_GPI_IE		0x120
+
+#define TGL_H_PAD_OWN		0x020
+#define TGL_H_PADCFGLOCK	0x090
 #define TGL_H_HOSTSW_OWN	0x0c0
-#define TGL_GPI_IS		0x100
-#define TGL_GPI_IE		0x120
+#define TGL_H_GPI_IS		0x100
+#define TGL_H_GPI_IE		0x120
 
 #define TGL_GPP(r, s, e, g)				\
 	{						\
@@ -31,25 +35,11 @@
 		.gpio_base = (g),			\
 	}
 
-#define TGL_COMMUNITY(b, s, e, g, v)				\
-	{							\
-		.barno = (b),					\
-		.padown_offset = TGL_PAD_OWN,			\
-		.padcfglock_offset = TGL_##v##_PADCFGLOCK,	\
-		.hostown_offset = TGL_##v##_HOSTSW_OWN,		\
-		.is_offset = TGL_GPI_IS,			\
-		.ie_offset = TGL_GPI_IE,			\
-		.pin_base = (s),				\
-		.npins = ((e) - (s) + 1),			\
-		.gpps = (g),					\
-		.ngpps = ARRAY_SIZE(g),				\
-	}
-
 #define TGL_LP_COMMUNITY(b, s, e, g)			\
-	TGL_COMMUNITY(b, s, e, g, LP)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, TGL_LP)
 
 #define TGL_H_COMMUNITY(b, s, e, g)			\
-	TGL_COMMUNITY(b, s, e, g, H)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, TGL_H)
 
 /* Tiger Lake-LP */
 static const struct pinctrl_pin_desc tgllp_pins[] = {
-- 
2.35.1

