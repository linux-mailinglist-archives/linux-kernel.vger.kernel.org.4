Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381E698156
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBOQvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBOQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:51:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8091360B7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676479891; x=1708015891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vxxvkcIxxjyHZj30W0rPKZe+cKEOLoFr41szlqVvpFU=;
  b=bneB541IrX1+ADbQLOdab30xLysZ0WFIqrxH7u1/IKBi8xxQ+iV4Xbkf
   tGYUcaEsTwGKf5bQpUg4bpzEudGH/veq05RdEU48ejhT2f4gord+3x5yD
   DmHjN5oxkigzd7zOxmdv27q9dj0hMpSbn4mGQ7G2hrPZsrBssmc8EEgqZ
   qjRuEpnsrJLHeTfBzVACdu/7dMOwGToP6BT86XkDTUuQiKHObMFCVGTEs
   77188C1tOhUlzxnDkYOtEL5l2tNB5ktBrw208+ong6m1C8T55eUDRxjDg
   U5oRqHMfUMyq7sAEoJ2SyED3AkI/84n4bVmN1fmo694AnenLmmn1oP52x
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="333619569"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="333619569"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="843671035"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="843671035"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2023 08:49:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75CA41A6; Wed, 15 Feb 2023 18:50:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] extcon: palmas: Remove unused of_gpio,h
Date:   Wed, 15 Feb 2023 18:50:35 +0200
Message-Id: <20230215165035.83657-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

of_gpio.h provides a single function, which is not used in this driver.
Remove unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-palmas.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 32f8b541770b..d339b8680445 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -18,7 +18,6 @@
 #include <linux/mfd/palmas.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/workqueue.h>
 
-- 
2.39.1

