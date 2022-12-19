Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A7650B71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiLSM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiLSM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04299DF7C;
        Mon, 19 Dec 2022 04:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452787; x=1702988787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7vPTQnnjuQ9gqcG9EdtRC4WR2jbM7e9d3snebxXyn0=;
  b=ZDK7G8OfFEQ7C5H+t9RSIc2/4TXtBz9wUzXsiNQhXsROq6y9UWcBZrWD
   1LnEA2DJkhRTu8C2DkYyv/2+wybmq34vPx2fwPAYBD3GGL5Oy/RQFmcn5
   /BiPM5v4PcJWM5tLhVdNCQv/BHKRWjrwhLi11KJT3QrCKn8LdM3jw1QTV
   l28wrXPP46Llg5dI0qBaxcM+xIOwKA/X5ByIHRMDPgEmjb+Zt2Q0RU+KE
   wsabzJo2xkzDZYheqyDitZ+kzt7cRvJiaVnzpRWCACNGU+icGlRUWwYFn
   y17wFLEEs9VYAEgOoh9uviiCJfp4iZWnejOg7nKj4SI5HcK4s2iAj1Ed/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302762233"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302762233"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824831628"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824831628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 04:26:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A9289B7; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 02/17] pinctrl: alderlake: Replace ADL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:28 +0200
Message-Id: <20221219122643.3513-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INTEL_COMMUNITY_GPPS() common macro instead custom ADL_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-alderlake.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-alderlake.c b/drivers/pinctrl/intel/pinctrl-alderlake.c
index 427febe09b69..55bbfd647ba4 100644
--- a/drivers/pinctrl/intel/pinctrl-alderlake.c
+++ b/drivers/pinctrl/intel/pinctrl-alderlake.c
@@ -34,25 +34,11 @@
 		.gpio_base = (g),			\
 	}
 
-#define ADL_COMMUNITY(b, s, e, g, v)				\
-	{							\
-		.barno = (b),					\
-		.padown_offset = ADL_##v##_PAD_OWN,		\
-		.padcfglock_offset = ADL_##v##_PADCFGLOCK,	\
-		.hostown_offset = ADL_##v##_HOSTSW_OWN,		\
-		.is_offset = ADL_##v##_GPI_IS,			\
-		.ie_offset = ADL_##v##_GPI_IE,			\
-		.pin_base = (s),				\
-		.npins = ((e) - (s) + 1),			\
-		.gpps = (g),					\
-		.ngpps = ARRAY_SIZE(g),				\
-	}
-
 #define ADL_N_COMMUNITY(b, s, e, g)			\
-	ADL_COMMUNITY(b, s, e, g, N)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, ADL_N)
 
 #define ADL_S_COMMUNITY(b, s, e, g)			\
-	ADL_COMMUNITY(b, s, e, g, S)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, ADL_S)
 
 /* Alder Lake-N */
 static const struct pinctrl_pin_desc adln_pins[] = {
-- 
2.35.1

