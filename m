Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C8619C68
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiKDQA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKDQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:00:54 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA202C65A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:00:52 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n1-20020a6b7701000000b006d1f2c2850aso3275722iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAtg1ws9gFpsv1LTsb4VFM2twH9JbH6Kcf5UmQN9wc8=;
        b=YqJSPjJn6btJHvMEwDioF8XGIsPM87DERhYxZEWdqxNLsVMgEGujEjaqVBtUowIcWL
         9LrWpxwgFtjNtjJWChDKWmVkf5exWuHV+9KlGxlZRmu58gexFR/N00jkYlGIO0Lj9Llh
         PC8tpDfgoWtSbzWi7ITBbg93BgHvA2dsEYLpOqZI+UKcMvaG8ID5Bpn+yNth864jic1m
         3l7AG5k2XgfARYABm/c+kxaUicCmNHlrInVRtzEGXvqhkjrPS6FRm2hp+D6kb/e8sb6S
         kkgiOSXib8eaHfMwsiv9o4VjJ9XVtPFs2grGuqFKpoVzDXAi5qgYiuUeOA4Vk2aQTjNg
         WjbA==
X-Gm-Message-State: ACrzQf1sjEFkUg64o3UfzSb34/lCMKP/6ANKsD1jawereSgC1L4wHbit
        1mLAXwOnWwM/4Jz2Fvs+dHxzk/N41zRRLgRkuEH3PTU7ql7J
X-Google-Smtp-Source: AMsMyM5am3Rxwvz49DUq+nJBgEFZoznmAZ5XU8/ZJOx3Jvd0uzKuzo1Kd2BzkTd9P24g9c54ZUYY38XSVIREvaLepF090rANIpgP
MIME-Version: 1.0
X-Received: by 2002:a6b:690a:0:b0:6c6:9bb1:a4c7 with SMTP id
 e10-20020a6b690a000000b006c69bb1a4c7mr21849185ioc.92.1667577651424; Fri, 04
 Nov 2022 09:00:51 -0700 (PDT)
Date:   Fri, 04 Nov 2022 09:00:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c742d05eca72d4d@google.com>
Subject: [syzbot] possible deadlock in hugetlb_fault
From:   syzbot <syzbot+ca56f14c500045350f93@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f2f32f8af2b0 Merge tag 'for-6.1-rc3-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137d52ca880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d080a4bd239918dd
dashboard link: https://syzkaller.appspot.com/bug?extid=ca56f14c500045350f93
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4f72e7a4c11/disk-f2f32f8a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f88997ad7c9/vmlinux-f2f32f8a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b4b5b3963e2d/bzImage-f2f32f8a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca56f14c500045350f93@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0 Not tainted
------------------------------------------------------
syz-executor.2/5665 is trying to acquire lock:
ffff88801c74c298 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa1/0x170 mm/memory.c:5645

but task is already holding lock:
ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:6816 [inline]
ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5859

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&vma_lock->rw_sema){++++}-{3:3}:
       down_write+0x90/0x220 kernel/locking/rwsem.c:1562
       hugetlb_vma_lock_write mm/hugetlb.c:6834 [inline]
       __unmap_hugepage_range_final+0x97/0x340 mm/hugetlb.c:5202
       unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
       unmap_vmas+0x21e/0x370 mm/memory.c:1733
       exit_mmap+0x189/0x7a0 mm/mmap.c:3090
       __mmput+0x128/0x4c0 kernel/fork.c:1185
       mmput+0x5c/0x70 kernel/fork.c:1207
       exit_mm kernel/exit.c:516 [inline]
       do_exit+0xa39/0x2a20 kernel/exit.c:807
       do_group_exit+0xd0/0x2a0 kernel/exit.c:950
       get_signal+0x21a1/0x2430 kernel/signal.c:2858
       arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
       exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
       exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
       __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
       __might_fault mm/memory.c:5646 [inline]
       __might_fault+0x104/0x170 mm/memory.c:5639
       _copy_from_user+0x25/0x170 lib/usercopy.c:13
       copy_from_user include/linux/uaccess.h:161 [inline]
       snd_rawmidi_kernel_write1+0x366/0x880 sound/core/rawmidi.c:1549
       snd_rawmidi_write+0x273/0xbb0 sound/core/rawmidi.c:1618
       vfs_write+0x2d7/0xdd0 fs/read_write.c:582
       ksys_write+0x1e8/0x250 fs/read_write.c:637
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&vma_lock->rw_sema);
                               lock(&mm->mmap_lock#2);
                               lock(&vma_lock->rw_sema);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by syz-executor.2/5665:
 #0: ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:6816 [inline]
 #0: ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5859

stack backtrace:
CPU: 1 PID: 5665 Comm: syz-executor.2 Not tainted 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
 __might_fault mm/memory.c:5646 [inline]
 __might_fault+0x104/0x170 mm/memory.c:5639
 _copy_from_user+0x25/0x170 lib/usercopy.c:13
 copy_from_user include/linux/uaccess.h:161 [inline]
 snd_rawmidi_kernel_write1+0x366/0x880 sound/core/rawmidi.c:1549
 snd_rawmidi_write+0x273/0xbb0 sound/core/rawmidi.c:1618
 vfs_write+0x2d7/0xdd0 fs/read_write.c:582
 ksys_write+0x1e8/0x250 fs/read_write.c:637
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fad549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f875cc EFLAGS: 00000296 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000000
RDX: 00000000c86ade39 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
