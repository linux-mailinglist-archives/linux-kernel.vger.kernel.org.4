Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3174BC50
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGHF4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGHF4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:56:52 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6721FD7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:56:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-346099c6f43so43335ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688795810; x=1691387810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktwdl5TQFeIYyiCaVsJWEC8esxXxEXEFyV/rHghDt34=;
        b=NwooO6EcfzdeygoL3cBGFSyNJIgQ20cApSfodbSdbSVMO2MIpHWrS1S54gfdhEBCsC
         21YPDxlG3BuvSUMYXR4Dzh8KjPLk7220fxQtMKplb/2uFa6aygBFBCmbE/uJJWbe3eO8
         7AyNg8faOSLWklZIMDME1NOCNF72HqKMHjli4yKtJcIGgP4qf6u1eXpkNSfuVHgLsyhm
         GepkIJPLMvcIaF4Uy1cCNWvAl/8/U8NB4sAftxhT7W6FMAX6GxZva+tyqxgBF52vAcEb
         pRAWm839dn9t2Psckm90y4GTQC78RemuHjQejXuSyxJiH/DIsb62UZBTz3tuLjJttrZ9
         AdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688795810; x=1691387810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktwdl5TQFeIYyiCaVsJWEC8esxXxEXEFyV/rHghDt34=;
        b=Bpm0t4+TD4p8zPqMuLLF7k1QqoSKlm1+97HsB0nG2f7cEOgSvqNalLyLGGZ6FiNWdH
         jPXcE2bBDXG/OcAs7dYeLdXv4gUfQ7qHkpYcW9L2uW7Q41LScVtNOnGJB7krN1qQCCeH
         ZXOMFF97ivAaLoM/AqpEwPcCoERrPlgMUi3doYOMTGjVZJOdo69OaaFRIKkLSpujGrvO
         2zFVdGd+Rop7rCLIMFCDIBDEezGKv+PSaFu8GE76Yjsa0W+pBM7Wl5kvkmd6KIie7egF
         twM8lSqSRCzKpBrULuJksvZ72UpnZ4+QxksXDL61MAhkvpySGwpn/455d9P7PcpTbBrJ
         iJhQ==
X-Gm-Message-State: ABy/qLZrtx/If6+V8AJfa0ru0YZgyUC+Bhq/akSUNgPwBDIGYHVJdQHM
        s6ZMqGYEhMTfiSLu6cDiSOduAVIu7IENVNwpwEZu2A==
X-Google-Smtp-Source: APBJJlFDdATi0FYftaqlgzOrtA94z7xNS20rW6NoNjUL5YYazYoP1NC3vVM6DtdDqwT7ltg2ogQlIgYEVynjKq1BYdw=
X-Received: by 2002:a92:c56e:0:b0:33d:f067:8fa4 with SMTP id
 b14-20020a92c56e000000b0033df0678fa4mr120021ilj.16.1688795810519; Fri, 07 Jul
 2023 22:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <20230707165221.4076590-3-fengwei.yin@intel.com> <CAOUHufZWYo4DMNgu4VtGsPtHR3LQmYRH9rC9inMAn+-4oZSyCw@mail.gmail.com>
 <928bb406-f09b-358e-c3cb-72ddd53a2793@intel.com>
In-Reply-To: <928bb406-f09b-358e-c3cb-72ddd53a2793@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Jul 2023 23:56:14 -0600
Message-ID: <CAOUHufb-73wxGNLKSr=wdp2Q_7U4Ueij9kAJhaUiqtuK=Szpbg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
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

On Fri, Jul 7, 2023 at 11:34=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 7/8/2023 1:11 PM, Yu Zhao wrote:
> > On Fri, Jul 7, 2023 at 10:52=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >> If large folio is in the range of VM_LOCKED VMA, it should be
> >> mlocked to avoid being picked by page reclaim. Which may split
> >> the large folio and then mlock each pages again.
> >>
> >> Mlock this kind of large folio to prevent them being picked by
> >> page reclaim.
> >>
> >> For the large folio which cross the boundary of VM_LOCKED VMA,
> >> we'd better not to mlock it. So if the system is under memory
> >> pressure, this kind of large folio will be split and the pages
> >> ouf of VM_LOCKED VMA can be reclaimed.
> >>
> >> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >> ---
> >>  mm/internal.h | 11 ++++++++---
> >>  mm/rmap.c     |  3 ++-
> >>  2 files changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index 66117523d7d71..c7b8f0b008d81 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -637,7 +637,8 @@ static inline void mlock_vma_folio(struct folio *f=
olio,
> >>          *    still be set while VM_SPECIAL bits are added: so ignore =
it then.
> >>          */
> >>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) =3D=3D V=
M_LOCKED) &&
> >> -           (compound || !folio_test_large(folio)))
> >> +           (compound || !folio_test_large(folio) ||
> >> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
> >>                 mlock_folio(folio);
> >>  }
> >>
> >> @@ -645,8 +646,12 @@ void munlock_folio(struct folio *folio);
> >>  static inline void munlock_vma_folio(struct folio *folio,
> >>                         struct vm_area_struct *vma, bool compound)
> >>  {
> >> -       if (unlikely(vma->vm_flags & VM_LOCKED) &&
> >> -           (compound || !folio_test_large(folio)))
> >> +       /*
> >> +        * To handle the case that a mlocked large folio is unmapped f=
rom VMA
> >> +        * piece by piece, allow munlock the large folio which is part=
ially
> >> +        * mapped to VMA.
> >> +        */
> >> +       if (unlikely(vma->vm_flags & VM_LOCKED))
> >>                 munlock_folio(folio);
> >>  }
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 2668f5ea35342..7d6547d1bd096 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -817,7 +817,8 @@ static bool folio_referenced_one(struct folio *fol=
io,
> >>                 address =3D pvmw.address;
> >>
> >>                 if ((vma->vm_flags & VM_LOCKED) &&
> >> -                   (!folio_test_large(folio) || !pvmw.pte)) {
> >> +                   (!folio_test_large(folio) || !pvmw.pte ||
> >> +                   folio_in_range(folio, vma, vma->vm_start, vma->vm_=
end))) {
> >>                         /* Restore the mlock which got missed */
> >>                         mlock_vma_folio(folio, vma, !pvmw.pte);
> >>                         page_vma_mapped_walk_done(&pvmw);
> >
> > It needs to bail out if large but not within range so that the
> > references within the locked VMA can be ignored. Otherwise, a hot
> > locked portion can prevent a cold unlocked portion from getting
> > reclaimed.
> Good point. We can't bail out here as return here means folio should
> not be reclaimed. My understanding is that we should skip the entries
> which is in the range of VM_LOCKED VMA. Will address this in coming
> version. Thanks.

Yes, that's what I mean. A wrapper would be cleaner:

    while () {
        ...
        if (vma->vm_flags & VM_LOCKED) {
            if (cant_mlock())
                goto next;
            ...
            return false;
        }
        ...
  next:
        pra->mapcount--;
    }
