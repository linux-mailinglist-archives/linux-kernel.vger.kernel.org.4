Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DD661EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjAIGio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjAIGij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:38:39 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA0BB3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:38:36 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so5468205ilb.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WchuXFZ0SQsQCqgwOOtdfVnilckMyDAJW8PIyYrDzs=;
        b=1SNOvm8aryMAEk7qUuSzxdKEAn04ZNEWlUgpDht5D8er/47hFCa4FzO0Wz+GnpMfOr
         S7FOpS6/BcJw4F9r6uhlsYefFlh90eKWyma1ItZ9KwCZWlxtQq3YsFciM03ZEbWTJ79d
         32jb+3dChNQtlxt9GdkW4voYRMB5aFqj6hvn8gC/aZ5ZzobUhL2J+CYKzL/dL+0JGxar
         J1xzwljivvZmlQ5mNaeYG8xJI31uB7U8h//QGrV4VXauvroEzkvy78pInaiAMx90NR21
         5X+Aqr3O3qDFCV1zbxlk5HY8J1dJrHCFWpiw0wBrmG0MeCb+2N4AocQKCykloxTzys+1
         6V3Q==
X-Gm-Message-State: AFqh2ko6jeT4xAdbzXl4gR08xg9Mf0l99OLtoRVOTHscBl0EWJwuOQQp
        KMX25+XLVcyVXHc5EVu0N2nB/qtLzD/w+MM+s87tXldaDU6z
X-Google-Smtp-Source: AMrXdXvKhbdjyyyeleItiVrrdGXee4Ei7n54iJZ9ainN6qO63RUZW8bvwl5feLiVHz28tZJogc9SBJgstTkokuCA3lJOZAIvs+pS
MIME-Version: 1.0
X-Received: by 2002:a02:665f:0:b0:376:1ab0:7bd5 with SMTP id
 l31-20020a02665f000000b003761ab07bd5mr6254341jaf.8.1673246315636; Sun, 08 Jan
 2023 22:38:35 -0800 (PST)
Date:   Sun, 08 Jan 2023 22:38:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043eebd05f1cf04a7@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in reiserfs_get_block
From:   syzbot <syzbot+ebfdcf89bfa9a9a37e0c@syzkaller.appspotmail.com>
To:     brauner@kernel.org, damien.lemoal@opensource.wdc.com,
        edward.shishkin@gmail.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        sforshee@digitalocean.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
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

HEAD commit:    41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16aa7006480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=ebfdcf89bfa9a9a37e0c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/041403c21ee3/disk-41c03ba9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/579dec11b65a/vmlinux-41c03ba9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcb6cfc03c78/bzImage-41c03ba9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebfdcf89bfa9a9a37e0c@syzkaller.appspotmail.com

REISERFS (device loop5): Created .reiserfs_priv - reserved for xattr storage.
overlayfs: upper fs needs to support d_type.
overlayfs: upper fs does not support tmpfile.
overlayfs: upper fs does not support RENAME_WHITEOUT.
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 14704 Comm: syz-executor.5 Not tainted 6.2.0-rc2-syzkaller-00057-g41c03ba9beea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:reiserfs_get_block+0x1afe/0x5180 fs/reiserfs/inode.c:1052
Code: 00 00 00 fc ff df 48 8b 44 24 58 42 0f b6 04 38 84 c0 0f 85 74 11 00 00 8b 94 24 20 04 00 00 4b 8d 1c ae 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 7d 11 00 00 4c 89 74 24 28 48 89 54 24
RSP: 0018:ffffc9000a966c20 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 000000000000000c RCX: ffffc9000a967003
RDX: 0000000000000217 RSI: 00000000000003f4 RDI: 0000000000000000
RBP: ffffc9000a967270 R08: ffffffff822832cb R09: ffffed100565982c
R10: ffffed100565982c R11: 1ffff1100565982b R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000010 R15: dffffc0000000000
FS:  00007f1f6b9fe700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c017dafef7 CR3: 000000002bab4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 __reiserfs_write_begin+0x21a/0x460 fs/reiserfs/inode.c:2835
 reiserfs_xattr_set_handle+0x394/0xec0 fs/reiserfs/xattr.c:571
 reiserfs_xattr_set+0x417/0x530 fs/reiserfs/xattr.c:633
 __vfs_setxattr+0x485/0x4c0 fs/xattr.c:202
 __vfs_setxattr_noperm+0x128/0x5d0 fs/xattr.c:236
 vfs_setxattr+0x228/0x450 fs/xattr.c:323
 ovl_do_setxattr fs/overlayfs/overlayfs.h:254 [inline]
 ovl_setxattr fs/overlayfs/overlayfs.h:266 [inline]
 ovl_verify_set_fh+0x1c7/0x430 fs/overlayfs/namei.c:473
 ovl_verify_upper fs/overlayfs/overlayfs.h:565 [inline]
 ovl_get_indexdir+0x519/0x680 fs/overlayfs/super.c:1503
 ovl_fill_super+0x195b/0x2790 fs/overlayfs/super.c:2025
 mount_nodev+0x52/0xe0 fs/super.c:1405
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1f6ce8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1f6b9fe168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1f6cfabf80 RCX: 00007f1f6ce8c0c9
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007f1f6cee7ae9 R08: 0000000020000280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd914fe18f R14: 00007f1f6b9fe300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reiserfs_get_block+0x1afe/0x5180 fs/reiserfs/inode.c:1052
Code: 00 00 00 fc ff df 48 8b 44 24 58 42 0f b6 04 38 84 c0 0f 85 74 11 00 00 8b 94 24 20 04 00 00 4b 8d 1c ae 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 7d 11 00 00 4c 89 74 24 28 48 89 54 24
RSP: 0018:ffffc9000a966c20 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 000000000000000c RCX: ffffc9000a967003
RDX: 0000000000000217 RSI: 00000000000003f4 RDI: 0000000000000000
RBP: ffffc9000a967270 R08: ffffffff822832cb R09: ffffed100565982c
R10: ffffed100565982c R11: 1ffff1100565982b R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000010 R15: dffffc0000000000
FS:  00007f1f6b9fe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00fba6000 CR3: 000000002bab4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 5 bytes skipped:
   0:	df 48 8b             	fisttps -0x75(%rax)
   3:	44 24 58             	rex.R and $0x58,%al
   6:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
   b:	84 c0                	test   %al,%al
   d:	0f 85 74 11 00 00    	jne    0x1187
  13:	8b 94 24 20 04 00 00 	mov    0x420(%rsp),%edx
  1a:	4b 8d 1c ae          	lea    (%r14,%r13,4),%rbx
  1e:	48 89 d8             	mov    %rbx,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
* 25:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2a:	84 c0                	test   %al,%al
  2c:	0f 85 7d 11 00 00    	jne    0x11af
  32:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
  37:	48                   	rex.W
  38:	89                   	.byte 0x89
  39:	54                   	push   %rsp
  3a:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
