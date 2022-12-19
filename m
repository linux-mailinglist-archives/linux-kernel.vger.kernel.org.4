Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B2650B85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiLSM1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiLSM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D5DEC2;
        Mon, 19 Dec 2022 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452789; x=1702988789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdWcVI4CgNkyNHsLiRZGRTpc2OVl6lYx9EbkNfottGA=;
  b=LeTnpomKI01CR5uP0Jj1bJ7o3BNd8UWf+kXHj8prnJ0P+Yl4gqFYYl60
   y9QVlTcXtX28xj71UdZDTvHJqfmShXtkPDQGveiSBu0m6Uma4yGhYsfFB
   p4F1FUIyQ02CMk58ouvn7AL1CzUBffBdtw75IbLiMzNkLn/1puQ1sjTC8
   idQMcUfd7fvLP8AjaKAy/iJ+sY5bXq9BqEhvSvkCV0NQZszJKm3RiCqpj
   lwQ3nCX91VmhZcGSkSzlI6pTYBi1Sjk3+2TPt/R1nYlxZ6+Yjp8e4NnK9
   4Hjk+JK4Q+uOeUgOxCx+gizaXTqs3ChSr0nrsOnJ0WUCL4Om+HlKfAxN8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382662"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283699"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283699"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB50321C; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 07/17] pinctrl: elkhartlake: Replace EHL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:33 +0200
Message-Id: <20221219122643.3513-7-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_GPPS() common macro instead custom EHL_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-elkhartlake.c | 24 ++++++---------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-elkhartlake.c b/drivers/pinctrl/intel/pinctrl-elkhartlake.c
index 4702bdfa10e3..64b1997df0be 100644
--- a/drivers/pinctrl/intel/pinctrl-elkhartlake.c
+++ b/drivers/pinctrl/intel/pinctrl-elkhartlake.c
@@ -27,18 +27,8 @@
 		.size = ((e) - (s) + 1),		\
 	}
 
-#define EHL_COMMUNITY(s, e, g)				\
-	{						\
-		.padown_offset = EHL_PAD_OWN,		\
-		.padcfglock_offset = EHL_PADCFGLOCK,	\
-		.hostown_offset = EHL_HOSTSW_OWN,	\
-		.is_offset = EHL_GPI_IS,		\
-		.ie_offset = EHL_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
+#define EHL_COMMUNITY(b, s, e, g)			\
+	INTEL_COMMUNITY_GPPS(b, s, e, g, EHL)
 
 /* Elkhart Lake */
 static const struct pinctrl_pin_desc ehl_community0_pins[] = {
@@ -121,7 +111,7 @@ static const struct intel_padgroup ehl_community0_gpps[] = {
 };
 
 static const struct intel_community ehl_community0[] = {
-	EHL_COMMUNITY(0, 66, ehl_community0_gpps),
+	EHL_COMMUNITY(0, 0, 66, ehl_community0_gpps),
 };
 
 static const struct intel_pinctrl_soc_data ehl_community0_soc_data = {
@@ -262,7 +252,7 @@ static const struct intel_padgroup ehl_community1_gpps[] = {
 };
 
 static const struct intel_community ehl_community1[] = {
-	EHL_COMMUNITY(0, 112, ehl_community1_gpps),
+	EHL_COMMUNITY(0, 0, 112, ehl_community1_gpps),
 };
 
 static const struct intel_pinctrl_soc_data ehl_community1_soc_data = {
@@ -335,7 +325,7 @@ static const struct intel_padgroup ehl_community3_gpps[] = {
 };
 
 static const struct intel_community ehl_community3[] = {
-	EHL_COMMUNITY(0, 46, ehl_community3_gpps),
+	EHL_COMMUNITY(0, 0, 46, ehl_community3_gpps),
 };
 
 static const struct intel_pinctrl_soc_data ehl_community3_soc_data = {
@@ -441,7 +431,7 @@ static const struct intel_padgroup ehl_community4_gpps[] = {
 };
 
 static const struct intel_community ehl_community4[] = {
-	EHL_COMMUNITY(0, 79, ehl_community4_gpps),
+	EHL_COMMUNITY(0, 0, 79, ehl_community4_gpps),
 };
 
 static const struct intel_pinctrl_soc_data ehl_community4_soc_data = {
@@ -469,7 +459,7 @@ static const struct intel_padgroup ehl_community5_gpps[] = {
 };
 
 static const struct intel_community ehl_community5[] = {
-	EHL_COMMUNITY(0, 7, ehl_community5_gpps),
+	EHL_COMMUNITY(0, 0, 7, ehl_community5_gpps),
 };
 
 static const struct intel_pinctrl_soc_data ehl_community5_soc_data = {
-- 
2.35.1

