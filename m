Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F319C6C3F37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCVAic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCVAiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:38:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38086E184;
        Tue, 21 Mar 2023 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679445489; x=1710981489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nohiqToOsP6y6cJNQuVw0xtw2VknYjmA95yg6FTsWC8=;
  b=mTg++/nj4JlBxKrZ6LHm8z7U9Qg8MZTYW4nfrAZgFwP+SKK1YtG8fDg/
   6eb8rIhRYActqveiR5XcKY3vnVQ+CZWy1dk/+1X2WDbqcOOFeMTlW5w+H
   NQZo+o8DlWTmWFwx5umPHSQvtvaXjtMvU+0c5emgmE3plFEaTWGwskOaq
   GPC+tOM0Vvs6UVRs8tLiJmXn4nm+AIlLYPom6pfOUcHYsfhBpMFgPtReH
   wpGo1WsTem0FiMDPozzgipPs6opqyP7Euv1wDp1tBf7BldtvEpz+o00nB
   f1Dp0tdZZdt/hwxl7Ne9Q+e3Avts7nERtFnMl9HLzIyyXOxep5lk1jXKa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322934967"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322934967"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="675076077"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="675076077"
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
Subject: [PATCH v4 9/9] Documentation/ABI: Update IFS ABI doc
Date:   Tue, 21 Mar 2023 17:33:59 -0700
Message-Id: <20230322003359.213046-10-jithu.joseph@intel.com>
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

Array BIST test doesn't need an IFS test image to operate unlike
the SCAN test. Consequently current_batch and image_version
files are not applicable for Array BIST IFS device instance,
clarify this in the ABI doc.

Also given that multiple tests are supported, take the opportunity
to generalize descriptions wherever applicable.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-ifs        | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 55991983d0d0..41b4d5b1e21c 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -1,3 +1,7 @@
+Device instance to test mapping
+intel_ifs_0  ->  Scan Test
+intel_ifs_1  ->  Array BIST test
+
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
 Date:		Nov 16 2022
 KernelVersion:	6.2
@@ -8,6 +12,7 @@ Description:	Write <cpu#> to trigger IFS test for one online core.
 		completes the test for the core containing that thread.
 		Example: to test the core containing cpu5: echo 5 >
 		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
+Devices:	all
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/status
 Date:		Nov 16 2022
@@ -15,21 +20,25 @@ KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	The status of the last test. It can be one of "pass", "fail"
 		or "untested".
+Devices:	all
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/details
 Date:		Nov 16 2022
 KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Additional information regarding the last test. The details file reports
-		the hex value of the SCAN_STATUS MSR. Note that the error_code field
+		the hex value of the STATUS MSR for this test. Note that the error_code field
 		may contain driver defined software code not defined in the Intel SDM.
+Devices:	all
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/image_version
 Date:		Nov 16 2022
 KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Version (hexadecimal) of loaded IFS binary image. If no scan image
-		is loaded reports "none".
+Description:	Version (hexadecimal) of loaded IFS test image. If no test image
+		is loaded reports "none". Only present for device instances where a test image
+		is applicable.
+Devices:	intel_ifs_0
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
 Date:		Nov 16 2022
@@ -39,3 +48,5 @@ Description:	Write a number less than or equal to 0xff to load an IFS test image
 		The number written treated as the 2 digit suffix in the following file name:
 		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
 		Reading the file will provide the suffix of the currently loaded IFS test image.
+		This file is present only for device instances where a test image is applicable.
+Devices:	intel_ifs_0
-- 
2.25.1

