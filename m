Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CD5ECF89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiI0VuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiI0VuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:50:00 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A674662E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:49:55 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so6677879ioe.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=t7n6NgdEt64WMJHmFOGwpy0sdeA+FQhPjaVwhNj/KWY=;
        b=482z/uzaZrcCvs0rMtOCZqK5EqygWrfNgJtCgSFRhjOFDvWqEzOA+HdEi9e9opE9l6
         CJdP9xSyeYnUHS6WPXYQ0npTIJLymk47mP9daqfkIJmCl7AkkTUFGEuKlQuT9fIzeOxv
         2Hox2bJrfUsNW1ANIuzI1rcRJ+AsjuI8R5RC6kKpXWtyoSRbCo0PqTGGGM8Pp7dfkqat
         wWno71vkr+skV+dk+RKNN4CGt67IasFHeIYwSqXc3FqOHG9H14zprxNQ2n7HjiOyTA0H
         dBo+z+KReznSSfRcbMIV/2X9pWQs8lMdWboeld6VajhtotUxL2G74Sbs2w/vn5qZwv0E
         wfrg==
X-Gm-Message-State: ACrzQf2nD0NJvFfcwyWCgzUbx1gsEGJAKIgF5HptD+Gv0AmCApu9gG4G
        ZR06TtCE9ioXcvKvT2FLdLC7Av87RxJrvKiYo6KZa+EaBwcg
X-Google-Smtp-Source: AMsMyM4f9kGwLOhUyympIIOPzw9J6bJHDrpBTm/O9FCy4D1dN2Nabi9vn8dZ8NKXq4AIlu4YP6ovf1xIiQ+dxwMlSI1WG0GbyRbL
MIME-Version: 1.0
X-Received: by 2002:a02:b788:0:b0:356:7430:fd30 with SMTP id
 f8-20020a02b788000000b003567430fd30mr15693521jam.27.1664315395104; Tue, 27
 Sep 2022 14:49:55 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:49:55 -0700
In-Reply-To: <000000000000df57ee05e9978cce@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb6db305e9af9f59@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in jfs_open
From:   syzbot <syzbot+027aa1f5f8487ba60a97@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1073ecd4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=027aa1f5f8487ba60a97
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103ceaa8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125bd024880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+027aa1f5f8487ba60a97@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/file.c:65:20
shift exponent 8205 is too large for 64-bit type '__u64' (aka 'unsigned long long')
CPU: 1 PID: 3690 Comm: syz-executor342 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 jfs_open+0x3a2/0x3d0 fs/jfs/file.c:65
 do_dentry_open+0x777/0x1180 fs/open.c:880
 do_open fs/namei.c:3557 [inline]
 path_openat+0x25fc/0x2df0 fs/namei.c:3691
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2044cd6ed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2044c4c278 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f2044d624b0 RCX: 00007f2044cd6ed9
RDX: 0000000000161842 RSI: 000000002000c380 RDI: 00000000ffffff9c
RBP: 00007f2044d2de4c R08: 00007f2044c4c700 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2044d29108
R13: 0030656c69662f2e R14: 00007f2044c4c400 R15: 00007f2044d624b8
 </TASK>
================================================================================

