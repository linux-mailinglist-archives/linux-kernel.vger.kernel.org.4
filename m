Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3560C20E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJYDHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJYDHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:07:45 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB021FFA6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:07:41 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w6-20020a6bd606000000b006bcd951c261so7473143ioa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uggnLmBJSzHLqm98nE0GRsAgmEiYaXNQ2tVvy7eGOXA=;
        b=4Ttm82AvWvDi0+KGplLAHEbbjkiv4izuUtbkIN+4jUqJFsxidSU8JOczCNsA6bDAdN
         gQhx8PaiR+ObyFEbcgqKadRSPyiQNMWRG2JJBKr4/HHipaTKwledB0dGSD2ywhkd4J/c
         Fapru0in5r75rOEsh4Bh3osM2j7SPS5ipvP0wAnSCvMCuQt4EYb7uCPseMKguM8xERTL
         QV3rZLuIBTbR5poBwwWlgSrTAW589+04/ArZFwGZsi/fKMyNLhXDjKPCKEiDxswHGWXj
         MNIQ7Zt8TgIl81MOnuKBGOjTF+n52w2J3WouNnJgYXHUb9Fzp3j60f6oLiFIhDc1LRjA
         jJrA==
X-Gm-Message-State: ACrzQf3Y2GxJIx/IwgIN8vWqmG++W+S8nfWZReoq370MAbYQV8wjuZ+T
        1KrqMJuksgOlUMN3gAYnvGIZU1D0c32zXRK3ElFXJbM0Za2n
X-Google-Smtp-Source: AMsMyM4+L2O/DH///G/6y8H5F48vGrGki/m7ptVO4Dbj7szoHnfxtPxQDXjQ9lm6SGEaAh259VsEB9DHh+voyG8OzKuYpGYzeDQ3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2103:b0:365:cea9:efbe with SMTP id
 n3-20020a056638210300b00365cea9efbemr22915809jaj.234.1666667260771; Mon, 24
 Oct 2022 20:07:40 -0700 (PDT)
Date:   Mon, 24 Oct 2022 20:07:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009854205ebd33650@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in jfs_statfs
From:   syzbot <syzbot+3424c9550a49659f1704@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    247f34f7b803 Linux 6.1-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11904f2c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=3424c9550a49659f1704
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5f39164dea4/disk-247f34f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d1b92f5a01f/vmlinux-247f34f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3424c9550a49659f1704@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/super.c:140:14
shift exponent -236023038 is negative
CPU: 0 PID: 3985 Comm: syz-executor.4 Not tainted 6.1.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 jfs_statfs+0x503/0x510 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x136/0x310 fs/statfs.c:90
 user_statfs fs/statfs.c:105 [inline]
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs fs/statfs.c:192 [inline]
 __x64_sys_statfs+0x120/0x230 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f96a5a8b5f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f96a6bce168 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 00007f96a5babf80 RCX: 00007f96a5a8b5f9
RDX: 0000000000000000 RSI: 0000000020005380 RDI: 0000000020005340
RBP: 00007f96a5ae67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff54f044bf R14: 00007f96a6bce300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
