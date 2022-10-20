Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEAA606BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJTXRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJTXRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:17:40 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4E22EE37
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:17:35 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id t26so1183186uaj.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z4UK+YSd44EWa9tT929JkG3rIhRX9wOtAF4K/xipQ=;
        b=Fz+yVYwnrjHx4w+MtD2CSa58RDIbjKnPExtdGatd7EutqG2N4rAwQDm7iMBlBm+zsI
         3hJdP9a62OXzPjOCb9DIYZs8ef0ybSyRf1qFHBBKe9gN3VwpddxGIF+iY6ifJZIKObqW
         mlaBZ/91X4IcOnT3pWS/wbjoi2xAcyZkIh9bZeupDqa48pyQ3c/O1v+DAJaLtVmG/pPW
         8rIxSST0Ya3NM3a+ACBfI0LaZY6TOFdr2Lo4k+zGAAfAOyZxR19Ts+JGRHc/SVAT6Noo
         e1h6g/XvjGpDF8hB/fIitRw4xKIMTr86OLyzavnTsQ+pL9lVsAuiIpX+V7APEP/zUONj
         NjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+z4UK+YSd44EWa9tT929JkG3rIhRX9wOtAF4K/xipQ=;
        b=o/A+t9LLbtQlxhSmp9T6lb0LZj9iJS8ZF0c0iJuSXgMA/PvbNhkLcv9IzR+qpNqArc
         8zflIKWUwMituWtON2KCn+DeUUaKv3Uv5XX8uwpHPeg79cr5h0PO7G9tSKssReHDFH7/
         glODObUpJdd5Gnh2IZpW9/qFMsY4OOEWd5ha4EwTHYnB7um2W32yYjPYRpJbDzBW/nLm
         17+0MtN/rG9082960QEHYHWDnB9dOsSWd24EDsL/+JU3bBbwNrSsy4lfRBE8UeIO/nRo
         gfFrOxBc1mzI7/QycJxO3dhu5f/EavZgdpHNq2JdCYIJKB2XIEION5Q4qTVUd79NJcLz
         WMBw==
X-Gm-Message-State: ACrzQf00cUQkQzgUuFbUwWSrkImDkpjvUTZoGs0vgRs7QR4gQjpOa/iO
        Nz4N+TIDnOw3mQxvuNmqY8bpTIbvex96+Fb+3q8=
X-Google-Smtp-Source: AMsMyM7YzZwl3myeXX3Vw+eUWCO1XEA3766+HOJj4kxM1O9KV2vKo2LYx9EacG1cGuYvJFoPJGvr7w==
X-Received: by 2002:a17:902:e5d1:b0:183:b450:ef76 with SMTP id u17-20020a170902e5d100b00183b450ef76mr16122080plf.151.1666307843787;
        Thu, 20 Oct 2022 16:17:23 -0700 (PDT)
Received: from localhost ([183.242.254.175])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090a990300b0020b2082e0acsm384222pjp.0.2022.10.20.16.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:17:23 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, 18801353760@163.com,
        yin31149@gmail.com
Subject: [PATCH -next] hugetlbfs: fix null-ptr-deref in hugetlbfs_parse_param()
Date:   Fri, 21 Oct 2022 07:16:08 +0800
Message-Id: <20221020231609.4810-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reports a null-ptr-deref bug as follows:
======================================================
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:hugetlbfs_parse_param+0x1dd/0x8e0 fs/hugetlbfs/inode.c:1380
[...]
Call Trace:
 <TASK>
 vfs_parse_fs_param fs/fs_context.c:148 [inline]
 vfs_parse_fs_param+0x1f9/0x3c0 fs/fs_context.c:129
 vfs_parse_fs_string+0xdb/0x170 fs/fs_context.c:191
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:231
 do_new_mount fs/namespace.c:3036 [inline]
 path_mount+0x12de/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 [...]
 </TASK>
======================================================

According to commit
ac369cdd9448("vfs: parse: deal with zero length string value"),
kernel will sets the param->string to null pointer in
vfs_parse_fs_string() if fs string has zero length.

Yet the problem is that, hugetlbfs_parse_param() will
dereference the param->string, without checking whether it
is a null pointer. To be more specific, if hugetlbfs_parse_param()
parses an illegal mount parameter, such as "size=,", kernel will
constructs struct fs_parameter with null pointer in
vfs_parse_fs_string(), then passes this struct fs_parameter to
hugetlbfs_parse_param(), which triggers the above
null-ptr-deref bug.

This patch solves it by adding sanity check on param->string
in hugetlbfs_parse_param().

Reported-by: syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com
Tested-by: syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/0000000000005ad00405eb7148c6@google.com/
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/hugetlbfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7f836f8f9db1..3ee84604e36d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1377,7 +1377,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 
 	case Opt_size:
 		/* memparse() will accept a K/M/G without a digit */
-		if (!isdigit(param->string[0]))
+		if (!param->string || !isdigit(param->string[0]))
 			goto bad_val;
 		ctx->max_size_opt = memparse(param->string, &rest);
 		ctx->max_val_type = SIZE_STD;
@@ -1387,7 +1387,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 
 	case Opt_nr_inodes:
 		/* memparse() will accept a K/M/G without a digit */
-		if (!isdigit(param->string[0]))
+		if (!param->string || !isdigit(param->string[0]))
 			goto bad_val;
 		ctx->nr_inodes = memparse(param->string, &rest);
 		return 0;
@@ -1403,7 +1403,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 
 	case Opt_min_size:
 		/* memparse() will accept a K/M/G without a digit */
-		if (!isdigit(param->string[0]))
+		if (!param->string || !isdigit(param->string[0]))
 			goto bad_val;
 		ctx->min_size_opt = memparse(param->string, &rest);
 		ctx->min_val_type = SIZE_STD;
-- 
2.25.1

