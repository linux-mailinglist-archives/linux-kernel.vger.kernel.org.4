Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937776A653D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCACBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCACBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:01:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4231CF4F;
        Tue, 28 Feb 2023 18:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677636077; x=1709172077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eiS3IxaAsk6x7BayF1DCQxveYExshrK1kKyFW8zL/CQ=;
  b=FrGlkLbVaix/hv/kEgnOYcoI+4WgA3qg70myIi1h+Bxt430L31rNQt3w
   l2pX6QOX8C73u7Jf5MA1Myi8Fzl3YvWrf+CEz4gvAmG5KCqjt661+1rjd
   MzM8hcMJfNGHkNSNRU6pGTKmrFHuo87CS2+r4c3z++l780nOWeCtfY+FM
   ddAFTLrt9iMFUOhx5o4M3CXPSFuihuOII0JvoA/08cb0dh+iEcV70tQds
   0NW2RmdS/IGQeU0sDU1zFt9rsOAAodjYPwovB4pVcDniqVoJiKyX93L+x
   JCK/uX8N9KeIlk8ocq1uMULk0yayBfffBHpGDEu/D1NpOtXoA7jmMjbjh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="420558493"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="420558493"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704639978"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704639978"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:16 -0800
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
Subject: [PATCH v3 8/8] Documentation/ABI: Update IFS ABI doc
Date:   Tue, 28 Feb 2023 17:59:42 -0800
Message-Id: <20230301015942.462799-9-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301015942.462799-1-jithu.joseph@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/ABI/testing/sysfs-platform-intel-ifs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 55991983d0d0..c0cc5ef0739a 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -21,15 +21,16 @@ Date:		Nov 16 2022
 KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Additional information regarding the last test. The details file reports
-		the hex value of the SCAN_STATUS MSR. Note that the error_code field
+		the hex value of the STATUS MSR for this test. Note that the error_code field
 		may contain driver defined software code not defined in the Intel SDM.
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/image_version
 Date:		Nov 16 2022
 KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Version (hexadecimal) of loaded IFS binary image. If no scan image
-		is loaded reports "none".
+Description:	Version (hexadecimal) of loaded IFS test image. If no test image
+		is loaded reports "none". Only present for device instances where a test image
+		is applicable.
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
 Date:		Nov 16 2022
@@ -39,3 +40,4 @@ Description:	Write a number less than or equal to 0xff to load an IFS test image
 		The number written treated as the 2 digit suffix in the following file name:
 		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
 		Reading the file will provide the suffix of the currently loaded IFS test image.
+		This file is present only for device instances where a test image is applicable.
-- 
2.25.1

