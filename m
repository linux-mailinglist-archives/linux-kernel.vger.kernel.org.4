Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80B966098E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjAFWev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjAFWes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:34:48 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45F81C0D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:34:47 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so1508928iow.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 14:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VVxBlJtQV6v5OcAs8EWLg+XArUjMk64C2b0BsikPv8=;
        b=HHrNbwdp25t/TiY3iB0OAkFFXBPRKWkoeMezQn9vG/AR8JOLsMj7RRcSnSYEvPVYPq
         qwlKmI7aYPIehqNyGK88dHl/BZe9Mxa42z1BHthuVql8S/yyZ5DD9hz5+JdqDkSVmM3n
         WdEHktkgWEe36WLvaEwbwwBRe1ZXal7FQHq7WbNaWwimF+7FrPQWUsY7SBPt4+eueEij
         NnPbCd1pHUzMAvcvvpjAO+2mfZm9WOqryZPY/bm8ifMcQMaAOxpNGmT313qy9hihbTd7
         rlR4H+AsvnwVtZ4ln5Yf9XpBeEQM2qaPJZ+I+XYMIi4rWbgCuxRex4BqZaBdC+5pegM4
         +VPA==
X-Gm-Message-State: AFqh2kqh/ipbHX9k/OkTo8NLgakJMP8saAT+2o/0Ekxc8tVW8PK09SLY
        YpeTSgi2AdmI3qJB8I0YSR/B7lYoqayTuE8aJeWlNqj+vTMm
X-Google-Smtp-Source: AMrXdXudrzg9rTtaP1hRnFiOdbmEEEaJcMyblDWe/fOPMR9zCLE1UKy/zhfVm+ynOLqzKoIHac4ipPiMyvIuVylFReHk4Q0xyuFm
MIME-Version: 1.0
X-Received: by 2002:a6b:1406:0:b0:6e0:992:d816 with SMTP id
 6-20020a6b1406000000b006e00992d816mr4401619iou.77.1673044487069; Fri, 06 Jan
 2023 14:34:47 -0800 (PST)
Date:   Fri, 06 Jan 2023 14:34:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005875da05f1a006b3@google.com>
Subject: [syzbot] WARNING in __kfence_free (2)
From:   syzbot <syzbot+a40ed4dfdfabdc0cdf9e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11aacc94480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3a84b3173b6e1cb
dashboard link: https://syzkaller.appspot.com/bug?extid=a40ed4dfdfabdc0cdf9e
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a40ed4dfdfabdc0cdf9e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3043 at mm/kfence/core.c:1059 __kfence_free+0x80/0xb4 mm/kfence/core.c:1059
Modules linked in:
CPU: 0 PID: 3043 Comm: syz-executor.1 Not tainted 6.2.0-rc2-syzkaller-00010-g69b41ac87e4a #0
Hardware name: linux,dummy-virt (DT)
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kfence_free+0x80/0xb4 mm/kfence/core.c:1059
lr : kfence_free include/linux/kfence.h:186 [inline]
lr : __slab_free+0x358/0x55c mm/slub.c:3588
sp : ffff80000aaeba20
x29: ffff80000aaeba20 x28: ffff00007b580c00 x27: ffff80000a383398
x26: f3ff000002c02a00 x25: ffff00007b580c00 x24: ffff00007b580c00
x23: ffff00007b580c00 x22: f9ff000005431f00 x21: ffff8000082328dc
x20: f3ff000002c02a00 x19: fffffc0001ed6000 x18: 0000000000000002
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000001 x13: 000000000006ad0a x12: fdff000005cb9b24
x11: fdff000005cb9b00 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff80000a380000
x5 : ffff8000082328dc x4 : ffff80000a6311f8 x3 : ffff80000a380340
x2 : fdff000005cf7c00 x1 : ffff80000a642f70 x0 : ffff00007b580c00
Call trace:
 __kfence_free+0x80/0xb4 mm/kfence/core.c:1059
 kfence_free include/linux/kfence.h:186 [inline]
 __slab_free+0x358/0x55c mm/slub.c:3588
 do_slab_free mm/slub.c:3731 [inline]
 slab_free mm/slub.c:3788 [inline]
 __kmem_cache_free+0x2d0/0x2f0 mm/slub.c:3800
 kfree+0x60/0xb0 mm/slab_common.c:1020
 kvfree+0x3c/0x50 mm/util.c:627
 xt_free_table_info+0x78/0x90 net/netfilter/x_tables.c:1212
 __do_replace+0x260/0x330 net/ipv4/netfilter/ip_tables.c:1087
 do_replace net/ipv6/netfilter/ip6_tables.c:1157 [inline]
 do_ip6t_set_ctl+0x36c/0x4b4 net/ipv6/netfilter/ip6_tables.c:1639
 nf_setsockopt+0x68/0x94 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x98/0xe4 net/ipv6/ipv6_sockglue.c:1028
 tcp_setsockopt+0x20/0x3c net/ipv4/tcp.c:3801
 sock_common_setsockopt+0x1c/0x2c net/core/sock.c:3664
 __sys_setsockopt+0xd4/0x1a0 net/socket.c:2246
 __do_sys_setsockopt net/socket.c:2257 [inline]
 __se_sys_setsockopt net/socket.c:2254 [inline]
 __arm64_sys_setsockopt+0x28/0x40 net/socket.c:2254
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xc0 arch/arm64/kernel/syscall.c:197
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0xb8/0xc0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
