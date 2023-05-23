Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DBB70D0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjEWBvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjEWBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:51:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4498E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:51:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510ddeab704so452167a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684806707; x=1687398707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hs7tg2jdqzr5NGkltllPirVALS3mHNLc1Hpq69tUjGE=;
        b=XQXFPk9o6s/r0/yeMiG5RLms940VlSGR/JhHVMgkf2YWwh/laKdVFHaKXQqpawiQIL
         rBZxwNInosp3sp2dH+etUhALzyiksgBpjUAx54d6xJ1gaq1QZaEZZBiI0VqHQT2t2b/O
         0hsjpNZOyZWsubXNUo6YRsJ50/VRdIDLPKUh7rv7CioKwp29k2bgP3IaudWxDeej7orx
         2SGs2SrOfHVsmFbs2HwMu/9ATEJy0Oq7lrewqwUrjR6fZOUNVdsmF7FLA9CkqU/sYIL0
         wJ1F0nBvZpwAcoGqlW3Z7hdqj7zKPXC+o/VGf7Zz4cGnbPEXzyM4zQk5iaBK4Y5FO29/
         Z2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806707; x=1687398707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs7tg2jdqzr5NGkltllPirVALS3mHNLc1Hpq69tUjGE=;
        b=L7/7S3+36AUZt2SX6W/DRU/a3csZBrqr6sEpSNDOQhZer7IhmPlnpz6LX6mWKEDQXe
         0T+gb4+mn0GCKmWtEBugtuQU6XGkvYvXZNB1AHArwiDDTdSVTaOmwrIj1Aavw41+oT34
         YfjajEaq9OB3a3HePupi+lKo9PC4dSb481EezHNs0hevCchqwlO8oeQ5Y6GXoGQJTSH1
         HgllNXqC5G/c8krdwFEuadCTDPNUqLl9VKAU9tBiKam6GORkZfHB0Y9Kxu72zkSENNC/
         mx2+UPIpG91SSe4oOl3wjGCWZMFYKctJ9cVtHOjymT9FEl12DjkW1USyuHkKFtpyVeqs
         eEzQ==
X-Gm-Message-State: AC+VfDwAWxwflpSbOufGi0BIItF3mkJseb6jiscVjMz2Q9TgOC6F+O2i
        f/ufXm+9bLXoiFxLh+ySrpO4XddMNw25iqWZhOo77pggeH0UBP/SoLk=
X-Google-Smtp-Source: ACHHUZ77abnn8KR+G76CdbPatTKmqLAf2PTmyQGrpcgTzQoltjr8/iNKku8pzldM5XoRWUFur/0WFDzfjxBAZOllaRE=
X-Received: by 2002:a17:907:709:b0:965:6075:d0e1 with SMTP id
 xb9-20020a170907070900b009656075d0e1mr11522851ejb.72.1684806707390; Mon, 22
 May 2023 18:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230522070905.16773-1-ying.huang@intel.com> <20230522070905.16773-2-ying.huang@intel.com>
 <CAJD7tkYUOHWFOTouv6WsGnzsBhJzm7OHi--RgujWH0ZabZwqHw@mail.gmail.com> <877cszyg2m.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <877cszyg2m.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 22 May 2023 18:51:10 -0700
Message-ID: <CAJD7tkZKvHTqqewGSqUrqL25qpx4T_QuMz3DKetK3zZTmP77EA@mail.gmail.com>
Subject: Re: [PATCH -V2 1/5] swap: Remove get/put_swap_device() in __swap_count()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
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

On Mon, May 22, 2023 at 6:48=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, May 22, 2023 at 12:09=E2=80=AFAM Huang Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> __swap_count() is called in do_swap_page() only, which encloses the
> >> call site with get/put_swap_device() already.
> >>
> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >> Cc: Yang Shi <shy828301@gmail.com>
> >> Cc: Yu Zhao <yuzhao@google.com>
> >> ---
> >>  mm/swapfile.c | 10 ++--------
> >>  1 file changed, 2 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index 274bbf797480..8419cba9c192 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -1432,16 +1432,10 @@ void swapcache_free_entries(swp_entry_t *entri=
es, int n)
> >>
> >
> > nit: I would add a comment here that the caller needs get/put_swap_devi=
ce().
>
> It's default behavior to call get/put_swap_device() in the caller for
> all almost all swap functions.  I would rather comment the swap
> functions needn't to do that, as the comments for
> read_swap_cache_async() in [2/5].

Fair enough. The comment that you added above get_swap_device() states
that all swap-related functions should have some sort of protection
against swapoff, so I guess that's sufficient.

My concern is that sometimes people don't know where to look, and
having a comment above the function might be helpful. I do agree
though that having a comment above ~all swap-related functions
pointing to the comment above get_swap_device() is too much.

>
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
> Thanks!
>
> >>  int __swap_count(swp_entry_t entry)
> >>  {
> >> -       struct swap_info_struct *si;
> >> +       struct swap_info_struct *si =3D swp_swap_info(entry);
> >>         pgoff_t offset =3D swp_offset(entry);
> >> -       int count =3D 0;
> >>
> >> -       si =3D get_swap_device(entry);
> >> -       if (si) {
> >> -               count =3D swap_count(si->swap_map[offset]);
> >> -               put_swap_device(si);
> >> -       }
> >> -       return count;
> >> +       return swap_count(si->swap_map[offset]);
> >>  }
> >>
> >>  /*
>
> Best Regards,
> Huang, Ying
