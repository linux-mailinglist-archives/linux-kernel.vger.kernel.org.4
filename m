Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFF6CA516
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjC0NCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjC0NCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:02:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FABE26A8;
        Mon, 27 Mar 2023 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679922139; x=1711458139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IDjT0jS9d3AwsbB9MrexcB6TbQwjnwhd09XzeHpePQU=;
  b=HQo1hoQOzLu9nEtnED9tgdYHfEp8g4UupLozIIYYXD5jQE4VmmbNKj+2
   OSm5tzcdU+OdnDsC8HWDyc3ZjgJaK20INH1DF85a//TCCU+FZiMfI7uoS
   dq9R8wNcXBJFID3KFOmLmb7rChPlz0ed34uND4nD/qlAcmT+XMXZpb/my
   +WKX9nOOnFkzfMhdXd2j+QMmVaRuKN0LVCVlAl2UjcEu73FG7QYASN8GV
   YXHqFU595ElgbiNw4DXS7u5NjpqS2wCcyj3fVkTUaeRHjx7BzZVp+bWZ5
   Ip+gl0XiGmwEFVo2mAaTOgCmn7mrczyxqFiHlwNffSTRrOphlZeMzZPi4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="324137638"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="324137638"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="676954402"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="676954402"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 06:02:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E617079C; Mon, 27 Mar 2023 16:02:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/2] device property: Add headers to the Driver Core entry in MAINTAINERS
Date:   Mon, 27 Mar 2023 16:01:49 +0300
Message-Id: <20230327130150.84114-1-andriy.shevchenko@linux.intel.com>
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

The header files (fwnode.h and property.h) are part of the device
property API, which in its turn is part of driver core. Add the
missed headers to the corresponding record in the MAINTAINERS database.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93fb4e5a2814..aa61d9ede78b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6316,7 +6316,9 @@ F:	drivers/base/
 F:	fs/debugfs/
 F:	fs/sysfs/
 F:	include/linux/debugfs.h
+F:	include/linux/fwnode.h
 F:	include/linux/kobj*
+F:	include/linux/property.h
 F:	lib/kobj*
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
-- 
2.40.0.1.gaa8946217a0b

