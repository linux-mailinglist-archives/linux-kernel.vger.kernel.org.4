Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B17734B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjFSEex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjFSEeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:34:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC12C9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:34:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-982a0232bdcso504993666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687149287; x=1689741287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQlhQ/GJgQzUBNcbs/51oGUQCslwDzBZawZLttFe2zs=;
        b=VrCmPthOaGEQb68j4amXLTUaxHBX8uPSPicAT/kBhVCd0MN5X5YX5/UOecABvefhRr
         naTMzTJ1PrLoyMQfkzHFof9lkTr3iV1J84qHx5ciUnSX+fAU6o/dtK/q/7Pwi785MhSG
         6MSCtS4lnJ0vK3AOjq9+wvRQWZok6apk60qmhtthOsitC5vZ5BArnnm5jFQINxp/oNFm
         QsmB03wEbPHkZaYTmhAWhaUt0SswvngN1vGLVL3/bG3mNajq6vGrVoH+TTqP+7K/y1JN
         QuYutO2fmAegNJB/XHc/abcYThe6NflLccqqrfyRIuseALvzAJSE7RQwFvaD/GmNjB1T
         +7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687149287; x=1689741287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQlhQ/GJgQzUBNcbs/51oGUQCslwDzBZawZLttFe2zs=;
        b=OI3k1arQ22jfXS1Sb+bm5j9xFCqr0XYM6zRERuXyvuRSFwwSttyWD9pwAK2b2PrJKS
         GMOuyWvqpqZLoAnGcw+IJmKs/+zm+DF1FO6W6dIFZcWJnSjp9xPBX/qZ8KU2vTjbwjbb
         oHj1EITQAz73SCckeB1msp7BjA4C1ycRYzSVzjA8b6pIdhCaX1seNDHShHwlAq7pCict
         gj/C4HlsyHSLe4RWA4HW+lcwWCVRw0LA1mCpHkgFgyh3GvK3+CqdXWrTR0j23MvqWdpC
         sVanZ5ga7Z4CjkpCkyc60J2wjDtVyWBqo30Wg2abgoOqm/ty/8p68hB5VMvXKHutrcNL
         i+LQ==
X-Gm-Message-State: AC+VfDwPxfW9nIehVRPos+3fOtxGYRe6lmr25KhrrEKywNTQ5tgFFq9Q
        ib5NUWRxYvf3mXfzdL5L1uEScCSVdES0j7eKJutK/A==
X-Google-Smtp-Source: ACHHUZ46xnLpaELxLld4ks9SpXhnggAeUh/XO8e/tIt2cOVuJsF0TKeKKur5BMys8pQFSn22vNVVegLcr0wvVTlj0tc=
X-Received: by 2002:a17:907:7dab:b0:94e:8559:b5c5 with SMTP id
 oz43-20020a1709077dab00b0094e8559b5c5mr9094566ejc.64.1687149286991; Sun, 18
 Jun 2023 21:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230618065824.1365750-1-yosryahmed@google.com>
 <87ilbk8b89.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkaiMWVHfam-j8v2i+0c8+BqKT=h=hv16-Ngz3u+7qJmaA@mail.gmail.com>
 <87a5ww84b9.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5ww84b9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 18 Jun 2023 21:34:10 -0700
Message-ID: <CAJD7tkakB5nr+AZWJAJLzz8BcvYOa9tSvDWFmKN20cfv+kFPVw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] Revert "mm/migrate: __unmap_and_move() push good
 newpage to LRU"
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
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

On Sun, Jun 18, 2023 at 9:29=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Sun, Jun 18, 2023 at 7:00=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Hi, Yosry,
> >>
> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >>
> >> > This reverts commit c3096e6782b733158bf34f6bbb4567808d4e0740.
> >> >
> >> > That commit made sure we immediately add the new page to the LRU bef=
ore
> >> > remove_migration_ptes() is called in migrate_move_folio() (used to b=
e
> >> > __unmap_and_move() back then), such that the rmap walk will rebuild =
the
> >> > correct mlock_count for the page again. This was needed because the
> >> > mlock_count was lost when the page is isolated. This is no longer th=
e
> >> > case since mlock_count no longer overlays page->lru.
> >> >
> >> > Revert the commit (the code was foliated afterward the commit, so th=
e
> >> > revert is updated as such).
> >> >
> >> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >> > ---
> >> >  mm/migrate.c | 24 +++++++++---------------
> >> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >> >
> >> > diff --git a/mm/migrate.c b/mm/migrate.c
> >> > index 01cac26a3127..68f693731865 100644
> >> > --- a/mm/migrate.c
> >> > +++ b/mm/migrate.c
> >> > @@ -1279,19 +1279,6 @@ static int migrate_folio_move(free_page_t put=
_new_page, unsigned long private,
> >> >       if (unlikely(!is_lru))
> >> >               goto out_unlock_both;
> >>
> >> The patch itself looks good to me!  Thanks!
> >>
> >> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >
> > Thanks for taking a look!
> >
> >>
> >> And, it seems that we can remove the above 2 lines and "out_unlock_bot=
h"
> >> label now.  That can make the code simpler a little.  Right?
> >
> > I am not familiar with this code. If we remove the above condition
> > then pages that have is_lru =3D=3D 0 (i.e __PageMovable(src) is true) a=
nd
> > page_was_mapped =3D=3D 1 will call remove_migration_ptes(). This wouldn=
't
> > happen without removing the above 2 lines. If this combination is
> > impossible (is_lru =3D=3D 0 && page_was_mapped =3D=3D 1), then yeah we =
can
> > remove the above condition.
> >
> > It looks like __SetPageMovable() is only called by zsmalloc, z3fold,
> > and balloon_page_insert(). The former 2 will never have those pages
> > mapped into userspace. I am not familiar with balloon_page_insert(),
> > but my gut feeling is that those are pages used by the driver and are
> > also not mapped into userspace.
>
> You can take a look at migrate_folio_unmap(), where "page_was_mapped"
> will not be set to 1 if !is_lru.

Oh I was looking in the wrong place huh, thanks. Will remove it when I resp=
in!

>
> Best Regards,
> Huang, Ying
>
> > So I guess we can just remove the condition, but a confirmation for
> > the above would be reassuring :)
> >
> >>
> >> Best Regards,
> >> Huang, Ying
> >>
> >> > -     /*
> >> > -      * When successful, push dst to LRU immediately: so that if it
> >> > -      * turns out to be an mlocked page, remove_migration_ptes() wi=
ll
> >> > -      * automatically build up the correct dst->mlock_count for it.
> >> > -      *
> >> > -      * We would like to do something similar for the old page, whe=
n
> >> > -      * unsuccessful, and other cases when a page has been temporar=
ily
> >> > -      * isolated from the unevictable LRU: but this case is the eas=
iest.
> >> > -      */
> >> > -     folio_add_lru(dst);
> >> > -     if (page_was_mapped)
> >> > -             lru_add_drain();
> >> > -
> >> >       if (page_was_mapped)
> >> >               remove_migration_ptes(src, dst, false);
> >> >
> >> > @@ -1301,9 +1288,16 @@ static int migrate_folio_move(free_page_t put=
_new_page, unsigned long private,
> >> >       /*
> >> >        * If migration is successful, decrease refcount of dst,
> >> >        * which will not free the page because new page owner increas=
ed
> >> > -      * refcounter.
> >> > +      * refcounter. As well, if it is LRU folio, add the folio to L=
RU
> >> > +      * list in here. Use the old state of the isolated source foli=
o to
> >> > +      * determine if we migrated a LRU folio. dst was already unloc=
ked
> >> > +      * and possibly modified by its owner - don't rely on the foli=
o
> >> > +      * state.
> >> >        */
> >> > -     folio_put(dst);
> >> > +     if (unlikely(!is_lru))
> >> > +             folio_put(dst);
> >> > +     else
> >> > +             folio_putback_lru(dst);
> >> >
> >> >       /*
> >> >        * A folio that has been migrated has all references removed
> >>
>
