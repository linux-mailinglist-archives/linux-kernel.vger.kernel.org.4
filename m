Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92841650B74
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiLSM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiLSM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348AADFC9;
        Mon, 19 Dec 2022 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452788; x=1702988788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vr66mB+X+nN+FNV+H9xxqKlBUIy4h6hLuyR2XHOPV0=;
  b=P1Ixxk21EawGwIZbyqJReZaax5jxmV89phE8QehiymMf+fOXznHlpSC5
   xmik8cWlJq+Mj2XNRjXATdibq6MJB7lPUWwcacoJvOPdpx0NB0zRzGfeU
   /5JIwubfym+zCyCtZXu2f5UXzaZlSgDizuHpLpRCLDu1xu0kGN7ybAdFX
   +kH+uP4GkUqRuvh46YiKVjibxnut0keRiCSzLy/FEAFrmM7JnAqfP+VC7
   gYhOG/enmz1HC72JMS8FTGhpoFHRBymGpPCb+LfRZIhO0vcMxqZA5n8fR
   lDXzv78YZ56WPjkob17TgCnSgStXBSQRI+2u2vPuOr5mbwZQlC2rVatUe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302762243"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302762243"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824831630"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824831630"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 04:26:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C73BE132; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 05/17] pinctrl: cedarfork: Replace CDF_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:31 +0200
Message-Id: <20221219122643.3513-5-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_GPPS() common macro instead custom CDF_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cedarfork.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cedarfork.c b/drivers/pinctrl/intel/pinctrl-cedarfork.c
index aa6f9040d3d8..2ab52b1fbc59 100644
--- a/drivers/pinctrl/intel/pinctrl-cedarfork.c
+++ b/drivers/pinctrl/intel/pinctrl-cedarfork.c
@@ -28,18 +28,7 @@
 	}
 
 #define CDF_COMMUNITY(b, s, e, g)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = CDF_PAD_OWN,		\
-		.padcfglock_offset = CDF_PADCFGLOCK,	\
-		.hostown_offset = CDF_HOSTSW_OWN,	\
-		.is_offset = CDF_GPI_IS,		\
-		.ie_offset = CDF_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
+	INTEL_COMMUNITY_GPPS(b, s, e, g, CDF)
 
 /* Cedar Fork PCH */
 static const struct pinctrl_pin_desc cdf_pins[] = {
-- 
2.35.1

