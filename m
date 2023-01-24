Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685B679425
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjAXJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjAXJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D572A5;
        Tue, 24 Jan 2023 01:26:41 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQBy7IN/YvfkXQt6TRd6rZ2ywPAj5eyVw6ULbuH+9WE=;
        b=TDl3FMaa9Fm93uXb6nTCYPffBSfZwBT3YZPV8ec3OOTZA+stXstBzojMIYkh+WpCYsWjjk
        tDdePkmorL1YL9nIrRuwSWWCyvtqXbGrp/eLsliGKnG+JMXcidfxrl7drsJ8sp/lK1oJ5y
        pQ38fRFyxEV+cmVHnlC2A6aM+H0WFQhEqiMeXnnKAID0MOcKpKBeabqSHvU66DwrCLuytm
        ciNvNg1iO0nR9ResZq1NXuHc6IQp5J97WAzmw1IysJ1Rrv9Mj8QFnImlrgH5Ffg/m1plJ8
        JkkbfBp0rQUcvFZKpRh6AYjXLgZRuYLaxCS//+v+PbRJc+M+5AEtJSzLe+cGWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQBy7IN/YvfkXQt6TRd6rZ2ywPAj5eyVw6ULbuH+9WE=;
        b=0XKLPW4RWqk6aQTFkXM+BqlmM3LF6eTr6GdKng47HSPgkmPNe5Ds2TMqFvgaAuaPWAo1Z6
        8DQS2xNmmdBl/lCA==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-8-babu.moger@amd.com>
References: <20230113152039.770054-8-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239706.4906.14594774721679630568.tip-bot2@tip-bot2>
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

Commit-ID:     bd334c86b5d70e5d1c6169991802e62c828d6f38
Gitweb:        https://git.kernel.org/tip/bd334c86b5d70e5d1c6169991802e62c828d6f38
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:33 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:40:11 +01:00

x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()

In an upcoming change, rdt_get_mon_l3_config() needs to call rdt_cpu_has() to
query the monitor related features. It cannot be called right now because
rdt_cpu_has() has the __init attribute but rdt_get_mon_l3_config() doesn't.

Add the __init attribute to rdt_get_mon_l3_config() that is only called by
get_rdt_mon_resources() that already has the __init attribute. Also make
rdt_cpu_has() available to by rdt_get_mon_l3_config() via the internal header
file.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-8-babu.moger@amd.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b4fc851..030d3b4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -728,7 +728,7 @@ static int __init set_rdt_options(char *str)
 }
 __setup("rdt", set_rdt_options);
 
-static bool __init rdt_cpu_has(int flag)
+bool __init rdt_cpu_has(int flag)
 {
 	bool ret = boot_cpu_has(flag);
 	struct rdt_options *o;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index fdbbf66..f16b8bc 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -512,6 +512,7 @@ void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
+bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 77538ab..5665ab9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -763,7 +763,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
-int rdt_get_mon_l3_config(struct rdt_resource *r)
+int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
