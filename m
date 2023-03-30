Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F96D0A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjC3Pxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjC3Px3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:53:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21EC65E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:53:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so78333657edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680191589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikZyF37hU9YDO+GQB/GUbHTmkdXciWAtoxo0PEHvqgY=;
        b=ROBarmsc9FRDQk/abfcUvYA25l2Bl8IEyF1WgfDPAx4A5JuDBqHyeCrwreeMJyenNA
         v/OJvRZVjGKu2bWHM+Y28FtVAY6hyB6C03uv4iS0cfRSbz/rNPzTHClz1dEfTIq8hAo/
         E2RjDsaqtmGYV8cQslOaONDxnL3O6+LRmtpvoq1XA6o4BxiTC15ritsL82jR1iGCzY7C
         3D2+R8sk27Dp51zWeHJx80dTawRIABmezauk948tCUgvfgwcei/0sLl0SuFo6h3Ofh6d
         U55bwxxMHRJLYAxH4nI8QpYP6r39xLfRaF8nWV7+OZhpkXsY2QUuxWRnvwrdCzq/CGqE
         aKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikZyF37hU9YDO+GQB/GUbHTmkdXciWAtoxo0PEHvqgY=;
        b=uVM0FrMqudoFzP4UwPvc8tcvBYkYWsLE7uATQEeMFVm18sq3LQkRAP4Q1PHjqQdlfL
         JMtIMyYnuhC0odSf/uE7/jK1fWhYntcVInMvqQ2BQVxZAlPgnXXkKYkWXZjh2WLmnVZv
         Q0zhZbTJnyVl1PvL6kRElR8cvC7FRszBGD3ZMgsI/WU6fB5ehc8N3svm10I4KIcAvIjf
         MVsiH/5b0RTrkUOCh4c/gCI0/VqoslZgghoOUFgEvzMlSYEZAVc+XTDUF6Mx85QmUvE/
         yrpOgeEJ29DRHYo4G7umamKEAB+9LHckl9AIyOzEfMTtEM7Uy231qu/CGzDneP4A9zAx
         Sxqg==
X-Gm-Message-State: AAQBX9eqUZ/A6g28wdUb/uphmJACl7MDcH2WTTM9ed1Sv/aqqDLDukaE
        ZYggm5S2XLju7JW1XignHVw=
X-Google-Smtp-Source: AKy350bonleupkdfcCxOXzFGjgMB/RZ0SXYhmfxsTBkQyFAwaTdJDflIKAwbXhgwxlO9d0UptITKhQ==
X-Received: by 2002:a17:906:2098:b0:8d2:78c5:1d4e with SMTP id 24-20020a170906209800b008d278c51d4emr2497476ejq.5.1680191588594;
        Thu, 30 Mar 2023 08:53:08 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.81.51])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b0093408d33875sm15027305ejb.49.2023.03.30.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:53:08 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, himadrispandya@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        shy828301@gmail.com, zokeefe@google.com,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
Subject: [PATCH v2] mm: khugepaged: Fix kernel BUG in hpage_collapse_scan_file
Date:   Thu, 30 Mar 2023 19:53:05 +0400
Message-Id: <20230330155305.423051-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

kernel BUG at mm/khugepaged.c:1823!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5097 Comm: syz-executor220 Not tainted 6.2.0-syzkaller-13154-g857f1268a591 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 madvise_collapse+0x721/0xf50 mm/khugepaged.c:2693
 madvise_vma_behavior mm/madvise.c:1086 [inline]
 madvise_walk_vmas mm/madvise.c:1260 [inline]
 do_madvise+0x9e5/0x4680 mm/madvise.c:1439
 __do_sys_madvise mm/madvise.c:1452 [inline]
 __se_sys_madvise mm/madvise.c:1450 [inline]
 __x64_sys_madvise+0xa5/0xb0 mm/madvise.c:1450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The 'xas_store' call during page cache scanning can potentially
translate 'xas' into the error state (with the reproducer provided
by the syzkaller the error code is -ENOMEM). However, there are no
further checks after the 'xas_store', and the next call of 'xas_next'
at the start of the scanning cycle doesn't increase the xa_index,
and the issue occurs.

This patch will add the xarray state error checking after the
'xas_store' and the corresponding result error code. It will
also add xarray state error checking via WARN_ON_ONCE macros,
to be sure that ENOMEM or other possible errors don't occur
at the places they shouldn't.

Tested via syzbot.

Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2: Add WARN_ON_ONCE error checking and comments

 mm/khugepaged.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 92e6f56a932d..8b6580b13339 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -55,6 +55,7 @@ enum scan_result {
 	SCAN_CGROUP_CHARGE_FAIL,
 	SCAN_TRUNCATED,
 	SCAN_PAGE_HAS_PRIVATE,
+	SCAN_STORE_FAILED,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1840,6 +1841,15 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					goto xa_locked;
 				}
 				xas_store(&xas, hpage);
+				if (xas_error(&xas)) {
+					/* revert shmem_charge performed
+					 * in the previous condition
+					 */
+					mapping->nrpages--;
+					shmem_uncharge(mapping->host, 1);
+					result = SCAN_STORE_FAILED;
+					goto xa_locked;
+				}
 				nr_none++;
 				continue;
 			}
@@ -1992,6 +2002,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 		/* Finally, replace with the new page. */
 		xas_store(&xas, hpage);
+		/* We can't get an ENOMEM here (because the allocation happened before)
+		 * but let's check for errors (XArray implementation can be
+		 * changed in the future)
+		 */
+		WARN_ON_ONCE(xas_error(&xas));
 		continue;
 out_unlock:
 		unlock_page(page);
@@ -2029,6 +2044,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	/* Join all the small entries into a single multi-index entry */
 	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	xas_store(&xas, hpage);
+	/* Here we can't get an ENOMEM (because entries were
+	 * previously allocated) But let's check for errors
+	 * (XArray implementation can be changed in the future)
+	 */
+	WARN_ON_ONCE(xas_error(&xas));
 xa_locked:
 	xas_unlock_irq(&xas);
 xa_unlocked:
-- 
2.34.1

