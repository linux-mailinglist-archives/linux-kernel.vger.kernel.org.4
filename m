Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F19617450
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKCCfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKCCfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:35:44 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C3313DC4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:35:43 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id z15-20020a5e860f000000b006c09237cc06so257798ioj.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+ApMCitcfQ5RDTwMjODcX4mcD7udxYglTKNWDCimZ4=;
        b=FgFyjsTligEbCnwHYjwgwgz1GTQikUS+8Efi/32N6nKjdhcye1RRsPFnbwrunStvOY
         J8B7I3lrht7MjdTNWCylQptQdVVVfNsj7qFW/0qaoV2VExdk4Esun1mCe/f2mYbGbvrG
         ZPsfJ9X1yqyvg6CBwssLCUQhraxCT8ph9yM31+S+O90l1iHKt5bJHXRIQWoLr3F1/XuH
         0tboRiGZIlgIM0VM7s32QXXqD8y+aL5T7Kt777Dt7Pr8ibkvZWJNglxHQYLhu7zAVKmn
         ev7DLoFU1jhHdM4BYNg+NgKJMs28vhi5Qb332yiW/2MyB2DjnMwA1MBxfAKOz0VnRnu2
         Xx9g==
X-Gm-Message-State: ACrzQf0gi/YKZdq/PwTE5jJH/p9Ckhw1J2rs3NLL4VVFz51vgDHXWdoa
        LJaRUidBaF0M+mu8k7M0q8fglNfOTT7Sgjn3uE43u35prz/5
X-Google-Smtp-Source: AMsMyM76C+sKXgcwRxwoaXoRephb1504WlyB5Ra9m+XP8b5tapJkYaujVFsmXUw3u80STQeYg+ArtqJBPkVAHWD38WI7Cejh+8Ho
MIME-Version: 1.0
X-Received: by 2002:a92:c6c3:0:b0:300:96a0:9cd0 with SMTP id
 v3-20020a92c6c3000000b0030096a09cd0mr16421159ilm.145.1667442942486; Wed, 02
 Nov 2022 19:35:42 -0700 (PDT)
Date:   Wed, 02 Nov 2022 19:35:42 -0700
In-Reply-To: <000000000000cb639605ec7f6e10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000452ed505ec87d0ad@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in ovl_set_acl
From:   syzbot <syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    61c3426aca2c Add linux-next specific files for 20221102
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=118e21de880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acb529cc910d907c
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef1c4586bb6fd1f61
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1620a689880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153fb2a9880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc56d88dd6a3/disk-61c3426a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5921b65b080f/vmlinux-61c3426a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39cbd355fedd/bzImage-61c3426a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffc3
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD bc8f067 P4D bc8f067 PUD bc91067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5240 Comm: syz-executor244 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:190 [inline]
RIP: 0010:atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
RIP: 0010:__refcount_sub_and_test include/linux/refcount.h:272 [inline]
RIP: 0010:__refcount_dec_and_test include/linux/refcount.h:315 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:333 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:57 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:55 [inline]
RIP: 0010:ovl_set_or_remove_acl fs/overlayfs/inode.c:624 [inline]
RIP: 0010:ovl_set_acl+0x730/0x910 fs/overlayfs/inode.c:685
Code: a3 24 ff 4c 89 ff 49 89 c4 e8 cc 2f 81 fe 4d 85 e4 74 7f e8 52 e9 ac fe be 04 00 00 00 4c 89 e7 bb ff ff ff ff e8 60 7a f9 fe <f0> 41 0f c1 1c 24 bf 01 00 00 00 89 de e8 fe e5 ac fe 83 fb 01 0f
RSP: 0018:ffffc90003c0fad8 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: ffffffff82cff810
RDX: fffffbfffffffff9 RSI: 0000000000000004 RDI: ffffffffffffffc3
RBP: ffff888078a5ca48 R08: 0000000000000001 R09: ffffffffffffffc6
R10: fffffbfffffffff8 R11: 0000000000000001 R12: ffffffffffffffc3
R13: ffff8880764ba330 R14: 1ffff92000781f60 R15: ffff888024e04f00
FS:  0000555555b7c300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc3 CR3: 0000000026941000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 set_posix_acl+0x257/0x320 fs/posix_acl.c:957
 vfs_remove_acl+0x272/0x630 fs/posix_acl.c:1209
 removexattr+0x12a/0x1b0 fs/xattr.c:894
 path_removexattr+0x174/0x1a0 fs/xattr.c:910
 __do_sys_removexattr fs/xattr.c:924 [inline]
 __se_sys_removexattr fs/xattr.c:921 [inline]
 __x64_sys_removexattr+0x55/0x80 fs/xattr.c:921
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f653cc6fbf9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffec22658 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f653cc6fbf9
RDX: 00007f653cc6fbf9 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007f653cc33da0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000280 R11: 0000000000000246 R12: 00007f653cc33e30
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffffffffffffc3
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:190 [inline]
RIP: 0010:atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
RIP: 0010:__refcount_sub_and_test include/linux/refcount.h:272 [inline]
RIP: 0010:__refcount_dec_and_test include/linux/refcount.h:315 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:333 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:57 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:55 [inline]
RIP: 0010:ovl_set_or_remove_acl fs/overlayfs/inode.c:624 [inline]
RIP: 0010:ovl_set_acl+0x730/0x910 fs/overlayfs/inode.c:685
Code: a3 24 ff 4c 89 ff 49 89 c4 e8 cc 2f 81 fe 4d 85 e4 74 7f e8 52 e9 ac fe be 04 00 00 00 4c 89 e7 bb ff ff ff ff e8 60 7a f9 fe <f0> 41 0f c1 1c 24 bf 01 00 00 00 89 de e8 fe e5 ac fe 83 fb 01 0f
RSP: 0018:ffffc90003c0fad8 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: ffffffff82cff810
RDX: fffffbfffffffff9 RSI: 0000000000000004 RDI: ffffffffffffffc3
RBP: ffff888078a5ca48 R08: 0000000000000001 R09: ffffffffffffffc6
R10: fffffbfffffffff8 R11: 0000000000000001 R12: ffffffffffffffc3
R13: ffff8880764ba330 R14: 1ffff92000781f60 R15: ffff888024e04f00
FS:  0000555555b7c300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc3 CR3: 0000000026941000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a3 24 ff 4c 89 ff 49 	movabs %eax,0xc48949ff894cff24
   7:	89 c4
   9:	e8 cc 2f 81 fe       	callq  0xfe812fda
   e:	4d 85 e4             	test   %r12,%r12
  11:	74 7f                	je     0x92
  13:	e8 52 e9 ac fe       	callq  0xfeace96a
  18:	be 04 00 00 00       	mov    $0x4,%esi
  1d:	4c 89 e7             	mov    %r12,%rdi
  20:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  25:	e8 60 7a f9 fe       	callq  0xfef97a8a
* 2a:	f0 41 0f c1 1c 24    	lock xadd %ebx,(%r12) <-- trapping instruction
  30:	bf 01 00 00 00       	mov    $0x1,%edi
  35:	89 de                	mov    %ebx,%esi
  37:	e8 fe e5 ac fe       	callq  0xfeace63a
  3c:	83 fb 01             	cmp    $0x1,%ebx
  3f:	0f                   	.byte 0xf

