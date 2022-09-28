Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F25ED6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiI1HtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiI1HtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:49:03 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09879128A30
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:45:46 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x6-20020a056e021bc600b002f8c7ccd2c4so2888653ilv.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9XycJCXCOZILN8/LxOH1n0Rwv2oa94xAGmUtD5INdg4=;
        b=tIj/3wFcuta2rOwPaiRw4Fb0N2G3GlY9niaSiiwkjQL6I+umw0UprItxA8dgEQPXFG
         00g90ETFJoSuf98j/26bsXVlbC9z3vOBlCa1X8a2LB0Ehf41gCvU65xnVd2bPOuJfpCu
         oLSk9ytQ1MAi68JfEOz+3Bf+/kAt0wD02aryuMoeXdfAuWLqQWii5a12UihFDVpsYE5f
         NNa2iPM2bZ9MSNPv2fJ0RS+6D6vV/T6VDP5lmfxiJAIe87V1yodr5BazicPSG6lMKV4e
         925UmA3O7UNJBjqz3iJlXL3n7LXuRRgVZ2WknnwUfoMMeUe85mLN3Dh0BSFmoC5SDijF
         j8Pw==
X-Gm-Message-State: ACrzQf074WucFa+SQtnGhNX13MyKFyzdwVJEpLcdR30k6KWt9esr51Ne
        o/LK14nL7J1jOx5hJSSYgakZOl+pplxA2WXrFql/vpW0Fwdw
X-Google-Smtp-Source: AMsMyM4+Hv8XfRgc3zhWDDPsJxH8ZzeRYrktZwjUP0Shtynt8fj6RnIIja+syYy15NpbhNMYqtSCF/ou9dKsiNp/TrioFcXbqM9L
MIME-Version: 1.0
X-Received: by 2002:a92:c24e:0:b0:2f8:13b3:9f3 with SMTP id
 k14-20020a92c24e000000b002f813b309f3mr9792458ilo.189.1664351143245; Wed, 28
 Sep 2022 00:45:43 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:45:43 -0700
In-Reply-To: <00000000000014512a05e9047a38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acbcd605e9b7f261@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in evict
From:   syzbot <syzbot+45df7ccc8b5bade4f745@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    46452d3786a8 Merge tag 'sound-6.0-rc8' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15305c35080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=45df7ccc8b5bade4f745
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147e7ddf080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a10538880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45df7ccc8b5bade4f745@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
=============================
WARNING: suspicious RCU usage
6.0.0-rc7-syzkaller-00042-g46452d3786a8 #0 Not tainted
-----------------------------
include/trace/events/lock.h:69 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor344/5141:
 #0: ffff88807aef40e0 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff88807aef49d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffff88807aef49d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: inode_sb_list_del fs/inode.c:503 [inline]
 #1: ffff88807aef49d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: evict+0x179/0x6b0 fs/inode.c:654

stack backtrace:
CPU: 1 PID: 5141 Comm: syz-executor344 Not tainted 6.0.0-rc7-syzkaller-00042-g46452d3786a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release.cold+0x1f/0x4e kernel/locking/lockdep.c:5677
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x12/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:389 [inline]
 inode_sb_list_del fs/inode.c:505 [inline]
 evict+0x2aa/0x6b0 fs/inode.c:654
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7d2f811a8a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca7746c38 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7d2f811a8a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffca7746c50
RBP: 00007ffca7746c50 R08: 00007ffca7746c90 R09: 00007ffca7746c90
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 00007ffca7746c90 R14: 000000000000010e R15: 0000000020001b50
 </TASK>
ntfs3: loop0: Mark volume as dirty due to NTFS errors

