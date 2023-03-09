Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E196B1DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCIIXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCIIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5450B12F13;
        Thu,  9 Mar 2023 00:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350100; x=1709886100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EeMpUHRwEcd/7GGcTgh3dH4kpXVjRSLeOKvHUS2QYVc=;
  b=Q+hU8pZq6BEEfcCDll90tafMfjbim0leyJDXAJheIBugLJASrGcismsP
   nlW6dGFhtUvJBM0A2Ud1L9kjne+2eAoYvFiKECMguYwchoZZiMc0zZEJ6
   xAySZfWQrCQFM6CtBJbKfn2fUAiGOOkQBuBX3fwKJHd0UGvIwOA0eRdu4
   L6SbdRM6WrVhSWeFIyZS1Skr62ou+BPiPRd828A6kF/rCJJSTB4vbizvM
   PN2R+fL3F4ToLwlFI+9i2OqL3m8YtXs8vlcbTbaWSyGw/7eUANl9U65qy
   wvyd7M0VToas3CDmjSS30QUZHDYrRT3HpEu6q1pVKhlpFnegMA6d0REv9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025884"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025884"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473880"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473880"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:05 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/8] n_tty: Sort includes alphabetically
Date:   Thu,  9 Mar 2023 10:20:31 +0200
Message-Id: <20230309082035.14880-5-ilpo.jarvinen@linux.intel.com>
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

Sort includes in n_tty alphabetically to make it easier to see if an
include is among the list or not.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4fc5bd166e56..2cf263de1366 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -28,27 +28,28 @@
  *		EAGAIN
  */
 
-#include <linux/types.h>
-#include <linux/major.h>
+#include <linux/audit.h>
+#include <linux/bitops.h>
+#include <linux/ctype.h>
 #include <linux/errno.h>
-#include <linux/signal.h>
 #include <linux/fcntl.h>
-#include <linux/sched.h>
+#include <linux/file.h>
 #include <linux/interrupt.h>
-#include <linux/tty.h>
-#include <linux/timer.h>
-#include <linux/ctype.h>
+#include <linux/major.h>
 #include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/bitops.h>
-#include <linux/audit.h>
-#include <linux/file.h>
-#include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/poll.h>
 #include <linux/ratelimit.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/tty.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+
 #include "tty.h"
 
 /*
-- 
2.30.2

