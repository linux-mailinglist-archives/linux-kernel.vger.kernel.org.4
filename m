Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1086C3F36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCVAi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCVAiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:38:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F5F9758;
        Tue, 21 Mar 2023 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679445488; x=1710981488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b2HqjCdXLmojgBEJmKt1Gb9Votzjmjl0kKbTWnmZybc=;
  b=m0UzKxP7CCJJ11a7JtyrBh3KlAk9kKmI0BLA2uWn8XW1RAQH+1wt21Lx
   339SPJSX/nZMW09LVZGe+JxL8pALbE7sDx2dlMtt1pu1dpunMU40U9BSw
   PhFOZidbHEALJIaJ2efBj++Nu/vQLqylKlbfYkayqyZ6uxO2t99C0hOz+
   PSJV/PyP/Iiz3Md8m4BeZDEH6b6IrxAyFkLcSh8td48NApnGOqGHI6Eu9
   d4p03fK/MG6wIDSNPdQO6JPdyr+p82vO2jYdDDHEe+Dv0yNJREemg1M/1
   i0ddSEd2ym4nYOTDp2b1DCBXah8tKw08DTuVae9YgBBuKJKmKdBwOOlgA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322934958"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322934958"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="675076068"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="675076068"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:07 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v4 8/9] platform/x86/intel/ifs: Update IFS doc
Date:   Tue, 21 Mar 2023 17:33:58 -0700
Message-Id: <20230322003359.213046-9-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322003359.213046-1-jithu.joseph@intel.com>
References: <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230322003359.213046-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array BIST is the second test supported by IFS. Modify IFS doc
entry to be more general.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 048131df13bc..93191855890f 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -17,7 +17,7 @@
  * In Field Scan (IFS) is a hardware feature to run circuit level tests on
  * a CPU core to detect problems that are not caught by parity or ECC checks.
  * Future CPUs will support more than one type of test which will show up
- * with a new platform-device instance-id, for now only .0 is exposed.
+ * with a new platform-device instance-id.
  *
  *
  * IFS Image
@@ -25,7 +25,10 @@
  *
  * Intel provides a firmware file containing the scan tests via
  * github [#f1]_.  Similar to microcode there is a separate file for each
- * family-model-stepping.
+ * family-model-stepping. IFS Images are not applicable for some test types.
+ * Wherever applicable the sysfs directory would provide a "current_batch" file
+ * (see below) for loading the image.
+ *
  *
  * IFS Image Loading
  * -----------------
@@ -35,7 +38,7 @@
  * SHA hashes for the test. Then the tests themselves. Status MSRs provide
  * feedback on the success/failure of these steps.
  *
- * The test files are kept in a fixed location: /lib/firmware/intel/ifs_0/
+ * The test files are kept in a fixed location: /lib/firmware/intel/ifs_<n>/
  * For e.g if there are 3 test files, they would be named in the following
  * fashion:
  * ff-mm-ss-01.scan
@@ -47,7 +50,7 @@
  * (e.g 1, 2 or 3 in the above scenario) into the curent_batch file.
  * To load ff-mm-ss-02.scan, the following command can be used::
  *
- *   # echo 2 > /sys/devices/virtual/misc/intel_ifs_0/current_batch
+ *   # echo 2 > /sys/devices/virtual/misc/intel_ifs_<n>/current_batch
  *
  * The above file can also be read to know the currently loaded image.
  *
@@ -69,16 +72,16 @@
  * to migrate those applications to other cores before running a core test.
  * It may also be necessary to redirect interrupts to other CPUs.
  *
- * In all cases reading the SCAN_STATUS MSR provides details on what
+ * In all cases reading the corresponding test's STATUS MSR provides details on what
  * happened. The driver makes the value of this MSR visible to applications
  * via the "details" file (see below). Interrupted tests may be restarted.
  *
- * The IFS driver provides sysfs interfaces via /sys/devices/virtual/misc/intel_ifs_0/
+ * The IFS driver provides sysfs interfaces via /sys/devices/virtual/misc/intel_ifs_<n>/
  * to control execution:
  *
  * Test a specific core::
  *
- *   # echo <cpu#> > /sys/devices/virtual/misc/intel_ifs_0/run_test
+ *   # echo <cpu#> > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
  *
  * when HT is enabled any of the sibling cpu# can be specified to test
  * its corresponding physical core. Since the tests are per physical core,
@@ -87,21 +90,21 @@
  *
  * For e.g. to test core corresponding to cpu5
  *
- *   # echo 5 > /sys/devices/virtual/misc/intel_ifs_0/run_test
+ *   # echo 5 > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
  *
  * Results of the last test is provided in /sys::
  *
- *   $ cat /sys/devices/virtual/misc/intel_ifs_0/status
+ *   $ cat /sys/devices/virtual/misc/intel_ifs_<n>/status
  *   pass
  *
  * Status can be one of pass, fail, untested
  *
  * Additional details of the last test is provided by the details file::
  *
- *   $ cat /sys/devices/virtual/misc/intel_ifs_0/details
+ *   $ cat /sys/devices/virtual/misc/intel_ifs_<n>/details
  *   0x8081
  *
- * The details file reports the hex value of the SCAN_STATUS MSR.
+ * The details file reports the hex value of the test specific status MSR.
  * Hardware defined error codes are documented in volume 4 of the Intel
  * Software Developer's Manual but the error_code field may contain one of
  * the following driver defined software codes:
-- 
2.25.1

