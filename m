Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB8674DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjATHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjATHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:23:49 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E013B66B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:23:45 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id n8-20020a6bf608000000b007048850aa92so2482446ioh.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0w/mrFJeCc6+JHbVg55B4KycHMZB5GYr8KfUIDltfA=;
        b=DsoxQE+hy0ERKSn1gwnNUQ6jQaiDsNoyiHtFwd6cdAp2ISvsek3O1KvKGnxpxJ3lZW
         k6/kU9essZSz7xGxcBU05IaD11cCGR1xE8v8Nxe/7be5naVY+TQ7sNDoQ6C/97zaGr2T
         qZ3I+J8fea98/oZHTcOZfrnRCq1xvxEDzf+pdp2ldz88XZfEi8DiCmWyL7lTSDRFxbXw
         rk9PnYpGjqwtAFUZO/MUALvBeIb/pWpdaJ6/Eu+3iw3xYT5TCIe+mcIVlsj1JQA70Y8A
         0ow+s66ODCOwDFZazDBNxBILKLr38PRilRtWeF1z0Y27WdI3e7qmb/KmV8zYME1zrVv0
         OvPg==
X-Gm-Message-State: AFqh2kpzXecJAUHYp3TOkBo7NsHdzxuhGw9FzaEDvNK5NM38TT3pNT6k
        MOk8B5GREt2OJVqWpZ9fgoqICfovF2cn2pxHqnz8DiEW8V0W
X-Google-Smtp-Source: AMrXdXsSs1+xbKe+dkBkGkuxHXiK83x/G/VWQOLvwA7vgEXMvMddovUYximgsCG5KyhbMJVuCbMRxYgrakI8d/H2w+hM/FP7KST/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d87:b0:38a:460b:d431 with SMTP id
 ci7-20020a0566383d8700b0038a460bd431mr1026312jab.93.1674199425098; Thu, 19
 Jan 2023 23:23:45 -0800 (PST)
Date:   Thu, 19 Jan 2023 23:23:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000042f4005f2acee02@google.com>
Subject: [syzbot] general protection fault in snd_rawmidi_kernel_write1
From:   syzbot <syzbot+d7cf279f42a3353263b2@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=108e6329480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7cf279f42a3353263b2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7cf279f42a3353263b2@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 5386 Comm: syz-executor.2 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:snd_rawmidi_kernel_write1+0x82/0x870 sound/core/rawmidi.c:1517
Code: a0 00 00 00 0f 84 44 05 00 00 e8 d9 a3 e7 f9 49 8d 44 24 10 48 89 c2 48 89 44 24 28 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 cf 07 00 00 49 83 7c 24 10 00 0f 84 da 05 00 00
RSP: 0018:ffffc90004f77b88 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888026110500 RCX: ffffc900040a1000
RDX: 0000000000000002 RSI: ffffffff879a1907 RDI: ffff8880261105a0
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffed1004c220a6 R11: 0000000000000000 R12: 0000000000000000
R13: 000000007f078000 R14: 0000000000000000 R15: ffffc90004f77cc0
FS:  00007fc907fb2700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020f86000 CR3: 000000007a7c6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 snd_rawmidi_write+0x277/0xbb0 sound/core/rawmidi.c:1616
 vfs_write+0x2db/0xe10 fs/read_write.c:582
 ksys_write+0x1ec/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc90728c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc907fb2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc9073ac050 RCX: 00007fc90728c0c9
RDX: 00000000fffffd2c RSI: 0000000020000000 RDI: 0000000000000007
RBP: 00007fc9072e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc1a5a1b9f R14: 00007fc907fb2300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:snd_rawmidi_kernel_write1+0x82/0x870 sound/core/rawmidi.c:1517
Code: a0 00 00 00 0f 84 44 05 00 00 e8 d9 a3 e7 f9 49 8d 44 24 10 48 89 c2 48 89 44 24 28 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 cf 07 00 00 49 83 7c 24 10 00 0f 84 da 05 00 00
----------------
Code disassembly (best guess):
   0:	a0 00 00 00 0f 84 44 	movabs 0x544840f000000,%al
   7:	05 00
   9:	00 e8                	add    %ch,%al
   b:	d9 a3 e7 f9 49 8d    	fldenv -0x72b60619(%rbx)
  11:	44 24 10             	rex.R and $0x10,%al
  14:	48 89 c2             	mov    %rax,%rdx
  17:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 cf 07 00 00    	jne    0x803
  34:	49 83 7c 24 10 00    	cmpq   $0x0,0x10(%r12)
  3a:	0f 84 da 05 00 00    	je     0x61a


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
