Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B56A39DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjB0D4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjB0D4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:56:00 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0161D910
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:55:38 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id k10-20020a92b70a000000b00316fed8644fso3096480ili.21
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHeqdS5JI3h3jdYxFHUssBoKIiehTxJlUXYm5bHMKHY=;
        b=zO8GxMMjPogAdtqpZfYnBHTF3iXsJSpZWSXxFySmyyWyxge/8q7L7RmwRWYx2XZtCd
         ax1nNO71pw1CbyhA1uQoOH0gwnRIgtkygG+ZOGNMMHCkM3SSuQ8d1HfMBJdjuxzwgaX+
         XFW/ldfwmvkkP9MpU+6JxUPrkqLa6g+fG0PYyfnnt+S1MCYE2P1uTwm9fQ/7WmuvVvuJ
         emsVu+RNHNoWm7Y0rj7j2kcHXZdpfFV1MHsGkeEoOBdMLp0h1LXq7WbCNRnKv1MQbvyY
         mPPQUu9+DvRqhKvE8BaUDY5Nbh+4UCNqcXPvsUhJM1DEWTUV2IhYELQtNobGwRZ6lM86
         YrSg==
X-Gm-Message-State: AO0yUKWb+KW2u0qfJGqSC2wDlrtJwyvmB8TBqBMNB4ztWV19Dc/kFUr/
        xPBtmEC5Uq153bOJpVPwPAmNbhYltYeNhYrp0xrqMSTnCCP7
X-Google-Smtp-Source: AK7set/maQJkLbknHRVglI/85Neazi+v0x28Gd9bPloAvMzai4/XPCokfwk2rzFkn2oP22EusSizAPKizh2xuCujSRXpeRnuiHq4
MIME-Version: 1.0
X-Received: by 2002:a92:444e:0:b0:315:9761:6965 with SMTP id
 a14-20020a92444e000000b0031597616965mr7653994ilm.5.1677470137812; Sun, 26 Feb
 2023 19:55:37 -0800 (PST)
Date:   Sun, 26 Feb 2023 19:55:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af8f7c05f5a673bb@google.com>
Subject: [syzbot] [keyrings?] [lsm?] WARNING in __mod_timer
From:   syzbot <syzbot+5093ba19745994288b53@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d8ca6dbb8de7 Merge tag 'nfs-for-6.3-1' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109cec8cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=636897a0dac3d81e
dashboard link: https://syzkaller.appspot.com/bug?extid=5093ba19745994288b53
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6eea6a7459e5/disk-d8ca6dbb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bcbaedb88c0/vmlinux-d8ca6dbb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/981f6d71a5c5/bzImage-d8ca6dbb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5093ba19745994288b53@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: ffffffff8d4fcbc0 object type: timer_list hint: key_gc_timer_func+0x0/0x80 security/keys/gc.c:117
WARNING: CPU: 1 PID: 10646 at lib/debugobjects.c:512 debug_print_object lib/debugobjects.c:509 [inline]
WARNING: CPU: 1 PID: 10646 at lib/debugobjects.c:512 debug_object_assert_init+0x1f2/0x240 lib/debugobjects.c:899
Modules linked in:
CPU: 1 PID: 10646 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-06695-gd8ca6dbb8de7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:debug_print_object lib/debugobjects.c:509 [inline]
RIP: 0010:debug_object_assert_init+0x1f2/0x240 lib/debugobjects.c:899
Code: a0 fd 4c 8b 4d 00 48 c7 c7 20 68 38 8b 48 c7 c6 00 65 38 8b 48 c7 c2 e0 69 38 8b 31 c9 4d 89 e8 53 e8 42 6f 10 fd 48 83 c4 08 <0f> 0b ff 05 42 e1 10 0a 48 83 c5 38 48 89 e8 48 c1 e8 03 42 80 3c
RSP: 0018:ffffc9000b1276f8 EFLAGS: 00010282
RAX: caefb79dfa053800 RBX: ffffffff83f63700 RCX: 0000000000040000
RDX: ffffc90014421000 RSI: 0000000000018ba9 RDI: 0000000000018baa
RBP: ffffffff8aec5400 R08: ffffffff81536d42 R09: fffff52001624e55
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffffffff8d4fcbc0 R14: 0000000000000004 R15: ffffffff91d3e4e8
FS:  00007f122cc29700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555632f708 CR3: 00000000690df000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_timer_assert_init kernel/time/timer.c:792 [inline]
 debug_assert_init kernel/time/timer.c:837 [inline]
 __mod_timer+0x10d/0xf40 kernel/time/timer.c:1020
 key_reject_and_link+0x3f5/0x6e0 security/keys/key.c:610
 key_negate_and_link include/linux/key-type.h:187 [inline]
 complete_request_key security/keys/request_key.c:64 [inline]
 call_sbin_request_key+0xa7b/0xcd0 security/keys/request_key.c:213
 construct_key security/keys/request_key.c:244 [inline]
 construct_key_and_link security/keys/request_key.c:503 [inline]
 request_key_and_link+0x11e3/0x18e0 security/keys/request_key.c:637
 __do_sys_request_key security/keys/keyctl.c:222 [inline]
 __se_sys_request_key+0x271/0x3b0 security/keys/keyctl.c:167
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f122be8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f122cc29168 EFLAGS: 00000246 ORIG_RAX: 00000000000000f9
RAX: ffffffffffffffda RBX: 00007f122bfabf80 RCX: 00007f122be8c0f9
RDX: 00000000200016c0 RSI: 0000000020001680 RDI: 0000000020001640
RBP: 00007f122bee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000a0c74db R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcdaafcfef R14: 00007f122cc29300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
