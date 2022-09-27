Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3A5EC965
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiI0QYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiI0QYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:24:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B27F3907;
        Tue, 27 Sep 2022 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295849; x=1695831849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NGzxSjw4VSFj+YnFlwkpebVj3ZY6c5JRzng6n18lD6A=;
  b=IIgzUXbOhFjikUEXQ7ls/b5LmDm57+fGgUvanJo2wCGB/De29ObhjquX
   ofmBC1h9mDrASWn3cXwKBc0BfRuMf5RIvFZjPOE2vwTyGm7MyN/R9x1sI
   lZGcbCb71drJPVpj2UlMgVt/ytyV+5KcylQbiD9DsLhnWMTYg2J1ug+Mn
   UxOGs743GHlQMbdYApekXHUzQObmCK2mfsRFQElpwWrgGydKNa1BD+LxY
   eUQRW91RigTv8Fd1APwPjlhI0B8V8HYfp9qZLXX229PIVsjwK/9fijbo4
   rSpMD6aBvpm96qDTueBsCeyutHQu7Ytpg1OmTarvmuP3S5Gbarnkg6xB9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327719523"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327719523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684047857"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="684047857"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 09:24:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AD81357F; Tue, 27 Sep 2022 19:24:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 7/7] pwm: lpss: Add a comment to the bypass field
Date:   Tue, 27 Sep 2022 19:24:21 +0300
Message-Id: <20220927162421.11052-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index c344921b2cab..8e82eb5a7e00 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -25,6 +25,11 @@ struct pwm_lpss_boardinfo {
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

