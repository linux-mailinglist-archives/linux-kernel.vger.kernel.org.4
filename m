Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A6630F79
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiKSQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiKSQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC4F4A05B;
        Sat, 19 Nov 2022 08:24:15 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muQTXZYSw3atrpSoZl8JOotKej5iiq3uT4V5g8UvXEE=;
        b=WWaOfmDwAVEuKmVDFEToUX1A/hSi1H751cGpYxqpLeOiziO8qf4D3YsmnTLNqB3SRRmm+r
        INtBEgmJ7eg4BF7uHE87BWQ+P4NN7O9Ajk7tnOAmdYLWhDTpCtW8BGhSayNrZkSx5MGEzJ
        SB/8b3IEqDvxRAfEHvdbqj1tEXtq74Iieo8XMQwz7fWq2C1Zq141ceX58ZXmMpDbhXcukN
        GsDHno5srhb03hI6yjlzE39I5ioQvsAsmV8JXSyHbHo1HnRt5WRhVYiY477DQCD9R1OBZP
        ywfWB6O8jPiNolCq72GJJDJzN0x+h38wYqBKSB3U4MGToPnhYlhEA1kKumdAMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muQTXZYSw3atrpSoZl8JOotKej5iiq3uT4V5g8UvXEE=;
        b=hGOqYyLRdFnES46i2Mxc+za50cI87DNc0ohmSdIJ2kq38VHzTxY+UL+6i8FXJxiLvKmSpJ
        +RGMpPt+IcGNc4AQ==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Remove image loading during init
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-4-jithu.joseph@intel.com>
References: <20221117035935.4136738-4-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887505241.4906.5775436926637389361.tip-bot2@tip-bot2>
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

Commit-ID:     a4c30fa4ead5e6628e5ff5a45664ba7181acf6f1
Gitweb:        https://git.kernel.org/tip/a4c30fa4ead5e6628e5ff5a45664ba7181acf6f1
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:22 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Nov 2022 21:37:04 +01:00

platform/x86/intel/ifs: Remove image loading during init

IFS test image is unnecessarily loaded during driver initialization.
Drop image loading during ifs_init() and improve module load time. With
this change, user has to load one when starting the tests.

As a consequence, make ifs_sem static as it is only used within sysfs.c

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-4-jithu.joseph@intel.com
---
 drivers/platform/x86/intel/ifs/core.c  | 6 +-----
 drivers/platform/x86/intel/ifs/ifs.h   | 2 --
 drivers/platform/x86/intel/ifs/sysfs.c | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 27204e3..5fb7f65 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -51,12 +51,8 @@ static int __init ifs_init(void)
 	ifs_device.misc.groups = ifs_get_groups();
 
 	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
-	    !misc_register(&ifs_device.misc)) {
-		down(&ifs_sem);
-		ifs_load_firmware(ifs_device.misc.this_device);
-		up(&ifs_sem);
+	    !misc_register(&ifs_device.misc))
 		return 0;
-	}
 
 	return -ENODEV;
 }
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 73c8e91..3ff1d9a 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -229,6 +229,4 @@ void ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
-extern struct semaphore ifs_sem;
-
 #endif
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 37d8380..65dd6fe 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -13,7 +13,7 @@
  * Protects against simultaneous tests on multiple cores, or
  * reloading can file while a test is in progress
  */
-DEFINE_SEMAPHORE(ifs_sem);
+static DEFINE_SEMAPHORE(ifs_sem);
 
 /*
  * The sysfs interface to check additional details of last test
