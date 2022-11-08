Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD606217C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiKHPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiKHPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:13:44 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37D1F2C3;
        Tue,  8 Nov 2022 07:13:42 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id t85so9104591vkb.7;
        Tue, 08 Nov 2022 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNIeB0UP6BDhS3WhrtN7N5HAMK4KBm7FNXWug9kCOt0=;
        b=N06qTS5oVP+WNvGhqlQB4zmIgdCWQ5qKDpje7dT0ed/N3YZ/84ajTHt4H6C01Mte5w
         Aw7b6YMmAGc67efJasLKJHXq1B50LqeAB3CqG+F9GnWBCCvWcGiZ2QExAUksYEieXXD3
         f598jMqZYuLBuUYw/J9n5yuQMxKez524JcCdPNX6jOp/PR1dRLfnZL3ShN4piuCE3SYZ
         sB3iltFVEYmcB23MUNjSPjMTVDM+QmhL60Ej1SlA2dxLsTyJ36l1mhGLK8UMjocVCXVz
         P0xCiH4ZVZfL7zCKG0ge35Jc6e6XMDOLqkoh9d3YvEeYdTiUjQUtLYVrzucgTqZfSaCz
         5TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNIeB0UP6BDhS3WhrtN7N5HAMK4KBm7FNXWug9kCOt0=;
        b=GL6lKsoYuMWlOxVo5iLJA2AjJhZRYsUj8t95CDTa4VFJmMjK6PPFTpr30ws0qtPKny
         v05qbAtKHUd2evhavh2SVCBpraW8Za0O1GTuXIU3TJ0f4IcXem040O0+crR2MLng5Ibt
         xqO8QXRN6KJ+y2Ud3d50MGmOt6NDUTM6abFR5pajXBGjE6cHnHLi8TxDu1dYVI3mpKei
         hErZaPL8/UpDl85PXpJH86Rvv0IiR84xdcBaw3zTfn6Ty8u1iRUxkuXz4WobPOs4ksMM
         /rGGVKz77s/XKk7vYqN8SOukDk94senqn0Qoxurmd1hZnk7q3hLqdzDOfZ6f2/b8/WfY
         11Og==
X-Gm-Message-State: ACrzQf0dQ8NQlyo3JpWEP5a3+9f6XskWn63kFwGoT6DDMWjIhB4UlTCi
        853LLlnXIZ/jv2O1ql0uLUiQ0tggRo+/6DcwoyXg5O085m8=
X-Google-Smtp-Source: AMsMyM5xT00ui0Jp4BtTm1/erH1ZC/K3FlXF+qg9wx1V/BICU9h/K886wIMbwy5ICaeHuMuemg9c/CpiUQM+9v73kDU=
X-Received: by 2002:a1f:2985:0:b0:3b7:68e9:e400 with SMTP id
 p127-20020a1f2985000000b003b768e9e400mr29051368vkp.33.1667920421117; Tue, 08
 Nov 2022 07:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
 <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com> <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
 <781fc98e-351c-58b0-b0e7-e5080a193d31@huawei.com> <CAKFNMomK=C4JY7ftNQs7Zs3dr0m=e_k-vVXTfmR-mpumuGUtDw@mail.gmail.com>
In-Reply-To: <CAKFNMomK=C4JY7ftNQs7Zs3dr0m=e_k-vVXTfmR-mpumuGUtDw@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 9 Nov 2022 00:13:24 +0900
Message-ID: <CAKFNMokX6wudO+WJbdc4-1gTXLXn59=dvm0CLGeXAFiA+kJXdg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_segctor_prepare_write()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu Shixin,

On Tue, Nov 8, 2022 at 9:24 PM Ryusuke Konishi wrote:
>
> On Tue, Nov 8, 2022 at 8:53 PM Liu Shixin wrote:
> >
> >
> >
> > On 2022/11/8 18:33, Ryusuke Konishi wrote:
> > > On Tue, Nov 8, 2022 at 3:49 PM Liu Shixin wrote:
> > >>
> > >>
> > >> On 2022/11/8 12:41, Ryusuke Konishi wrote:
> > >>> Hi Liu Shixin,
> > >>>
> > >>> On Tue, Nov 8, 2022 at 10:41 AM Liu Shixin wrote:
> > >>>> Syzbot reported a NULL pointer dereference:
> > >>>>
> > >>>>  Unable to handle kernel NULL pointer dereference at virtual addre=
ss 0000000000000168
> > >>>>  Mem abort info:
> > >>>>    ESR =3D 0x0000000096000004
> > >>>>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >>>>    SET =3D 0, FnV =3D 0
> > >>>>    EA =3D 0, S1PTW =3D 0
> > >>>>    FSC =3D 0x04: level 0 translation fault
> > >>>>  Data abort info:
> > >>>>    ISV =3D 0, ISS =3D 0x00000004
> > >>>>    CM =3D 0, WnR =3D 0
> > >>>>  user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000108bcf000
> > >>>>  [0000000000000168] pgd=3D0000000000000000, p4d=3D0000000000000000
> > >>>>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > >>>>  Modules linked in:
> > >>>>  CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-1=
8095-gbbed346d5a96 #0
> > >>>>  Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 09/30/2022
> > >>>>  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > >>>>  pc : _compound_head include/linux/page-flags.h:253 [inline]
> > >>>>  pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
> > >>>>  lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
> > >>>>  sp : ffff80001290bc00
> > >>>>  x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
> > >>>>  x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
> > >>>>  x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
> > >>>>  x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
> > >>>>  x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
> > >>>>  x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
> > >>>>  x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
> > >>>>  x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
> > >>>>  x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
> > >>>>  x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
> > >>>>  Call trace:
> > >>>>   lock_page+0x28/0x1e0 include/linux/pagemap.h:956
> > >>>>   nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
> > >>>>   nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
> > >>>>   nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
> > >>>>   nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
> > >>>>   nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
> > >>>>   kthread+0x12c/0x158 kernel/kthread.c:376
> > >>>>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> > >>>>
> > >>>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_constru=
ction(),
> > >>>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, =
we will
> > >>>> add a bh in two segbuf->sb_segsum_buffers. And finally cause list =
error.
> > >>>>
> > >>>> Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
> > >>>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> > >>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > >>>> ---
> > >>>>  fs/nilfs2/segment.c | 1 +
> > >>>>  fs/nilfs2/sufile.c  | 2 +-
> > >>>>  2 files changed, 2 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> > >>>> index b4cebad21b48..7be632c15f91 100644
> > >>>> --- a/fs/nilfs2/segment.c
> > >>>> +++ b/fs/nilfs2/segment.c
> > >>>> @@ -1371,6 +1371,7 @@ static int nilfs_segctor_extend_segments(str=
uct nilfs_sc_info *sci,
> > >>>>                 sci->sc_segbuf_nblocks +=3D segbuf->sb_rest_blocks=
;
> > >>>>
> > >>>>                 /* allocate the next next full segment */
> > >>>> +               nextnextnum =3D segbuf->sb_segnum;
> > >>>>                 err =3D nilfs_sufile_alloc(sufile, &nextnextnum);
> > >>>>                 if (unlikely(err))
> > >>>>                         goto failed_segbuf;
> > >>>> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> > >>>> index 77ff8e95421f..853a8212114f 100644
> > >>>> --- a/fs/nilfs2/sufile.c
> > >>>> +++ b/fs/nilfs2/sufile.c
> > >>>> @@ -317,7 +317,7 @@ int nilfs_sufile_alloc(struct inode *sufile, _=
_u64 *segnump)
> > >>>>                 goto out_sem;
> > >>>>         kaddr =3D kmap_atomic(header_bh->b_page);
> > >>>>         header =3D kaddr + bh_offset(header_bh);
> > >>>> -       last_alloc =3D le64_to_cpu(header->sh_last_alloc);
> > >>>> +       last_alloc =3D max(le64_to_cpu(header->sh_last_alloc), *se=
gnump);
> > >>>>         kunmap_atomic(kaddr);
> > >>>>
> > >>>>         nsegments =3D nilfs_sufile_get_nsegments(sufile);
> > >>>> --
> > >>>> 2.25.1
> > >>> Thank you for your help.   I have a few questions, so I'll ask them=
 below.
> > >>>
> > >>>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_constru=
ction(),
> > >>>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, =
we will
> > >>>> add a bh in two segbuf->sb_segsum_buffers.
> > >>> If nilfs_sufile_alloc() succeeds to allocate a segment, sh_last_all=
oc
> > >>> is updated.
> > >>> all segment allocation must be done through nilfs_sufile_alloc().
> > >>> And, the allocated segment is marked dirty on the sufile not to be
> > >>> reallocated until it's freed.
> > >>>
> > >>> So, why is it happening that the same segment is allocated twice in=
 a log ?
> > >>> Is it hard to fix the problem by correcting the calling sequence of
> > >>> nilfs_sufile_alloc()/free()/etc without touching nilfs_sufile_alloc=
()
> > >>> ?
> > >> The problem happened when we call nilfs_segctor_begin_construction()=
 and satisfied
> > >> condition nilfs->ns_segnum !=3D nilfs->ns_nextnum. In such scenario,=
 nilfs_sufile_alloc()
> > >> will be skipped, but we call nilfs_segbuf_map() and nilfs_segbuf_set=
_next_segnum()
> > >> all the time, so last_alloc is not updated.
> > >> Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->s=
b_nextnum directly,
> > >> and calculate next sb_segnum by nilfs_sufile_alloc(), since last_all=
oc is not updated,
> > >> we will get sb_segnum again.
> > >>
> > >> By the way, I still don't understand why skip nilfs_sufile_alloc() i=
n some cases and why
> > >> nilfs->ns_segnum !=3D nilfs->ns_nextnum. Do you have any ideas?
> > >>> I haven't looked closely at this patch yet, but I'm concerned about
> > >>> the impact on other places as well.
> > >>> nilfs_sufile_alloc() is also used in
> > >>> nilfs_segctor_begin_construction() and
> > >>> nilfs_prepare_segment_for_recovery().  Are there any side effects?
> > >>>
> > >>> This patch turns an output-only argument into both input and output=
,
> > >>> and that input value is always used in the calculation of
> > >>> "last_alloc".
> > >>> So, this change requires all callers to pass a meaningful initial
> > >>> value (at least a valid value) to *segnump.
> > >>>
> > >>> Another question, will this work near the end of the segments ?
> > >>> Since segments are used cyclically, wouldn't comparison with the ma=
x
> > >>> function break down there?
> > >>> (I mean it seems that sh_last_alloc may be chosen unintentionally a=
t the end.)
> > >> Thanks for the heads-up=EF=BC=8CI need to look at it again. This pat=
ch can only prevent this problem,
> > >> and seems to need improvement. Maybe there is a more reasonable solu=
tion.
> > >>
> > >> Thanks,
> > > I will explain step by step.
> > >
> > >> By the way, I still don't understand why skip nilfs_sufile_alloc() i=
n some cases and why
> > >> nilfs->ns_segnum !=3D nilfs->ns_nextnum. Do you have any ideas?
> > > nilfs->ns_segnum holds the segment number where nilfs2 currently
> > > writes logs to, and nilfs->ns_nextnum holds the next segment number
> > > where nilfs2 will select to write logs when the current segment gets
> > > full.
> > > Here, a segment is a fixed sized container of logs (*), in which
> > > multiple logs can be appended and written in.
> > > (*) Exceptionally, segment #0 is shorter than others to exclude the
> > > superblock area.
> > >
> > > The reason "nextnum" is needed is that mount-time recovery processing
> > > needs to know which segment the logs follow.
> > >
> > > Both segments (nilfs->ns_segnum and nilfs->ns_nextnum) must be alread=
y
> > > allocated on the sufile.
> > > Here, "allocated" means the corresponding segment usage entry is
> > > marked "dirty" on the sufile.
> > > In nilfs_sufile_alloc() this is done with the following line:
> > >
> > >                         nilfs_segment_usage_set_dirty(su);
> > >
> > > On the other hand, the test whether the segment is allocatable or not
> > > is done at the following part:
> > >
> > >                         if (!nilfs_segment_usage_clean(su))
> > >                                 continue;
> > >                         /* found a clean segment */
> > >
> > > Coming back to your last question, if nilfs->ns_segnum !=3D
> > > nilfs->ns_nextnum, it indicates that nilfs2 is still writing a log to
> > > the segment of ns_segnum.
> > > Both should be in the allocated state, so there is no need to call
> > > nilfs_sufile_alloc() in this case.
> > >
> > > If nilfs->ns_segnum =3D=3D nilfs->ns_nextnum in
> > > nilfs_segctor_begin_construction(), then nilfs_shift_to_next_segment(=
)
> > > sets ns_segnum to ns_nextnum because the current segment (ns_segnum)
> > > is full and no more logs can be written.
> > > In this case, a new segment must be allocated for new ns_nextnum,
> > > therefore nilfs_sufile_alloc() will be called.
> > >
> > >> The problem happened when we call nilfs_segctor_begin_construction()=
 and satisfied
> > >> condition nilfs->ns_segnum !=3D nilfs->ns_nextnum. In such scenario,=
 nilfs_sufile_alloc()
> > >> will be skipped, but we call nilfs_segbuf_map() and nilfs_segbuf_set=
_next_segnum()
> > >> all the time, so last_alloc is not updated.
> > > As I explained above, it is expected behavior that
> > > nilfs_sufile_alloc() is not called and last_alloc is not updated if
> > > nilfs->ns_segnum !=3D nilfs->ns_nextnum.
> > >
> > > nilfs_segbuf_map() is always called there to set the geometry
> > > information in the segbuf.  This is expected behavior.
> > > And, nilfs_segbuf_set_next_segnum() is called later to set the
> > > determined ns_nextnum to the segbuf, so this is expected behavior as
> > > well.
> > >
> > >> Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->s=
b_nextnum directly,
> > >> and calculate next sb_segnum by nilfs_sufile_alloc(), since last_all=
oc is not updated,
> > >> we will get sb_segnum again.
> > > nilfs_segctor_extend_segments() pre-allocates one or more segments
> > > large enough to store updated blocks of metadata files that need to b=
e
> > > written in a series of logs at once, and sets up a chain of segbufs.
> > > (Sorry for the missing function comment).
> > >
> > > sb_segnum is set by prev->sb_nextnum to form a chain of buffers for
> > > segments.  This is expected behavior.
> > > And, the sb_nextnum (=3D next sb_segnum) will be given by
> > > nilfs_sufile_alloc().   This is also expected.
> > > It looks like the problem is that nilfs_sufile_alloc() here allocates
> > > the same segnum again.
> > Thanks to your series of explanations, I learned a lot. So I can assume=
 that
> > the skip of nilfs_sufile_alloc() here is because it's already been allo=
cated. So
> > in next time, we will skip previous sb_segnum natually. And the problem
> > should not be happend.
> >
> > >
> > > Because sb_segnum is set by prev->sb_nextnum which is allocated by th=
e
> > > previous nilfs_sufile_alloc() call,
> > > this usually does not happen.
> > >
> > > A possible anomaly is if the segment pointed by the first nextnum (or
> > > segnum) was not marked dirty on sufile.
> > > This may happen if the sufile is corrupted on the test disk image tha=
t
> > > syzbot provided (mounted).
> > >
> > > Can you confirm if this is actually happening?
> > This problem was discovered through syzbot and can be reproduced. The r=
oot
> > reason I think is data corruption rather than logical error. So we shou=
ld add
> > some protection instead of modifying the logic, right?
>
> I think the most likely cause is metadata corruption.  If so, we
> should fix it by adding a proper sanity check, yes.
> However, there is still the possibility that the error retry logic
> after detecting errors has a flaw. (I believe at least this is not a
> problem with normal paths.)
> The sufile state inconsistency above is hypothetical for now.
> Either way, I'd like to make sure what's actually happening (and where
> the anomaly is coming from) so we can decide how to fix it.

I noticed that this syzbot report has a disk image "mount_0.gz", so I
tried to mount it read-only.
The result was as follows:

$ sudo mount -t nilfs2 -r ./mount_0 /mnt/test
$ lssu
              SEGNUM        DATE     TIME STAT     NBLOCKS
                   0  26760730-10-29 19:40:00  -de   527958016
                   1  26760730-11-01 20:29:04  -de   527958016
                   2  1176433641-11-01 02:01:52  -de  2983038235
                   3  -1158249729-11-01 04:57:19  a--       25375
                   4  1970-01-02 21:24:32  a--           0
                   5  -1415215929-01-02 00:19:15  --e  1631451365
                   6  841067190-01-02 13:02:59  -d-  3101461260
                   7  1495233207-01-02 01:31:11  -de  1697748441
                   8  1875753393-01-02 21:54:14  -de   337757600
                   9  648878284-01-02 21:06:08  ---  2133388152
                  10  2122778986-01-02 17:49:43  --e   874605800
                  11  55846197-01-02 09:50:53  -de  4262365368
                  12  1872396026-01-02 06:45:18  ---  1051768258
                  13  820920473-01-02 19:28:35  --e  2932336675
                  14  2128306755-01-02 10:17:45  ---  3568501216
                  15  1457063063-01-02 01:24:17  --e  2330511560
                  16  586864775-01-02 16:08:15  ---   355283425
                  17  -824870041-01-02 22:47:26  -d-  4177999057
                  18  1562176264-01-02 08:06:45  ---  1312597355
                  19  -392925420-01-02 17:08:27  -d-  3811075948
                  20  1927575458-01-02 21:26:51  -de  1384562525
                  21  2139923505-01-02 08:16:04  -d-    41861305

Here,  we can see that neither segment #3 (=3D ns_segnum) nor #4 (=3D
ns_nextnum) has the dirty flag
("d" in STAT).   So, as expected, this seems to be the root cause of
the duplicate assignments and oops.
The proper correction would be, therefore, to check and reject (or
fix) this anomaly while outputting an error message
(or warning if fix it at the same time).
It should be inserted in mount time logic because the segments that
nilfs2 itself allocates are always marked dirty with
nilfs_sufile_alloc().

Regards,
Ryusuke Konishi
