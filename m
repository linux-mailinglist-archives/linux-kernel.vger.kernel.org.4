Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE32731E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjFOQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjFOQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:42:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F0626BA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686847325; x=1718383325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SjfkhPAqQ8PyzFqydNEFnaWjUK63HBu4s/AtSRqBNIk=;
  b=Hvaz0Q7p0XIaxUydNFugAE9dQOWiGn9PuOJb3GyIgKSadpv7PhUhT8YD
   YMebWk6R7sM5P3rSmClUff7CvaIsPgXPcQKShhNUSjVwYmTW+4F7PL4il
   31Cdmf2M8h0cjT1tCbkAK1bvufr/j27AbzyhUa5iC3BZxIT1/5aO+ZZfj
   1ldQQHyKW7bRBlD6OxvpNwkOBNHB1c6bNKGLvdtLWIL1XERfErRmCkFU+
   u9j7XQz3p0SPzFL9cfotMv2+M0/u2LXBCGj2IqraBFBt/7tlvKHYXeNEE
   CEXrht0KoBiXdj7ONWMoHNNloRpcZARwpNe2peiSVamhYJovf+WCWkz9e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343702876"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343702876"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777742128"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777742128"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 09:42:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 624C5379; Thu, 15 Jun 2023 19:42:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mtd: rawnand: Remove unused of_gpio.h inclusion
Date:   Thu, 15 Jun 2023 19:42:10 +0300
Message-Id: <20230615164210.25515-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_gpio.h is not and shouldn't be used in the drivers. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/nand/raw/nand_base.c | 1 -
 drivers/mtd/nand/raw/xway_nand.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index a6af521832aa..132e3bee8f5a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -42,7 +42,6 @@
 #include <linux/io.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 
 #include "internals.h"
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 6b1e2a2bba15..5a19b6b314b4 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/mtd/rawnand.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 
 #include <lantiq_soc.h>
-- 
2.40.0.1.gaa8946217a0b

