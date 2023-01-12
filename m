Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22196675EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbjALO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjALO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:26:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927855854;
        Thu, 12 Jan 2023 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673533049; x=1705069049;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+9OeLd9jOBkiupMfGGpng53Agg/34VDvHZQiavcP+6w=;
  b=bGHILp/OgaL47aBNWltQ80ETVAkplGkLQXaoF2Ccr/b0DTPKuV6513tZ
   X/XU//Zoj4OV7K3VfTUbujCY5lX5fe+/bEa06/7/G3mLjZxB4/yUYEa3T
   r+BS3HABtohrtaMSquYCVh77gULrgx42ioTDj1JaSpbW6EeDrMogs3KKf
   6a3fOxLo5HSCqyrv1B1KO3fOi/fpl+tIivQQDpSVqZ3ZGI6Sg1HtTdGOi
   F6ew+Z/VTWR15cIUj+lh3jR7iSBiHW/X+lXUcbEZKzXqGqRVnKrnZdHew
   /UdhRvv84wMgXFegLQCpCJhgf9KdEueA525B2Z3f7NGaIY2M24QLuzJzc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="321406417"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="321406417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800218009"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="800218009"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 06:17:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6C97714B; Thu, 12 Jan 2023 16:17:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpiolib: Do not mention legacy API in the code
Date:   Thu, 12 Jan 2023 16:17:43 +0200
Message-Id: <20230112141743.63521-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Replace mentioning of legacy API by the latest one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 8e2e2618d40e..ddc7a14a274f 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -339,7 +339,7 @@ struct device_node;
  * @set_multiple: assigns output values for multiple signals defined by "mask"
  * @set_config: optional hook for all kinds of settings. Uses the same
  *	packed config format as generic pinconf.
- * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
+ * @to_irq: optional hook supporting non-static gpiod_to_irq() mappings;
  *	implementation may not sleep
  * @dbg_show: optional routine to show contents in debugfs; default code
  *	will be used when this is omitted, but custom code can show extra
-- 
2.39.0

