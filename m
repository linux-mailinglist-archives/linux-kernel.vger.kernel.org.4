Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE263EF79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiLAL3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiLAL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:29:39 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC452148;
        Thu,  1 Dec 2022 03:29:38 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 6so682320vkk.6;
        Thu, 01 Dec 2022 03:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb8vv5jss6wfwfF7zFNw5paYN1YtF0RIRN9PthLHcKI=;
        b=JLjf+8oxz86T/IzfzzS02Xz1X4vtgn5ROheArMrhFvRULEm3QHvrtDB1xgGIFDaeVX
         EyrOli6pCxcwbOsl9o2DtzR6TY9L4EqeQ2S5ar6UVOpS0/3gQlHm7pqWP4gpaXi/HcHs
         OiPhpRHhPCupU8dJXv+zC7HxHBmINqCb7WujWl9v2d/GUh2Ti0oEDhK9Tn/QW3OIUeY8
         bqZVKjyhRN5oZ4ILI9VVsBaKr65Eff8nsMxtsMTrsAhnmRi1PL8cLgg7IhWq5gBHDWR/
         b4cvWmVjuOMX8Qo97S41NLUqiWRIQHKzyIr2hrcgIwIWqxkbz202VHgZYTplsQrPoc/6
         bswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb8vv5jss6wfwfF7zFNw5paYN1YtF0RIRN9PthLHcKI=;
        b=JG2GC6kNeWp11AJxriM94dWxfQg7lrAqcGEjJyd2VnlAH/FPHft0Lrm3qwVfMLgzGm
         gWd7Pi5n70e1Jk7IFA9LJQUOPPw/lJP42oub5LewOZrdfPaM6yhtO7KlhdeaFfs5GT+V
         s6vM5tN23aavA8dfmMkpZ084f7CMu0QC8gMRi3RximhVHHA2Wp6gnwtcHnPLA4pP4lXB
         cShuDXrAAGL83zou+r059PiflBscrmZlXJ4CQShHg0FVAktmxUCUUi/zkoPwBNADDgyW
         sSJk2TVx4LocHdacLlG4YMKKZlgtXYg2YHObpiMJkh0SuqnpgNUXnyOjINfHwlO765L4
         MRiA==
X-Gm-Message-State: ANoB5plUiAITfyOM0xScFVNzgDI9yu7FfsIl5t+FxlYr9394yUzSKne8
        UVpVNM2pxG19BzjzcySlTK9VpXBIuW6o0VBIiDg=
X-Google-Smtp-Source: AA0mqf6Y6OWNLsGO2C6d1qljLi39wqKJUPZ4TbhIwUqyZgMUyZu09EI+tL/dNtFOiUzTvERiWe255cMIDOTS9QbSwFA=
X-Received: by 2002:a1f:5cc5:0:b0:3bd:1d27:eaa with SMTP id
 q188-20020a1f5cc5000000b003bd1d270eaamr3576447vkb.4.1669894177098; Thu, 01
 Dec 2022 03:29:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c8457f05ec1e4c69@google.com>
In-Reply-To: <000000000000c8457f05ec1e4c69@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 1 Dec 2022 20:29:20 +0900
Message-ID: <CAKFNMon0cn-ieJ1kqaeqkge0b0NXC6fwhyKhvx45h7RbqnNrCw@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in lock_page
To:     syzbot <syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 5:42 AM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=100804a6880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=77e4f005cb899d4268d1
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111fa5f2880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13687212880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c8d7f5e1917f/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
>
> NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000168
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108bcf000
> [0000000000000168] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : _compound_head include/linux/page-flags.h:253 [inline]
> pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
> lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
> sp : ffff80001290bc00
> x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
> x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
> x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
> x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
> x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
> x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
> x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
> x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
> Call trace:
>  lock_page+0x28/0x1e0 include/linux/pagemap.h:956
>  nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
>  nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
>  nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
>  nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
>  kthread+0x12c/0x158 kernel/kthread.c:376
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> Code: 9001df80 912a5000 52807781 97c7bd0e (f9400674)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   9001df80        adrp    x0, 0x3bf0000
>    4:   912a5000        add     x0, x0, #0xa94
>    8:   52807781        mov     w1, #0x3bc                      // #956
>    c:   97c7bd0e        bl      0xffffffffff1ef444
> * 10:   f9400674        ldr     x20, [x19, #8] <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

The bugfix patch for this issue has already been merged into mainline,
but its "Reported-by" tag looks to be broken.
It is the patch titled below:

#syz fix: nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty

Ryusuke Konishi
