Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB5661ED5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjAIGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjAIGsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:48:41 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A0E12633
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:48:40 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so5431478ilu.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZxoDGIUXPGrupbgdSJfUdBAOmhNQ8UvSXrona3AoYg=;
        b=Rhh9jXBLi5RyluyEaC5P+haoLtfQt0VBD1IK8af8CqBrWIV1YxctVuZU5fP2++1IRv
         W82vnF1f5tJz+FrKVXa3SMcpHl2HJkTnk9BQnkzfSUUfUMR12R+5LCwQ+v+8jaZ7YK9B
         zD85vr98jcSU64eAgLqCddNtUF0RsKInrtC3U38TlASZeKzRhBpgpB3qHWqloMQ/My0C
         KswYZv/hfXQc7B1LiL4wMW9jo0HfCr/7yl1hUbGvyW4G342u3rtuQZFN+9HYQIaTnGWU
         EG5pzmHF1duNADE1aIIUaevDUuU0FFcOKUw6W2iZ8lpqR0CvomNeyW2L9Y1fdUVL9yxY
         oGVw==
X-Gm-Message-State: AFqh2krI8lgsHs4/iBpoqEoGsTTLt60g8i95FJ0YFjMiBGi5mAD/LwU8
        nGA+gZc82qb2MjdeXIh4JuYkUGRkLHC0+kS6nG3iYvVEd283
X-Google-Smtp-Source: AMrXdXs2JylWKdp//knDSg/T1GQHokJNbtsjPWaWLdmeHXl8FgrZkQ+I6CLv9g/2T/LBlKzAwLvTC71dLUpVc/Xx96z7hwXapZV3
MIME-Version: 1.0
X-Received: by 2002:a02:cc4b:0:b0:375:c16b:7776 with SMTP id
 i11-20020a02cc4b000000b00375c16b7776mr5636701jaq.54.1673246919742; Sun, 08
 Jan 2023 22:48:39 -0800 (PST)
Date:   Sun, 08 Jan 2023 22:48:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045dcd205f1cf28f2@google.com>
Subject: [syzbot] [ntfs3?] general protection fault in ntfs_lookup
From:   syzbot <syzbot+3e567493c9db9df18d8f@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
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

HEAD commit:    cc3c08b41a9c Add linux-next specific files for 20230105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c4ded6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac9ebd4cb9742f3
dashboard link: https://syzkaller.appspot.com/bug?extid=3e567493c9db9df18d8f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6def59e24625/disk-cc3c08b4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef1bd308bc05/vmlinux-cc3c08b4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09339fbdbfe9/bzImage-cc3c08b4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e567493c9db9df18d8f@syzkaller.appspotmail.com

ntfs3: loop5: Mark volume as dirty due to NTFS errors
general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 PID: 13888 Comm: syz-executor.5 Not tainted 6.2.0-rc2-next-20230105-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ntfs_lookup+0x16b/0x260 fs/ntfs3/namei.c:96
Code: ff ff e8 e8 24 cd fe 48 81 fd 00 f0 ff ff 77 2b e8 0a 28 cd fe 48 8d 7d 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d3 00 00 00 48 83 7d 20 00 74 54 e8 df 27 cd fe
RSP: 0018:ffffc900039877c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffffffff1ce77e6 RCX: ffffc9000bb11000
RDX: 0000000000000004 RSI: ffffffff82b48776 RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880919dfbe8
R13: ffff88807d6a0000 R14: ffff888091a24c10 R15: ffff888091a24a58
FS:  00007fe7387b9700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3342a000 CR3: 000000001dec0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __lookup_slow+0x24c/0x460 fs/namei.c:1685
 lookup_slow fs/namei.c:1702 [inline]
 walk_component+0x33f/0x5a0 fs/namei.c:1993
 link_path_walk.part.0+0x730/0xdf0 fs/namei.c:2320
 link_path_walk fs/namei.c:2244 [inline]
 path_lookupat+0xb7/0x840 fs/namei.c:2473
 do_o_path fs/namei.c:3685 [inline]
 path_openat+0x1766/0x2b40 fs/namei.c:3707
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe737a8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe7387b9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fe737babf80 RCX: 00007fe737a8c0c9
RDX: 0000000000200002 RSI: 0000000020000180 RDI: ffffffffffffff9c
RBP: 00007fe737ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff9572fccf R14: 00007fe7387b9300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_lookup+0x16b/0x260 fs/ntfs3/namei.c:96
Code: ff ff e8 e8 24 cd fe 48 81 fd 00 f0 ff ff 77 2b e8 0a 28 cd fe 48 8d 7d 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d3 00 00 00 48 83 7d 20 00 74 54 e8 df 27 cd fe
RSP: 0018:ffffc900039877c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffffffff1ce77e6 RCX: ffffc9000bb11000
RDX: 0000000000000004 RSI: ffffffff82b48776 RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880919dfbe8
R13: ffff88807d6a0000 R14: ffff888091a24c10 R15: ffff888091a24a58
FS:  00007fe7387b9700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6fa9185058 CR3: 000000001dec0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	e8 e8 24 cd fe       	callq  0xfecd24ed
   5:	48 81 fd 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rbp
   c:	77 2b                	ja     0x39
   e:	e8 0a 28 cd fe       	callq  0xfecd281d
  13:	48 8d 7d 20          	lea    0x20(%rbp),%rdi
  17:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1e:	fc ff df
  21:	48 89 fa             	mov    %rdi,%rdx
  24:	48 c1 ea 03          	shr    $0x3,%rdx
* 28:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2c:	0f 85 d3 00 00 00    	jne    0x105
  32:	48 83 7d 20 00       	cmpq   $0x0,0x20(%rbp)
  37:	74 54                	je     0x8d
  39:	e8 df 27 cd fe       	callq  0xfecd281d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
