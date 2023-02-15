Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E23698196
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjBORFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBORFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:05:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF23669D;
        Wed, 15 Feb 2023 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676480721; x=1708016721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EkzFT1Nke/B9I8aR5SnJ8afv1Mh9pNWCQQ/xa3G/7d0=;
  b=Wr3rTZrgtWAfhc8fKQGgLyULBK9/YwycvUcEcVr2JL9ONLxdBHpoKgWe
   USUlaEhtjpyw4u0J4OpmvVaiUBulH/C1OxB1RleNn7aPWhJo0pYy5xANk
   hBx3ProW6Xg/FzReNWh+9X0zzBPP+QE+jgDOQfNlDw0/9TSqF6RkbRha7
   UIAJS86O7l0saapAAxrAgKFheAjrAxbYHIZOwCdOo/mS2uTqo0LEUXyRL
   W4oNGjTxShP8ZmMfmNb7U1/cq4hclNdcw/RYFSsRh3kihkjNbZjlhesja
   rVhRhgI/++TgAdJ1812pD6vhNZyithFr+GgvkKYTDcimDIiLga3YicWG/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="393886453"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="393886453"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 09:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="647262367"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="647262367"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2023 09:03:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2070B1A6; Wed, 15 Feb 2023 19:04:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/2] leds: lp8860: Remove unused of_gpio,h
Date:   Wed, 15 Feb 2023 19:04:02 +0200
Message-Id: <20230215170403.84449-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_gpio.h provides a single function, which is not used in this driver.
Remove unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-lp8860.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index b66ed5ac1aa5..666f4d38214f 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
-- 
2.39.1

