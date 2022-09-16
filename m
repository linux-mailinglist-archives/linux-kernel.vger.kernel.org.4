Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29CC5BB3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIPUy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiIPUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:54:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999E3CBC8;
        Fri, 16 Sep 2022 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663361692; x=1694897692;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+VzWhmgyYCXNILKaundHDtRro3YKIfd1SdoSLC4IIgk=;
  b=GI3LgrwN7Oiyb3sEKpEQg09IVTKFQOmYr9cDXgDZz6O8IXrLVGsCX0HL
   xLcEc4TxsKtwuJmWvIVgQlhxT1iwXfvdR2uDzy8D2j2YkOuYrxgPhYOMf
   QCnHNhHh2g9cZSHfUcKNcBl1tP9r64QHi2RsMQx/m4PColMgZewVpFNRJ
   l0pL5iPkN8e+4a5bFDpc0PRDKr5korj+Y/T6LBlon46BcSxrT2q9lX0Wd
   YZ8mzcXzVS08MxmB+eoSMHKstcaLaTVxzxpNTd8vmMWQKfmopLmoxDMiC
   baaXBVLog/adiVxz0z3jOzeDnjjdHV6+DSbv3yOMZmU+jaWUq+30zbEBK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="297803155"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="297803155"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="862860544"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2022 13:54:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4051A238; Fri, 16 Sep 2022 23:54:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] pinctrl: cy8c95x0: Align function names in cy8c95x0_pmxops
Date:   Fri, 16 Sep 2022 23:54:50 +0300
Message-Id: <20220916205450.86278-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916205450.86278-1-andriy.shevchenko@linux.intel.com>
References: <20220916205450.86278-1-andriy.shevchenko@linux.intel.com>
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

Align the function names in the cy8c95x0_pmxops() to follow
the struct pinmux_ops members naming schema.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 367a9386dfb7..68509a2301b8 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1103,7 +1103,7 @@ static const struct pinctrl_ops cy8c95x0_pinctrl_ops = {
 	.pin_dbg_show = cy8c95x0_pin_dbg_show,
 };
 
-static const char *cy8c95x0_get_functions_name(struct pinctrl_dev *pctldev, unsigned int selector)
+static const char *cy8c95x0_get_function_name(struct pinctrl_dev *pctldev, unsigned int selector)
 {
 	return cy8c95x0_get_fname(selector);
 }
@@ -1113,9 +1113,9 @@ static int cy8c95x0_get_functions_count(struct pinctrl_dev *pctldev)
 	return 2;
 }
 
-static int cy8c95x0_get_groups(struct pinctrl_dev *pctldev, unsigned int selector,
-			       const char * const **groups,
-			       unsigned int * const num_groups)
+static int cy8c95x0_get_function_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+					const char * const **groups,
+					unsigned int * const num_groups)
 {
 	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1164,8 +1164,8 @@ static int cy8c95x0_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 
 static const struct pinmux_ops cy8c95x0_pmxops = {
 	.get_functions_count = cy8c95x0_get_functions_count,
-	.get_function_name = cy8c95x0_get_functions_name,
-	.get_function_groups = cy8c95x0_get_groups,
+	.get_function_name = cy8c95x0_get_function_name,
+	.get_function_groups = cy8c95x0_get_function_groups,
 	.set_mux = cy8c95x0_set_mux,
 	.strict = true,
 };
-- 
2.35.1

