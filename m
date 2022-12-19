Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C3650B81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiLSM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiLSM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7E2DFD1;
        Mon, 19 Dec 2022 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452790; x=1702988790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WEdHlu62lXIIgtF0pXsUsRguyzZalokUxcEJKG5t4jg=;
  b=Gb8eJMefzkLArhsVeH5QaGO2EcFLPwMC36UrcAUCvNURMYc6YgfZ+pY3
   g9kkXlFun0sZccQwLc3vnBaDWIUSjE0uJkMTEKxKR6m90ckAC8PaaUMy5
   FV2aHWBUc+/EDwZYDSkvklK5a26s/CYhwLeAsVYr0oT/6PRir+kZ94ABG
   GcUtoZb2f3LUtLerCda7oeRmCYk5ou+3EJ8CO4zPv5kq6eKR1EzanLW9G
   to3yYOHHHLi5vsYjzICAGWlB9iP02t0SoH0u06ucmidkisvN8e3rRkO5H
   N107X9qnfJ/vW1o6ZW8NK4G68n1IoHSx3iuxs/tE024vlt50shxl+T86t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382670"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283702"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283702"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 15A085B3; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 11/17] pinctrl: jasperlake: Replace JSL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:37 +0200
Message-Id: <20221219122643.3513-11-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_GPPS() common macro instead custom JSL_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-jasperlake.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-jasperlake.c b/drivers/pinctrl/intel/pinctrl-jasperlake.c
index ec435b7ab392..086ab7fe08dd 100644
--- a/drivers/pinctrl/intel/pinctrl-jasperlake.c
+++ b/drivers/pinctrl/intel/pinctrl-jasperlake.c
@@ -29,18 +29,7 @@
 	}
 
 #define JSL_COMMUNITY(b, s, e, g)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = JSL_PAD_OWN,		\
-		.padcfglock_offset = JSL_PADCFGLOCK,	\
-		.hostown_offset = JSL_HOSTSW_OWN,	\
-		.is_offset = JSL_GPI_IS,		\
-		.ie_offset = JSL_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
+	INTEL_COMMUNITY_GPPS(b, s, e, g, JSL)
 
 /* Jasper Lake */
 static const struct pinctrl_pin_desc jsl_pins[] = {
-- 
2.35.1

