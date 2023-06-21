Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF3738B11
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjFUQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:26:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CACB1BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687364794; x=1718900794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fj/XxZTOv1WUM7TqNdWaNwm0NkdYp96+MU7kw4x4N38=;
  b=i6YPlRfp7xCmr3QgvOOOHPwzItv8CFnsnBhGLhLrDuZEGJF1p00mm9Q2
   Fs+2bORqLygZF+VLwPfyJIkGJoc5Rdal5u3FTDHNqwf19Bg2A+qShmoDj
   aKUbYWIk+6I88eelzi8UYWLFFQALlLoRYdexsgtJLIRB3TdK1bkjosaKO
   7yuZH1GW9nljXi+0fpX8YW+ygAiVQ5UF0C1Ru/mgW33NNTBuIiYCkB5pV
   LbhHmeC2z1NAwAeLiCMq11rAcC1f+RwqROK8NR+qHXEtoM2xPCzTLMtIe
   HJffXNsUDJUQKNPt63PUUJLyf1fBFrljUAnD7ZZUrV5FoH1ZOfISzZDNm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="426178616"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208,223";a="426178616"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 09:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804435782"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208,223";a="804435782"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2023 09:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A413241; Wed, 21 Jun 2023 19:26:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] MAINTAINERS: Add bitfield.h to the BITMAP API record
Date:   Wed, 21 Jun 2023 19:26:26 +0300
Message-Id: <20230621162626.86033-3-andriy.shevchenko@linux.intel.com>
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

From time to time changes are tending to go to bitfield.h
header while it may affect other bit operataions. Add
bitfiled.h to the BITMAP API record.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 34553d2136ea..758443559d26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3591,6 +3591,7 @@ M:	Yury Norov <yury.norov@gmail.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
+F:	include/linux/bitfield.h
 F:	include/linux/bitmap.h
 F:	include/linux/bits.h
 F:	include/linux/cpumask.h
@@ -3603,6 +3604,7 @@ F:	lib/cpumask_kunit.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
+F:	tools/include/linux/bitfield.h
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/bits.h
 F:	tools/include/linux/find.h
-- 
2.40.0.1.gaa8946217a0b

