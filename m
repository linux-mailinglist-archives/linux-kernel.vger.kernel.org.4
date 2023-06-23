Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBDC73BA54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjFWOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjFWOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:38:03 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95408184
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:38:01 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77e23d23eccso36433639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531081; x=1690123081;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92pwCV4fKKNhe01hHVdoCqgEIL8zomg86DHJeEualbE=;
        b=VfqJ0u4RBm+mKEcR1GIrT0BxtRnrDDItF+dy0trZjvwTQ/L972aUD7EyJZsEhukIRf
         UkZLWzfd6qo3YqfWap1THLawc0pP/psWAbHGXuh6UvGVMU7WrM5GcKkkSg0f0DFAjZUq
         /fvGERt+lB4AxkdAKOPysySuarL5YbhUlt1ObuoQgniVVdprGBY2ZtoSSGysEWlcJhw0
         rrSjT2SMJHKS5WCTxqWFP4p96eXVg+l/0VcjmH5rIkpP3ASLYGAM9jMy10i1EcdZ5n7w
         DAn6SCOl+pH1mqZQIY3WFrx14kXGUH0P9wT4JZ/r4a/DwDHmRd/Ck01XNyaX5XNpi0N1
         6XbQ==
X-Gm-Message-State: AC+VfDxeu9R/H179Tzg9qm72kijdM7FT/FZOMQSJdakmaz8d3azDBnKP
        ymiyEcrGlIi0HkD50rOsfLXB9D+K8PASGlT4cyomDBPKu7WS
X-Google-Smtp-Source: ACHHUZ72bR0s5CYWr4d53WMdmSKGgcNRuPtYWIplUy4Ab6Q4UkaMW0sgpXtsEibEFuWFnnaZmdNM2swIIQ+lNQ8QY8HcJKISZUDY
MIME-Version: 1.0
X-Received: by 2002:a02:a1cf:0:b0:423:215d:b76b with SMTP id
 o15-20020a02a1cf000000b00423215db76bmr7695680jah.1.1687531080864; Fri, 23 Jun
 2023 07:38:00 -0700 (PDT)
Date:   Fri, 23 Jun 2023 07:38:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f59f005feccf27e@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in __lock_sock_fast
From:   syzbot <syzbot+c54a9e997982d1a7dc11@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    98e95872f2b8 Merge branch 'mptcp-expose-more-info-and-smal..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109c5c1b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a7d74e6a7c3211
dashboard link: https://syzkaller.appspot.com/bug?extid=c54a9e997982d1a7dc11
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9846b6358605/disk-98e95872.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2ebfcba122e/vmlinux-98e95872.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5c7c23565e4/bzImage-98e95872.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c54a9e997982d1a7dc11@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at net/core/sock.c:3549
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10350, name: syz-executor.3
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 0
7 locks held by syz-executor.3/10350:
 #0: ffffffff8e125408 (sock_diag_mutex){+.+.}-{3:3}, at: sock_diag_rcv+0x1b/0x40 net/core/sock_diag.c:279
 #1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at: sock_diag_rcv_msg net/core/sock_diag.c:259 [inline]
 #1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at: sock_diag_rcv_msg+0x2d2/0x440 net/core/sock_diag.c:248
 #2: ffff88802f311688 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{3:3}, at: netlink_dump+0xbe/0xc50 net/netlink/af_netlink.c:2215
 #3: ffffffff8e29a628 (inet_diag_table_mutex){+.+.}-{3:3}, at: inet_diag_lock_handler+0x6e/0x100 net/ipv4/inet_diag.c:63
 #4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:95 [inline]
 #4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: mptcp_diag_dump+0x7c8/0x1330 net/mptcp/mptcp_diag.c:197
 #5: ffffc9000130c330 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
 #5: ffffc9000130c330 (&h->lhash2[i].lock){+.+.}-{2:2}, at: mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:98 [inline]
 #5: ffffc9000130c330 (&h->lhash2[i].lock){+.+.}-{2:2}, at: mptcp_diag_dump+0x838/0x1330 net/mptcp/mptcp_diag.c:197
 #6: ffff88805c820cf0 (msk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_diag_get_info+0x1ae/0x380 net/mptcp/mptcp_diag.c:224
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 10350 Comm: syz-executor.3 Not tainted 6.4.0-rc6-syzkaller-01415-g98e95872f2b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10153
 __lock_sock_fast+0x25/0xe0 net/core/sock.c:3549
 lock_sock_fast include/net/sock.h:1744 [inline]
 mptcp_diag_fill_info+0x45c/0x9c0 net/mptcp/sockopt.c:930
 mptcp_diag_get_info+0x1ae/0x380 net/mptcp/mptcp_diag.c:224
 inet_sk_diag_fill+0x1258/0x1fd0 net/ipv4/inet_diag.c:342
 sk_diag_dump net/mptcp/mptcp_diag.c:24 [inline]
 sk_diag_dump net/mptcp/mptcp_diag.c:16 [inline]
 mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:125 [inline]
 mptcp_diag_dump+0xc5e/0x1330 net/mptcp/mptcp_diag.c:197
 __inet_diag_dump+0x114/0x2e0 net/ipv4/inet_diag.c:1179
 inet_diag_dump_compat+0x209/0x290 net/ipv4/inet_diag.c:1287
 netlink_dump+0x570/0xc50 net/netlink/af_netlink.c:2268
 __netlink_dump_start+0x6c0/0x9b0 net/netlink/af_netlink.c:2375
 netlink_dump_start include/linux/netlink.h:330 [inline]
 inet_diag_rcv_msg_compat+0x26d/0x2d0 net/ipv4/inet_diag.c:1321
 __sock_diag_cmd net/core/sock_diag.c:240 [inline]
 sock_diag_rcv_msg+0x2eb/0x440 net/core/sock_diag.c:269
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2548
 sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 splice_to_socket+0x964/0xee0 fs/splice.c:915
 do_splice_from fs/splice.c:967 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:1155
 splice_direct_to_actor+0x34a/0x9c0 fs/splice.c:1101
 do_splice_direct+0x1ad/0x280 fs/splice.c:1207
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa74588c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa7443fe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fa7459ac050 RCX: 00007fa74588c389
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000009
RBP: 00007fa7458d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000021fd1ee9 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffca549394f R14: 00007fa7443fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
