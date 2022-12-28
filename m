Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB616574F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiL1Jte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiL1JtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:49:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C00F01B;
        Wed, 28 Dec 2022 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672220946; x=1703756946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ozAS6yksRC8a62UTirV31SEjQ8EBsV6SC/XfQ+AkkA=;
  b=UZdhzyyHMy/MsyrFmgyatPqdRrvUYqG6Rt4PTzzv9UJ7CcfKRa5mEEF0
   UZXeNg8dUOPXS+ADr3EaQq2EeBVqXj3nm++cB6nhKrikcMjE/SpF1bXAS
   mK5b9YjBjdIuXHezjcaSSrKe53ZqN1xw7AMwPfebIQp0zLj/bZA0SUbwA
   4+rymtiDmh1fmGaTfbOFIL0btXqNUWbn1w5dHkJGeli2v1qQ8GOa7cY+V
   7nR587SpiWXvjO9GVDjBSzw47Jq7r7koSlkR407o+Eo/H0ZaufFHKXDnb
   k+tNjB4OOcaHZ1BoERJ6vKMwrTTbMU8bdlGdgLJeko1oHaGftFT4eMbd2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="385266808"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="385266808"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="603291141"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="603291141"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2022 01:49:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E8B04220; Wed, 28 Dec 2022 11:49:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH v3 4/4] software node: Remove unused APIs
Date:   Wed, 28 Dec 2022 11:49:22 +0200
Message-Id: <20221228094922.84119-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221228094922.84119-1-andriy.shevchenko@linux.intel.com>
References: <20221228094922.84119-1-andriy.shevchenko@linux.intel.com>
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

There are no more users of software_node_register_nodes() and
software_node_unregister_nodes(). Remove them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 61 ----------------------------------------
 include/linux/property.h |  3 --
 2 files changed, 64 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 0a482212c7e8..da3c1c2cb9a8 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -819,67 +819,6 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	return &swnode->fwnode;
 }
 
-/**
- * software_node_register_nodes - Register an array of software nodes
- * @nodes: Zero terminated array of software nodes to be registered
- *
- * Register multiple software nodes at once. If any node in the array
- * has its .parent pointer set (which can only be to another software_node),
- * then its parent **must** have been registered before it is; either outside
- * of this function or by ordering the array such that parent comes before
- * child.
- */
-int software_node_register_nodes(const struct software_node *nodes)
-{
-	int ret;
-	int i;
-
-	for (i = 0; nodes[i].name; i++) {
-		const struct software_node *parent = nodes[i].parent;
-
-		if (parent && !software_node_to_swnode(parent)) {
-			ret = -EINVAL;
-			goto err_unregister_nodes;
-		}
-
-		ret = software_node_register(&nodes[i]);
-		if (ret)
-			goto err_unregister_nodes;
-	}
-
-	return 0;
-
-err_unregister_nodes:
-	software_node_unregister_nodes(nodes);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(software_node_register_nodes);
-
-/**
- * software_node_unregister_nodes - Unregister an array of software nodes
- * @nodes: Zero terminated array of software nodes to be unregistered
- *
- * Unregister multiple software nodes at once. If parent pointers are set up
- * in any of the software nodes then the array **must** be ordered such that
- * parents come before their children.
- *
- * NOTE: If you are uncertain whether the array is ordered such that
- * parents will be unregistered before their children, it is wiser to
- * remove the nodes individually, in the correct order (child before
- * parent).
- */
-void software_node_unregister_nodes(const struct software_node *nodes)
-{
-	unsigned int i = 0;
-
-	while (nodes[i].name)
-		i++;
-
-	while (i--)
-		software_node_unregister(&nodes[i]);
-}
-EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
-
 /**
  * software_node_register_node_group - Register a group of software nodes
  * @node_group: NULL terminated array of software node pointers to be registered
diff --git a/include/linux/property.h b/include/linux/property.h
index 37179e3abad5..1ffd4f9bb67b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -486,9 +486,6 @@ const struct software_node *
 software_node_find_by_name(const struct software_node *parent,
 			   const char *name);
 
-int software_node_register_nodes(const struct software_node *nodes);
-void software_node_unregister_nodes(const struct software_node *nodes);
-
 int software_node_register_node_group(const struct software_node **node_group);
 void software_node_unregister_node_group(const struct software_node **node_group);
 
-- 
2.35.1

