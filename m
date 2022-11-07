Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1814C6202C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiKGWzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiKGWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE62935D;
        Mon,  7 Nov 2022 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861689; x=1699397689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7zyU0EMZtiBlCMi0pWV2TZ8XEkOY6y3ce2a9bhJ6dI=;
  b=BZcnB+CxME1goxSDHKYZq6aUQTYRBlC0FG3CyYZHi7R42k3ZLnXUStjX
   zamkIxAGfDwMnLWs+b2r5St3lIepPgG/6A93inKwD4ZVmgojRLU7GYuSj
   2cPMuXoD0tOlzRU+Pk+fgcqH9aAP4LAvxbqoxNMvhwR//OCyKmaM7H5f9
   PaIyJY12Mng4cYUw5RhHzcqoS5kBo/oRVaUaQb8mhfcqCKeGVQCcdRrmH
   WJupKc7xxJQFW03BfxAChGrwXO7pktE8BlraFvHLTMxoaFv1IG1ibwAv3
   obDbZXPMw9x87+MpCJZHzz6BaqqXYAZskuML6QW0Q/7kfPsWeL8wguhKU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911839"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911839"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012991"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012991"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:48 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 11/14] platform/x86/intel/ifs: Remove reload sysfs entry
Date:   Mon,  7 Nov 2022 14:53:20 -0800
Message-Id: <20221107225323.2733518-12-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reload sysfs entry will be replaced by current_batch, drop it.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/sysfs.c | 29 --------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 65dd6fea5342..e077910c5d28 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -87,34 +87,6 @@ static ssize_t run_test_store(struct device *dev,
 
 static DEVICE_ATTR_WO(run_test);
 
-/*
- * Reload the IFS image. When user wants to install new IFS image
- */
-static ssize_t reload_store(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct ifs_data *ifsd = ifs_get_data(dev);
-	bool res;
-
-
-	if (kstrtobool(buf, &res))
-		return -EINVAL;
-	if (!res)
-		return count;
-
-	if (down_interruptible(&ifs_sem))
-		return -EINTR;
-
-	ifs_load_firmware(dev);
-
-	up(&ifs_sem);
-
-	return ifsd->loaded ? count : -ENODEV;
-}
-
-static DEVICE_ATTR_WO(reload);
-
 /*
  * Display currently loaded IFS image version.
  */
@@ -136,7 +108,6 @@ static struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
 	&dev_attr_status.attr,
 	&dev_attr_run_test.attr,
-	&dev_attr_reload.attr,
 	&dev_attr_image_version.attr,
 	NULL
 };
-- 
2.25.1

