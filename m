Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3ED6CA510
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjC0NCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjC0NCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:02:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1050195;
        Mon, 27 Mar 2023 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679922130; x=1711458130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Weg/0/02UONhZFz14EiBELwBEiOnQdZ6A+iDbpuVdmU=;
  b=ZGXcNpENaeHm4R1tIt0sTvbA6FhlX+V1BF01/fymP2Jb7mw21UDbt3jX
   1/1pSYLPmzGGBvVZ7TKbnoctkwVONN+H5dy3exKedFj1F6xsMJSsPNiOW
   DHiVf77JisAw4COvSdOU1lw4YUKdc1emNPmKA6z0F82z+JmPKQZvK6seK
   cHo2w8kPKb0s3Xto7dCFINk34ingPedf+bmzck2HKlNM65GCtrOjZwDmj
   HJ2I86l/X/n53mlpZXukv507WWz2iXD3f+UACdi1dtaq6pQ/Zg6/Z3aW0
   XZhFe6qQXFnUNCWdVVSE/TOzQZDlx0Mtt4tuMLGaVQsjD4OHfCOh+zgs8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="324137632"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="324137632"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="676954401"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="676954401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 06:02:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F1053D0; Mon, 27 Mar 2023 16:02:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/2] device property: Remove unused struct net_device forward declaration
Date:   Mon, 27 Mar 2023 16:01:50 +0300
Message-Id: <20230327130150.84114-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230327130150.84114-1-andriy.shevchenko@linux.intel.com>
References: <20230327130150.84114-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no users in the property.h for the struct net_device.
Remove the latter for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes (just Cc'ed accordingly)
 include/linux/property.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 4a536548606b..59f452198c64 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -16,7 +16,6 @@
 #include <linux/types.h>
 
 struct device;
-struct net_device;
 
 enum dev_prop_type {
 	DEV_PROP_U8,
-- 
2.40.0.1.gaa8946217a0b

