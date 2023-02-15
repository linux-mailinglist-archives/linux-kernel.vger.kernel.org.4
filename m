Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4FB698152
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBOQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBOQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:51:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7D36698;
        Wed, 15 Feb 2023 08:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676479859; x=1708015859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sY4N+Zu/3b1j1ICZ956aPR/7nTZfVNeI9erLtne45ig=;
  b=faAjSlZDf6c8P8HoFHcBs0Rm6gi6H+aVGDxkUbU9ziRkNVd3DEh1vKO0
   VzwfPXKHrmTmM9HIBXEmrs6eo99QSbRC0O5AH73qnbuYK3gbQAqjXp2cT
   ykP/Yv/JoIqJGHtxTBdcJaKY2PnmZGlaVzt4fSmlYqD2TvA8lMe+odEXX
   uouZ86Lc0vwM0E+7qDcgUAvnJlD2rVaWIJhxCKQUYo4euPv9DNZGisNn3
   MkNGVFhsBhalG+IVlRlGuaMwJxatkI2H4qI7V9+KRZDQAgaTBtIf3qdbe
   sHphA4KEx4mY9N+ZLEq9T44cq4sJnvgSI+SpJugTJ8fEkSV6L85NiC7ey
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="333619553"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="333619553"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="843670986"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="843670986"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2023 08:49:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB5381A6; Wed, 15 Feb 2023 18:50:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] rtc: rx6110: Remove unused of_gpio,h
Date:   Wed, 15 Feb 2023 18:50:30 +0200
Message-Id: <20230215165030.83621-1-andriy.shevchenko@linux.intel.com>
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
 drivers/rtc/rtc-rx6110.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index 76a49838014b..37608883a796 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -10,7 +10,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/of.h>
-- 
2.39.1

