Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E006EE50B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjDYPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjDYPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:52:53 -0400
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A435AC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682437965;
        bh=JlYbbOs6z6hz+QzmnaXvi+VrUzPthQqcCo2R3Rs46yk=;
        h=From:To:Cc:Subject:Date;
        b=N4zKowrp+DkgWYGqEn2ck72aJy+qhilu/hQKZ7Sx6sipgx4v3DOCukeRfUUpTe+ah
         FJuPEQFweQTs+JMagWqVNPG16tRI8UQ2p19/KhdzgW6wkBFzsIvnQWeEHgK36b0Ya8
         OxmAhdzjPUUiwduhQ/VQx9S1zgIoiIu+w4JMsyPQ=
Received: from wen-VirtualBox.lan ([106.92.97.36])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id D2AA7EF8; Tue, 25 Apr 2023 23:52:42 +0800
X-QQ-mid: xmsmtpt1682437962trnudvj3a
Message-ID: <tencent_DFF54DB2A60F3333F97D3F6B5441519B050A@qq.com>
X-QQ-XMAILINFO: NCCl67D2lQ93xU+TdbuXKJH9/3z14+g0kHC1RIf5AlMXcdy0ey+UTbsytNU0Yl
         aMMJYE5gEOmNuwFfF+cwQOGgOXWyDvGp36YYooRoKboBuwPGO3Wn83IaRNgFNvDdptpObrbIAt/1
         qWJatIVZsc3QP0Dy+WedF/p5rx9cG7MiErCUfACU8HXsjZOs+NXOxVkj3kYR+ee8Zdc9VWIaEGrC
         NgibYn/UXRxUddF+azICdYkcXhFhbQe+X0h6WyqHCkxETfq4Yu7rBgSxzoqC7B76ZLJtLkanU+gz
         gQQQmgZ6bDk20hYaxwQafdK6Y9ifN1uGdLVIQpX/NWi7ao4RgnR0qykqMAchh1GDT4e7wY/tNISJ
         dV+1jKUrn9XWul0arhNL5HiTpTqOfUWWHa1f0O2D0ZpXzdHzTIjFNqyowYn6z+MMQUpbtQZXAuRA
         nKQxuRHnfCtGUV0+7oPO3SUWy5KZFRMRADiu+x4Cezxr5u85WrWiuUsH1/mUPN5LhEbhB7J217fs
         wE7dJCGoXjz1b9v0cLkbbKs8y/Lmd6jArWKjHHqvB2lMV8IFYM0akbBawuc09tE1RNFNWRD8muto
         SWr8BArpbJ4KLLZPMYDHlESkWTdmucv0RSkLTSNoliw1OSwOVQOHxVDak9ZrLHGybYV3DXc3LsX5
         JWqkPzohmXZgv8Sw4M/gY/A0quqtewWr4f1+hGoWsJ3tmhzKRpCPpJmErvXOjCsyYfPoPfnyiORB
         LCnwZiB3V74DeTRtounqdVFaaJzC7yGsdY1n4nnT3aZpMPtJsC3nD+uau4G+b41NaUlu9B2p9ZSf
         8npIHfvwL+eKite+dbMk22lkdNUDlqp68aaFPQ7NDs2EYctDQdXC2RGdODb36AcKHoJlcUS6v3Yv
         8z5uSa0Q9+PS/g8ScwQFNvOZRzzoA/EB0ADDxw/7LuOGSDqHWNgJXxIjxjKI6SXk18xfzphQsQba
         4ZUZoxlCwNEE0Tns3AYuSBG0MvyLnDVwYtF74M2Lq5TG0y8gEjHI+Kb43daO2pLJ99fyvnKr8ZtY
         JUu4/4nkFzAsehKfplPQYTIkl0zlJ82c7NtvIVG/jXcSmblRZYtBHoSL45EqMOiwJCMqRYoQ==
From:   wenyang.linux@foxmail.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Pintu Kumar <pintu@codeaurora.org>, Fu Wei <wefu@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: compaction: optimize compact_memory to comply with the admin-guide
Date:   Tue, 25 Apr 2023 23:52:35 +0800
X-OQ-MSGID: <20230425155235.1020-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

For the /proc/sys/vm/compact_memory file, the admin-guide states:
When 1 is written to the file, all zones are compacted such that free
memory is available in contiguous blocks where possible. This can be
important for example in the allocation of huge pages although processes
will also directly compact memory as required

But it was not strictly followed, writing any value would cause all
zones to be compacted.
It has been slightly optimized to comply with the admin-guide.
Enforce the 1 on the unlikely chance that the sysctl handler is ever
extended to do something different.

Commit ef4984384172 ("mm/compaction: remove unused variable sysctl_compact_memory")
has also been optimized a bit here, as the declaration in the external header
file has been eliminated, and sysctl_compact_memory also needs to be verified.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: William Lam <william.lam@bytedance.com>
Cc: Pintu Kumar <pintu@codeaurora.org>
Cc: Fu Wei <wefu@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/compaction.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..ba57d4178866 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1736,6 +1736,7 @@ static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNE
  */
 static unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
 static int sysctl_extfrag_threshold = 500;
+static int sysctl_compact_memory;
 
 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
@@ -2780,6 +2781,15 @@ static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int
 static int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
+	int ret;
+
+	ret = proc_dointvec(table, write, buffer, length, ppos);
+	if (ret)
+		return ret;
+
+	if (sysctl_compact_memory != 1)
+		return -EINVAL;
+
 	if (write)
 		compact_nodes();
 
@@ -3095,7 +3105,7 @@ static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
 static struct ctl_table vm_compaction[] = {
 	{
 		.procname	= "compact_memory",
-		.data		= NULL,
+		.data		= &sysctl_compact_memory,
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= sysctl_compaction_handler,
-- 
2.37.2

