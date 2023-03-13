Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080DF6B7ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjCMOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCMOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:45:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E228862;
        Mon, 13 Mar 2023 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678718722; x=1710254722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xUYcK7XJvLY1dMjMeqZCwhuSpycc+EaqI3YKX0sIHTU=;
  b=W5wTwyUCeEmsEqMhoHF8fKVSPy+i1sQOYlmggghj4oOzNE2CMhmcKAA8
   Rb9gJGPn/MzcfCnwhatHMzUBXjhzTpIdnlbKj/JdySWlwJggnrbGv0NsZ
   YqC1ew70glAWga2w8pRkYxt+vpNze19zWDMTdO25z9XzDF3Ew/J7ZzayC
   VSA9SDhEa1H6qzSs8maFqib53rtK97VS7cEqoyzmdigMwG9cyvWljdgss
   xDH+TseRezjf0G1be8JZujO6inT3DARuI5gYB7a0U53RK+dvM/wvMu4Of
   StvQmaRbhsPeaXCZm0zTCJRzDs4AoMkIaADGXO20nTfalrwED98TpaGTN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325523379"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="325523379"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 07:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628662504"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="628662504"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2023 07:45:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C27CD365; Mon, 13 Mar 2023 16:46:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
Date:   Mon, 13 Mar 2023 16:45:57 +0200
Message-Id: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preliminary step, drop unused inclusions from of_gpio.h,
so people will use the header only when it's really needed and
not as a substitute of any of the dropped ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

For testing purposes on what will fail in CIs. People are also
encourage to test this, if have time / chance / wish.

 include/linux/of_gpio.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index d0f66a5e1b2a..bf6774632b5e 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -10,11 +10,6 @@
 #ifndef __LINUX_OF_GPIO_H
 #define __LINUX_OF_GPIO_H
 
-#include <linux/compiler.h>
-#include <linux/gpio/driver.h>
-#include <linux/gpio.h>		/* FIXME: Shouldn't be here */
-#include <linux/of.h>
-
 struct device_node;
 
 #ifdef CONFIG_OF_GPIO
-- 
2.39.2

