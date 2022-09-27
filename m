Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE25EC6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiI0OuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI0Ot1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:49:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917E4B49F;
        Tue, 27 Sep 2022 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664290035; x=1695826035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=12q8cDNacifTN/HmQ4Xx/05Vt+MQ8T4JNw/rqVBiRhA=;
  b=dMnptJcRWgyZA3dS+JhCqglEN70s37PNRvuiXAcqlneNYG8ve7lSZCsx
   T1fw3j0bHpcXkIwDPR+1LPlu+MEwZmRsrxHwbBpFSqMoFof5OYK5r8XOI
   PEEw9CBCQTea2pG5WuoGGUJfRNYI1KzB7IbzBeqmmVQ5Qssh4Bl0QOOwz
   NU9mxs80x1QD4IPD5H/qZ7WZ0sJhYiitzBaVX2AIjMZBbaEOzKbAD0Xo7
   3bzaZK4BxU8L+DH7bbkZrQCc4BVfPnRZ3HCh22ADN/ORGfD3sc1N0PS+3
   7PcUM9ZZx3WPjaFejzuzGLHQZOc3IylY83MBtF10jhHW75/WgK2EmiH8P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363173003"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="363173003"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621544886"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="621544886"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 07:47:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA0275E4; Tue, 27 Sep 2022 17:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 8/8] pwm: lpss: Add a comment to the bypass field
Date:   Tue, 27 Sep 2022 17:47:23 +0300
Message-Id: <20220927144723.9655-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment to the bypass field based on the commit b997e3edca4f
("pwm: lpss: Set enable-bit before waiting for update-bit
to go low").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 839622964b2a..0249c01befd5 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -29,6 +29,11 @@ struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
 	unsigned int npwm;
 	unsigned long base_unit_bits;
+	/*
+	 * Some versions of the IP may stuck in the state machine if enable
+	 * bit is not set, and hence update bit will show busy status till
+	 * the reset. For the rest it may be otherwise.
+	 */
 	bool bypass;
 	/*
 	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
-- 
2.35.1

