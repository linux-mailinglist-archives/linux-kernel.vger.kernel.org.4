Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526D5E81F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIWSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIWSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:46:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A711F137;
        Fri, 23 Sep 2022 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663958781; x=1695494781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9jhfX73gUsArJ3SoUzVU+ZDtU0JoItMsQDOrrko5PAM=;
  b=Ygm3GBoOoVUIte2rAyUwqkVSSWRhMYnNL6oMrjLOfMvS5aRSagPlnS1U
   BGKj7sJNfIJe2ELaLUj1K0crZyYyv6rHF672FA7QUP5xnbjOLVjz4FbLL
   C9GfqlxHPl6GSOHBi+H+UpPrZSvYWBdrbR5xuTYJ6HLp7p16B8zrSOwZv
   jk98esuGkzb0UgRG4xzn+vFYjZcdZJ1x9KXzovXdh7FzKbWtYMnaTWtA7
   FyjSEi/XnskLJpNLuFMWeSALlfcEaUt7KCy/+xmHpc1PjOq5InRPA2eUC
   6I1QtWYkVay907R4MjbyV7ug6MHtpf+t+mFCDgtm8r2syLfzPRhZkOlC8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="362482137"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="362482137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="949127416"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2022 11:46:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC06FF7; Fri, 23 Sep 2022 21:46:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 1/2] Input: matrix_keypad - add missed header inclusion
Date:   Fri, 23 Sep 2022 21:46:31 +0300
Message-Id: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The gpiod_count() API is defined in gpio/consumer.h. Include it.

Fixes: f8f7f47d576f ("Input: matrix_keypad - replace of_gpio_named_count() by gpiod_count()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/keyboard/matrix_keypad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 63f078f2bc4a..7dd3f3eda834 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/irq.h>
-- 
2.35.1

