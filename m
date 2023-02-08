Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE86968EEB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBHMQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBHMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:16:48 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7A2222C5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:16:44 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id i124-20020a6b3b82000000b0073440a80b1aso2939084ioa.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 04:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRbi5JrVY2+czlGcEev8SFLivuipDA3VTik7qAX2O98=;
        b=r8YIameV40QmmYKVI/iQ/6C4HDM2k/qLP/SJwRLqIRZbcC5F/Vbvcnpr97/TBABTLJ
         T9iBxPQnsWtNx1K3M7S/IijfjE2llsqXBpAnK7SgFhCJxVDopd0sO20fj+9HbFeHjnRr
         wCAy3jFIyQh1gkhYhdLYNw+nsr32kyuw+vF//gxVcp3UM4nrlWFJqlCF5En98dyuPcKA
         2vGvrgpFxHWFqfhjIOq2ogCGuJ8dJM3ANn0szAzAArDZMtCnxJBMfiTjqGLvcFkuUok2
         jcpSuOrTVL0gyqFo4CH/BwZ6grnV1hS0c5r9EE2Y1aDEGwmQx1pkUacJFmXsi8O78wNC
         A1pw==
X-Gm-Message-State: AO0yUKXu0ct8osphqbY7Wf3GfVmXplVURjNlkjpa+m3+1DW8iWEUICQv
        LbP5Gchiny33ygepK7puFIF8AUjRJJ60sAfUHrWHwNB4BcUDxiE=
X-Google-Smtp-Source: AK7set/nfrYox7vvqPsDM50f6VkH7DMVe1s0hnM32e9lUIYkHeal7NbpYCF3mQrg7ITZXICiyeu1M5okNI4uP7H22wUaohA17ouB
MIME-Version: 1.0
X-Received: by 2002:a92:8e43:0:b0:30f:5797:2c71 with SMTP id
 k3-20020a928e43000000b0030f57972c71mr4155574ilh.51.1675858604277; Wed, 08 Feb
 2023 04:16:44 -0800 (PST)
Date:   Wed, 08 Feb 2023 04:16:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd489f05f42f3c52@google.com>
Subject: [syzbot] possible deadlock in exc_page_fault
From:   syzbot <syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0136d86b7852 Merge tag 'block-6.2-2023-02-03' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1775a375480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de1f4b1f70af0b59
dashboard link: https://syzkaller.appspot.com/bug?extid=6d274a5dc4fa0974d4ad
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c63dfadfcd7e/disk-0136d86b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a5df54d745a/vmlinux-0136d86b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8a388fa8486/bzImage-0136d86b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc6-syzkaller-00239-g0136d86b7852 #0 Not tainted
------------------------------------------------------
syz-executor.4/23057 is trying to acquire lock:
ffff8880764c8158 (&mm->mmap_lock){++++}-{3:3}, at: exc_page_fault+0x546/0x880

but task is already holding lock:
ffff8880789ba0e0
 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x1d6/0x3500

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (
&sbi->s_lock#2){+.+.}-{3:3}:
       lock_acquire+0x20b/0x600
       __mutex_lock_common+0x1c2/0x2630
       mutex_lock_nested+0x1b/0x20
       exfat_get_block+0x18c/0x1de0
       do_mpage_readpage+0x7bd/0x2070
       mpage_readahead+0x45e/0x930
       read_pages+0x16f/0x820
       page_cache_ra_unbounded+0x697/0x7c0
       filemap_read+0x7ce/0x32d0
       __kernel_read+0x3d4/0x820
       integrity_kernel_read+0xb0/0xf0
       ima_calc_file_hash+0x1581/0x1c80
       ima_collect_measurement+0x483/0x900
       process_measurement+0xf71/0x1c20
       ima_file_check+0xdc/0x130
       path_openat+0x264b/0x2e30
       do_filp_open+0x26d/0x500
       do_sys_openat2+0x128/0x4f0
       __x64_sys_open+0x225/0x270
       do_syscall_64+0x41/0xc0
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#15){.+.+}-{3:3}:
       lock_acquire+0x20b/0x600
       down_read+0x3d/0x50
       filemap_fault+0x617/0x17d0
       __do_fault+0x136/0x500
       handle_mm_fault+0x32f3/0x51c0
       __get_user_pages+0x509/0x11e0
       populate_vma_page_range+0x21b/0x2b0
       __mm_populate+0x279/0x450
       vm_mmap_pgoff+0x212/0x2d0
       ksys_mmap_pgoff+0x4f9/0x6d0
       do_syscall_64+0x41/0xc0
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       validate_chain+0x166b/0x5860
       __lock_acquire+0x125b/0x1f80
       lock_acquire+0x20b/0x600
       down_read+0x3d/0x50
       exc_page_fault+0x546/0x880
       asm_exc_page_fault+0x26/0x30
       filldir64+0x30b/0x710
       exfat_iterate+0x306/0x3500
       iterate_dir+0x228/0x570
       __se_sys_getdents64+0x1c0/0x4a0
       do_syscall_64+0x41/0xc0
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> mapping.invalidate_lock#15 --> &sbi->s_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock#2);
                               lock(mapping.invalidate_lock#15);
                               lock(&sbi->s_lock#2);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.4/23057:
 #0: ffff88801d503c68 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0
 #1: ffff888073984a30 (&sb->s_type->i_mutex_key#37){++++}-{3:3}, at: iterate_dir+0x135/0x570
 #2: ffff8880789ba0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x1d6/0x3500

stack backtrace:
CPU: 0 PID: 23057 Comm: syz-executor.4 Not tainted 6.2.0-rc6-syzkaller-00239-g0136d86b7852 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 dump_stack_lvl+0x1b5/0x2a0
 check_noncircular+0x2d1/0x390
 validate_chain+0x166b/0x5860
 __lock_acquire+0x125b/0x1f80
 lock_acquire+0x20b/0x600
 down_read+0x3d/0x50
 exc_page_fault+0x546/0x880
 asm_exc_page_fault+0x26/0x30
RIP: 0010:filldir64+0x30b/0x710
Code: 48 29 eb 48 89 df 4c 89 e6 e8 21 2c 97 ff 85 ed 0f 88 40 02 00 00 4c 39 e3 0f 82 37 02 00 00 0f 01 cb 0f ae e8 48 8b 44 24 58 <49> 89 44 24 08 48 8b 4c 24 10 48 8b 44 24 50 48 89 01 48 8b 44 24
RSP: 0018:ffffc9000ba37708 EFLAGS: 00050206
RAX: 0000000000000000 RBX: 00007fffffffefe8 RCX: ffff88807d931d40
RDX: ffff88807d931d40 RSI: 0000000000000000 RDI: 00007fffffffefe8
RBP: 0000000000000018 R08: ffffffff81f30cff R09: 0000000000000004
R10: 0000000000000003 R11: ffff88807d931d40 R12: 0000000000000000
R13: ffffc9000ba37e70 R14: 0000000000000001 R15: ffffffff8aff2380
 exfat_iterate+0x306/0x3500
 iterate_dir+0x228/0x570
 __se_sys_getdents64+0x1c0/0x4a0
 do_syscall_64+0x41/0xc0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faac368c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faac444f168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007faac37ac120 RCX: 00007faac368c0c9
RDX: 0000000000000018 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007faac36e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffffd775cff R14: 00007faac444f300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 29 eb             	sub    %rbp,%rbx
   3:	48 89 df             	mov    %rbx,%rdi
   6:	4c 89 e6             	mov    %r12,%rsi
   9:	e8 21 2c 97 ff       	callq  0xff972c2f
   e:	85 ed                	test   %ebp,%ebp
  10:	0f 88 40 02 00 00    	js     0x256
  16:	4c 39 e3             	cmp    %r12,%rbx
  19:	0f 82 37 02 00 00    	jb     0x256
  1f:	0f 01 cb             	stac
  22:	0f ae e8             	lfence
  25:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
* 2a:	49 89 44 24 08       	mov    %rax,0x8(%r12) <-- trapping instruction
  2f:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  34:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  39:	48 89 01             	mov    %rax,(%rcx)
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
