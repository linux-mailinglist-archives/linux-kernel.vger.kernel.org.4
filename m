Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66A650BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiLSMc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiLSMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:32:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA6CEE19;
        Mon, 19 Dec 2022 04:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453105; x=1702989105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f+Y573fbqCtXZip97WFp1idIb9kXQkOhGQmr7sMp5sg=;
  b=UJtzmAGzI/X6LIguwsGIdUcM7mAIeeM/i5FKmK+2Gn5ibsp9HK8ZU+WR
   gC0Hqvp5HQErkjaMsYJ4L/CDlfwmkzit22VQgb74rv1SRIJ52DoOB1RCP
   h61S58CemmSMfuFTPcLL8aIQVWe/XchtwlUqfFvRA74rdXIIjWG2w5U1Z
   Glrv4Fu/Q97PWDZXNyNOs9oZwIpnPLue/U7aIIRbJEWBbHcRvQEYg81Tg
   DQZqdxGwIlFRGQAwmCotPfUL4JxlBIybheivi4P9n2l7BB9uU/7kJ4rva
   YQW+e8eSNmLjcCC0WhhrSA+4Ia4M9RFlIp4DT+N14pDmeBR0J3ADlglRP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="299670627"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299670627"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="896027911"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="896027911"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2022 04:31:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E287411D; Mon, 19 Dec 2022 14:32:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/4] pinctrl: intel: Add definitions to all possible biases
Date:   Mon, 19 Dec 2022 14:32:07 +0200
Message-Id: <20221219123208.5505-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
References: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
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

Add definitions to all possible biases, i.e. add ~800 Ohms,
~952 Ohms, ~4 kOhms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 6926f64b68d4..8ecb7ca7fbac 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -81,8 +81,11 @@
 #define PADCFG1_TERM_MASK		GENMASK(12, 10)
 #define PADCFG1_TERM_20K		BIT(2)
 #define PADCFG1_TERM_5K			BIT(1)
+#define PADCFG1_TERM_4K			(BIT(2) | BIT(1))
 #define PADCFG1_TERM_1K			BIT(0)
+#define PADCFG1_TERM_952		(BIT(2) | BIT(0))
 #define PADCFG1_TERM_833		(BIT(1) | BIT(0))
+#define PADCFG1_TERM_800		(BIT(2) | BIT(1) | BIT(0))
 
 #define PADCFG2				0x008
 #define PADCFG2_DEBEN			BIT(0)
-- 
2.35.1

