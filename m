Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E0667C04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbjALQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbjALQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:50:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47875B145;
        Thu, 12 Jan 2023 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541584; x=1705077584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JF5iRDY0fpuumx63GOwMxnOeegscSLVnrkxXT4Iq3pE=;
  b=UZUU/AITYcPRovBh5YnLR1t08amSk7p1JvgnXAFkVOmpQ4Ey66RqMHuS
   g70hiiHwttMAFUCQPmUh/jMd9F6zEZTTfLx0jwIUivacxt8tE2N2eL3kQ
   5pLFK56tOl2Jt88cTk28PJh2oRcob7zqZZueyJTWLxbfXJOOM6PN+F1lG
   5IhvvYishx9YadrRbbCOcjKNHi9cdIdqi0qyXOzNDb+dJf0UASc8Wmfjq
   7D8Od/yx+NNzM0ppjr06rn1wf3fN18b58G0COjKD3etmYibA84JwASdIh
   YMUQpaR8EM9FWBFhnOTDkpYQQ+2buTpM/KzR48rmASh460LQl9+rIdQ6d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304132804"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304132804"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="635447549"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="635447549"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2023 08:39:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D4DAE1; Thu, 12 Jan 2023 18:39:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moses Christopher Bollavarapu <mosescb.dev@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpio: zevio: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 18:39:40 +0200
Message-Id: <20230112163941.73143-1-andriy.shevchenko@linux.intel.com>
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

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-zevio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index ce9d1282165c..c9f4c26cae3d 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -162,7 +162,6 @@ static const struct gpio_chip zevio_gpio_chip = {
 	.base			= 0,
 	.owner			= THIS_MODULE,
 	.ngpio			= 32,
-	.of_gpio_n_cells	= 2,
 };
 
 /* Initialization */
-- 
2.39.0

