Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F5741E37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjF2CVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjF2CVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:21:21 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAFF10B;
        Wed, 28 Jun 2023 19:21:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1c162cdfeso149159b6e.2;
        Wed, 28 Jun 2023 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688005278; x=1690597278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySyAmfVhMfVx98sxPbiAVA/jFjbxdrr+oshC1ybeyhc=;
        b=f/AVb8r9xYD3+whHU3qtmPhPa/Wh01Idfg/drHq8Gr6guNSXvXQ/pAjwYbqItSG+Nj
         Z84SzpAh17q6wvr3q2N5ze1fpSRPxUpsP/kxaREQxH076ZEmRHVPam+YCm6P0CDXBKG6
         bVNS+8UJBISeaOmr3dbOLt8PsGF/ZtgGU2Ana6FMCgIF2G6mo13X0pKJi/mfsena8JFL
         udMFLL4DI8r5WrXp8NJ8kEl/TBJXr9bTse16S39f5NY08Xj8hIp0wcv53gbhlKQIc/Vw
         lmaAbiDcW5DHveSlmwuZtRQ61CIXCSUOII2jpAN9w4tXZMimamKxTfOxRlE1VQ4wmzgV
         H1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688005278; x=1690597278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySyAmfVhMfVx98sxPbiAVA/jFjbxdrr+oshC1ybeyhc=;
        b=kpOVKeERNaimrvWR58zM8+QZqnZhst07cyOflZTVlk2g6KAtTqvt6TbiY74kOaF/0c
         a9KKpeNF5SHPfkFlMoQtaqpM7UhQqXdQm+uJ2xHaiPusa9Dt9OunLXdHPWIXe7oUUHqe
         l48AZFNqzvag2iM2AmKNdVtNoDUXzptlQrSJdnrozfOmmo4uoMj48TVIbLific8ZRFa5
         DSKDDnmh/6GcKw1B9wSrmXcMo3Hz4YHkZ4Ho61O7N2Epz/4wFgQ+mJSYZDbRpUiG0uKu
         9XTFKOCISCVSPJrEFwXkeyl/LV5hQQj5Z0FzOuEjS+RPtLYXueAU7BXwyRIBgjx6idyX
         A+zA==
X-Gm-Message-State: AC+VfDwlBLxIY5VGJ0sDmtyjCGkHS7u56z1L2SIq8NeULic1FDIpoPpg
        YRTNrzNQFzemVIrEqMi/9dSZmxMmldun3DmEyxk=
X-Google-Smtp-Source: ACHHUZ7UAQTQw0vu93YPC3yL+Fh5PVTx9pSYuEGC+hZSnUlnYtuDlw64T8GUG8gOF+WXmdmX60xB15SofoDXqSO9ovU=
X-Received: by 2002:aca:1703:0:b0:3a1:d075:348b with SMTP id
 j3-20020aca1703000000b003a1d075348bmr10384323oii.59.1688005278204; Wed, 28
 Jun 2023 19:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <CAOUHufaUTbUw9MTzw8D=sVrEB+RP6LSBQVGn93TWk=ozV8XobA@mail.gmail.com> <CAOUHufa0S_ayrys0XzDbH8KJi5HxvbGCh_bSAhDpAgcmSJjFUQ@mail.gmail.com>
In-Reply-To: <CAOUHufa0S_ayrys0XzDbH8KJi5HxvbGCh_bSAhDpAgcmSJjFUQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 28 Jun 2023 19:21:06 -0700
Message-ID: <CAHbLzkqUD7ABOMVBgW_hZncL3OxZG-8bhfs0H3xK4M=ok_dyQQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] variable-order, large folios for anonymous memory
To:     Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:49=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jun 26, 2023 at 9:30=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> > >
> > > Hi All,
> > >
> > > Following on from the previous RFCv2 [1], this series implements vari=
able order,
> > > large folios for anonymous memory. The objective of this is to improv=
e
> > > performance by allocating larger chunks of memory during anonymous pa=
ge faults:
> > >
> > >  - Since SW (the kernel) is dealing with larger chunks of memory than=
 base
> > >    pages, there are efficiency savings to be had; fewer page faults, =
batched PTE
> > >    and RMAP manipulation, fewer items on lists, etc. In short, we red=
uce kernel
> > >    overhead. This should benefit all architectures.
> > >  - Since we are now mapping physically contiguous chunks of memory, w=
e can take
> > >    advantage of HW TLB compression techniques. A reduction in TLB pre=
ssure
> > >    speeds up kernel and user space. arm64 systems have 2 mechanisms t=
o coalesce
> > >    TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
> > >
> > > This patch set deals with the SW side of things only and based on fee=
dback from
> > > the RFC, aims to be the most minimal initial change, upon which futur=
e
> > > incremental changes can be added. For this reason, the new behaviour =
is hidden
> > > behind a new Kconfig switch, CONFIG_LARGE_ANON_FOLIO, which is disabl=
ed by
> > > default. Although the code has been refactored to parameterize the de=
sired order
> > > of the allocation, when the feature is disabled (by forcing the order=
 to be
> > > always 0) my performance tests measure no regression. So I'm hoping t=
his will be
> > > a suitable mechanism to allow incremental submissions to the kernel w=
ithout
> > > affecting the rest of the world.
> > >
> > > The patches are based on top of v6.4 plus Matthew Wilcox's set_ptes()=
 series
> > > [2], which is a hard dependency. I'm not sure of Matthew's exact plan=
s for
> > > getting that series into the kernel, but I'm hoping we can start the =
review
> > > process on this patch set independently. I have a branch at [3].
> > >
> > > I've posted a separate series concerning the HW part (contpte mapping=
) for arm64
> > > at [4].
> > >
> > >
> > > Performance
> > > -----------
> > >
> > > Below results show 2 benchmarks; kernel compilation and speedometer 2=
.0 (a
> > > javascript benchmark running in Chromium). Both cases are running on =
Ampere
> > > Altra with 1 NUMA node enabled, Ubuntu 22.04 and XFS filesystem. Each=
 benchmark
> > > is repeated 15 times over 5 reboots and averaged.
> > >
> > > All improvements are relative to baseline-4k. 'anonfolio-basic' is th=
is series.
> > > 'anonfolio' is the full patch set similar to the RFC with the additio=
nal changes
> > > to the extra 3 fault paths. The rest of the configs are described at =
[4].
> > >
> > > Kernel Compilation (smaller is better):
> > >
> > > | kernel          |   real-time |   kern-time |   user-time |
> > > |:----------------|------------:|------------:|------------:|
> > > | baseline-4k     |        0.0% |        0.0% |        0.0% |
> > > | anonfolio-basic |       -5.3% |      -42.9% |       -0.6% |
> > > | anonfolio       |       -5.4% |      -46.0% |       -0.3% |
> > > | contpte         |       -6.8% |      -45.7% |       -2.1% |
> > > | exefolio        |       -8.4% |      -46.4% |       -3.7% |
> > > | baseline-16k    |       -8.7% |      -49.2% |       -3.7% |
> > > | baseline-64k    |      -10.5% |      -66.0% |       -3.5% |
> > >
> > > Speedometer 2.0 (bigger is better):
> > >
> > > | kernel          |   runs_per_min |
> > > |:----------------|---------------:|
> > > | baseline-4k     |           0.0% |
> > > | anonfolio-basic |           0.7% |
> > > | anonfolio       |           1.2% |
> > > | contpte         |           3.1% |
> > > | exefolio        |           4.2% |
> > > | baseline-16k    |           5.3% |
> >
> > Thanks for pushing this forward!
> >
> > > Changes since RFCv2
> > > -------------------
> > >
> > >   - Simplified series to bare minimum (on David Hildenbrand's advice)
> >
> > My impression is that this series still includes many pieces that can
> > be split out and discussed separately with followup series.
> >
> > (I skipped 04/10 and will look at it tomorrow.)
>
> I went through the series twice. Here what I think a bare minimum
> series (easier to review/debug/land) would look like:
> 1. a new arch specific function providing a prefered order within (0,
> PMD_ORDER).
> 2. an extended anon folio alloc API taking that order (02/10, partially).
> 3. an updated folio_add_new_anon_rmap() covering the large() &&
> !pmd_mappable() case (similar to 04/10).
> 4. s/folio_test_pmd_mappable/folio_test_large/ in page_remove_rmap()
> (06/10, reviewed-by provided).
> 5. finally, use the extended anon folio alloc API with the arch
> preferred order in do_anonymous_page() (10/10, partially).
>
> The rest can be split out into separate series and move forward in
> parallel with probably a long list of things we need/want to do.

Yeah, the suggestion makes sense to me. And I'd like to go with the
simplest way unless there is strong justification for extra
optimization for the time being IMHO.

>
