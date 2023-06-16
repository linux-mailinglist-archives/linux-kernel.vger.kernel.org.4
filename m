Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B9733AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjFPUfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjFPUey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:34:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8DF3A9B;
        Fri, 16 Jun 2023 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686947693; x=1718483693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gqFVDbmVob3I2MoqOIXVaTRuNrQ5hYWbmLsucJsf0nY=;
  b=ac68FdO8tQy5GdqPGg00jlGyicPp/O8zg5oDTh5gS4tMXn750INuM/qg
   aAvSFlkz+zEwD0rarNEzT0po+jYyQYSqwZ/G4pPIFrcIxwVCwYyz8C2l8
   xWF+2pRQxXK/K1acH47LnR3ZSEFiB6T+Qinj84DLbg9BZeIgpFJ2wJu8v
   d3IUrGzcWAV9pVMtVpgI1L7oRkJJCIe40cpjegMzty6r4Z8o5cud8r2Jb
   nSvlAAWfkUW+vNHpGDzO8OZWR490D6C2Z1421c0O5wfDHX22berNG1ST0
   ilcfGTtjilIQbijl+HODZQ7IQVTjE0JpH8H6FT/WTTXk/KYygBoHyq+kF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358181776"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="358181776"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 13:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="802964400"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="802964400"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2023 13:34:50 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 57A7B911EA;
        Sat, 17 Jun 2023 02:04:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 5461CCA; Sat, 17 Jun 2023 02:04:49 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH for-next v1 3/3] pinctrl: baytrail: invert if condition
Date:   Sat, 17 Jun 2023 02:03:56 +0530
Message-Id: <20230616203356.27343-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616203356.27343-1-raag.jadav@intel.com>
References: <20230616203356.27343-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert if condition and get rid of redundant else.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 97ead2c58b66..27aef62fc7c0 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -753,9 +753,7 @@ static void byt_gpio_clear_triggering(struct intel_pinctrl *vg, unsigned int off
 	value = readl(reg);
 
 	/* Do not clear direct-irq enabled IRQs (from gpio_disable_free) */
-	if (value & BYT_DIRECT_IRQ_EN)
-		/* nothing to do */ ;
-	else
+	if (!(value & BYT_DIRECT_IRQ_EN))
 		value &= ~(BYT_TRIG_POS | BYT_TRIG_NEG | BYT_TRIG_LVL);
 
 	writel(value, reg);
-- 
2.17.1

