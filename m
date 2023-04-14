Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B66E299D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNRos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjDNRoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:44:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CECE189
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:44:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dm2so47655888ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681494270; x=1684086270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbN0jpcGA5XqhM/WcDWy1vf/Fqs9pIA93z/uU3WZM4I=;
        b=3Eyw0wQNRnyWbfClJ4tTEf5mh6i6eE4NDoRK+I5X10/m9BF764kAjogFs4DvpmA1/p
         kqj4XpXAcvK8KKXTl+hGgLuG3FaQkhkJjhbBXhRSKIblro+q0Z7iEyiWyX7+Gju+Uo2v
         +G6b9RaWJr/DEqz8VfsdIGtporhgC5hVj5H9fVyq7+FSrP0vrdRkHSKboXAry5tDAvr5
         O7XD8HgfnOzus9NRVrfVS4BPP1pT1zggl7iXZtw+4RhVrAjk/7FEPrxpprla1BA8rzKw
         t/6pGBA+8Br+mrEAmcrfc9LzH8SMBlV/2+VRKK07vOAqEdqKjZ2o8Akv/gxHIDE54lsY
         gxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681494270; x=1684086270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbN0jpcGA5XqhM/WcDWy1vf/Fqs9pIA93z/uU3WZM4I=;
        b=jvIlUKB9WqvbVBPqQRbJTYDlImpGDbPiTjvqMI7JdYF0UPify4FVTCD3Tebr326Yiw
         KthERAmOwA72qd9qihKxvsX34sOY68FSw6afXCHeaCmXLMNsz1kvtwpLxsq54Bbym1J0
         7FCrZUnZk8jhq2+YLTOtZbwBWemNllWJdGwbNW0Y+P2VwlsKMBsPcNjjQQsOT57/A9LD
         uPoz7E9VfFAGTTRUMIU+ZynjL7wUDeXJrsoX6RCgHiB97zEUTtMU6GybO6WMKw+Iug8/
         f3dTGWxWNm4cZIeY+IpshQ4NiLXPcNd8rQjBJe5G6g6PmI8MYq31JviFVU/YCHZkcGX7
         rhhg==
X-Gm-Message-State: AAQBX9fW3d4NNHC1O5VyrJlzC8ohqr/zhSz66pNDP6QCHB1+Yw7GHuPv
        8mCuUnY+ZSprCbVYbvV6yq5QhqdIlNvRtj3Q0bwSnw==
X-Google-Smtp-Source: AKy350aGTIVKOyJPf/0/gaGmkDnb5nRJar59+IUjNbkN+dxrLST1bm64fJmchDEhz1/n7wR8u7+NVweid9zjz/D0/g0=
X-Received: by 2002:a17:906:f0cc:b0:94e:d53e:cc7c with SMTP id
 dk12-20020a170906f0cc00b0094ed53ecc7cmr2039026ejb.15.1681494269910; Fri, 14
 Apr 2023 10:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1676378702.git.quic_charante@quicinc.com> <CAPTztWYgRORXKp83Spm3DX8qJsi1rw5s=WbPcjUYfOxFXxRAwg@mail.gmail.com>
In-Reply-To: <CAPTztWYgRORXKp83Spm3DX8qJsi1rw5s=WbPcjUYfOxFXxRAwg@mail.gmail.com>
From:   Frank van der Linden <fvdl@google.com>
Date:   Fri, 14 Apr 2023 10:44:18 -0700
Message-ID: <CAPTztWadceJtPUrSab1Tj2WV=uAhLo+CrxqyeSQ8rLn0FtM_zA@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 12:45=E2=80=AFPM Frank van der Linden <fvdl@google.=
com> wrote:
>
> On Tue, Feb 14, 2023 at 4:53=E2=80=AFAM Charan Teja Kalla
> <quic_charante@quicinc.com> wrote:
> >
> > This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEE=
D
> > advices to shmem files which can be helpful for the drivers who may wan=
t
> > to manage the pages of shmem files on their own, like, that are created
> > through shmem_file_setup[_with_mnt]().
> >
> > Changes in V7:
> >  -- Use folio based interface, shmem_read_folio(), for FADV_WILLNEED.
> >  -- Don't swap the SHM_LOCK'ed pages.
> >
> > Changes in V6:
> >  -- Replaced the pages with folio's for shmem changes.
> >  -- https://lore.kernel.org/all/cover.1675690847.git.quic_charante@quic=
inc.com/
> >
> > Changes in V5:
> >  -- Moved the 'endbyte' calculations to a header function for use by sh=
mem_fadvise().
> >  -- Addressed comments from suren.
> >  -- No changes in resend. Retested on the latest tip.
> >  -- https://lore.kernel.org/all/cover.1648706231.git.quic_charante@quic=
inc.com/
> >
> > Changes in V4:
> >   -- Changed the code to use reclaim_pages() to writeout the shmem page=
s to swap and then reclaim.
> >   -- Addressed comments from Mark Hemment and Matthew.
> >   -- fadvise() on shmem file may even unmap a page.
> >   -- https://patchwork.kernel.org/project/linux-mm/patch/1644572051-240=
91-1-git-send-email-quic_charante@quicinc.com/
> >
> > Changes in V3:
> >   -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identifi=
ed by Matthew.
> >   -- xarray used properly, as identified by Matthew.
> >   -- Excluded mapped pages as it requires unmapping and the man pages o=
f fadvise don't talk about them.
> >   -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defin=
ed.
> >   -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-138=
65-1-git-send-email-quic_charante@quicinc.com/
> >
> > Changes in V2:
> >   -- Rearranged the code to not to sleep with rcu_lock while using xas_=
() functionality.
> >   -- Addressed the comments from Suren.
> >   -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-159=
1-1-git-send-email-quic_charante@quicinc.com/
> >
> > changes in V1:
> >   -- Created the interface for fadvise(2) to work on shmem files.
> >   -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-223=
02-1-git-send-email-charante@codeaurora.org/
> >
> >
> > Charan Teja Kalla (2):
> >   mm: fadvise: move 'endbyte' calculations to helper function
> >   mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
> >
> >  mm/fadvise.c  |  11 +-----
> >  mm/internal.h |  21 +++++++++++
> >  mm/shmem.c    | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 138 insertions(+), 10 deletions(-)
> >
> > --
> > 2.7.4
> >
> >
>
> I didn't see this patch before, so I looked a bit at the history. At
> some point, in v3, dealing with mapped pages for DONTNEED was left
> out, they are now skipped. Unfortunately, that makes this patch no
> longer usable for a case that we have: restoring the (approximate)
> swap state of a tmpfs file. This involves walking a potentially large
> number of regions, and explicitly pushing them out to swap. This can
> be used to e.g. restore the state VM memory that is backed by a tmpfs
> file, avoiding memory usage by cold VM pages after resume.
>
> If DONTNEED also reclaims mapped pages (e.g. they get pushed out to
> swap, if any), implementing the above use case efficiently is simple:
> use io_uring with a vector that contains each region and the fadvise
> method.
>
> Without DONTNEED reclaiming mapped pages, you'd have to do mmap +
> madvise(MADV_PAGEOUT) for each region that you want swapped out, which
> is rather inefficient.
>
> I understand that the semantics for POSIX_FADV_DONTNEED on shmem/tmpfs
> files are open to interpretation, as it is a special case. And you can
> certainly make the argument that relying on behavior caused by what
> can be considered an implementation detail is bad.
>
> So, is there any way we can make this use case work efficiently using
> this patch?
>
> You state in the commit message:
>
> > So, FADV_DONTNEED also covers the semantics of MADV_PAGEOUT for file pa=
ges
> > and there is no purpose of PAGEOUT for file pages.
>
> But that doesn't seem correct: for shmem file pages, there actually
> can be a purpose, and the FADV_DONTNEED as implemented for shmem in
> this patch set does not cover the semantics.
>
> You can say that it doesn't need to cover the pageout case of mapped
> shmem pages, and that's fair. But I don't think you can claim that it
> covers the case as currently implemented.
>
> I suppose there are three options here:
>
> 1) Do nothing, this use case will just have to spend more time doing
> mmap+madvise
> 2) Don't skip mapped pages for POSIX_FADV_DONTNEED in shmem_fadvise
> 3) Implement something like POSIX_FADV_PAGEOUT_NP, which would include
> mapped pages.
>
> What do people think?
>
> - Frank

Hmm, actually, looking at it a bit more, there are several issues
here. One is that with fadvise, you can't be sure if you are the only
one dealing with the page in a mapped way(with madvise, if mapcount =3D=3D
1, that mean's it's just you, but you don't know that for fadvise, so
that makes correctly dealing with mapped pages harder).

Also, the madvise loop issue can probably also be dealt with via io_uring.

So, I think we can deal with the use case I mentioned in a different
way, that is mostly unrelated to this patchset, so basically:
disregard my previous email.

- Frank
