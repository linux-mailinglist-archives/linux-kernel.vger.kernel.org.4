Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9002F650B87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiLSM1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiLSM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCDDF7C;
        Mon, 19 Dec 2022 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452791; x=1702988791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MgTVQspvxypYWPH2mE03rgHPPqPElJG5kwQZEMZhevw=;
  b=ByrfnuLbTrjULg9L9M3+XIxMyjEzWgTYXw5GBjz201qtFTIHucY9gvfm
   5ZRuI/8Xgnv3lKDjB/ePW82v+zApc0wpvZNHRrr/fV/fYwm4iudN1RVD+
   iYyj079lNh2TCnyjP448BHtLQZVeLO++jdxgH1JYTQeP9F861ym0jqK60
   GCfg9XKhry15rusEDz2CU8D6HPh6DxY334Dhl1DtN0y4tbVp4yGsMdyZ3
   izhMBwi734mOgRcY4sEdVx+vAJin96Cwp/N4MfmBhHw9SA5GFpRXr09N5
   l5qRr1aEjPBrqPo7W3r9MYYGEmkI3anaT0uCOOT595uJFpQri4ERy3XxJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382680"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382680"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283704"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283704"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C6BE5BB; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 12/17] pinctrl: lakefield: Replace LKF_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:38 +0200
Message-Id: <20221219122643.3513-12-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_GPPS() common macro instead custom LKF_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lakefield.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lakefield.c b/drivers/pinctrl/intel/pinctrl-lakefield.c
index 3c6283c4827f..8dac2d6012b1 100644
--- a/drivers/pinctrl/intel/pinctrl-lakefield.c
+++ b/drivers/pinctrl/intel/pinctrl-lakefield.c
@@ -29,18 +29,7 @@
 	}
 
 #define LKF_COMMUNITY(b, s, e, g)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = LKF_PAD_OWN,		\
-		.padcfglock_offset = LKF_PADCFGLOCK,	\
-		.hostown_offset = LKF_HOSTSW_OWN,	\
-		.is_offset = LKF_GPI_IS,		\
-		.ie_offset = LKF_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
+	INTEL_COMMUNITY_GPPS(b, s, e, g, LKF)
 
 /* Lakefield */
 static const struct pinctrl_pin_desc lkf_pins[] = {
-- 
2.35.1

