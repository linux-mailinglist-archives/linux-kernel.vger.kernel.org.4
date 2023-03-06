Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA37C6AC4AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCFPV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFPVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:21:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF42BF3E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678116085; x=1709652085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MsmZkjzhshq5GrJn5PqIhozrx6ZauAaghOCW2Gi3s3s=;
  b=Ft0I4yE4UPqUV4LH5+lumrf8wqnxBEZR6vSVtQI8GzD/T+nI6D12oc49
   RwiMxcCOTKtQZy98h/j5XxlQO/vNgv8FmTqbAyTrKHXtqSmFRbB0YJGLQ
   STTidUwx5AcuKFmNemAsOyUd0RYIh31tL3JeaR/UFFcaZD0mDRLPiYyS2
   P8PM6Zqg7p27vDWsUoHQgYE93iKpQU5aW7FTR1o8JNMsE7gxtBy50Vy1N
   F+TEDxW/kZrOmjc8uteRR50pe3bRHAAdXm89pZAlyVdrC54XEYNvz57oD
   Xl2VpA3tTyL3SVGCMXiq+44VR6cADtaUrPnqYxSlrrHHs8XIO16Ykpowc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="315237531"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="315237531"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 07:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626186880"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626186880"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2023 07:21:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 73FE8143; Mon,  6 Mar 2023 17:22:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1 1/1] cpumask: Fix typo nr_cpumask_size --> nr_cpumask_bits
Date:   Mon,  6 Mar 2023 17:22:04 +0200
Message-Id: <20230306152204.49836-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the never used nr_cpumask_size is just a typo,
hence use existing redefinition that's called nr_cpumask_bits.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 8fbe76607965..ce8eb7ef2107 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -66,7 +66,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
  *
  * Finally, some operations just want the exact limit, either because
  * they set bits or just don't have any faster fixed-sized versions. We
- * call this just 'nr_cpumask_size'.
+ * call this just 'nr_cpumask_bits'.
  *
  * Note that these optional constants are always guaranteed to be at
  * least as big as 'nr_cpu_ids' itself is, and all our cpumask
-- 
2.39.1

