Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C85B8D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiINQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiINQwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:52:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8032C816A1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663174358; x=1694710358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yXblJJEv92otsbXfWMW0OtOAUDfqMFueQdslT0LGvTc=;
  b=oJEgU21/wGpFxZh/zlzPkOkro1FKyr7JNeNKgTMhIeIXzsHQocBmJBYx
   /S/0ndZWWvzgq4SHQtBgXAI1vc2KkaCKmiIroB75hlWD+bG3U0/0m/9ih
   qjwtLigrrrCIxsrkEld9Q5iv9N8aHIVVdPjoHto9T78QG1cIN61sAjpNQ
   ZrYlQ4yGa7TOZ7qtHp/930VSO2/o6Ez3yxRfv0aKWF6kUevJFFJPfrYbd
   SVXMzbbX9L0dZ2Kn9R2gZozFzyd5P3O5/p6qAuyb8cwnzdpyEkkzljJXr
   izt1ssAJ04RYcKwBrchmk3TT5wNnm0QFr5IiaY0l5g6bSsn/92a2g6XYl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="296071431"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="296071431"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="619378650"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Sep 2022 09:52:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9B61F7; Wed, 14 Sep 2022 19:52:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] headers/prep: kernel.h: Move READ/WRITE definitions to <linux/types.h>
Date:   Wed, 14 Sep 2022 19:52:50 +0300
Message-Id: <20220914165250.38270-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Headers shouldn't be forced to include <linux/kernel.h> just to
gain these simple constants.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 4 ----
 include/linux/types.h  | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4f14e77fba32..1601d9a9df38 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -45,10 +45,6 @@
  */
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
-/* generic data direction definitions */
-#define READ			0
-#define WRITE			1
-
 /**
  * ARRAY_SIZE - get the number of elements in array @arr
  * @arr: array to be sized
diff --git a/include/linux/types.h b/include/linux/types.h
index ea8cf60a8a79..67846bc43d53 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -125,6 +125,10 @@ typedef s64			int64_t;
 typedef u64 sector_t;
 typedef u64 blkcnt_t;
 
+/* generic data direction definitions */
+#define READ			0
+#define WRITE			1
+
 /*
  * The type of an index into the pagecache.
  */
-- 
2.35.1

