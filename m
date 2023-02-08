Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6726A68F8BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBHUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBHUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:19:58 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DEF5247
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:19:55 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id r11-20020a6b8f0b000000b0071853768168so12039280iod.23
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boyPZOAY3X383WTfH+FoTPjeMXz4TtxflAWHGTjO3uA=;
        b=2yXz5LvUwO9vR9QjRSqYxupxeuUHDxMZknwd7fP3KMxv4AaFsDZECwg5IniEsDcJbC
         xXKflPbN4Lfpj8xceubeg5qYkyDaSoRZUktdWsmHnO5nr/AWK/eLdR9+MrjSGRCrg8qU
         HqFItkleSHp9uPG0JELw+xZNNgfoikcf8xTtcOIiUKj7K4GkZbOQaqo0Td/TCAIfPlPt
         GzvtSQ+xbi5A9waVFtoyNvH5qq9evwX+4iaIaQZvE+V/rAP6L6qmUEZ1mWLSbm1iK95r
         hmOmhAxdG9c0aC1ooQBHDAHpPnvQJ1maSybnNH8ET0ZgE4ABkD0MSc20YOzOVOzE/Lgx
         43XA==
X-Gm-Message-State: AO0yUKXRKaU++rHORHsIvd9r98ohEstIvjlnPQ3gLl4m2hFIGrX1WG0D
        XHnFhX5E3vTDlOTuUFP2qMI0r25jA4FLWeaHLL1D3Nfe2NCr
X-Google-Smtp-Source: AK7set8HYAF5nFRgeMXQys2wWST+vnCsVc2VRHahIaPre0bJD5v2smb7lJcTLDbPs50DhSTMEy1OfLkPggppcyjOJpylfvd+gWZc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:100f:b0:311:be1:d35c with SMTP id
 n15-20020a056e02100f00b003110be1d35cmr4576653ilj.116.1675887595282; Wed, 08
 Feb 2023 12:19:55 -0800 (PST)
Date:   Wed, 08 Feb 2023 12:19:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cce8cd05f435fc77@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in folio_flags
From:   syzbot <syzbot+d632e24db18585d7b3c6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    38d2b86a665b Add linux-next specific files for 20230208
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147599df480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3691b32dd4410e01
dashboard link: https://syzkaller.appspot.com/bug?extid=d632e24db18585d7b3c6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a9d60e90514/disk-38d2b86a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71311be5f1a1/vmlinux-38d2b86a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a242870cc8eb/bzImage-38d2b86a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d632e24db18585d7b3c6@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffed
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD c570067 P4D c570067 PUD c572067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5544 Comm: syz-executor.2 Not tainted 6.2.0-rc7-next-20230208-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:PageTail include/linux/page-flags.h:290 [inline]
RIP: 0010:folio_flags.constprop.0+0x2c/0x150 include/linux/page-flags.h:317
Code: 49 89 fc 55 53 e8 84 4e b7 ff 49 8d 7c 24 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f8 00 00 00 <49> 8b 5c 24 08 31 ff 83 e3 01 48 89 de e8 c2 4a b7 ff 48 85 db 0f
RSP: 0018:ffffc9000675fc08 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffffffffffe5 RCX: ffffc9000cd62000
RDX: 1ffffffffffffffd RSI: ffffffff81cd1f5c RDI: ffffffffffffffed
RBP: ffffffffffffffe5 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffe5 R11: 0000000000000000 R12: ffffffffffffffe5
R13: 000feffffff00000 R14: 0000000000000046 R15: 000feffffff00000
FS:  00007f6f37eb3700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffed CR3: 00000000217a0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_test_head include/linux/page-flags.h:781 [inline]
 folio_test_large include/linux/page-flags.h:802 [inline]
 PageHeadHuge+0x18/0xc0 mm/hugetlb.c:2060
 folio_test_hugetlb include/linux/page-flags.h:830 [inline]
 folio_file_page include/linux/pagemap.h:702 [inline]
 shmem_read_mapping_page_gfp+0x34/0x100 mm/shmem.c:4366
 shmem_read_mapping_page include/linux/shmem_fs.h:124 [inline]
 udmabuf_create+0x93b/0x1440 drivers/dma-buf/udmabuf.c:286
 udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:346 [inline]
 udmabuf_ioctl+0x156/0x2c0 drivers/dma-buf/udmabuf.c:377
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6f3708c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6f37eb3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6f371abf80 RCX: 00007f6f3708c0f9
RDX: 0000000020000080 RSI: 0000000040187542 RDI: 0000000000000005
RBP: 00007f6f370e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffec3da43f R14: 00007f6f37eb3300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: ffffffffffffffed
---[ end trace 0000000000000000 ]---
RIP: 0010:PageTail include/linux/page-flags.h:290 [inline]
RIP: 0010:folio_flags.constprop.0+0x2c/0x150 include/linux/page-flags.h:317
Code: 49 89 fc 55 53 e8 84 4e b7 ff 49 8d 7c 24 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f8 00 00 00 <49> 8b 5c 24 08 31 ff 83 e3 01 48 89 de e8 c2 4a b7 ff 48 85 db 0f
RSP: 0018:ffffc9000675fc08 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffffffffffe5 RCX: ffffc9000cd62000
RDX: 1ffffffffffffffd RSI: ffffffff81cd1f5c RDI: ffffffffffffffed
RBP: ffffffffffffffe5 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffe5 R11: 0000000000000000 R12: ffffffffffffffe5
R13: 000feffffff00000 R14: 0000000000000046 R15: 000feffffff00000
FS:  00007f6f37eb3700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffed CR3: 00000000217a0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 89 fc             	mov    %rdi,%r12
   3:	55                   	push   %rbp
   4:	53                   	push   %rbx
   5:	e8 84 4e b7 ff       	callq  0xffb74e8e
   a:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
   f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  16:	fc ff df
  19:	48 89 fa             	mov    %rdi,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  24:	0f 85 f8 00 00 00    	jne    0x122
* 2a:	49 8b 5c 24 08       	mov    0x8(%r12),%rbx <-- trapping instruction
  2f:	31 ff                	xor    %edi,%edi
  31:	83 e3 01             	and    $0x1,%ebx
  34:	48 89 de             	mov    %rbx,%rsi
  37:	e8 c2 4a b7 ff       	callq  0xffb74afe
  3c:	48 85 db             	test   %rbx,%rbx
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
