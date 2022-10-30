Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486AB612A1A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ3K3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJ3K3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:29:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44265D9;
        Sun, 30 Oct 2022 03:29:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 21so13768710edv.3;
        Sun, 30 Oct 2022 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=shNg+dHGfPncRZz8YKz02c/WY1HIESAXVh0TT/7e0KQ=;
        b=oVnJ2SHAlaZzhPilwePTjvsY7cBvPE2jIibMeyBINU9HRIzTMc3xgRgwjNMdrbfYbJ
         CNZ34yJwD+LkCm15l2yzcwYOTG1ad1iN5Q4ODUAV/+VoAbG3zzXYRMi+V6T36FA5jjfR
         PSN4BTPOn3llXluPTE2VD7LXx/LdG7N1jWv/o2yOPkfIdOi1KwNwv4MOiiy5ff4wCKtg
         zccEn3yK6Hbj57nB/YxMCdK7Ty0V9hMXteH3pO1ov5KiwE735JGftQYsnY+KiaF3jF3P
         C2kW5+vpfSkMuWdQgZJXXFK7gwCd8i9MU3uP2ymTeeknCugPRZ5ZdPTBBkEajsgVhc3z
         Ngqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shNg+dHGfPncRZz8YKz02c/WY1HIESAXVh0TT/7e0KQ=;
        b=B/Fq3W2cLCPTEPvvgNHWyZDI8a4pX3deVneKDKCwyFpRL0U8LWdXotpDfSjSQmylOx
         2hQpRKfc/kNStVGIh1qmUJMu7oo8rP/oEaKnI6Pbm0IAWvz6rrTI+bvqyM/k51oqobAn
         kTanXIVmC8jVuENNyw4Hm3NpwSNGeazipgn4l584zaHg2ulN8tywdYEaURmwb5BMVON1
         OU+kO1M0AAYlEoqFRbZ6O/FyqsVm8LRhnbI1WhMiEmE5AQJ+dafLUz6V1G47ktc4j9LK
         rCf6p/T4Uzrldw44UbVVT1jgkDtAUQg1VTe40QBHEzdfmTWuY9DX2azXE3zD3FRvxX/m
         REGg==
X-Gm-Message-State: ACrzQf1gI7yhhzLhkXHGArCqaO8hxNyTuuIikIocKni8R5pwR3be7SGE
        9yimOPAhgxF849V96F7H5feHU5FBovn7FaV3nzoPXyCJOR9W3w==
X-Google-Smtp-Source: AMsMyM40P2taACyY9Ujw4V6j9h4mzrzwp2g2jcot3NdqQ67diQJmUHScnVSC4uaeRvyRDnMAbWN48AKKO6IbyQPZgi4=
X-Received: by 2002:a05:6402:204d:b0:463:153d:6790 with SMTP id
 bc13-20020a056402204d00b00463153d6790mr5087658edb.293.1667125775023; Sun, 30
 Oct 2022 03:29:35 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:28:54 +0800
Message-ID: <CAO4mrfctrzpCgpPAp-xt1bm3wtkGBMisOe8xCw3PRARPJLyUpQ@mail.gmail.com>
Subject: KFENCE: invalid write in leaf_paste_entries
To:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1Cq7j7bFaFe65Xo9xiOwMHvi0CpnFxEBU/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

REISERFS (device loop0): journal params: device loop0, size 512,
journal first block 18, max trans len 256, max batch 225, max commit
age 0, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using rupasov hash to sort names
==================================================================
BUG: KFENCE: invalid write in __memmove+0x24/0x1a0

Invalid write at 0xffff88813da00000:
 __memmove+0x24/0x1a0
 leaf_paste_entries+0x1b8/0x2c0
 balance_leaf+0x46b3/0x4cd0
 do_balance+0xc6/0x350
 reiserfs_paste_into_item+0x2d6/0x320
 reiserfs_add_entry+0x3dd/0x570
 reiserfs_mkdir+0x2b6/0x3c0
 reiserfs_xattr_init+0x1be/0x330
 reiserfs_fill_super+0x110e/0x1620
 mount_bdev+0x23d/0x280
 legacy_get_tree+0x2e/0x90
 vfs_get_tree+0x29/0x100
 path_mount+0x58e/0x10a0
 do_mount+0x9b/0xb0
 __x64_sys_mount+0x13a/0x150
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

CPU: 0 PID: 5293 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__memmove+0x24/0x1a0
Code: ff cc cc cc cc cc 48 89 f8 48 39 fe 7d 0f 49 89 f0 49 01 d0 49
39 f8 0f 8f a9 00 00 00 48 83 fa 20 0f 82 f5 00 00 00 48 89 d1 <f3> a4
c3 48 81 fa a8 02 00 00 72 05 40 38 fe 74 3b 48 83 ea 20 48
RSP: 0018:ffffc90002493578 EFLAGS: 00010286
RAX: ffff888129298fb4 RBX: 0000000000000002 RCX: ffffffffeb898f94
RDX: ffffffffffffffe0 RSI: ffff88813d9ffff0 RDI: ffff88813da00000
RBP: ffff888129298fa4 R08: ffff888129298f84 R09: 0000000100000001
R10: 0004004800000002 R11: 0000000100000001 R12: 0000000000000000
R13: ffff888129298f84 R14: 0000000000000010 R15: 0000000000000001
FS:  00007f2f77e09700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88813da00000 CR3: 000000010b047000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 leaf_paste_entries+0x1b8/0x2c0
 balance_leaf+0x46b3/0x4cd0
 do_balance+0xc6/0x350
 reiserfs_paste_into_item+0x2d6/0x320
 reiserfs_add_entry+0x3dd/0x570
 reiserfs_mkdir+0x2b6/0x3c0
 reiserfs_xattr_init+0x1be/0x330
 reiserfs_fill_super+0x110e/0x1620
 mount_bdev+0x23d/0x280
 legacy_get_tree+0x2e/0x90
 vfs_get_tree+0x29/0x100
 path_mount+0x58e/0x10a0
 do_mount+0x9b/0xb0
 __x64_sys_mount+0x13a/0x150
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46abda
Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f77e08a48 EFLAGS: 00000206
 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2f77e08af0 RCX: 000000000046abda
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f2f77e08ab0
RBP: 0000000020000000 R08: 00007f2f77e08af0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
R13: 00007f2f77e08ab0 R14: 0000000000000001 R15: 0000000020011500
==================================================================
----------------
Code disassembly (best guess):
   0: ff cc                dec    %esp
   2: cc                    int3
   3: cc                    int3
   4: cc                    int3
   5: cc                    int3
   6: 48 89 f8              mov    %rdi,%rax
   9: 48 39 fe              cmp    %rdi,%rsi
   c: 7d 0f                jge    0x1d
   e: 49 89 f0              mov    %rsi,%r8
  11: 49 01 d0              add    %rdx,%r8
  14: 49 39 f8              cmp    %rdi,%r8
  17: 0f 8f a9 00 00 00    jg     0xc6
  1d: 48 83 fa 20          cmp    $0x20,%rdx
  21: 0f 82 f5 00 00 00    jb     0x11c
  27: 48 89 d1              mov    %rdx,%rcx
* 2a: f3 a4                rep movsb %ds:(%rsi),%es:(%rdi) <--
trapping instruction
  2c: c3                    retq
  2d: 48 81 fa a8 02 00 00 cmp    $0x2a8,%rdx
  34: 72 05                jb     0x3b
  36: 40 38 fe              cmp    %dil,%sil
  39: 74 3b                je     0x76
  3b: 48 83 ea 20          sub    $0x20,%rdx
  3f: 48                    rex.W

Best,
Wei
