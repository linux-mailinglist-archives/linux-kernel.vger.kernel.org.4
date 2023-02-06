Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86FE68C0DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBFPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:01:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F81E9C0;
        Mon,  6 Feb 2023 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675695701; x=1707231701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Om6WD/1Mx5CxjfHlHObyDLvGRocDTOtSddT1RwDeHp4=;
  b=cCEnINPQ3hpcNO3ycu3gpSDNwwml053Q8en1iTPvPorEMwM87WKjspBP
   ajPAS6ECTI9GQZ+/YiwGLLqHx0ZVl9VUaaZRytPg5YX9reXc3M236CvAS
   U9zVtjUQVkm7K9d57xziUaXRZGy7SzEMZeFeuMhm1BGPJg00RXFmeuhLM
   Nar31BYNGu1oVlTz9U/uBVssdIe+uroOiaI3GNnxIV9OtSQFYKPynUQII
   nzCEXOYAT3jOQGTYVnRvxlK89wf7U5vOTtn7mT0jWZZQSd2reCItknSF0
   6mmsKIKuurom/RTfx2QyzMlpWaBih2RdlpXikJ5IKQbDQ5WoDj9xDfF39
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="331355591"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331355591"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 07:01:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="735153689"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="735153689"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2023 07:01:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 227451EA; Mon,  6 Feb 2023 17:02:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: Add include/linux/platform_data/x86 to MAINTAINERS
Date:   Mon,  6 Feb 2023 17:02:02 +0200
Message-Id: <20230206150202.27892-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Most of the files there are being used under PDx86 subsystem or
tightly related drivers (like drivers/clk/x86/). I think it makes
sense to assure that PDx86 keeps an eye on the changes there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4329d6611c20..705ffd15afbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22598,6 +22598,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
 F:	drivers/platform/olpc/
 F:	drivers/platform/x86/
+F:	include/linux/platform_data/x86/
 
 X86 PLATFORM DRIVERS - ARCH
 R:	Darren Hart <dvhart@infradead.org>
-- 
2.39.1

