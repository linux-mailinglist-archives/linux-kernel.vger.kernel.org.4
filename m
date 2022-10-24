Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC2609D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJXIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJXIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:52:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF26744D;
        Mon, 24 Oct 2022 01:52:38 -0700 (PDT)
Date:   Mon, 24 Oct 2022 08:52:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666601555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fe5cUYaOyO4LInB2yVSxDGWGWGSQEQAqVZoCd+lv1ck=;
        b=LolFnQFULv1Fw63R4S38bY84k68Fc5cR1/22CXCKBZdOohfKm+Sd5w8T+WtcOxuAR8M8hZ
        9GxUOIhio6g0CSpYIuN6xBnu4DFLDJuw/aAaA4MF/II3BNQrRtVK/UElCrMnJ8yZ0+/Hh8
        djq2c1IWuFmc7ZkgJGU7SiBTATJP9as+4ewRlHjmh+GjhVlFDI2oanmld6LQHkwXZe4dmz
        NOXrA68IiS8LeNZ5LBfi8DgYL5ThwJHUjdlteHxhWORcrEC3wv8DZg72MroWTNaNFSwnrN
        Skrv01/vjW1aiQOMU/Dr+3rLiHodrVWvQ3bvTzZ0qOtMedf/9GWqxbFo+TBZIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666601555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fe5cUYaOyO4LInB2yVSxDGWGWGSQEQAqVZoCd+lv1ck=;
        b=f61ehkCpqmMwSZ3HulY48DC//dtlwp5xpmO8LseA3vZyAYcX/qB/vIW9yqCC/JpYFj/5UU
        qoDdCzvlO37EVrCw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove arch_has_empty_bitmaps
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <166430979654.372014.615622285687642644.stgit@bmoger-ubuntu>
References: <166430979654.372014.615622285687642644.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Message-ID: <166660155398.401.9624938541778955549.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2d4daa549c17b6ba4845a751c7a78d3b2419d78f
Gitweb:        https://git.kernel.org/tip/2d4daa549c17b6ba4845a751c7a78d3b2419d78f
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Tue, 27 Sep 2022 15:16:36 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 24 Oct 2022 10:30:29 +02:00

x86/resctrl: Remove arch_has_empty_bitmaps

The field arch_has_empty_bitmaps is not required anymore. The field
min_cbm_bits is enough to validate the CBM (capacity bit mask) if the
architecture can support the zero CBM or not.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lore.kernel.org/r/166430979654.372014.615622285687642644.stgit@bmoger-ubuntu
---
 arch/x86/kernel/cpu/resctrl/core.c        | 2 --
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 3 +--
 include/linux/resctrl.h                   | 6 +++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3266ea3..03cfbf0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -828,7 +828,6 @@ static __init void rdt_init_res_defs_intel(void)
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
 			r->cache.arch_has_sparse_bitmaps = false;
-			r->cache.arch_has_empty_bitmaps = false;
 			r->cache.arch_has_per_cpu_cfg = false;
 			r->cache.min_cbm_bits = 1;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
@@ -849,7 +848,6 @@ static __init void rdt_init_res_defs_amd(void)
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
 			r->cache.arch_has_sparse_bitmaps = true;
-			r->cache.arch_has_empty_bitmaps = true;
 			r->cache.arch_has_per_cpu_cfg = true;
 			r->cache.min_cbm_bits = 0;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1dafbdc..1df0e32 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -105,8 +105,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if ((!r->cache.arch_has_empty_bitmaps && val == 0) ||
-	    val > r->default_ctrl) {
+	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > r->default_ctrl) {
 		rdt_last_cmd_puts("Mask out of range\n");
 		return false;
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0cf5b20..0cee154 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -89,11 +89,12 @@ struct rdt_domain {
 /**
  * struct resctrl_cache - Cache allocation related data
  * @cbm_len:		Length of the cache bit mask
- * @min_cbm_bits:	Minimum number of consecutive bits to be set
+ * @min_cbm_bits:	Minimum number of consecutive bits to be set.
+ *			The value 0 means the architecture can support
+ *			zero CBM.
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
- * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
  */
@@ -102,7 +103,6 @@ struct resctrl_cache {
 	unsigned int	min_cbm_bits;
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmaps;
-	bool		arch_has_empty_bitmaps;
 	bool		arch_has_per_cpu_cfg;
 };
 
