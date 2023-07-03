Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B49745DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGCNwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjGCNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:52:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED74E58;
        Mon,  3 Jul 2023 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688392353; x=1719928353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvhTxjRQxN86NZW9US2cS3jRAx1NtAYDGutfkvlmQXc=;
  b=YozgYY3IEXdID1a+bm+xIDmJgJh+lX0WBDal0fxHQK7SKKTjiPZ2ZL7O
   aL5bquKJIsDSjuZ9OuHQUKj/TklmS9zUhuyas2EBaZJsUWk5pyXsJ06Rs
   58fMFKWWcOwvH5cznnlOPGYg48lWcvOwgh3Pm/heRS/M8su4oi2Fj/EWr
   klyZHMJ4L1su5xG8CHYMGs53ESI+faxg4Xnc3xyYu99gz+p9CoJeVkM0a
   wbQFf9DQvQJ2XX8ysPn6azGKjqj6ACyztfz1xEF0tnVC48Jd3e+OaQ6p/
   92avJ+Zkpj4Pczckm8rodLzyhiqBeFQj/XXBGRMTgj10mXAzC/6Yif36r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="361744796"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="361744796"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831839500"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831839500"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 06:52:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 02CF1178; Mon,  3 Jul 2023 16:52:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Antti Palosaari <crope@iki.fi>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 3/4] lib/math/int_log: Replace LGPL-2.1-or-later boilerplate with SPDX identifier
Date:   Mon,  3 Jul 2023 16:52:10 +0300
Message-Id: <20230703135211.87416-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
References: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
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

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Link: https://lore.kernel.org/r/20230619172019.21457-4-andriy.shevchenko@linux.intel.com
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

