Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDE36C6C04
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCWPPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCWPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:15:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D29001;
        Thu, 23 Mar 2023 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679584501; x=1711120501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eeRabBK6QPfoQ8luPUQT5zoPHyjCVC0mZMDpYDE/5Fg=;
  b=WrIMxlmkThg+4MSMrMzKLcY64wHrGRRl0UWxvjQTC+lOpfr/6QM0+wyF
   JZWc2Hqkvsl+vkBYs74I7U8Wh8d7I1HmVhDr09Ouv4mb+QWHKqxLAWrt+
   WfPknh7tlZ0s67p3xg3FMrfRHzDTAta5pI0RXKn4rbGgB5crknUj9fwll
   T7LKy3uC8qoyVkSV4l87qhNHvYoOFWL6FGsa/qJNYBpCdm3a2yCGsQvfS
   jvWi5V++qeTTtE8J0pGTp12DNGYMsaiJombIeQv3N7NQQZPq1Vh9TQTw8
   EV5lF0c/AT0+xL+t6To5QJJjR7ZxJAqc5K3s5fwIhIQ18SgcSnFVfuXIg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323378828"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="323378828"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 08:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="746746088"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="746746088"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2023 08:14:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D34ECD0; Thu, 23 Mar 2023 17:15:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/1] device property: Remove unused struct net_device forward declaration
Date:   Thu, 23 Mar 2023 17:15:19 +0200
Message-Id: <20230323151519.58479-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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
 include/linux/property.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index ee9cc1710d82..1dff38e930fc 100644
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

