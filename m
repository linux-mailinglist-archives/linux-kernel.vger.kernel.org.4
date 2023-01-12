Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9266737E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjALNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjALNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:46:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6048CD4;
        Thu, 12 Jan 2023 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673531195; x=1705067195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dg7wbQ/f03u+4zmjcOXWKVMr24y9KJs4Ga7gh6SIJvM=;
  b=cCsO1uLJ4z2ovsVZTP07kGBQcLSpJJUj4M6aBzFdjEdjmtuFi24Zwg90
   elbP4H9LxO3iV8v7L9iZDs59dCNKzDXYy1RFLRMtL6lYrprt/IPQ/USI+
   vKbwe+jMqss8F9bO4qS6ujWb0mYyaDRnlPdMREvzbZXi5oOoX0v3V+EbR
   Pehe5Obltkz5bCwFpJoLihP72vnsYd5FyW18ZnWr+gRLUKz6dFywnB9u4
   FHB9L9oekzfMV0zjObhPoELlea+G/vlgQSW3MHgtASZdbHFsex7d0mrAF
   YsiFpX/Az7m400kr3tuFW7XCbZ4xDTFDpBwvcO+QS684JWR3+IA4lqMmf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="325729241"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325729241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659787915"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659787915"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2023 05:46:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 16D18E1; Thu, 12 Jan 2023 15:46:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: rockchip: Do not mention legacy API in the code
Date:   Thu, 12 Jan 2023 15:46:53 +0200
Message-Id: <20230112134653.59268-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 200e43a6f4b4..e5de15a2ab9a 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -299,7 +299,7 @@ static int rockchip_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 }
 
 /*
- * gpiolib gpio_to_irq callback function. Creates a mapping between a GPIO pin
+ * gpiod_to_irq() callback function. Creates a mapping between a GPIO pin
  * and a virtual IRQ, if not already present.
  */
 static int rockchip_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
-- 
2.39.0

