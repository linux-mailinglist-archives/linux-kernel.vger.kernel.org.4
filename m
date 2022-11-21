Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5790632912
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiKUQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKUQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:11:41 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6FBCEB98
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:11:40 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso8859167ilg.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQ1zfeFmNsAsIxaKH/SjGFqk5lQttN1A1CeY8+UIilU=;
        b=WxlGi466Qelqr/2Frtb8g1adF45kxQnVzVqjAy6jGM4BXWfOxoFqQ6e6/Fb3FPS9Fi
         Qlh7fyXgLWDrLeRakA6Otw8fQPig2O3hF1i1I9YF2x9IcAzLuoVSIC7yyC9iHHxFcYgV
         eYKP5dv7pLG4Cp5P0smimDBqHbRvg19TLlQSpIYce2uy7DA/AnrxTWfhivkS9vR+bD5p
         MwrkFGyD9EViQEaEpKOEgAy+iqSoUo+F1eNd+Xhta7pN1+Fe7Op30okx9uc+V8fG1AZv
         RXjBNfNr+96Cmgca278RPabAl2K/Hak9qh2Ztus7HLu3YmwXmxMOVLkdL4jr3PrLSfly
         YmLw==
X-Gm-Message-State: ANoB5pmdPrG24jIsUldfAsqo/3uQOJrsrUBPtJV9K7q5MORjtYGsaP1B
        7SBpU9u0so2x8UMPeFngOOUTl2GBdKeH/XH9P+hTeoG7/2iF
X-Google-Smtp-Source: AA0mqf5TKpsu7cjyArCHQI4Bv/jOsQ9WA1NfZ8/8TVAf98OxGihpm9pZJD/r4zuyXKu5LbcMUz7XKuSIdY/0TGtqYL+OgaNOkCfA
MIME-Version: 1.0
X-Received: by 2002:a92:280a:0:b0:302:47fc:5578 with SMTP id
 l10-20020a92280a000000b0030247fc5578mr37957ilf.45.1669047100041; Mon, 21 Nov
 2022 08:11:40 -0800 (PST)
Date:   Mon, 21 Nov 2022 08:11:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082f1d605edfd4f60@google.com>
Subject: [syzbot] BUG: corrupted list in v9fs_session_close
From:   syzbot <syzbot+fbd9516e00e67ffaf87d@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
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

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10ca37d9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=fbd9516e00e67ffaf87d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbd9516e00e67ffaf87d@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff00011fd79548, but was ffff00014c2e3030. (prev=ffff00010c388948)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3127 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
lr : __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
sp : ffff800012ddbcb0
x29: ffff800012ddbcb0 x28: ffff0000c3e69a40 x27: 0000000000000000
x26: 00000000000000c0 x25: 0000000000000002 x24: ffff80000d3ad050
x23: ffff80000d3a9000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff00011fd79500 x18: 00000000000000c0
x17: 20747562202c3834 x16: ffff80000dc18158 x15: ffff0000c3e69a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e69a40
x11: ff808000081c6510 x10: 0000000000000000 x9 : d3c609970caf8000
x8 : d3c609970caf8000 x7 : ffff80000c0b2b74 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcc8 x1 : 0000000100000001 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 v9fs_session_close+0x8c/0xd8 fs/9p/v9fs.c:516
 v9fs_kill_super+0x34/0x50 fs/9p/vfs_super.c:226
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: f001b780 912ce000 aa0803e3 94aa876f (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
