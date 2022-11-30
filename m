Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721763D4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiK3LuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiK3LuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:50:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C283E0A0;
        Wed, 30 Nov 2022 03:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669809004; x=1701345004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6wimyYQbsxLPBuz4Yl1fOGCJ7Sk/b97+f3lsZ3q38XY=;
  b=MAoRtzYTjQRwJVwyXb/RntzeXhsdBna8BVu7DATW/ssE6Vs/ow9W9vef
   nj7mluIybWVtTd5pQZZAMySaGt5/fooE3mJuPrC9a6gxTQI/Tj5bgaqe9
   tMyWcVb5sZPriGPkUjXkVVBM4ULvPjIgB9ihtu32Gvd+DEA0YE5hN/sec
   2qOmGnnTW75FQxhAAMF2OYG9oM3OnzfUkzwZo96W3+Fi4IpX+a5IjrVxf
   FK/+O2D0RxZT8udZ5yQWKFZz673xU/2jg31ToOfj4lAqORnNBOqzk+bPQ
   f7C0eL4oXzhrd2gRVsapzVkfqW2my6f0zt78cig87eEK7rP8u5cJNTN4D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295739717"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="295739717"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 03:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="712779990"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="712779990"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2022 03:50:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C600B10E; Wed, 30 Nov 2022 13:50:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 1/3] lib/string_helpers: Add missing header files to MAINTAINERS database
Date:   Wed, 30 Nov 2022 13:50:20 +0200
Message-Id: <20221130115022.68956-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The header files string.h and string_helpers.h are missing in
the MAINTAINERS. Add them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 331dc0e3e5f9..c1f0310dae18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8721,6 +8721,8 @@ F:	drivers/input/touchscreen/resistive-adc-touch.c
 GENERIC STRING LIBRARY
 R:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
+F:	include/linux/string.h
+F:	include/linux/string_helpers.h
 F:	lib/string.c
 F:	lib/string_helpers.c
 F:	lib/test_string.c
-- 
2.35.1

