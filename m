Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A9630F65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiKSQYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiKSQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B82326D4;
        Sat, 19 Nov 2022 08:24:03 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AS5Z+BBmecwdSUivSO62SfVuMhcWxNStj6XBmnAtfA=;
        b=xVXMdFjJ9V4dIlbifdGWCutNp8/aEU4rRHkrJFTqz8pDk+8kbYMq8L+k2rrRDrjQvpeVBr
        fGLlxGjTDREueW8X61Z4MGNO9FTCsn7FMH05zNNsTcaaGbAnmJHwPh55OXTYnM4x6winHP
        jsz/8C2Dz4u2MUE2rkzifr9CzDEmv9ABDgIhDiDxI/OortVJmwm/YDT+5lKdA2KRPX85y1
        L4bbg6rARJNojV1rm9BllFVht/9TWA4aG49AG2POuZlWHCD2Judlc6tilFl1hG5Vl3kGZq
        oIzh7Li4I+PQbysbBe0jxghUAir4fMiGW5QkuXkgM9mPFFSJwhMuehLlhvOcOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AS5Z+BBmecwdSUivSO62SfVuMhcWxNStj6XBmnAtfA=;
        b=3+MMmdGmM2N2JOtuVxy4kpsn1fLTa0nE3ZUVWpSfw5KSSd8sL2rt1SIP5HxIRfUzegy3Fs
        7clBbIyZxsDeoFDA==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Remove reload sysfs entry
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-14-jithu.joseph@intel.com>
References: <20221117035935.4136738-14-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504113.4906.18024308117030745196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     bf835ee852be38e9fab1fdb330eccdd9728aec34
Gitweb:        https://git.kernel.org/tip/bf835ee852be38e9fab1fdb330eccdd9728aec34
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:32 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Nov 2022 11:23:53 +01:00

platform/x86/intel/ifs: Remove reload sysfs entry

Reload sysfs entry will be replaced by current_batch, drop it.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-14-jithu.joseph@intel.com
---
 drivers/platform/x86/intel/ifs/sysfs.c | 29 +-------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 65dd6fe..e077910 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -88,34 +88,6 @@ static ssize_t run_test_store(struct device *dev,
 static DEVICE_ATTR_WO(run_test);
 
 /*
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
-/*
  * Display currently loaded IFS image version.
  */
 static ssize_t image_version_show(struct device *dev,
@@ -136,7 +108,6 @@ static struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
 	&dev_attr_status.attr,
 	&dev_attr_run_test.attr,
-	&dev_attr_reload.attr,
 	&dev_attr_image_version.attr,
 	NULL
 };
