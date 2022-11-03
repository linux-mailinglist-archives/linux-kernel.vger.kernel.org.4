Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427AE61898D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCU2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKCU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:28:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABD21B9DE;
        Thu,  3 Nov 2022 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667507281; x=1699043281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fKNwzugQRgX5XrTVd9rzENjibvNWAzmss5RxzVqONVk=;
  b=RRUxiivaR8AAEW4aQu2dmknKvwmRVz9p66Orw++piXGDDCrGMnAWIRBp
   kv47ZbrzhVpKfMufIyMZ3wh5Pn1Nu2/TtJkxuwDDll9fqfe9PECvIbbRZ
   m7kkdFG9MmdLraCgNfm0KcvUDD2ye084LqLB5YIker2xxVpctmgkGhJIB
   09aKIyO/30RaSNaKt2ewn1YnvCVhOgNzSAm3s9KIB6AddufNwlVEfT1Og
   Icmc6Mn1vqY1QJ/E4579IgHl1HtSIIX1CEL3ejdI2O52jeOQKELHZXlEP
   Mluka//T0OL4gMMsA0VMTouNKYr+7TbEbLasBEP+NZ02BuJwk/Q9+DCcP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="309790077"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="309790077"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740342810"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="740342810"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2022 13:27:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6D5F9F7; Thu,  3 Nov 2022 22:28:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: Add Generic regmap GPIO conversion to the TODO list
Date:   Thu,  3 Nov 2022 22:28:17 +0200
Message-Id: <20221103202817.25567-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's actually preferable to use Generic regmap GPIO over other
simple approaches. Add a TODO item for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/TODO | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index f87ff3fa8a53..76560744587a 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -124,6 +124,13 @@ Work items:
   this with dry-coding and sending to maintainers to test
 
 
+Generic regmap GPIO
+
+In the very similar way to Generic MMIO GPIO convert the users which can
+take advantage of using regmap over direct IO accessors. Note, even in
+MMIO case the regmap MMIO with gpio-regmap.c is preferable over gpio-mmio.c.
+
+
 GPIOLIB irqchip
 
 The GPIOLIB irqchip is a helper irqchip for "simple cases" that should
-- 
2.35.1

