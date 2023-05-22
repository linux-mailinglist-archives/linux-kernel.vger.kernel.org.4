Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3241570B305
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjEVCHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:07:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E56B7
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:07:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso4049424e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684721220; x=1687313220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o1JrsfH1Q1L+OLEEIhjvDhMdiV4AbRg16ZMJOJ+nHY=;
        b=kVzRmtd6i2buheixqrgAOax4f4kpjb76V9Ixbx26N5o/+a+1FjWyyPtM/pUfPgBcoc
         K+/3ZH4NiFk7uXkM8pULDTHnCfSRShYBnHKdJbnokgrGLu/moytD1ZXQ3bkPoO12Rrv4
         01Xn5pvUacT8lj9A+kNWNxHKqlbTX6dB2IXFF1iawEO9OLxEWs7TQzoHJ0YCrsK1vqti
         a5J54G8mhMdyCRFjWJjbhxLjL9ENsOtiQBJEWTqzBtzderjmSHNvsXkh2SfNeHAQ08Dx
         M8fCS59GFwRB4qd/zi3Z/AcY+QvUGu41eO1S9wiShcm0RtJ3kJobNyjKTTJTDWjxiyOa
         gROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684721220; x=1687313220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o1JrsfH1Q1L+OLEEIhjvDhMdiV4AbRg16ZMJOJ+nHY=;
        b=Jg8kwi3OLFl6AVFYz7P7kuRVFw8fnHRhzmv8LeHYuL58TahvaLw3F6vDvAh/qS6IJG
         KwomwkYjibt5i2K6vWdoTfj0nVldngjHZC7vWIYZQ0wkNPz1pOR+SMA7uNxLQLRN0n/b
         9un4tv5DgVoxQjGhIlup7OcF3h3jwkmT/lhYNLp+9K3MJ95S1foX0XkBCgwkdWleLgLO
         PQkFrQ2klOk77NXyuPULtucwBmDlim1ygwTt1JsE+3b4RdZ/aBPc6CYUSYp5QAEsD5hv
         YWXmH5tTFGfG8g1tjdokoJ9mhnexcbV5gTMmtxNaUIV9n17qWjQNw2gEdHSXMsk2Eo/z
         CoHQ==
X-Gm-Message-State: AC+VfDy4qQUY8sZCXRubNWI7/ed0EnOVDF9ENvqODXOWYPJbclKEKM5n
        oOA2wDgrt/gyRZrV9kgCjCiLIWPuVnrW5FMVRgc=
X-Google-Smtp-Source: ACHHUZ7tkAXmXic6xNcvkj2mJE66oK6OWHVz0mbiH/WtLvmfg3UzSWjX3vTz+xrFii60C0yRQiohFDYY30H+caH/dwI=
X-Received: by 2002:a19:c218:0:b0:4f4:b05c:dbca with SMTP id
 l24-20020a19c218000000b004f4b05cdbcamr368005lfc.66.1684721220062; Sun, 21 May
 2023 19:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <1684143495-12872-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznFVeCYUCXg4JZ78pjXp9gBUWAUzyGntVT+kkPRydxmS6A@mail.gmail.com> <20230519145839.3b5193e6accf3b13fd619a07@linux-foundation.org>
In-Reply-To: <20230519145839.3b5193e6accf3b13fd619a07@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 22 May 2023 10:06:36 +0800
Message-ID: <CAGWkznEqrXZnK4j3-n-yEUeFfxjwmFE_pCKyomH9WD7CEv_xRQ@mail.gmail.com>
Subject: Re: [Resend PATCHv2] mm: skip CMA pages when they are not available
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
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

On Sat, May 20, 2023 at 5:58=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 19 May 2023 16:41:41 +0800 Zhaoyang Huang <huangzhaoyang@gmail.co=
m> wrote:
>
> > any comments?
>
> Have any of the regular CMA developers commented on a version of this?
None comments until now. IMO, it is mainly affect reclaiming process.
>
>
> I have a couple of little complaints:
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bd6637f..19fb445 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
> >         unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
> >         unsigned long skipped =3D 0;
> >         unsigned long scan, total_scan, nr_pages;
> > +       bool cma_cap =3D true;
> > +       struct page *page;
> >         LIST_HEAD(folios_skipped);
> >
> >         total_scan =3D 0;
> >         scan =3D 0;
> > +       if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
> > +               && (gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE)=
)
> > +               cma_cap =3D false;
> > +
>
> A code comment above this alteration would be good.  Tell the reader
> why we're doing this.
ok, will update
>
>
> >         while (scan < nr_to_scan && !list_empty(src)) {
> >                 struct list_head *move_to =3D src;
> >                 struct folio *folio;
> > @@ -2239,12 +2245,17 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
> >                 nr_pages =3D folio_nr_pages(folio);
> >                 total_scan +=3D nr_pages;
> >
> > -               if (folio_zonenum(folio) > sc->reclaim_idx) {
> > +               page =3D &folio->page;
> > +
> > +               if ((folio_zonenum(folio) > sc->reclaim_idx)
> > +#ifdef CONFIG_CMA
> > +                       || (get_pageblock_migratetype(page) =3D=3D MIGR=
ATE_CMA && !cma_cap)
> > +#endif
> > +               ) {
> >                         nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> >                         move_to =3D &folios_skipped;
> >                         goto move;
> >                 }
>
> That's pretty ugly.  Can we use IS_ENABLED(CONFIG_CMA) here to avoid
> the ifdef?
ok
>
