Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA1652B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiLUBsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLUBsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:48:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5FD1A38B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671587332; x=1703123332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=saA6yNu5Ageeoss/mZtX0ds4Mj5RDpNf2Va/EUNjVGU=;
  b=cw/09BjDCDtJKkQ15ewGX2dtlut28rHoiNZYimZSGJrgbTAzA73jpm4I
   rLT5Har3rN+4SpKHFdhXLypl9CwG59xV51K/Uxrw98z93BoA1iSPiq7xC
   KxOwflSbtjJQhLyOKtDSD+mFAlDhlIUcA20/S4iRqnmHqF7uasX/dtRgM
   PEG7edMYsr9MpZED/iFR+dc1tup8JTZk1FFRAK6D1v9RWiBHGOtXwL91N
   TmSvGKAosRCfpU4bf2xpcKU4+RlQKa8hjBS8tinFxuxkkegwpVVSDfhxi
   mzg1MnSDu2vLLSBpK5WE6RN3SWyYJACgDKMKyrdiNoYNVZigi08Nr1A4n
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="318462858"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="318462858"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 17:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="739984976"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="739984976"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2022 17:48:50 -0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>, kevin.tian@intel.com,
        seanjc@google.com
Subject: [PATCH v2 1/1] x86/fpu: Fix the "Block comments should align the * on each line" WARNING from checkpatch
Date:   Wed, 21 Dec 2022 09:49:41 +0800
Message-Id: <57144fd558233e24729420f5c34c78d039108bf0.1671587242.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1671587242.git.pengfei.xu@intel.com>
References: <cover.1671587242.git.pengfei.xu@intel.com>
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

This commit fixes the following WARNING from checkpatch:
"
WARNING: Block comments should align the * on each line
Line 273: FILE: /home/code/lkml/arch/x86/kernel/fpu/core.c:273:
+/*
+  * fpu_enable_guest_xfd_features - Check xfeatures against guest perm and enable
"

Fixes: 0781d60f658e2 ("x86/fpu: Provide fpu_enable_guest_xfd_features() for KVM")
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 arch/x86/kernel/fpu/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d00db56a8868..cc7bab92c4c1 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -270,14 +270,14 @@ void fpu_free_guest_fpstate(struct fpu_guest *gfpu)
 EXPORT_SYMBOL_GPL(fpu_free_guest_fpstate);
 
 /*
-  * fpu_enable_guest_xfd_features - Check xfeatures against guest perm and enable
-  * @guest_fpu:         Pointer to the guest FPU container
-  * @xfeatures:         Features requested by guest CPUID
-  *
-  * Enable all dynamic xfeatures according to guest perm and requested CPUID.
-  *
-  * Return: 0 on success, error code otherwise
-  */
+ * fpu_enable_guest_xfd_features - Check xfeatures against guest perm and enable
+ * @guest_fpu:         Pointer to the guest FPU container
+ * @xfeatures:         Features requested by guest CPUID
+ *
+ * Enable all dynamic xfeatures according to guest perm and requested CPUID.
+ *
+ * Return: 0 on success, error code otherwise
+ */
 int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures)
 {
 	lockdep_assert_preemption_enabled();
-- 
2.31.1

