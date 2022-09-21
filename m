Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9665BF52F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiIUEWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIUEWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:22:52 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF1785B7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:22:52 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id r12-20020a92cd8c000000b002f32d0d9fceso2891637ilb.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=TEkDHeexFehR247kTIAXqKbN4bpm27BUN5tS2rZBnJM=;
        b=pcTKxae0mJtC5ijUq44ubsPhzscE1k0O8oITeOaQ3K0nMYiOJxifyexPolNw50BbJK
         qLkTvrAIbdl4RAP4Lmq4G2x84FHnrjUERcpbA6wpqmTVM5IhuWYVJao2ostf0ukhXmgT
         DqmJSuf/05JQ564RaXWpRS2hQVJSLyzEwUNfnZfXwThAx1UJx3wukPgf2SVXWi8+5k5P
         7/BZ/8RVfezuu6ji/45mgUBFTZ7FpJGlrzunczg/rjptxgqnUixC5dfK90PnVq2C8ahw
         IZ4FAMKQ0WFJVnMC0mWoIYGybGpIEk/CCbjkggEgYtOvm2JDeZs+s4k0hIS7L9N+yN03
         RboQ==
X-Gm-Message-State: ACrzQf1sUxndfzmdIbpt6ItvBRtiB2Ave0KPMSfyJn7RoG/TWrFZD/kh
        BK8R0vZUz9hAMAMm0UqMQcZFmkVwsgFQY46WbE/RG2TLbzrm
X-Google-Smtp-Source: AA6agR4lt8aHSfWbIg8Fc40fP8RSGrCTFL8gTbdk9tcEbE5uT/xntw8e2Xq/60fI6m8KbYfIrvnN1pe+NemyeWjDiFcgeuf+QP87
MIME-Version: 1.0
X-Received: by 2002:a02:a493:0:b0:35a:7a4b:3efa with SMTP id
 d19-20020a02a493000000b0035a7a4b3efamr13188332jam.117.1663734171472; Tue, 20
 Sep 2022 21:22:51 -0700 (PDT)
Date:   Tue, 20 Sep 2022 21:22:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a9b0c05e9284c4f@google.com>
Subject: [syzbot] upstream test error: WARNING: ODEBUG bug in netdev_run_todo (2)
From:   syzbot <syzbot+bf973863c8d0a9db51d6@syzkaller.appspotmail.com>
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

HEAD commit:    a335366bad13 Merge tag 'gpio-fixes-for-v6.0-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166fc9d8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5a674186c801bcb
dashboard link: https://syzkaller.appspot.com/bug?extid=bf973863c8d0a9db51d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf973863c8d0a9db51d6@syzkaller.appspotmail.com

bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): Released all slaves
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: batadv_dat_purge+0x0/0x60 net/batman-adv/distributed-arp-table.c:171
WARNING: CPU: 0 PID: 10 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/u16:0 Not tainted 6.0.0-rc5-syzkaller-00094-ga335366bad13 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 00 01 49 8a 4c 89 ee 48 c7 c7 a0 f4 48 8a e8 a4 4e 39 05 <0f> 0b 83 05 55 08 dd 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc900005df8d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8880124b2000 RSI: ffffffff81611e08 RDI: fffff520000bbf0d
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff89eeed80
R13: ffffffff8a48f9c0 R14: ffffffff816a4eb0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564b4c8cd300 CR3: 00000000267bf000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x301/0x420 lib/debugobjects.c:1020
 kfree+0xda/0x390 mm/slab.c:3785
 kvfree+0x42/0x50 mm/util.c:655
 device_release+0x9f/0x240 drivers/base/core.c:2330
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1be/0x4c0 lib/kobject.c:721
 netdev_run_todo+0x75e/0x1100 net/core/dev.c:10385
 default_device_exit_batch+0x44e/0x590 net/core/dev.c:11357
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:595
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
