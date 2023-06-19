Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239C9735CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjFSRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjFSRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:20:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8A133;
        Mon, 19 Jun 2023 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687195222; x=1718731222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pnBvaAXYA1YK+iYr+QnoTRToNMTLkN2QhhkWEfWRPa0=;
  b=SwkczYZNi6SWwVoeR/w86o3ZEPAbSRDoMO3imNCUUgkYhlu2RzLy99IY
   WAfKyTtFNHePnWl7Ef0Kz9K42nUlMF3GdXmzoB0y+TgWFYo6unq5CmTZ+
   tMsiq8eMtS91qv8hjVlycH7VNCccWGn4wNFSlOsXBaD4AxObPTyckd44n
   8YmbaSbz3EDho7O70OsWu9/ggH9ABUubdN5YcP+Y1qTRg5sXbOWCSiOYC
   pn/2P/8IIrW9FD6QgXglFDRq7fxXbkxmqEdJFukz/8UtTKQ91zPFae/rK
   WoI2u4INevBKW9Qc+i9dgU6voCBxk14V/wdyeYQ7mfyPnA4QmWKbfQzTT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423342554"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="423342554"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 10:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="691150804"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="691150804"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2023 10:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B84D4690; Mon, 19 Jun 2023 20:20:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Antti Palosaari <crope@iki.fi>, Sergey Kozlov <serjk@netup.ru>,
        Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 3/4] lib/math/int_log: Replace LGPL-2.1-or-later boilerplate with SPDX identifier
Date:   Mon, 19 Jun 2023 20:20:18 +0300
Message-Id: <20230619172019.21457-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
References: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace license boilerplate in udftime.c with SPDX identifier for
LGPL-2.1-or-later.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/int_log.h | 11 +----------
 lib/math/int_log.c      | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/linux/int_log.h b/include/linux/int_log.h
index 332306202464..0a6f58c38b61 100644
--- a/include/linux/int_log.h
+++ b/include/linux/int_log.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  * Provides fixed-point logarithm operations.
  *
  * Copyright (C) 2006 Christoph Pfister (christophpfister@gmail.com)
- *
- * This library is free software; you can redistribute it and/or modify
- * it under the terms of the GNU Lesser General Public License as
- * published by the Free Software Foundation; either version 2.1 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU Lesser General Public License for more details.
  */
 
 #ifndef __LINUX_INT_LOG_H
diff --git a/lib/math/int_log.c b/lib/math/int_log.c
index ea98fc0b3fe2..8f9da3a2ad39 100644
--- a/lib/math/int_log.c
+++ b/lib/math/int_log.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Provides fixed-point logarithm operations.
  *
  * Copyright (C) 2006 Christoph Pfister (christophpfister@gmail.com)
- *
- * This library is free software; you can redistribute it and/or modify
- * it under the terms of the GNU Lesser General Public License as
- * published by the Free Software Foundation; either version 2.1 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU Lesser General Public License for more details.
  */
 
 #include <linux/bitops.h>
-- 
2.40.0.1.gaa8946217a0b

