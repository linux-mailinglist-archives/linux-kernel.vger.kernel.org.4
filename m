Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BEB652B09
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLUBhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLUBhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:37:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42319295
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671586619; x=1703122619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjjOX2Dsepa7e1W35S9brSm7o/ermaFF62lo2om6VGs=;
  b=eJQ8x0TwcWQeFO1yl11UN1iUxwnW+Z0wrqLElV/1/xDH3f/EvOXHoEB+
   VN3LsjZOf+5SN1WIXbda3x7D3p1yrNQyGIQtNWy/fGannBtj2m+ilfCt6
   HXHRWOl2zNQDLx4Lklr4IeMWz3AF+oco5aMoCBbr5jlac+2TkFoRByH8o
   uHdNwAJ55McZhf87XzLgMji8gKtmjof5Vl2hlR2NUCYBMsxPX/DbCB2K8
   J4G96jCg+miQHoO5UYofjWlBKBzuXjeYcJoM+JGIe8Wzv+oCfr/+/KKCG
   SiM9V4EPXCQroeA9JLzr8uLd6LjDYit6SrkX2HjI60eo+2c28E/rukgWc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="346883700"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="346883700"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 17:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="775514236"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="775514236"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2022 17:36:57 -0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>, kevin.tian@intel.com,
        seanjc@google.com
Subject: [PATCH v1 1/1] x86/fpu: Fix the "Block comments should align the * on each line" WARNING from checkpatch
Date:   Wed, 21 Dec 2022 09:37:47 +0800
Message-Id: <013d5cc84ac559d2a70b79e29b4e124365e50e77.1671586299.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1671586299.git.pengfei.xu@intel.com>
References: <cover.1671586299.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

