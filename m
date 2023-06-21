Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17D738B10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjFUQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjFUQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:26:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3910CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687364795; x=1718900795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hNSc7CAuV/ZCUpAhpy/Z3AjgPjffDt3AynsJLDnBfI=;
  b=OEGyyoUDrw5xs9IGq3ojcfelRb1PPCZQtRXLkxzpSHM5KpRm2WzsCaht
   B9GwcmGTJClkvvsfXGcsczAordzgNUxo0LBlv1XGfLP2A7tMEGlw9QCoz
   NlQY74bJejOw8crzymYJseuJ9rWkqWHLkS/yZxn3avhKfV48C/d1A2X1U
   gDuaYfFY8VEzN+ADKdKMNVBL2W/N/nvQF5bUmVqxUD85YoxFyku2aC5IR
   YdMI9XXjBaFM0BC6/qGXbRe4gAmr1EIR81HMRrhO/ltkKhqb0twmNRsl1
   mu0Lq8tTWHTSBiY3ja+ISxLBnd6ea5bGxC1kgNU2nKhpSHXuDjR/BJ6Tb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="426178620"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208,223";a="426178620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 09:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804435783"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208,223";a="804435783"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2023 09:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71590195; Wed, 21 Jun 2023 19:26:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] MAINTAINERS: Add bits.h to the BITMAP API record
Date:   Wed, 21 Jun 2023 19:26:25 +0300
Message-Id: <20230621162626.86033-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230621162626.86033-1-andriy.shevchenko@linux.intel.com>
References: <20230621162626.86033-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From time to time changes are tending to go to the bits.h
headers while it may affect other bit operataions. Add
the bits.h to the BITMAP API record.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 210285042dcd..34553d2136ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3592,9 +3592,11 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
 F:	include/linux/bitmap.h
+F:	include/linux/bits.h
 F:	include/linux/cpumask.h
 F:	include/linux/find.h
 F:	include/linux/nodemask.h
+F:	include/vdso/bits.h
 F:	lib/bitmap.c
 F:	lib/cpumask.c
 F:	lib/cpumask_kunit.c
@@ -3602,7 +3604,9 @@ F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
 F:	tools/include/linux/bitmap.h
+F:	tools/include/linux/bits.h
 F:	tools/include/linux/find.h
+F:	tools/include/vdso/bits.h
 F:	tools/lib/bitmap.c
 F:	tools/lib/find_bit.c
 
-- 
2.40.0.1.gaa8946217a0b

