Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51D66EA66C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDUJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDUJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:00:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E554902D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:00:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8aea2a654so13052311fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682067626; x=1684659626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QkvhdTYnDkr/y7u4Tqh+X12AIRQj3eziSNdnEwCKok=;
        b=eQBZDtzuaDLN/OA/t4ek+7wPgfOcN8abW+MeC5aXDdTuL5gahGhH8Y5wG59GuDnNgI
         cpbo2VRYCwn1wqdifg0058q3wwSjogO+UudfmPGO6KZWUCgMamrkUFzuf6+0W1X/61tp
         dR6QRpap1GIlRAB/mGTXkps5DrEZbDeYxoYEFPp96Df8CnHlLWzhwAGvEgV0CANTnblf
         e8fGUh4YrM6RaGF2B+dDdV6Ja2nxmEsWtdmlMVPibbQViM01OJtFwb5bdNTyMOcoB8FN
         tB2Qc9ms+TjIh35QNze1N9jr7Aoe/kmWBCRwJi5V1UWqWxOhmARDbbHS06jyAmJ3QP1e
         YZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067626; x=1684659626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QkvhdTYnDkr/y7u4Tqh+X12AIRQj3eziSNdnEwCKok=;
        b=kdGMtxL8uD/bHOAVpS1aCnmkMZwuVPkMzSjrAeWw3Od4pvDgtFHS59m21pwJmAr0q3
         3OcbTjbIM2h4CTxujI6hEhioXPbGe+jkF0hMdVI3RnYGfOfXgFXGDPQrcbEWZdlLCUBO
         VtTGe3fshbFlGSwRWtVTSYnmkQE8HQHqjO0TqZJiX9evS15UNoBTONSmKAN/pOl6+zyp
         6ea1vXhdi4DrY1WVANa19KMJl+H68i1yy+BrXKBtczIDBIxt1CILQkBOXbHUdtQJfXeR
         wb3q0kvZQ2ngiNpUkAtqdrWMwaApe9+hx+aMajFeYyltkNzzVKJGF/k1G58eMgBb/0SY
         9AmQ==
X-Gm-Message-State: AAQBX9cZzDqRRRvoymBihXcE3kC+NmYi6LP8TiRSKoP8O3G250fSC2X3
        KMuw9HMET6PVObdp4XPYQNEnIeSBb8NtB2Q7Hk4=
X-Google-Smtp-Source: AKy350aq0fn25/npLop7sLmFVfMvWGQbZlqKXRn7b8pxRcAcj73FeZmbTwiyuZUs7/nMCVulR93/EPCanb6efbkz8cU=
X-Received: by 2002:a2e:6806:0:b0:2a8:bc08:a9a3 with SMTP id
 c6-20020a2e6806000000b002a8bc08a9a3mr488323lja.28.1682067626234; Fri, 21 Apr
 2023 02:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com> <87v8hpspge.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v8hpspge.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 21 Apr 2023 17:00:04 +0800
Message-ID: <CAGWkznEt1mNWwA0aVmyH=oVFdVw4TCZYH+BYgim=V4z+4=oVvw@mail.gmail.com>
Subject: Re: [PATCHv2] mm: skip CMA pages when they are not available
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 2:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> "zhaoyang.huang" <zhaoyang.huang@unisoc.com> writes:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > This patch fixes unproductive reclaiming of CMA pages by skipping them =
when they
> > are not available for current context. It is arise from bellowing OOM i=
ssue, which
> > caused by large proportion of MIGRATE_CMA pages among free pages. There=
 has been
> > commit(168676649) to fix it by trying CMA pages first instead of fallba=
ck in
> > rmqueue. I would like to propose another one from reclaiming perspectiv=
e.
> >
> > 04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page al=
location failure: order:0, mode:0xc00(GFP_NOIO), nodemask=3D(null),cpuset=
=3Dforeground,mems_allowed=3D0
> > 0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C)=
 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (=
C) 0*1024kB 0*2048kB 0*4096kB =3D 35848kB
> > 0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 4=
9*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB =
(H) 0*1024kB 0*2048kB 0*4096kB =3D 3236kB
> >       ......
> > 041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate=
 memory on node -1, gfp=3D0xa20(GFP_ATOMIC)
> > 041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, obje=
ct size: 64, buffer size: 64, default order: 0, min order: 0
> > 041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: =
3392, free: 0
>
> From the above description, you are trying to resolve an issue that has
> been resolved already.  If so, why do we need your patch?  What is the
> issue it try to resolve in current upstream kernel?

Please consider this bellowing sequence as __perform_reclaim() return
with reclaiming 32 CMA pages successfully and then lead to
get_page_from_freelist failure if MIGRATE_CMA is NOT over 1/2 number
of free pages which will then unreserve H pageblocks and drain percpu
pageset. right? Furthermore, this could also introduce OOM as
direct_reclaim is the final guard for alloc_pages.

*did_some_progress =3D __perform_reclaim(gfp_mask, order, ac);

retry:
page =3D get_page_from_freelist(gfp_mask, order, alloc_flags, ac);

if (!page && !drained) {
unreserve_highatomic_pageblock(ac, false);
drain_all_pages(NULL);
drained =3D true;
goto retry;
}

return page;
>
> At the first glance, I don't think your patch doesn't make sense.  But
> you really need to show the value of the patch.
>
> Best Regards,
> Huang, Ying
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: update commit message and fix build error when CONFIG_CMA is not se=
t
> > ---
> > ---
> >  mm/vmscan.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bd6637f..19fb445 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
> >       unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
> >       unsigned long skipped =3D 0;
> >       unsigned long scan, total_scan, nr_pages;
> > +     bool cma_cap =3D true;
> > +     struct page *page;
> >       LIST_HEAD(folios_skipped);
> >
> >       total_scan =3D 0;
> >       scan =3D 0;
> > +     if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
> > +             && (gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE))
> > +             cma_cap =3D false;
> > +
> >       while (scan < nr_to_scan && !list_empty(src)) {
> >               struct list_head *move_to =3D src;
> >               struct folio *folio;
> > @@ -2239,12 +2245,17 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
> >               nr_pages =3D folio_nr_pages(folio);
> >               total_scan +=3D nr_pages;
> >
> > -             if (folio_zonenum(folio) > sc->reclaim_idx) {
> > +             page =3D &folio->page;
> > +
> > +             if ((folio_zonenum(folio) > sc->reclaim_idx)
> > +#ifdef CONFIG_CMA
> > +                     || (get_pageblock_migratetype(page) =3D=3D MIGRAT=
E_CMA && !cma_cap)
> > +#endif
> > +             ) {
> >                       nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> >                       move_to =3D &folios_skipped;
> >                       goto move;
> >               }
> > -
> >               /*
> >                * Do not count skipped folios because that makes the fun=
ction
> >                * return with no isolated folios if the LRU mostly conta=
ins
