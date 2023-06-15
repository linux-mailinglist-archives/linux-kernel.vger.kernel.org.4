Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E95731B26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbjFOOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344999AbjFOOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:20:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD101FE5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:20:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666a63f7907so461469b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686838841; x=1689430841;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JGAswJvrN9ycwNK3V8LbKRDbgcmOmmNh+l9o4Hidpg=;
        b=reIk64f9MXuAuPeWyNGo383hVNVC/u76gluY6eO7V5f/ec+hXKqIofT/ETvYjvPg0j
         HIJ0VrjPk7Gdmnte6rmdB2jU5na6GJXDFdTNGpOD5rLODVKI945tApGSxko9FhGTdaSj
         s1+DoKun9sSO3Whc1Dep5qihmEXSK6EwqN0KO0F8NcgWGeoxunariwSSn0MFZBQjgpAJ
         2ESQ0jRb8VKKsN2fYU7mnODvdfX+rEeVfB7CoWNEVZWE91IFDtWD9DvGsPIMfniGtnAt
         pbhakwox3J2ADRdLtxAsMSl2rPmKhgOdeJqqo2R225KSeuQoZj1Fr46/MQ9VeF22Kzz+
         bFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686838841; x=1689430841;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JGAswJvrN9ycwNK3V8LbKRDbgcmOmmNh+l9o4Hidpg=;
        b=hJVAl7mL2WuiJ2djxRPBSYp+6nPmRgOTGULPlIvhPhGzDpfzMhFwOVdLDzbYlWWfqs
         D7uCwVbkK8dQGp0g9yjBMB9JB/ocDeQRfWQj5V/ZvyTH5+DYHFROAGp0BOreRCowc1OD
         j/QuvIOscu5mXvmyc/N67ae+QINqNLI2KiXR+Ug2OsGoCRvVaypWnZAfd2Cm8UGGWXBq
         KEV/f9l88t1afrhA8wvP3dNc96Lk4ifR5b8CuzS/Ec4+w/KiAOH768CRIFpR9hD9T1Iz
         hw/B2WJlEokmETYeSun0JJmpXsOeOPIMRi2C+NMg7qEsRxAH81G+G9NXNJ5dtJ6RI6se
         Onyg==
X-Gm-Message-State: AC+VfDzAxhbwsIer4R8YxoznldLeZT/3I0ozCLkEysQjDwoTeFsqglIV
        UqqjvPP8HrnryjcnSxJAWBE=
X-Google-Smtp-Source: ACHHUZ74ya95W5jl4Y1m5VmgCOFfbK98QmvK0eQULayH+Iq9tqGTxWC3lPlehCCJr54jmdKZYIulKg==
X-Received: by 2002:a05:6a20:2d26:b0:10b:5ce1:beb9 with SMTP id g38-20020a056a202d2600b0010b5ce1beb9mr4993069pzl.33.1686838841170;
        Thu, 15 Jun 2023 07:20:41 -0700 (PDT)
Received: from localhost.localdomain ([112.213.33.6])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b0065055ad5754sm1571094pfo.64.2023.06.15.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:20:40 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        akpm@linux-foundation.org, rppt@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        zhiguangni01@gmail.com
Subject: [PATCH] x86,NUMA:Get the number of ram pages directly in numa_meminfo_cover_memory()
Date:   Fri, 16 Jun 2023 00:20:16 +1000
Message-Id: <20230615142016.419570-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous implementation,The ram page is calculated
by counting the number of holes,
however,the number of ram pages is calculated during hole calculation.
Therefore,we can directly calculate the amount of ram pages.

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 arch/x86/mm/numa.c |  4 ++--
 include/linux/mm.h |  4 ++++
 mm/mm_init.c       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..8ea0e956e3d7 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -461,12 +461,12 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
 		u64 s = mi->blk[i].start >> PAGE_SHIFT;
 		u64 e = mi->blk[i].end >> PAGE_SHIFT;
 		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
+		numaram += __available_pages_in_range(mi->blk[i].nid, s, e);
 		if ((s64)numaram < 0)
 			numaram = 0;
 	}
 
-	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
+	e820ram = available_pages_in_range(0, max_pfn);
 
 	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
 	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0daef3f2f029..f7f8c3476d1e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3041,8 +3041,12 @@ void free_area_init(unsigned long *max_zone_pfn);
 unsigned long node_map_pfn_alignment(void);
 unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
 						unsigned long end_pfn);
+unsigned long __available_pages_in_range(int nid, unsigned long start_pfn,
+						unsigned long end_pfn);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
+extern unsigned long available_pages_in_range(unsigned long start_pfn,
+						unsigned long end_pfn);
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3ddd18a89b66..33451afbc040 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1165,6 +1165,39 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
 	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
 }
 
+/*
+ * Return the number of avalible pages in a range on a node. If nid is MAX_NUMNODES,
+ * then all avalible pages in the requested range will be accounted for.
+ */
+unsigned long __init __available_pages_in_range(int nid,
+				unsigned long range_start_pfn,
+				unsigned long range_end_pfn)
+{
+	unsigned long nr_avalible;
+	unsigned long start_pfn, end_pfn;
+	int i;
+
+	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
+		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
+		nr_avalible += end_pfn - start_pfn;
+	}
+	return nr_avalible;
+}
+
+/**
+ * available_pages_in_range - Return the number of available page frames within a range
+ * @start_pfn: The start PFN to start searching for holes
+ * @end_pfn: The end PFN to stop searching for holes
+ *
+ * Return: the number of available pages frames within a range.
+ */
+unsigned long __init available_pages_in_range(unsigned long start_pfn,
+							unsigned long end_pfn)
+{
+	return __available_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
+}
+
 /* Return the number of page frames in holes in a zone on a node */
 static unsigned long __init zone_absent_pages_in_node(int nid,
 					unsigned long zone_type,
-- 
2.25.1

