Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59635B97A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIOJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIOJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:40:40 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69343630
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:40:38 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so12072584ilu.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=omhAUk7bsXafEU9Ap5qnDHppt5GzXj+9QBBHYEvy1CI=;
        b=MUkQO7QdT7p+m4b0qwuwSFsSay/nlQr/hHtFKOFoof597mcM7FZMSfPrQumgYlfZ09
         rkHumvSQ40ciBXUoMzY/X5Ei9uuRNKG3r3sisTs1AIZhENmMoO8gwDPhXs6uun64M7ci
         QKaOEgqWTwORvXpoexzd5AElF7HUJwwVkSis9hzk1KpF3BaJ9LCTpc3H+HIA6vfS+nBq
         jnRSBCj1dbQLR4cYvgLefyVNRX4ZwiSY9gtDqvHPmj3RznRTPGQz9yCPRp4H1P0+TXLV
         O8j8Vx9PDanOes3ghjRwTLlxgbbXckO0ZPBDuJ1bCLXQdlZaqPC/rbO2yj8QBJvp7jQf
         /Aew==
X-Gm-Message-State: ACgBeo3ul86mcBSq9ylwhXt0h1LvD0+5bZkxPac4mEyyk1Dn0hWQQtS7
        +iO3/u4/2Iuj0r9dqGEqMgEHqTXG+gAkLcZkb6+tU7tp6ivy
X-Google-Smtp-Source: AA6agR4sEC9CuFp13bz/LmJScklNUV9kBtmoGKUXlvutYZPrnCC6v7dLzvbn2BBpxel2cTZI1I3/gE0yr12Qs+fS146IR9CvSWFV
MIME-Version: 1.0
X-Received: by 2002:a5d:8a13:0:b0:69e:2133:4b38 with SMTP id
 w19-20020a5d8a13000000b0069e21334b38mr14211384iod.106.1663234837694; Thu, 15
 Sep 2022 02:40:37 -0700 (PDT)
Date:   Thu, 15 Sep 2022 02:40:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adcbdd05e8b40931@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in free_pcp_prepare
From:   syzbot <syzbot+de8f29c509042ee4cfce@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b96fbd602d35 Merge tag 's390-6.0-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149fd037080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79df237bd9a0448
dashboard link: https://syzkaller.appspot.com/bug?extid=de8f29c509042ee4cfce
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d9969364c8a/disk-b96fbd60.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00883756a3a3/vmlinux-b96fbd60.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de8f29c509042ee4cfce@syzkaller.appspotmail.com

ODEBUG: free active (active state 0) object type: work_struct hint: slcan_transmit+0x0/0x4d0 drivers/net/can/slcan/slcan-core.c:671
WARNING: CPU: 0 PID: 11471 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 0 PID: 11471 Comm: syz-executor.4 Not tainted 6.0.0-rc4-syzkaller-00302-gb96fbd602d35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 80 0a 49 8a 4c 89 ee 48 c7 c7 20 fe 48 8a e8 24 3a 39 05 <0f> 0b 83 05 45 9d dd 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90002e2fa08 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff8161f408 RDI: fffff520005c5f33
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff89ebcdc0
R13: ffffffff8a490340 R14: ffffffff814dd5e0 R15: dffffc0000000000
FS:  00007f46116af700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562b80d36950 CR3: 0000000026ded000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x301/0x420 lib/debugobjects.c:1020
 free_pages_prepare mm/page_alloc.c:1455 [inline]
 free_pcp_prepare+0x445/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 kvfree+0x42/0x50 mm/util.c:655
 device_release+0x9f/0x240 drivers/base/core.c:2330
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1be/0x4c0 lib/kobject.c:721
 put_device+0x1b/0x30 drivers/base/core.c:3624
 free_netdev+0x438/0x620 net/core/dev.c:10750
 tty_ldisc_close+0x110/0x190 drivers/tty/tty_ldisc.c:456
 tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:608
 tty_ldisc_hangup+0x35c/0x680 drivers/tty/tty_ldisc.c:724
 __tty_hangup.part.0+0x40a/0x830 drivers/tty/tty_io.c:637
 __tty_hangup drivers/tty/tty_io.c:592 [inline]
 tty_vhangup drivers/tty/tty_io.c:707 [inline]
 tty_ioctl+0xe8e/0x15d0 drivers/tty/tty_io.c:2718
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f46104893c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f46116af168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f461059bf80 RCX: 00007f46104893c9
RDX: 0700000000000000 RSI: 0000000000005437 RDI: 0000000000000003
RBP: 00007f46104e433f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffce6dbdeaf R14: 00007f46116af300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
