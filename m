Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD5650BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiLSMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiLSMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:42:31 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF352E02C;
        Mon, 19 Dec 2022 04:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453750; x=1702989750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFXRuNuxKSqw6oDareMv/+ap40tT1Fx8IbD+8iaDdIA=;
  b=IZXetE5XNAHD7uM/btlUAH6uU8hmpShZrZjomkb+CyNzsWvuFKxGg1aQ
   ArPLVfcN4PsEtShgjLLne7amUxMlGKxKmUmU90FadwGVxNLuXNcjLlf+1
   JUjCcYl8sRVd2khi7gEnbkVykPv7Zjnj+GFpf6g24fJtkxz9yMOZ8gybC
   GuqcZTMk1G36aYdwIjWudIkedB/0h4DjrXFar8xqBuNEIQ1rWZw3+1LK/
   KVppPNoENae3fpjluJCk0OW6Yu02dC7Z05UjgN+4uLvdK1EGjl73vIIG2
   bszhZ3ulISZwweOtgUA06YvSK3LqCoLcMtmgXWIg4a6YSpi86DYMGYZaH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="381564791"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="381564791"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="979361387"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="979361387"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2022 04:42:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6A45343A; Mon, 19 Dec 2022 14:42:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 8/8] pinctrl: intel: Get rid of unused members in struct intel_function
Date:   Mon, 19 Dec 2022 14:42:40 +0200
Message-Id: <20221219124240.62781-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
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

The driver has been converted to a generic data type and macro for
the pin function definition, hence get rid of not used members in
the struct intel_function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 91e5bedba00b..1faf2ada480a 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -37,15 +37,9 @@ struct intel_pingroup {
 /**
  * struct intel_function - Description about a function
  * @func: Generic data of the pin function (name and groups of pins)
- * @name: Name of the function
- * @groups: An array of groups for this function
- * @ngroups: Number of groups in @groups
  */
 struct intel_function {
 	struct pinfunction func;
-	const char *name;
-	const char * const *groups;
-	size_t ngroups;
 };
 
 #define INTEL_PINCTRL_MAX_GPP_SIZE	32
@@ -188,9 +182,6 @@ struct intel_community {
 #define FUNCTION(n, g)							\
 	{								\
 		.func = PINCTRL_PINFUNCTION((n), (g), ARRAY_SIZE(g)),	\
-		.name = (n),						\
-		.groups = (g),						\
-		.ngroups = ARRAY_SIZE((g)),				\
 	}
 
 /**
-- 
2.35.1

