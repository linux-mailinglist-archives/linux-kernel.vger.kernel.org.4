Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B770A10D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjESUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjESUye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:54:34 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A4132
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:33 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-561c1436c75so56797797b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684529673; x=1687121673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHyyjBXGdkt4cSmFwqyUBwVMuSNH2CUYNfBzVRGjfmY=;
        b=r4xcUW9P7mdoHn/A+CRJgXb7Dqt1J5nqN2qQstM8zJ4vzpyBMLRQdqE6O+2Yt6wZ6J
         XLqtV3cGRqQGUqAA9uK56ZkgjSbV0DPsadwZmjjpqLmDlgNahNwvWzbH4rcJNkYyHC9W
         o8ziEEEcSETn5YCI2g6cJ9lMg1lSJV8QIQFxS785UqdAwFS7ZIpIWhsjFz+Hii7g7Ixo
         /sp1fZvkYpFdnucZ7Rn/CpYqyFIIsK2y1a1IQIsEx+/attmCuI/8AqP29nXX5PeL+FtD
         qv8JalAbNLD7Thc4JRda4MAJSCga202V19OZZGmXjWKaVrvf/iGocJ8Sna1zG/TmP/2P
         Nupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529673; x=1687121673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHyyjBXGdkt4cSmFwqyUBwVMuSNH2CUYNfBzVRGjfmY=;
        b=bVbijgw6d1kAU/vaIK+Ml6LTkGjqTEHzmrQ95CwCuFPBIXPrbfv+NO32Mq5c1stgli
         82c2IJ6n4f26PyHxt7av8CGmSDsUFd331BPpG7oVnfex0nTawpKUYn3DXf8BUzS/xC4D
         3Ryg6o8BOGsA/hAo/wKLyGUOq41KeBUL4Kz+SgvUgkts/DGQ9AYAl6k8TrWIvbm7zbPd
         6VsVJHlHYu3eq6vfRHdY+L6fDxqRiMsbuAvoynOtfF1xmDKwkKZ7mKBBCHYM3IcVIbqp
         X2Nlx+q0xcxXhgUzhv1HX4JBolAOy9azKLzIjcExkJ+Alm/igrTme0XhIlAhG3V1xRMc
         9JhA==
X-Gm-Message-State: AC+VfDwJbpw8nKb3OIcBO5+OPSi6xDGbnp+9Lgdcx0rtUPXTwD2RltgT
        229zfzk2UzRSMuPcq/54aWDVCyKjA3ZCEmtNVm7/Jw==
X-Google-Smtp-Source: ACHHUZ7Uhhh6XgxXqlIUX4pwzEPbZOoNALxhDzGkdqBmt0G1CfN66PxvYVOA6Lxetgil3GBAaSSTlcRNPu7moiIMNx8=
X-Received: by 2002:a0d:ca11:0:b0:561:4bc2:1587 with SMTP id
 m17-20020a0dca11000000b005614bc21587mr3564951ywd.39.1684529672768; Fri, 19
 May 2023 13:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com> <20230517160948.811355-3-jiaqiyan@google.com>
 <20230518221808.GC4029@monkey>
In-Reply-To: <20230518221808.GC4029@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 19 May 2023 13:54:21 -0700
Message-ID: <CACw3F53+Hg4CgFoPj3LLSiURzWfa2egWLO-=12GzfhsNC3XTvQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] hugetlbfs: improve read HWPOISON hugepage
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     songmuchun@bytedance.com, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
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

On Thu, May 18, 2023 at 3:18=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 05/17/23 16:09, Jiaqi Yan wrote:
> > When a hugepage contains HWPOISON pages, read() fails to read any byte
> > of the hugepage and returns -EIO, although many bytes in the HWPOISON
> > hugepage are readable.
> >
> > Improve this by allowing hugetlbfs_read_iter returns as many bytes as
> > possible. For a requested range [offset, offset + len) that contains
> > HWPOISON page, return [offset, first HWPOISON page addr); the next read
> > attempt will fail and return -EIO.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  fs/hugetlbfs/inode.c | 62 +++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 56 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index ecfdfb2529a3..1baa08ec679f 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -282,6 +282,46 @@ hugetlb_get_unmapped_area(struct file *file, unsig=
ned long addr,
> >  }
> >  #endif
> >
> > +/*
> > + * Someone wants to read @bytes from a HWPOISON hugetlb @page from @of=
fset.
> > + * Returns the maximum number of bytes one can read without touching t=
he 1st raw
> > + * HWPOISON subpage.
> > + *
> > + * The implementation borrows the iteration logic from copy_page_to_it=
er*.
> > + */
> > +static size_t adjust_range_hwpoison(struct page *page, size_t offset, =
size_t bytes)
> > +{
> > +     size_t n =3D 0;
> > +     size_t res =3D 0;
> > +     struct folio *folio =3D page_folio(page);
> > +
> > +     folio_lock(folio);
>
> What is the reason for taking folio_lock?

I intended to make this routine (mostly find_raw_hwp_page) to be
serialized with folio_clear_hugetlb_hwpoison() and
hwpoison_user_mappings() in try_memory_failure_hugetlb(). They don't
directly affect the raw_hwp_list. I can remove the lock in v2.

>
> > +
> > +     /* First subpage to start the loop. */
> > +     page +=3D offset / PAGE_SIZE;
> > +     offset %=3D PAGE_SIZE;
> > +     while (1) {
> > +             if (find_raw_hwp_page(folio, page) !=3D NULL)
> > +                     break;
> > +
> > +             /* Safe to read n bytes without touching HWPOISON subpage=
. */
> > +             n =3D min(bytes, (size_t)PAGE_SIZE - offset);
> > +             res +=3D n;
> > +             bytes -=3D n;
> > +             if (!bytes || !n)
> > +                     break;
> > +             offset +=3D n;
> > +             if (offset =3D=3D PAGE_SIZE) {
> > +                     page++;
> > +                     offset =3D 0;
> > +             }
> > +     }
> > +
> > +     folio_unlock(folio);
> > +
> > +     return res;
> > +}
> > +
> >  /*
> >   * Support for read() - Find the page attached to f_mapping and copy o=
ut the
> >   * data. This provides functionality similar to filemap_read().
> > @@ -300,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
> >
> >       while (iov_iter_count(to)) {
> >               struct page *page;
> > -             size_t nr, copied;
> > +             size_t nr, copied, want;
> >
> >               /* nr is the maximum number of bytes to copy from this pa=
ge */
> >               nr =3D huge_page_size(h);
> > @@ -328,16 +368,26 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> >               } else {
> >                       unlock_page(page);
> >
> > -                     if (PageHWPoison(page)) {
> > -                             put_page(page);
> > -                             retval =3D -EIO;
> > -                             break;
> > +                     if (!PageHWPoison(page))
> > +                             want =3D nr;
> > +                     else {
> > +                             /*
> > +                              * Adjust how many bytes safe to read wit=
hout
> > +                              * touching the 1st raw HWPOISON subpage =
after
> > +                              * offset.
> > +                              */
> > +                             want =3D adjust_range_hwpoison(page, offs=
et, nr);
> > +                             if (want =3D=3D 0) {
> > +                                     put_page(page);
> > +                                     retval =3D -EIO;
> > +                                     break;
> > +                             }
> >                       }
> >
> >                       /*
> >                        * We have the page, copy it to user space buffer=
.
> >                        */
> > -                     copied =3D copy_page_to_iter(page, offset, nr, to=
);
> > +                     copied =3D copy_page_to_iter(page, offset, want, =
to);
> >                       put_page(page);
> >               }
> >               offset +=3D copied;
> > --
> > 2.40.1.606.ga4b1b128d6-goog
> >
>
> Code looks fine, just wondering about that folio_lock.
> --
> Mike Kravetz
