Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0156126D9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 03:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ3CEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ3CEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 22:04:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20334F010
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 19:04:41 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id a6-20020a056602208600b006bff2e56943so6408030ioa.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 19:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KENEzeOv1xiMZcfoPEnQtIZHWEKHhSdkzIqMFu+aGI=;
        b=i8RB47pncf4wNh9EFTqVrFX2Wr7irUce0+/V2NxD/RVLW256Ni/BXNmAGRxLyxhDjj
         C+fe5JIJdzacM/fF+l2LpvY5IOU1UGgqLdOrS5AMSMZeSuq2B4tiSE0/mBi3/JBmfvea
         57qG5kCE0dsRoeySmJeGh5pbog48qzQwuvKPcwDTtc6apValLepEnIM2cWc86pZVs49f
         TqPVM/GteldJKACO3+0cb6yCBYn+wPplbBt5cTFFeeWlPMpyIzJsjjFrhBZ01Sm9espP
         ec6GrIaI14bEZNY9nXRr4fIFKH39d5YMV92I3g0TlY++v69pc/9JGQI7IUFNItYfRE8W
         DX1A==
X-Gm-Message-State: ACrzQf0ZyfRJm80LE9B6xX7xksKf14otvmlhVRwPENYbcBrB6cYTK5Zq
        NKBFriTMam/OqHnW2dlgnBayyyZGIzHNUvtQyDQuGkyewr1N
X-Google-Smtp-Source: AMsMyM48K6HHRrjV1hPIRWtTaEX59WKj5KCv0ljwUTba5ZPWf7CK7UiLkaxMzGY8ya0tN9weoD0hkZvkncXTp1DqfqFG/Y+srqVX
MIME-Version: 1.0
X-Received: by 2002:a02:cc58:0:b0:375:4e26:f408 with SMTP id
 i24-20020a02cc58000000b003754e26f408mr508688jaq.230.1667095480429; Sat, 29
 Oct 2022 19:04:40 -0700 (PDT)
Date:   Sat, 29 Oct 2022 19:04:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eaf19105ec36e9b8@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Read in drop_buffers
From:   syzbot <syzbot+fbdb4ec578ebdcfb9ed2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1465473a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c29b6436e994d72e
dashboard link: https://syzkaller.appspot.com/bug?extid=fbdb4ec578ebdcfb9ed2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8f5131ab57d/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77167f226f35/vmlinux-55be6084.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbdb4ec578ebdcfb9ed2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2856 [inline]
BUG: KASAN: null-ptr-deref in drop_buffers+0x61/0x2f0 fs/buffer.c:2868
Read of size 4 at addr 0000000000000060 by task syz-executor.5/24786

CPU: 0 PID: 24786 Comm: syz-executor.5 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_report+0xf1/0x220 mm/kasan/report.c:436
 kasan_report+0xfb/0x130 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 buffer_busy fs/buffer.c:2856 [inline]
 drop_buffers+0x61/0x2f0 fs/buffer.c:2868
 try_to_free_buffers+0x2b1/0x640 fs/buffer.c:2898
 shrink_page_list+0x3be3/0x6260 mm/vmscan.c:1939
 shrink_inactive_list+0x5cd/0xc10 mm/vmscan.c:2447
 shrink_list mm/vmscan.c:2674 [inline]
 shrink_lruvec+0x489/0xc80 mm/vmscan.c:2991
 shrink_node_memcgs+0x360/0x770 mm/vmscan.c:3180
 shrink_node+0xe9f/0x2040 mm/vmscan.c:3304
 shrink_zones+0x4fb/0xc40 mm/vmscan.c:3542
 do_try_to_free_pages+0x215/0xcd0 mm/vmscan.c:3601
 try_to_free_mem_cgroup_pages+0x3cb/0x6d0 mm/vmscan.c:3916
 memory_high_write+0x24f/0x3c0 mm/memcontrol.c:6303
 cgroup_file_write+0x2ab/0x780 kernel/cgroup/cgroup.c:3962
 kernfs_fop_write_iter+0x3ac/0x500 fs/kernfs/file.c:330
 do_iter_write+0x6f0/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x830/0xff0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
 do_sendfile+0x641/0xfd0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x178/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2ac848b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2ac9545168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f2ac85abf80 RCX: 00007f2ac848b5a9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000007
RBP: 00007f2ac84e6580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc10d5a64f R14: 00007f2ac9545300 R15: 0000000000022000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
