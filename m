Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DDE74411B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjF3RWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjF3RW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:22:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B31BCA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688145727; x=1719681727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4v52pbTbPKjL7/CqY3UgPjebMqu/2BTGtwSA/m6eKM=;
  b=SzVexxdUpKtPex7/zdNqjEPy3HuHVcHfKT2UpLVY1/XalQsx2RDWdC7e
   HDX42w1k6ETc7G0KwBuL7CDHj+52OcudhvAZyQm2qTH+pWkKa2GuARwRv
   JIZ1FkCEAQK47gbBh76P20kWPCIzC4WqPG3puwY108axlC07UOZGefdeh
   XLIN8onmQdbS4D8OTjXe4SXDrpDOkXe9p6C/wmT1lQK6q8ELoPj7zYEQ0
   37s/ieQX3esVwEtmr3p0EZoAMRFbRDjweDGiA0za6R4Is2BoiWrfaaWC7
   9X+Jc9ASfOiUMcOxiI2P8GLPfX70lyiTU7IYDS679DnNQOpxKbqXpFAAD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="342032364"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="342032364"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="711879225"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="711879225"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2023 10:21:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01F2A51E; Fri, 30 Jun 2023 20:21:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 4/4] ASoC: rt5677: Sort headers alphabetically
Date:   Fri, 30 Jun 2023 20:21:55 +0300
Message-Id: <20230630172155.83754-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard to see what's included and what's not on the glance.
Sort headers alphabetically to improve maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/rt5677.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b0c15e27c763..0e70a3ab42b5 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -6,21 +6,21 @@
  * Author: Oder Chiou <oder_chiou@realtek.com>
  */
 
+#include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
+#include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/firmware.h>
-#include <linux/property.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/irqdomain.h>
 #include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
2.40.0.1.gaa8946217a0b

