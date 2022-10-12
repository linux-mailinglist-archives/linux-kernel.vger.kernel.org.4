Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9315FC117
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJLHKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJLHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:10:40 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019F0ACA06
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:10:38 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id 23-20020a5d9c57000000b006bbd963e8adso6745247iof.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYSkbxbZp7Lujns4JDNxK9vBGB5ktyygEXvBNF9YcpM=;
        b=muc/IY0oCynm5irl6HfvO4RRmZ+/63pSdsUliFcE6iIpwZuFEfJcaO4lAwAbD9zaj+
         ihSHX0Ly/Ca/VHNC8oRSO2TYEhbIc2tfmlJFFPIpFRtCpYGFC33lcxfdEWvVeup8/Gpp
         GHmLxkhQHQ9clhF8Omk4wXzwLJ0QP8xrzMmydXoZ/LuGeNRkkZYAXSi6jRyUlWvD9u7H
         vM8ZXO1dBTD+un4sniXPkjTxUp3h0q8TVEY7JxUtNSnIjajj57zi4ksvGkJaMUr6zlg0
         O1qhOrcNcy6rR//99zpuzzttw8FcRkryjTEeE6SjNU55QlT/IEJ0qpqXDi+sSTyk/lO/
         zKTw==
X-Gm-Message-State: ACrzQf1Gkw/lF3BUCGy95UwPrtLI5z0O78H2awE2O5FMuwuog/gVLqKR
        Gse5WP1YKrBmQhEAITpb4/0DUs5BVWW8Nnotegt9xLoEVzBr
X-Google-Smtp-Source: AMsMyM4eooXBmwRS5Hn7xx58BanYfSnC+kW1AZHjL93el4GOdaI65PfghWQfpN0oFsADj+veKko+bq605FxmY8S5BvudcWCFpJxj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:2fa:2428:a37b with SMTP id
 y5-20020a056e02178500b002fa2428a37bmr13295814ilu.312.1665558638316; Wed, 12
 Oct 2022 00:10:38 -0700 (PDT)
Date:   Wed, 12 Oct 2022 00:10:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd532f05ead1161d@google.com>
Subject: [syzbot] WARNING in diAlloc
From:   syzbot <syzbot+10b40e9bbb7ce5b6dd42@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15c3a20c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=10b40e9bbb7ce5b6dd42
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14932ffa880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129ede94880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/427d0279ba6b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10b40e9bbb7ce5b6dd42@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 3065 at kernel/locking/mutex.c:582 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
Modules linked in:
CPU: 1 PID: 3065 Comm: syz-executor404 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
sp : ffff80000fb63a20
x29: ffff80000fb63a90 x28: ffff80000ee2b000 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0000ca4b1e88 x24: 0000000000000002
x23: ffff800008d3efd8 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0001110fab68 x18: 000000000000010f
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c0d5c x10: 0000000000000000 x9 : 45906cf89ce0d400
x8 : 45906cf89ce0d400 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 diAlloc+0x8c/0x98c fs/jfs/jfs_imap.c:1343
 ialloc+0x5c/0x2fc fs/jfs/jfs_inode.c:56
 jfs_mkdir+0xf8/0x490 fs/jfs/namei.c:225
 vfs_mkdir+0x1f8/0x2b0 fs/namei.c:4013
 do_mkdirat+0xe4/0x22c fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __arm64_sys_mkdirat+0x40/0x54 fs/namei.c:4051
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 21471
hardirqs last  enabled at (21471): [<ffff80000bfc89b4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (21471): [<ffff80000bfc89b4>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (21470): [<ffff80000bfc87f0>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (21470): [<ffff80000bfc87f0>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (18588): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (18579): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
ERROR: (device loop0): dbAlloc: the hint is outside the map

ERROR: (device loop0): remounting filesystem as read-only
ialloc: diAlloc returned -5!


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
