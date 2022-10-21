Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A705607FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJUUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJUUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:40:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EA9A9D0;
        Fri, 21 Oct 2022 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384800; x=1697920800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ieAw6DOi25+M/PVVeqIKsG7UFRjhjw4Kz3UXCTTfxEQ=;
  b=CMbYtpihPhC9398J+dEVDSR1aQ+Nm/lV9atyaFHFHOQVe9o/mhMpTWRc
   UBjHu+eSOdBXTcdu9HzuuZ5NQ7ZAdJthRRGZ2nloUxJEfQAsRSFSQZ2xR
   UwoNciOKr3vdnwmqHfWeI7D2fhTrSJ/mpuDklgpF9W5dWdDu8H1rMxHjO
   +fRQzSfCUrj9qfHsvl4LaJoXWca4kvhiaPdJr6bN+NrZDGFqEC0wHkJlN
   a9e716SSEROyNcF7TVDlzObBJq10XJwK1MEbqG2n/a35CJDrsa5/zAPa5
   vw2DgEM9POXESHvbaAN5wbU5N3qt4b7xdjs6bW++tPRihGkkJ+PntxaTL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161192"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161192"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701044"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701044"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:36 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 13/14] Documentation/ABI: Update IFS ABI doc
Date:   Fri, 21 Oct 2022 13:34:12 -0700
Message-Id: <20221021203413.1220137-14-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reload documentation and add current_batch documentation.
Update the kernel version and date for all the entries.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-ifs      | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 486d6d2ff8a0..f74df3abee57 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -1,39 +1,41 @@
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
-Date:		April 21 2022
-KernelVersion:	5.19
+Date:		Sept 30 2022
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
+Date:		Sept 30 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	The status of the last test. It can be one of "pass", "fail"
 		or "untested".
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/details
-Date:		April 21 2022
-KernelVersion:	5.19
+Date:		Sept 30 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Additional information regarding the last test. The details file reports
 		the hex value of the SCAN_STATUS MSR. Note that the error_code field
 		may contain driver defined software code not defined in the Intel SDM.
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/image_version
-Date:		April 21 2022
-KernelVersion:	5.19
+Date:		Sept 30 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Version (hexadecimal) of loaded IFS binary image. If no scan image
 		is loaded reports "none".
 
-What:		/sys/devices/virtual/misc/intel_ifs_<N>/reload
-Date:		April 21 2022
-KernelVersion:	5.19
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
+Date:		Sept 30 2022
+KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Write "1" (or "y" or "Y") to reload the IFS image from
-		/lib/firmware/intel/ifs/ff-mm-ss.scan.
+Description:	Write a number less than or equal to 0xff to load an IFS test image.
+		The number written treated as the 2 digit suffix in the following file name:
+		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
+		Reading the file will provide the suffix of the currently loaded IFS test image.
-- 
2.25.1

