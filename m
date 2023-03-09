Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A26B1DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCIIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCIIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F181EBDC;
        Thu,  9 Mar 2023 00:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350103; x=1709886103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uA1jsUBpsTn1cyEGtu8uNzvvl9mod+0mi7D3hpv/8ZU=;
  b=YE7WcahnrA7kUKtR9GEKP6Yd3E0r2eOgmUfeEBK7M9VqSMUoD59TNfLN
   V3LmKsnGkdxBJVO4nhFZYF3BiHO2sP5g2Y1j1Tkk3RycjwN89zCVuienu
   /KzKejzgB/gQQLHbRRNlcWDAbvXpkEp8W4vH8QJ5Iazac2YVkX6mD4JdS
   dCDDp2dPlpGMfqfe5y4YkhAaw1bGzZrw/kSzSBLuRwDUcOlKVz6Pj5cXo
   CtfKc8/xqZEggEQYy+c4rKaxEbq2XWumShwNJaAX0vYfGUX/9M4l1yPrm
   pw9d20IxR4th985nM9zN/aGO0eWD7qt91nCzuEU1dq+48Jm3JW52dvvKo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025895"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025895"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473896"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473896"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:12 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/8] n_tty: Reindent if condition
Date:   Thu,  9 Mar 2023 10:20:34 +0200
Message-Id: <20230309082035.14880-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align if condition to make it easier to read.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0481e57077f1..1c9e5d2ea7de 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1176,7 +1176,7 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
 
 	ldata->num_overrun++;
 	if (time_after(jiffies, ldata->overrun_time + HZ) ||
-			time_after(ldata->overrun_time, jiffies)) {
+	    time_after(ldata->overrun_time, jiffies)) {
 		tty_warn(tty, "%d input overrun(s)\n", ldata->num_overrun);
 		ldata->overrun_time = jiffies;
 		ldata->num_overrun = 0;
-- 
2.30.2

