Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5659650B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiLSM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiLSM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF706DFCE;
        Mon, 19 Dec 2022 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452790; x=1702988790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQ0pE9lQAKNGuk+R8xXXl/VW745Y6xWzxqnmj5FsCVM=;
  b=aCZD3Gw+54BPTkhx59ftp/m87az3anYJDRmSuuJORCFd5ghATPCZXRW1
   mWu6e7bj0MEjnsqetasb6hcdtUfCvYVsy9MFhYLik2X60v7PJgMeKZRFR
   wHAFX1kaz3WJAaeWgg9N5hswHihQYEyVnt2FO5qdJftZbzcteRLU3L+oV
   IanDlxDflgYz6x70jqwfOb5EfUoRKQIp8yVyQym9fPJBM5a/9wQbQW/1e
   YWVeOWuvJXBV449bg9OhvowlkgHpkCZYz5gI9EWa9U/yYg34TmgoXigFO
   CnFWlq6NQ4/K5TF1ubZ9p/WXtS/mrfu8j+cPzD68kXIcwUZoEdtQRyGca
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382668"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382668"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283701"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283701"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A08B580; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 10/17] pinctrl: icelake: Replace ICL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:36 +0200
Message-Id: <20221219122643.3513-10-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_GPPS() common macro instead custom ICL_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-icelake.c | 35 +++++++++----------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-icelake.c b/drivers/pinctrl/intel/pinctrl-icelake.c
index 84a56d9ae47e..1c64b4a1c491 100644
--- a/drivers/pinctrl/intel/pinctrl-icelake.c
+++ b/drivers/pinctrl/intel/pinctrl-icelake.c
@@ -15,12 +15,17 @@
 
 #include "pinctrl-intel.h"
 
-#define ICL_PAD_OWN	0x020
-#define ICL_PADCFGLOCK	0x080
-#define ICL_HOSTSW_OWN	0x0b0
-#define ICL_GPI_IS	0x100
-#define ICL_LP_GPI_IE	0x110
-#define ICL_N_GPI_IE	0x120
+#define ICL_LP_PAD_OWN		0x020
+#define ICL_LP_PADCFGLOCK	0x080
+#define ICL_LP_HOSTSW_OWN	0x0b0
+#define ICL_LP_GPI_IS		0x100
+#define ICL_LP_GPI_IE		0x110
+
+#define ICL_N_PAD_OWN		0x020
+#define ICL_N_PADCFGLOCK	0x080
+#define ICL_N_HOSTSW_OWN	0x0b0
+#define ICL_N_GPI_IS		0x100
+#define ICL_N_GPI_IE		0x120
 
 #define ICL_GPP(r, s, e, g)				\
 	{						\
@@ -30,25 +35,11 @@
 		.gpio_base = (g),			\
 	}
 
-#define ICL_COMMUNITY(b, s, e, g, v)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = ICL_PAD_OWN,		\
-		.padcfglock_offset = ICL_PADCFGLOCK,	\
-		.hostown_offset = ICL_HOSTSW_OWN,	\
-		.is_offset = ICL_GPI_IS,		\
-		.ie_offset = ICL_##v##_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
-
 #define ICL_LP_COMMUNITY(b, s, e, g)			\
-	ICL_COMMUNITY(b, s, e, g, LP)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, ICL_LP)
 
 #define ICL_N_COMMUNITY(b, s, e, g)			\
-	ICL_COMMUNITY(b, s, e, g, N)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, ICL_N)
 
 /* Ice Lake-LP */
 static const struct pinctrl_pin_desc icllp_pins[] = {
-- 
2.35.1

