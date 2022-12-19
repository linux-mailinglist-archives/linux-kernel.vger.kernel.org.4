Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEDA650B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiLSM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiLSM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C2BDEC2;
        Mon, 19 Dec 2022 04:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452792; x=1702988792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lD2WNMbGhWg9OhgYWLibWUcl9/Fo27U2GLeG+VzK6jo=;
  b=PpSbCN3ZmUyG1NQ6jNwcQ26wzTK/qgO4oIkH2wACbLVX9ekhlV8aXgKu
   C/X9dPOzqUSQJF65clnp6l7V/VCnxPd0q5MxgSvXN2G8Ae0XQ37yAjfI+
   qTv0xS3NYIBjhGO1HOHIWI8kVy+qpvo2vqWQkLfGjnFC6MIX+7vQR7zx9
   CugAHe+hjoVglN0sU32ii3nh0KHshGHdM/ciLSQ3tTJzoCyZ9SuaJTCCH
   9MLXu2XIU1NxEhacs2fS+2FNsYlYC3Qgl79uIsGdTl/Ryzz9Np88ZF2zm
   MwJ/TMxFi0wvPXfPfubPHB4UVewauuVr10W9eWPF8fr2nU1ymwGNTKb5z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302762257"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302762257"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824831637"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824831637"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 04:26:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2AB4C5F6; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 14/17] pinctrl: meteorlake: Replace MTL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:40 +0200
Message-Id: <20221219122643.3513-14-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_GPPS() common macro instead custom MTL_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-meteorlake.c | 23 ++++++----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-meteorlake.c b/drivers/pinctrl/intel/pinctrl-meteorlake.c
index 9576dcd1cb29..a82f6754c45b 100644
--- a/drivers/pinctrl/intel/pinctrl-meteorlake.c
+++ b/drivers/pinctrl/intel/pinctrl-meteorlake.c
@@ -14,11 +14,11 @@
 
 #include "pinctrl-intel.h"
 
-#define MTL_PAD_OWN	0x0b0
-#define MTL_PADCFGLOCK	0x110
-#define MTL_HOSTSW_OWN	0x140
-#define MTL_GPI_IS	0x200
-#define MTL_GPI_IE	0x210
+#define MTL_P_PAD_OWN		0x0b0
+#define MTL_P_PADCFGLOCK	0x110
+#define MTL_P_HOSTSW_OWN	0x140
+#define MTL_P_GPI_IS		0x200
+#define MTL_P_GPI_IE		0x210
 
 #define MTL_GPP(r, s, e, g)				\
 	{						\
@@ -29,18 +29,7 @@
 	}
 
 #define MTL_COMMUNITY(b, s, e, g)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = MTL_PAD_OWN,		\
-		.padcfglock_offset = MTL_PADCFGLOCK,	\
-		.hostown_offset = MTL_HOSTSW_OWN,	\
-		.is_offset = MTL_GPI_IS,		\
-		.ie_offset = MTL_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
+	INTEL_COMMUNITY_GPPS(b, s, e, g, MTL_P)
 
 /* Meteor Lake-P */
 static const struct pinctrl_pin_desc mtlp_pins[] = {
-- 
2.35.1

