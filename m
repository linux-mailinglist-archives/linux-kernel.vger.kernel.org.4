Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810BC630F66
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiKSQYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKSQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98764317F1;
        Sat, 19 Nov 2022 08:24:02 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:23:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAPdjN5/N/OGC+H5XcA7O43gh7b6fe9xTAcrAoEmJNM=;
        b=K0irHBUR+ByKZF1VDEuAC59nICj8IOynsab+xXQxiuGO4q0kvTfy3SAHJNxIgmPXLM9jtm
        xLKFojCXlmXO46FMqcx97H4APVWceXt5fEEnun08DAXlYhRwTbBTI3ufjoBuOfivTY396I
        NaAG1T7Wm85IToJCeJy+gAgCvcYUD43+ZSL6+K1I/zDIiUIChy6CZSEQSf9n4nA9xspXqh
        ANvwNORrChZ1BKhq8xSZ1L/wQae/9v/xghs/j+vTfOAoy1HyH+4zrwOnieFXyU1acbEEz9
        3gqEKmLoC3xwjIB7hT/LZbNIfjIe0Zsb8+RymMKyKIIs7ETdiN734DeoceA+0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAPdjN5/N/OGC+H5XcA7O43gh7b6fe9xTAcrAoEmJNM=;
        b=PvVZCupVu/OXQbB1pJAGfq7uF7PlCmOy8v00UuFwEfbHDJ5AxKSQLYVeDBGoXaZdH9KU1R
        UlCRmiy2HNSW3ZBQ==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] Documentation/ABI: Update IFS ABI doc
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-16-jithu.joseph@intel.com>
References: <20221117035935.4136738-16-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887503889.4906.10128020775936056075.tip-bot2@tip-bot2>
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

Commit-ID:     72a0f445fc091bd18873b10b9ab56573e490f00d
Gitweb:        https://git.kernel.org/tip/72a0f445fc091bd18873b10b9ab56573e490f00d
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:34 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Nov 2022 11:30:00 +01:00

Documentation/ABI: Update IFS ABI doc

Remove reload documentation and add current_batch documentation.
Update the kernel version and date for all the entries.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-16-jithu.joseph@intel.com
---
 Documentation/ABI/testing/sysfs-platform-intel-ifs | 30 ++++++-------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 486d6d2..5599198 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -1,39 +1,41 @@
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
-Date:		April 21 2022
-KernelVersion:	5.19
+Date:		Nov 16 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Write <cpu#> to trigger IFS test for one online core.
 		Note that the test is per core. The cpu# can be
 		for any thread on the core. Running on one thread
 		completes the test for the core containing that thread.
 		Example: to test the core containing cpu5: echo 5 >
-		/sys/devices/platform/intel_ifs.<N>/run_test
+		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/status
-Date:		April 21 2022
-KernelVersion:	5.19
+Date:		Nov 16 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	The status of the last test. It can be one of "pass", "fail"
 		or "untested".
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/details
-Date:		April 21 2022
-KernelVersion:	5.19
+Date:		Nov 16 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Additional information regarding the last test. The details file reports
 		the hex value of the SCAN_STATUS MSR. Note that the error_code field
 		may contain driver defined software code not defined in the Intel SDM.
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/image_version
-Date:		April 21 2022
-KernelVersion:	5.19
+Date:		Nov 16 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Version (hexadecimal) of loaded IFS binary image. If no scan image
 		is loaded reports "none".
 
-What:		/sys/devices/virtual/misc/intel_ifs_<N>/reload
-Date:		April 21 2022
-KernelVersion:	5.19
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
+Date:		Nov 16 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Write "1" (or "y" or "Y") to reload the IFS image from
-		/lib/firmware/intel/ifs/ff-mm-ss.scan.
+Description:	Write a number less than or equal to 0xff to load an IFS test image.
+		The number written treated as the 2 digit suffix in the following file name:
+		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
+		Reading the file will provide the suffix of the currently loaded IFS test image.
