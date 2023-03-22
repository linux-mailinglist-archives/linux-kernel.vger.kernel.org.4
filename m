Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12786C4DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCVOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCVOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA08231E19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495963; x=1711031963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AVd04bvZvtiru6UczXNHsDReJQuNasVR+P+brwfuTWw=;
  b=iJs+32hqHLHVe/Q0/iv6EsW/Qg2zi5zP26kth/g0+ihLppYZxnki0TVn
   GG2WFf80ESKMtXNyqAktLZiyujYf+jlYEb2KHf+EMsPy38dVqtxJWmHeI
   C9DhoFep4XKJBgcY/Gxr8UEp82QaPZY1/aQl4Zgu9W07gOkuHjPJY9Bbe
   o1/1JkzxHOH/VZ5URlaC1Yffx6fwmq9hG5ijQHGe75uPnjp5fXGC+KKIC
   k8JIm028OjTjQNnfCSHUqoYYCeSeIu4f2EHIJf7iS45OSJIJFDyuzSZQY
   RNwHdZSp2CXLDqbRq9CdOgktM4QZq5U52pdQyLby+Qcjb+YEpJ+4yJ/hb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327609290"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327609290"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792579429"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792579429"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:39:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A3E0E4FF; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 02/14] extcon: Fix kernel doc of property capability fields to avoid warnings
Date:   Wed, 22 Mar 2023 16:39:53 +0200
Message-Id: <20230322144005.40368-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel documentation has to be synchronized with a code, otherwise
the validator is not happy:

     Function parameter or member 'usb_bits' not described in 'extcon_cable'
     Function parameter or member 'chg_bits' not described in 'extcon_cable'
     Function parameter or member 'jack_bits' not described in 'extcon_cable'
     Function parameter or member 'disp_bits' not described in 'extcon_cable'

Describe the fields added in the past.

Fixes: ceaa98f442cf ("extcon: Add the support for the capability of each property")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 1bc2639704c2..79006ab5334b 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -210,6 +210,10 @@ static const struct __extcon_info {
  * @chg_propval:	the array of charger connector properties
  * @jack_propval:	the array of jack connector properties
  * @disp_propval:	the array of display connector properties
+ * @usb_bits:		the bit array of the USB connector property capabilities
+ * @chg_bits:		the bit array of the charger connector property capabilities
+ * @jack_bits:		the bit array of the jack connector property capabilities
+ * @disp_bits:		the bit array of the display connector property capabilities
  */
 struct extcon_cable {
 	struct extcon_dev *edev;
-- 
2.40.0.1.gaa8946217a0b

