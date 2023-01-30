Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77D7680BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjA3LSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjA3LRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:17:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8B8A70
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675077434; x=1706613434;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aLXq2Zr8iui/4kI413wp/69WFDz8oE+zOv2Fmzjlo7c=;
  b=Kl9MHEqVkQgM5pF5bQVrySKn91+R8oV19lkRh5JZU4MUb6m/xfZ7VmC1
   9K1zrZqrvgnbxzbA36jJLwjDKnNIKIoCc2BW+6jqHJoGPEuICsKz93MrI
   F8JSSwKuzxZhmCBcjCWTei9pRyixtnIHXynXW2OFi6wELhG9vsrzQCsnv
   F2K3MbkiE1gmfkCowM9HihBEreqE66rMuJ4kDaAs3eQVXuBW2CGi0Lxhi
   +8nngl8N+yyge3D7zJijFGyRoNFDIy3wqBNLn0Jc55xquhZg15J1xvi2M
   xI9R7Oax4cmBKAbUHgKDSc4Yf7lstkgTJQz5V/PIzHPzpMnbBU8e4H+DN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="327550066"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="327550066"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 03:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="666040737"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="666040737"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jan 2023 03:17:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1693C337; Mon, 30 Jan 2023 13:17:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] container_of: Update header inclusions
Date:   Mon, 30 Jan 2023 13:17:46 +0200
Message-Id: <20230130111746.59830-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

The commit 848dba781f19 ("container_of: remove container_of_safe()")
removed the code that uses err.h. Replace the inclusion by stddef.h
which provides offsetof() definition which is still in use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/container_of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 1d898f9158b4..713890c867be 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -3,7 +3,7 @@
 #define _LINUX_CONTAINER_OF_H
 
 #include <linux/build_bug.h>
-#include <linux/err.h>
+#include <linux/stddef.h>
 
 #define typeof_member(T, m)	typeof(((T*)0)->m)
 
-- 
2.39.0

