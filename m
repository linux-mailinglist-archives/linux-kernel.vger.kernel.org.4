Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A03D6026B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJRIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJRIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:25:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5112633
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:25:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l1so13103661pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZpmCLR1hF5indS150MrkYZSlje/HXn7i2XKe1x9Dvs=;
        b=dqdAVfvKOkLVI7zPqzC+N2JLRvbkWfaqyORvJvnFVSPo6LaptLQYpBQ91KFQsbAXOW
         jOgrIDOh8nIFiw5DGIyHj/o9pVj7Nse24l7OIhuVX8yp23TIgf84aT1TXL+5egkp9IVo
         jgZaJR+y8uwXBwfU0u5UA/yaFNpfViEtplgDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZpmCLR1hF5indS150MrkYZSlje/HXn7i2XKe1x9Dvs=;
        b=haBQA9Fue2xDq06X/yGCc0i57yfpOS2t3SlYzOChCK4KNMh889XTJV9itAg/iVv1kv
         ZfGSc/erkbQ5QqgBsV0KmtJCFOjaS9tnKTZzS6fNK8VqIEpYbKUyUwNhjoCV/D/WISWA
         WFQl79qkpl0K/BEfurLbnnegLw31zRJWbIFx/N9U6rchnUxdlI2DrYJShHxImH9ZAZwb
         8xuDDgn/46BdUowb8waYrmUOhEJGzb4LHOz55udIBn7TU8c6rDJOmR8g+TywAU89Q0o7
         ver2mbOb1sTJUqNsAspGBuLWSEwVfXjGobhGHKqY5fHM+s20hdk9sYLfu2jIVOkakVqE
         kSrQ==
X-Gm-Message-State: ACrzQf2ZBsIL1RvNUIANcwRr2TGRemMVsy2R1zbs7URDCAznT9kUCF5R
        sqTvsDtq9VS9UABlFStkUHMNGaAjt2c+T2xMWOASBA==
X-Google-Smtp-Source: AMsMyM6y7VKicFgvVx8dsksOFGLsX2VUfi4dRPGOLeq53dJM1CPEac0ZO/++xgen87AYpJ193fAE/WjMbF414Xd92jU=
X-Received: by 2002:a17:90b:4f4a:b0:20c:64e2:2bf1 with SMTP id
 pj10-20020a17090b4f4a00b0020c64e22bf1mr2435342pjb.30.1666081512601; Tue, 18
 Oct 2022 01:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com> <41c05ece-2e63-391a-e1ba-fc1acb235559@alu.unizg.hr>
In-Reply-To: <41c05ece-2e63-391a-e1ba-fc1acb235559@alu.unizg.hr>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 18 Oct 2022 16:24:46 +0800
Message-ID: <CAJMQK-hgQEkhgpO9VFOCgn-cKtVsr7Hb_58pAYiGoDi5SzGZtA@mail.gmail.com>
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk,
        bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 2:52 PM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 10/18/22 04:15, Jintao Yin wrote:
>
> > On Sat, Oct 15, 2022 at 09:59:36PM +0100, Phillip Lougher wrote:
> >> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> >>> Topposting, to make this easier to access for everyone.
> >>>
> >>> @Mirsad, thx for bisecting.
> >>>
> >>> @Phillip: if you want to see a problem description and the whole
> >>> backstory of the problem that apparently is caused by       b09a7a036=
d20
> >>> ("squashfs: support reading fragments in readahead call"), see this
> >>> thread (Mirsad sadly started a new one with the quoted mail below):
> >>> https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.=
unizg.hr/
> >>>
> >> The above backstory tends to suggest data corruption which is happenin=
g
> >> after a couple of hours especially on heavy loads, e.g. the comment
> >>
> >>> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
> >>> The bug usually isn't showing immediately, but after a couple of hour=
s
> >>> of running (especially with multimedia running inside Firefox).
> >> Which is typically caused by double freed buffers or race conditions i=
n
> >> freeing and reusing.
> >>
> >> Thanks Mirsad for the following
> >>
> >> On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
> >>> Here are the results of the requested bisect on the bug involving the
> >>> Firefox snap build 104.x, 105.0.x, squashfs and which was manifested =
on
> >>> both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
> >>>
> >>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
> >>> git bisect start
> >>> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
> >>> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> >>> # good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
> >>> git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
> >>> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
> >>> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
> >>> # good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
> >>> 'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
> >>> git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
> >>> # good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
> >>> 'mm-stable-2022-08-03' of
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >>> git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
> >>> # bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag
> >>> 'mm-nonmm-stable-2022-08-06-2' of
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >>> git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
> >>> # good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek:
> >>> Add quirk for HP Spectre x360 15-eb0xxx
> >>> git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
> >>> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag
> >>> 'dma-mapping-5.20-2022-08-06' of
> >>> git://git.infradead.org/users/hch/dma-mapping
> >>> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
> >>> # good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix
> >>> kexec build error
> >>> git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
> >>> # good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag
> >>> 's390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/l=
inux
> >>> git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
> >>> # good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always
> >>> build "file direct" version of page actor
> >>> git bisect good db98b43086275350294f5c6f797249b714d6316d
> >>> # good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb=
:
> >>> Check the size of screen before memset_io()
> >>> git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
> >>> # good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag
> >>> 'for-5.20/fbdev-1' of
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
> >>> git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
> >>> # bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some
> >>> useless functions
> >>> git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
> >>> # bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: f=
ix
> >>> address space of proc_dohung_task_timeout_secs
> >>> git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
> >>> # bad: [b09a7a036d2035b14636cd4c4c69518d73770f65]  squashfs: support
> >>> reading fragments in readahead call
> >>> git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
> >>> mtodorov@domac:~/linux/kernel/linux_stable$
> >>>
> >>> The git bisect stopped at the squashfs commit
> >>> b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in Cc=
:,
> >>> according to the Code of Conduct.
> >> Which identified the "squashfs: support reading fragments in readahead=
 call"
> >> patch.
> >>
> >> There is a race-condition introduced in that patch, which involves cac=
he
> >> releasing and reuse.
> >>
> >> The following diff will fix that race-condition.  It would be great if
> >> someone could test and verify before sending it out as a patch.
> >>
> >> Thanks
> >>
> >> Phillip
> > Hi Phillip,
> >    There is a logical bug in commit 8fc78b6fe24c36b151ac98d7546591ed920=
83d4f
> >    which is parent commit of commit b09a7a036d2035b14636cd4c4c69518d737=
70f65.
> >
> >    In function squashfs_readahead(...),
> >    file_end is initialized with i_size_read(inode) >> msblk->block_log,
> >    which means the last block index of the file.
> >    But later in the logic to check if the page is last one or not the
> >    code is
> >      if (pages[nr_pages - 1]->index =3D=3D file_end && bytes) {
> >        ...
> >      }
> >    , use file_end as the last page index of file but actually is the la=
st
> >    block index, so for the common setup of page and block size, the fir=
st
> >    comparison is true only when pages[nr_pages - 1]->index is 0.
> >    Otherwise, the trailing bytes of last page won't be zeroed.
> >
> >    Maybe it's the real cause of the snap bug in some way.
> >
Hi Jintao,

Thanks for pointing out and sorry for missing this. Does the following
diff improve the issue?

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index e56510964b229..7759bd70dfbf2 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -600,7 +600,7 @@ static void squashfs_readahead(struct
readahead_control *ractl)

                        /* Last page (if present) may have trailing
bytes not filled */
                        bytes =3D res % PAGE_SIZE;
-                       if (pages[nr_pages - 1]->index =3D=3D file_end && b=
ytes)
+                       if ((pages[nr_pages - 1]->index >> shift) =3D=3D
file_end && bytes)
                                memzero_page(pages[nr_pages - 1], bytes,
                                             PAGE_SIZE - bytes);


readahead only handles the case that the first page and the last page
have the same block index:
    index =3D pages[0]->index >> shift;
    if ((pages[nr_pages - 1]->index >> shift) !=3D index)
        goto skip_pages;

The diff above makes a difference to SQUASHFS_INVALID_BLK case, which
will not be handled by squashfs_readahead_fragment() if
index=3D=3Dfile_end.
With the above diff, it will now be memzero_page().

Hi Phillip,
Does the SQUASHFS_INVALID_BLK case handling with index=3D=3Dfile_end
sounds reasonable to you?

Thanks.

> >    Thanks,
> >
> >    Jintao
>
> Dear Jintao,
>
> Forgive me for noticing that this is no longer Phillip's code, so I took =
the
> freedom as the original submitter of the bug to include Hsin-Yi into the =
Cc:
> list, so he'd be informed about the error in his code.
>
> Phillip:
> I usually stop myself at bisecting bugs, and not people, so if you think =
that
> I was demeaning your professional contribution, I will pull a halt on thi=
s and
> pull out of this thread.
>
> I am more like weeks than decades long in Linux kernel study, so I realis=
e I
> haven't earned the right to give you lessons, and if I sounded like that,=
 I
> apologise again.
>
> Owing to the Author of my story, it is more important for me to win heart=
s for
> my Saviour than points in bug hunting.
>
> Thank you.
>
> --
> Mirsad Goran Todorovac
> Sistem in=C5=BEenjer
> Grafi=C4=8Dki fakultet | Akademija likovnih umjetnosti
> Sveu=C4=8Dili=C5=A1te u Zagrebu
> --
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
>
