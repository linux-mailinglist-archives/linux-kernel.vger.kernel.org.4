Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226406202C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiKGWzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiKGWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E962B61F;
        Mon,  7 Nov 2022 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861691; x=1699397691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DyrS883OR7AFX4gN5EeEXTzT5dUJ/TdR0BLm14KTOTM=;
  b=IM1Zga1Ppta/6CWnZJJiVS1nc52O4WgmVQNMmqYtlG9nn7u0BzoaNo2d
   dUyzCebOi5PRi567CEBCiJTWNyaclkLZtLUJJKnEWM/kl3zQbXnBBG3xT
   U53SvrvFX2QrIgm34eXwbXgMb9j263Is4Tzy9v3J2onqU/WujFUrPxa2B
   Zr2kUAUs0pLHJFgZ89Ixi0V9ax9bSAq4qyic4GcVpX9JZ6mi1rISVlUsK
   9IKvkGLygMwlLHA5nMZ2X7uCmhGT6Ue9BFwoFxs9p2qpSxIsBMZcJXBmA
   f2TNhCS5S8JMLqVnmGtZMr8hcoQzllJu7rRYpBzQ5TW2c3/lWsH53HRv5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911843"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911843"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811013001"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811013001"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:49 -0800
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
Subject: [PATCH v2 14/14] Revert "platform/x86/intel/ifs: Mark as BROKEN"
Date:   Mon,  7 Nov 2022 14:53:23 -0800
Message-Id: <20221107225323.2733518-15-jithu.joseph@intel.com>
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

Issues with user interface [1] to load scan test images
has been addressed, so the following can be reverted.
commit c483e7ea10fa ("platform/x86/intel/ifs: Mark as BROKEN")

Link: https://lore.kernel.org/lkml/26102aca-a730-ddf8-d024-2e7367696757@redhat.com/ [1]

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
index 89152d46deee..3eded966757e 100644
--- a/drivers/platform/x86/intel/ifs/Kconfig
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -1,9 +1,6 @@
 config INTEL_IFS
 	tristate "Intel In Field Scan"
 	depends on X86 && CPU_SUP_INTEL && 64BIT && SMP
-	# Discussion on the list has shown that the sysfs API needs a bit
-	# more work, mark this as broken for now
-	depends on BROKEN
 	help
 	  Enable support for the In Field Scan capability in select
 	  CPUs. The capability allows for running low level tests via
-- 
2.25.1

