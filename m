Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAC564DAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiLOMKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiLOMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:09:53 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C02DAB4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:09:39 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l3-20020a056e021aa300b00304be32e9e5so7479405ilv.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v19udvftbSniCnGYGHf56v07WyW0/5U5GTfBbyBO90c=;
        b=2UwAunClAqA2YjC6pLqyqIDCTlaiolyutI8t4FleeGqq4wK1bypJBiC24kKIXwXjUk
         mvh8YcOIxeDI9BlL5cZ9/P9zSm/HM6Ip+K3jrQjWfsdzeizYzXjkOaaUbfePlBuZOELH
         XKTAx5izwLGKnCtqUmPX7WRWBV4BdzHOjVMnatbZMO0yw4K2yVrYRVzqYSDK6us9ADqm
         /1/PQhHzE1tLCdTLRNFphc73lTf8RrbzpBtlH/oV5Dz++cN71mXiuQJ4eSZ+a/ePN7jg
         SUUHebeB75D3Iw8coSbfjmr+2v7XQfDhQT/frBNwiNbDfocUxR5ETU3n/KmWpQpK5Bdz
         Xk+Q==
X-Gm-Message-State: ANoB5plnV51rPBEI0WSvAmT7lTohYoh2ujTAek9B+hC0CNr+P3mDP5+B
        w5VJ51Vq+jAR+HfG//HBkOVXvq5zF8+Ov2ixL/yBKo7Tw2qI
X-Google-Smtp-Source: AA0mqf5zWAGLL9UBjbjeZ1bOxINhrzvPhsdG/fSsF/lRHV1F0vx2rXhHPfbMkgHrE5BWlCqh3vMRwBacp21CyA6j5aucZnCKP1qK
MIME-Version: 1.0
X-Received: by 2002:a5d:88c3:0:b0:6d6:5fe4:8212 with SMTP id
 i3-20020a5d88c3000000b006d65fe48212mr46681325iol.180.1671106178714; Thu, 15
 Dec 2022 04:09:38 -0800 (PST)
Date:   Thu, 15 Dec 2022 04:09:38 -0800
In-Reply-To: <00000000000098830505eec4fe41@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a15a005efdcbab1@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in path_openat
From:   syzbot <syzbot+59a66cac604a6b49ecce@syzkaller.appspotmail.com>
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

HEAD commit:    041fae9c105a Merge tag 'f2fs-for-6.2-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=154d4400480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc96ce6808e37967
dashboard link: https://syzkaller.appspot.com/bug?extid=59a66cac604a6b49ecce
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104af21b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b91d77880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09a117be80ce/disk-041fae9c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac71ead731f7/vmlinux-041fae9c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f39b53cf5591/bzImage-041fae9c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fc2c06c4a4bb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59a66cac604a6b49ecce@syzkaller.appspotmail.com

ntfs: (device loop0): check_windows_hibernation_status(): Failed to find inode number for hiberfil.sys.
ntfs: (device loop0): load_system_files(): Failed to determine if Windows is hibernated.  Mounting read-only.  Run chkdsk.
ntfs: (device loop0): ntfs_lookup(): ntfs_lookup_ino_by_name() failed with error code 16777149.
BUG: unable to handle page fault for address: ffffffffff0000ab
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD d08f067 P4D d08f067 PUD d091067 PMD d0b1067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5072 Comm: syz-executor156 Not tainted 6.1.0-syzkaller-10971-g041fae9c105a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:lookup_open fs/namei.c:3405 [inline]
RIP: 0010:open_last_lookups fs/namei.c:3481 [inline]
RIP: 0010:path_openat+0x1147/0x2dd0 fs/namei.c:3711
Code: 48 89 d8 48 89 5c 24 10 48 83 c3 68 49 89 de 49 c1 ee 03 43 80 3c 26 00 74 08 48 89 df e8 61 7c ed ff 48 89 9c 24 c0 00 00 00 <4c> 8b 23 8b 9c 24 80 00 00 00 83 e3 40 31 ff 89 de e8 63 e6 97 ff
RSP: 0018:ffffc90003bcf940 EFLAGS: 00010246
RAX: ffffffffff000043 RBX: ffffffffff0000ab RCX: 0000000003bcf803
RDX: 0000000000000001 RSI: ffffffff8aedc900 RDI: ffffffff8b4bbba0
RBP: ffffc90003bcfb70 R08: dffffc0000000000 R09: fffffbfff1d30a3e
R10: fffffbfff1d30a3e R11: 1ffffffff1d30a3d R12: dffffc0000000000
R13: ffffc90003bcfbc0 R14: 1fffffffffe00015 R15: 1ffff1100e6b97a0
FS:  00005555572d3300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff0000ab CR3: 0000000027baf000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa47a6ba749
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9f456828 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fa47a6ba749
RDX: 00007fa47a678dc3 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007fa47a679fe0 R08: 000000000001ee42 R09: 0000000000000000
R10: 00007ffe9f4566f0 R11: 0000000000000246 R12: 00007fa47a67a070
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffffffff0000ab
---[ end trace 0000000000000000 ]---
RIP: 0010:lookup_open fs/namei.c:3405 [inline]
RIP: 0010:open_last_lookups fs/namei.c:3481 [inline]
RIP: 0010:path_openat+0x1147/0x2dd0 fs/namei.c:3711
Code: 48 89 d8 48 89 5c 24 10 48 83 c3 68 49 89 de 49 c1 ee 03 43 80 3c 26 00 74 08 48 89 df e8 61 7c ed ff 48 89 9c 24 c0 00 00 00 <4c> 8b 23 8b 9c 24 80 00 00 00 83 e3 40 31 ff 89 de e8 63 e6 97 ff
RSP: 0018:ffffc90003bcf940 EFLAGS: 00010246
RAX: ffffffffff000043 RBX: ffffffffff0000ab RCX: 0000000003bcf803
RDX: 0000000000000001 RSI: ffffffff8aedc900 RDI: ffffffff8b4bbba0
RBP: ffffc90003bcfb70 R08: dffffc0000000000 R09: fffffbfff1d30a3e
R10: fffffbfff1d30a3e R11: 1ffffffff1d30a3d R12: dffffc0000000000
R13: ffffc90003bcfbc0 R14: 1fffffffffe00015 R15: 1ffff1100e6b97a0
FS:  00005555572d3300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff0000ab CR3: 0000000027baf000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 d8             	mov    %rbx,%rax
   3:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
   8:	48 83 c3 68          	add    $0x68,%rbx
   c:	49 89 de             	mov    %rbx,%r14
   f:	49 c1 ee 03          	shr    $0x3,%r14
  13:	43 80 3c 26 00       	cmpb   $0x0,(%r14,%r12,1)
  18:	74 08                	je     0x22
  1a:	48 89 df             	mov    %rbx,%rdi
  1d:	e8 61 7c ed ff       	callq  0xffed7c83
  22:	48 89 9c 24 c0 00 00 	mov    %rbx,0xc0(%rsp)
  29:	00
* 2a:	4c 8b 23             	mov    (%rbx),%r12 <-- trapping instruction
  2d:	8b 9c 24 80 00 00 00 	mov    0x80(%rsp),%ebx
  34:	83 e3 40             	and    $0x40,%ebx
  37:	31 ff                	xor    %edi,%edi
  39:	89 de                	mov    %ebx,%esi
  3b:	e8 63 e6 97 ff       	callq  0xff97e6a3

