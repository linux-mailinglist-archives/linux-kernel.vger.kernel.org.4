Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07290748B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjGESPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjGESPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:15:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0AC173F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:15:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso7973043276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688580902; x=1691172902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN+8m1ObowZ74/MLZ++4zNOVgKxyk4abeoHHzPL0ezY=;
        b=4TFMCjMv9iG+yqvy1BZCXvPVHaAAiUMgSlESlQ24abzZb75mpvo4noUD94rWEbxSwN
         2Dlz8AWTMjrSG4gawG4Uh6ULXX+zF17/kLnPeMF1MCgbYmbB6+zq2cO418wb9Xi7Ffjt
         vvBykSdfuu+sRbQU5SCWpWrlzrjNPXjxI5avEpX3nxHQGa6Wmh4i0wG2pi4KEdqW1qNS
         tta+EW2l09KXS+jEIZFzV3NaW7CAg7cSqRBw768qp7KoyC+dUhLwH3L8IHjR9Q4vU0Wh
         PoK+i/B5EHpcdwlqwH5hK4aAvpfmUemy0RRP54JpB8jaV/4bwUnwBUXTw42Axmxfy0ed
         Gdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580902; x=1691172902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN+8m1ObowZ74/MLZ++4zNOVgKxyk4abeoHHzPL0ezY=;
        b=D1t7diYx1XXLJgk+p3Ya+1tb5ZEou7cIJ+VpgLEtWNhGaZOLjLWhm/K7lZQfm4v3wl
         SwebI5m+2Ay4/8goAXyiOWxD31QGv3pqkE7PyUdMyNgfksw8uVS1mpdZwwNgNqNcDP0C
         xBr7ltF1m+bwpz3JuFUlrLVINGEv0oKij/crh9khRQr1ldHtcTdOGhsGf31bpIgkr9Oz
         j47CrEIo92MrIZARIfStNirhdyyHg1SIjKRUDshkxiemNWhSbHoaDSsBTONiTLi3CmNR
         iipJVOdb77z4xVNSRN0YIO0ILE8sC5yBwj7A7k7DfWL8D63hgItdKEPMxGLhazlLf+Dh
         GVvA==
X-Gm-Message-State: ABy/qLalcBV/yea6zfMqWlHuUlSBBoYN6SML077R3kr7Zf9f933AX6jx
        AmlIpmNIXQUBsiNPoCCwFq0AQ8qIoY5aDUqD2nCfCg==
X-Google-Smtp-Source: APBJJlEmDjvoEme69I8YCn0M78cljJMU1hQs/lP0iWGg79WAt9uupvyQmLpjOx+Bgg5NHy46qtYnpkRlzLRzoRRjbnU=
X-Received: by 2002:a25:cfd3:0:b0:c4e:48eb:b8d4 with SMTP id
 f202-20020a25cfd3000000b00c4e48ebb8d4mr10899950ybg.27.1688580902461; Wed, 05
 Jul 2023 11:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <e4f64aa8-93f5-e731-5d6f-e37ae373c006@redhat.com> <CAJuCfpGSt-P6NzTDa8HG6tBKac4Y4Rhkiwcz+80x6aTmVCNS1Q@mail.gmail.com>
In-Reply-To: <CAJuCfpGSt-P6NzTDa8HG6tBKac4Y4Rhkiwcz+80x6aTmVCNS1Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 11:14:51 -0700
Message-ID: <CAJuCfpHdw0rMfuYhAEAp_LC3sMUsBDmaKD_NU9hX8z5TH-CBxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 11:09=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 5, 2023 at 10:24=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 05.07.23 19:22, Suren Baghdasaryan wrote:
> > > On Wed, Jul 5, 2023 at 10:16=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> > >>
> > >> On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > >>> A memory corruption was reported in [1] with bisection pointing to =
the
> > >>> patch [2] enabling per-VMA locks for x86.
> > >>> Disable per-VMA locks config to prevent this issue while the proble=
m is
> > >>> being investigated. This is expected to be a temporary measure.
> > >>>
> > >>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > >>> [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@go=
ogle.com
> > >>>
> > >>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > >>> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3c=
df51b@kernel.org/
> > >>> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > >>> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handlin=
g first")
> > >>> Cc: stable@vger.kernel.org
> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>> ---
> > >>>    mm/Kconfig | 3 ++-
> > >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/mm/Kconfig b/mm/Kconfig
> > >>> index 09130434e30d..0abc6c71dd89 100644
> > >>> --- a/mm/Kconfig
> > >>> +++ b/mm/Kconfig
> > >>> @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
> > >>>           def_bool n
> > >>>
> > >>>    config PER_VMA_LOCK
> > >>> -     def_bool y
> > >>> +     bool "Enable per-vma locking during page fault handling."
> > >>>        depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> > >>> +     depends on BROKEN
> > >>>        help
> > >>>          Allow per-vma locking during page fault handling.
> > >>>
> > >> Do we have any testing results (that don't reveal other issues :) ) =
for
> > >> patch #1? Not sure if we really want to mark it broken if patch #1 f=
ixes
> > >> the issue.
> > >
> > > I tested the fix using the only reproducer provided in the reports
> > > plus kernel compilation and my fork stress test. All looked good and
> > > stable but I don't know if other reports had the same issue or
> > > something different.
> >
> > Can you point me at the other reports, so I can quickly scan them?
>
> by Jacob Young: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> by Jiri Slaby: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3=
cdf51b@kernel.org/

From strace in https://lore.kernel.org/all/f7ad7a42-13c8-a486-d0b7-01d5acf0=
1e13@kernel.org/
looks like clone3() was involved, so this seems quite likely to be the
same issue I think.

> by Holger Hoffst=C3=A4tte:
> https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@applied-=
asynchrony.com/
> only saying that Firefox started crashing after upgrading to 6.4.1
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
