Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47285B4180
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIIVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIIVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:35:28 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BF5C0BE4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:35:27 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n4-20020a056e02100400b002f09be72a53so2208131ilj.18
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 14:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qvMKEVxzkjP30KVacXSCCSGWq4tedEnyYyuSltD6/Ig=;
        b=BBe7X19VybBoj2/gsDuqsJVL7EzVdmjvN9IAQz2El51tP7qnRiLw1AnlQgm3cvhuTN
         n79kkgIMhj6t4xy2YDId7PTQNgIVS10FZOSa56HuxQLt1+Ys9ovUS6W+6QChGLsbUAmK
         HsayrV+x7C+auUUMSFNjgPRpBOKgZ4nlTTbHJPefKi5CAhI3NXvbYLgiJIzYZo73oDdx
         hTagbfpsgMCnv1796mfSskTS89S9Zm7Z9HasbW66BDHe2+ekbTZnuHhVsOJ1nHBF8LJV
         mecbV8JEhI1K3GPza4+bBrRureHySjz0AGix8KPAZqt0e+THZSmNq29NoSIhl0H5ne8C
         NV7Q==
X-Gm-Message-State: ACgBeo0eZe62YxnxY9MpYGoKvuZJnanJKtXwr1hC4xq1NWrlDPnAi1z/
        QnCXHEzfkGL0K3bQQqyS3cOPwF18eEDw/Mclz0NEg9bsaKCA
X-Google-Smtp-Source: AA6agR4mglpJ0W9sqFSYbZS4GCFS8h6ir8Tl+U5YmG1/6SSZfTjhHCWmLfNKBJwYacfdz3fkcUbCtwtIlhY77dS5y8umcETUim5M
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378f:b0:356:4966:9b7b with SMTP id
 w15-20020a056638378f00b0035649669b7bmr8427233jal.103.1662759326695; Fri, 09
 Sep 2022 14:35:26 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:35:26 -0700
In-Reply-To: <0000000000006c2bbc05e714ec79@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003c78505e845532e@google.com>
Subject: Re: [syzbot] WARNING in reiserfs_lookup
From:   syzbot <syzbot+392ac209604cc18792e5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    92221e2af10d Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15b18f43080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79d82586727c5df
dashboard link: https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172e6877080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cad8af080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ea7850f2fc1/disk-92221e2a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b514f934717/vmlinux-92221e2a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+392ac209604cc18792e5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
BFS-fs: bfs_fill_super(): loop0 is unclean, continuing
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 3079 at kernel/locking/mutex.c:582 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
Modules linked in:
CPU: 0 PID: 3079 Comm: syz-executor275 Not tainted 6.0.0-rc4-syzkaller-17255-g92221e2af10d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
sp : ffff8000127938e0
x29: ffff800012793950 x28: ffff80000ee5a000 x27: ffff0000caad0618
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000002
x23: ffff80000878cbbc x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0000c8f03e28 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d61f820
x11: ff808000081c1fa0 x10: 0000000000000000 x9 : 1d38989ac5d23000
x8 : 1d38989ac5d23000 x7 : 4e5241575f534b43 x6 : ffff8000081965e0
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_lookup+0xa4/0x1c4 fs/reiserfs/namei.c:364
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x738/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 1073
hardirqs last  enabled at (1073): [<ffff80000bfd8fbc>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1073): [<ffff80000bfd8fbc>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (1072): [<ffff80000bfd8df8>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (1072): [<ffff80000bfd8df8>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (982): [<ffff80000801c370>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (980): [<ffff80000801c33c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel execute from non-executable memory at virtual address ffff80000ef5d0a8
Mem abort info:
  ESR = 0x000000008600000e
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x0e: level 2 permission fault
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c56f6000
[ffff80000ef5d0a8] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=00680001c7400701
Internal error: Oops: 8600000e [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3079 Comm: syz-executor275 Tainted: G        W          6.0.0-rc4-syzkaller-17255-g92221e2af10d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bfs_fill_super.__key+0x0/0x10
lr : get_third_component fs/reiserfs/namei.c:196 [inline]
lr : reiserfs_find_entry+0x130/0x298 fs/reiserfs/namei.c:317
sp : ffff800012793960
x29: ffff800012793990 x28: 0000000000000040 x27: ffff0000caad0618
x26: ffff0000c057e750 x25: ffff0000c70db000 x24: 0000000010000000
x23: ffff0000c057e7c0 x22: 000000000000000e x21: ffff8000127939e0
x20: ffff800012793a48 x19: ffff0000cabd87b8 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000002 x12: ffff80000d4b94d8
x11: ff80800008754e24 x10: 0000000000000000 x9 : ffff800008754e24
x8 : ffff80000ef5d0a8 x7 : 4e5241575f534b43 x6 : ffff80000878cbbc
x5 : 0000000000000000 x4 : ffff8000127939e0 x3 : ffff800012793a48
x2 : 000000000000000e x1 : 000000000000000e x0 : ffff0000c057e7c0
Call trace:
 bfs_fill_super.__key+0x0/0x10
 reiserfs_lookup+0xc4/0x1c4 fs/reiserfs/namei.c:368
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x738/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 00000000 00000000 00000000 00000000 (00000000) 
---[ end trace 0000000000000000 ]---

