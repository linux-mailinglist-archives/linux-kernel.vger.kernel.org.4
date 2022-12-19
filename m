Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45906650B86
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiLSM1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiLSM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:31 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325DDFC9;
        Mon, 19 Dec 2022 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452790; x=1702988790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iMLdNNO1hMk56m2xtFasBjRkvMDBbrcO/XmmuYRFxSM=;
  b=S8RpxcgoJfqYIv8pdGJlUPZ4sVsQTTQs5XidtcFakKxKnfBtoJwRTxD1
   HCSDMy6EJ9j07nKDWKqnaViwJUj0cWucp6A9Yxy2+AVrlFf6drFlNoEvi
   QkIuj/86v9uWh8KH54eSG1yxpQsSgrgNWaTCajOAEzWQq6ShvEzLG1pyx
   lGRgKoW/ncQ6gN2Isf1B/G0bdtcOCPKpFkfK3XTzwrG0TYGjWRIZegYTO
   TiwlTmwWyu5L7Nxx7h0CQs+MgLx5H9tgjt122ckX88RmxOEPsY3da3zWx
   wsUEKc3JpRfZdeA0Sm9uaobafsR4NGHbFK5P87bkptE1KY7grC01kR1MF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302762250"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302762250"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824831634"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824831634"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 04:26:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5C7F223; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 06/17] pinctrl: denverton: Replace DNV_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:32 +0200
Message-Id: <20221219122643.3513-6-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_GPPS() common macro instead custom DNV_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-denverton.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-denverton.c b/drivers/pinctrl/intel/pinctrl-denverton.c
index f26d030b9b41..c1a9db091c6e 100644
--- a/drivers/pinctrl/intel/pinctrl-denverton.c
+++ b/drivers/pinctrl/intel/pinctrl-denverton.c
@@ -28,18 +28,7 @@
 	}
 
 #define DNV_COMMUNITY(b, s, e, g)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = DNV_PAD_OWN,		\
-		.padcfglock_offset = DNV_PADCFGLOCK,	\
-		.hostown_offset = DNV_HOSTSW_OWN,	\
-		.is_offset = DNV_GPI_IS,		\
-		.ie_offset = DNV_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
+	INTEL_COMMUNITY_GPPS(b, s, e, g, DNV)
 
 /* Denverton */
 static const struct pinctrl_pin_desc dnv_pins[] = {
-- 
2.35.1

