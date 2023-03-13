Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E66B8483
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCMWJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCMWJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:09:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2727222ED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:09:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so10863077ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678745364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3OeuxTTRs5EeVQ05rcBtKdGfCZb7/E65xY/ioqhLy0=;
        b=XuH9uqDrjhMJ0wD0SHLGuoVlcEzeXZ1JAwowL0dFRi+2bA5NEBDUREQIwdIzFjpUjd
         2fRptqAuoPFbxn47D6wW4kofVCesET4jqcAnV0ih0lCOlZ/7P7PoQC3krhpoJOvcqFmN
         LB0Iqr+f/zkp12PJKPzyAH0PQKJYBBBX3FzH4GCDbubmi3ZzbywqWfO0U0iymFqTemkH
         uIJegGxRz4hEZr1qgHa/7t74OxemGtXOinnt9/GiLN9lrEJdwBmaZ8qflIWex8JtEfUn
         3qUkAysRmHE50KXk4CRFo/rSFNEhaJ9YCHn6JqM+p0Pm2jcCnf7c7SyooaYrmuDL6kCW
         7wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678745364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3OeuxTTRs5EeVQ05rcBtKdGfCZb7/E65xY/ioqhLy0=;
        b=i587y/BFnZOJrV7P2LKZlAde3AJ8RN1fs4Ez5b/FzgyYyhriOl8V/tWHwnN3pkvIjk
         36iE49dr7aHslp1g6sb3XDD1RI3osU4jYZkTr4ElZaS03tdVX5MqjlpcA3LCbMcgRMdy
         x78H9Fsmvvi1Iw4+BcX9DmyvdVpiQXk69p4NS/I0vJFQ/RH1cigepSP+7IqCGyz4acn1
         urTOF0aukPA3moqTLJ7VysNEVkjwy88ZzDAFMg0RLhRb2sem6rPH5wPosFXOXWUFAO+n
         IrTmaPBxItofE9lZ2K8YlqLeFNqLo5NwiAFm34DBjcjoOSlNUblZngwNB2R2oXifzybN
         bGWg==
X-Gm-Message-State: AO0yUKVcid5rt/42gLPwWwNxImMqARhlAjKe6bmNNPnbyaR/ofcX632x
        4tIk1Mk7tPPw7yyOIS9V32LAzIphkweuVvU9XlH67w==
X-Google-Smtp-Source: AK7set8pRDONb7WUZbMq8xfL2yvUL5Ha1W2eQ2wjnD7oyUtdVHPc+glIEaqz2xgVH89I1yb9vW88JsgrnBIBLNvBOC8=
X-Received: by 2002:a50:baa6:0:b0:4c1:6acc:ea5 with SMTP id
 x35-20020a50baa6000000b004c16acc0ea5mr19591251ede.4.1678745363793; Mon, 13
 Mar 2023 15:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000226a6105f6954b47@google.com> <CAAa6QmSH-c4voB2vg=ohdeQwmGDJ8X5rUw97-99cFkVaOPD5mg@mail.gmail.com>
 <20230313191557.6lm53ndvwoxtf5dz@google.com> <CAAa6QmQnYYdVzESYvf6DE-nR9A-raSVpY-zVyTFHFrqpj8yd9A@mail.gmail.com>
 <20230313211142.oalluasyfr6mecic@google.com>
In-Reply-To: <20230313211142.oalluasyfr6mecic@google.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 13 Mar 2023 15:08:46 -0700
Message-ID: <CAAa6QmQUReQivwsu1a9tHoTXuFT29MBAv3hDN8-KtudfQJjhJg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in hpage_collapse_scan_file
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 2:11=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> On Mar 13 12:38, Zach O'Keefe wrote:
> > On Mon, Mar 13, 2023 at 12:16=E2=80=AFPM Zach O'Keefe <zokeefe@google.c=
om> wrote:
> > >
> > > On Mar 10 17:02, Zach O'Keefe wrote:
> > > > On Fri, Mar 10, 2023 at 4:52=E2=80=AFPM syzbot
> > > > <syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    857f1268a591 Merge tag 'objtool-core-2023-03-02' =
of git://..
> > > > > git tree:       upstream
> > > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D168e1=
032c80000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df763d=
89e26d3d4c4
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9578faa=
5475acb35fa50
> > > > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils=
 for Debian) 2.35.2
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D179=
e4e12c80000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D119cc=
e98c80000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/b3b7a7e3=
33f1/disk-857f1268.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5940be1cf17=
1/vmlinux-857f1268.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/986015=
398e4a/bzImage-857f1268.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> > > > > Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.co=
m
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at mm/khugepaged.c:1823!
> > > > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > > > CPU: 1 PID: 5097 Comm: syz-executor220 Not tainted 6.2.0-syzkalle=
r-13154-g857f1268a591 #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 02/16/2023
> > > > > RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
> > > > > RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:=
2233
> > > > > Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84=
 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b =
f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
> > > > > RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
> > > > > RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
> > > > > RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
> > > > > RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
> > > > > R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
> > > > > R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
> > > > > FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  madvise_collapse+0x721/0xf50 mm/khugepaged.c:2693
> > > > >  madvise_vma_behavior mm/madvise.c:1086 [inline]
> > > > >  madvise_walk_vmas mm/madvise.c:1260 [inline]
> > > > >  do_madvise+0x9e5/0x4680 mm/madvise.c:1439
> > > > >  __do_sys_madvise mm/madvise.c:1452 [inline]
> > > > >  __se_sys_madvise mm/madvise.c:1450 [inline]
> > > > >  __x64_sys_madvise+0xa5/0xb0 mm/madvise.c:1450
> > > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > > > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > RIP: 0033:0x7fdbae65dc39
> > > > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > > RSP: 002b:00007fdbae5ee2f8 EFLAGS: 00000246 ORIG_RAX: 00000000000=
0001c
> > > > > RAX: ffffffffffffffda RBX: 00007fdbae6e64b8 RCX: 00007fdbae65dc39
> > > > > RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
> > > > > RBP: 00007fdbae6e64b0 R08: 0000000000000001 R09: 0000000000000033
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdbae5ee300
> > > > > R13: 0000000000000001 R14: 00007fdbae5ee400 R15: 0000000000022000
> > > > >  </TASK>
> > > > > Modules linked in:
> > > > > ---[ end trace 0000000000000000 ]---
> > > > > RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
> > > > > RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:=
2233
> > > > > Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84=
 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b =
f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
> > > > > RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
> > > > > RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
> > > > > RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
> > > > > RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
> > > > > R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
> > > > > R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
> > > > > FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > >
> > > > >
> > > > > ---
> > > > > This report is generated by a bot. It may contain errors.
> > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > >
> > > > > syzbot will keep track of this issue. See:
> > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > > syzbot can test patches for this issue, for details see:
> > > > > https://goo.gl/tpsmEJ#testing-patches
> > > >
> > > > I had a look at this, and the issue is stemming from failed (due to
> > > > error injection here) xas_store() in collapse_file() (in this repor=
t,
> > > > specifically was picking on shmem after MADV_REMOVE punch). This pu=
ts
> > > > the xa_state into an error state (-ENOMEM) and the subsequent
> > > > xas_next() will (a) not increment xas->xa_index (which trips the
> > > > VM_BUG_ON), and (b) returns NULL (which is confusing, since AFAIU,
> > > > that's a "valid" entry for a truncated page cache entry, but also
> > > > being used to indicate error).
> > > >
> > > > I think the right thing to do is to check xas_invalid() at the top =
of
> > > > the loop, or checking return value of all those xas_store()'s and
> > > > taking appropriate action. There is also the possibility this never
> > > > occurs in practice due to the "Ensure we have slots for all the pag=
es
> > > > in the range" check at the top of the function, and that we are onl=
y
> > > > able to trip this from error injection.
> > >
> > > Right, so looking a bit more into this this morning, my last question=
 about
> > > whether the xas_create_range() check at the top of collapse_file() gu=
aranteeing
> > > us the needed slots (and that syzbot was only able to trip this due t=
o error
> > > injection) is plainly false: we are actually attempting to allocate m=
emory here,
> > > so clearly the slots weren't already available - duh.
> > >
> > > Now, why isn't that well-intending pre-reservation enough? Well, we a=
re dropping
> > > the xarray lock ~ every iteration of the for-loop, then relocking it =
to store
> > > the hugpage at the current index. While the lock is dropped, there is=
n't
> > > anything protecting us from racing with page_cache_delete() -- here, =
from
> > >
> > >         __filemap_remove_folio()
> > >         truncate_inode_folio()
> > >         shmem_undo_range()
> > >         shmem_truncate_range()
> > >         vfs_fallocate()
> > >         madvise_remove()
> > >
> > > which can then remove slots out from under us:
> > >
> > >         xas_delete_node()
> > >         update_node()
> > >         xas_store()
> > >         page_cache_delete()
> > >
> > > So, I think this code needs to be guarded against concurrent slot rem=
oval.
> > >
> > > I think just giving up is the best (i.e. simplest) route (vs taking s=
ome
> > > additional measures to serialize vs concurrent removal). One concern =
is that if
> > > we've encountered ENOMEM situation where xas_store() is failing, then=
 the
> > > rollback code also won't work correctly. However, rollback xas_store(=
) will
> > > either replace the current hpage entry with the previous entry, or re=
place it
> > > will a NULL entry (had it been a hole previously) -- neither of which=
 will
> > > involve any additional allocations -- so we're safe.
> > >
> > > Patch to fix this should be following in the next day or so.
> > >
> > >
> >
> > Also, to be clear, the concurrent removal isn't actually a problem on
> > its own, it's only concurrent removal + subsequent inability to
> > allocate missing xarray slot that is the issue.
>
> Expectedly, this area clashes significantly with David Stevens' "mm/khuge=
paged:
> refactor collapse_file control flow" on mm-unstable.
>
> Looking at the updated code now, while we do serialize on immap_lock at s=
ome
> points in the new flow, there are still fallible xas_store() callsites, a=
nd
> xas_next() calls that assume !xas_next() implies NULL-page entry (as oppo=
sed to
> error).
>
> IIUC, we are still waiting on a v5 of that series? If so, it seems like t=
his fix
> would be a great inclusion there. Reviewing this series is part of my pen=
ding
> TODO work (apologies I haven't gotten to it sooner). As such, I'll hold o=
ff on
> sending out a fix to this issue.
>
> Best,
> Zach
>
>

Sorry, I'm just adding noise here now / making the above unreadable. I
just realized v5 is out (thank you, David), and was included in the
mm-unstable version I grabbed.

I'll review that series as-is, and suggest any changes (to address the
above bug) in a follow-up patch.

Thanks,
Zach
