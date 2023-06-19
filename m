Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E064B734AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjFSEAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFSEAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:00:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EAFC5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:00:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso4213459a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687147229; x=1689739229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj0loivS4oUf7RkNDVjtH35pM6SVj82a3/WxNIXAr94=;
        b=liNxIXCOPgV0NXaraug6RWYcJpcRYj/gogLh22/imSmj/o9B8I42UgxL2hbVFWj0NX
         kELdD5bdOmOY4wJ3wdTqQb35Q4WWqtrzYnxc/FUU6MvlgO3kzqYNksV5egxh2xUJuBWx
         FvLXnJOa+5nsy9VOptpTVnpOZDvDKZmSe4kAR1HqqnOLlM+oT7zQg5QJCHVH01E37MoJ
         R1Qyq1btLvmj2rNuH0oAZZ+O+bTCKstqiEvGIOUuY1QduSDsDR/EMOs8kmQylmQhKq9N
         5lngynipHCqoFhfdO2doPxFUKCovaQbqbN9SUD0/jM/8R/7Rc6d5BulHeEqWTqchn0oC
         BCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147229; x=1689739229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj0loivS4oUf7RkNDVjtH35pM6SVj82a3/WxNIXAr94=;
        b=DJ8uTKzeHxdy356k+xfZTlKK04KscjyocR11MC0inNLAEG32TQ9MyLVCd8aZApdWNd
         mz8Lg/N1aCtRon0aGgrmle4UPwtjX4R9EanrFLA5X8hZNgTgK/sjx+lxN5RocIz92fdt
         aF5M5iqfsOhw4Us6gfKKxjKJetQW1/rIsO99ozKuhbXIOj2qQPrFhUwZq0jdbg4mPIBG
         PL+o0ngro7CDNwO9JvweKSBrjQjYGrfnFiUQcyCJD0FWGfHoz4a0r6vAlbklqDkizH5Q
         PLatViDoYBf3HWbqrCEhZfnZKKFrSaZCc5FiQZj9ky5eLuP+3NnaaaGfPEpWOi8X6agV
         QNsg==
X-Gm-Message-State: AC+VfDwPHgi9+YElsVQUWvETziQ23zcr4SJriHnhdtmoF03q0nvZnCxr
        +XjdWBQ25SR+eq/vXlcpNqacvIGQszDXyeY8VZGR8g==
X-Google-Smtp-Source: ACHHUZ5AmF5iJZMsMI1kC6TL3hPNZj5ewdCazp5jw+M7S8VBSd7CV2CIuRwo6cjXS2po4KnZwjvWnYnQdHznS39Qu3k=
X-Received: by 2002:a17:907:7245:b0:982:a454:6d24 with SMTP id
 ds5-20020a170907724500b00982a4546d24mr7929914ejc.74.1687147228860; Sun, 18
 Jun 2023 21:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230618065824.1365750-1-yosryahmed@google.com> <87ilbk8b89.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ilbk8b89.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 18 Jun 2023 20:59:52 -0700
Message-ID: <CAJD7tkaiMWVHfam-j8v2i+0c8+BqKT=h=hv16-Ngz3u+7qJmaA@mail.gmail.com>
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

On Sun, Jun 18, 2023 at 7:00=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Yosry,
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > This reverts commit c3096e6782b733158bf34f6bbb4567808d4e0740.
> >
> > That commit made sure we immediately add the new page to the LRU before
> > remove_migration_ptes() is called in migrate_move_folio() (used to be
> > __unmap_and_move() back then), such that the rmap walk will rebuild the
> > correct mlock_count for the page again. This was needed because the
> > mlock_count was lost when the page is isolated. This is no longer the
> > case since mlock_count no longer overlays page->lru.
> >
> > Revert the commit (the code was foliated afterward the commit, so the
> > revert is updated as such).
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/migrate.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 01cac26a3127..68f693731865 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1279,19 +1279,6 @@ static int migrate_folio_move(free_page_t put_ne=
w_page, unsigned long private,
> >       if (unlikely(!is_lru))
> >               goto out_unlock_both;
>
> The patch itself looks good to me!  Thanks!
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thanks for taking a look!

>
> And, it seems that we can remove the above 2 lines and "out_unlock_both"
> label now.  That can make the code simpler a little.  Right?

I am not familiar with this code. If we remove the above condition
then pages that have is_lru =3D=3D 0 (i.e __PageMovable(src) is true) and
page_was_mapped =3D=3D 1 will call remove_migration_ptes(). This wouldn't
happen without removing the above 2 lines. If this combination is
impossible (is_lru =3D=3D 0 && page_was_mapped =3D=3D 1), then yeah we can
remove the above condition.

It looks like __SetPageMovable() is only called by zsmalloc, z3fold,
and balloon_page_insert(). The former 2 will never have those pages
mapped into userspace. I am not familiar with balloon_page_insert(),
but my gut feeling is that those are pages used by the driver and are
also not mapped into userspace.

So I guess we can just remove the condition, but a confirmation for
the above would be reassuring :)

>
> Best Regards,
> Huang, Ying
>
> > -     /*
> > -      * When successful, push dst to LRU immediately: so that if it
> > -      * turns out to be an mlocked page, remove_migration_ptes() will
> > -      * automatically build up the correct dst->mlock_count for it.
> > -      *
> > -      * We would like to do something similar for the old page, when
> > -      * unsuccessful, and other cases when a page has been temporarily
> > -      * isolated from the unevictable LRU: but this case is the easies=
t.
> > -      */
> > -     folio_add_lru(dst);
> > -     if (page_was_mapped)
> > -             lru_add_drain();
> > -
> >       if (page_was_mapped)
> >               remove_migration_ptes(src, dst, false);
> >
> > @@ -1301,9 +1288,16 @@ static int migrate_folio_move(free_page_t put_ne=
w_page, unsigned long private,
> >       /*
> >        * If migration is successful, decrease refcount of dst,
> >        * which will not free the page because new page owner increased
> > -      * refcounter.
> > +      * refcounter. As well, if it is LRU folio, add the folio to LRU
> > +      * list in here. Use the old state of the isolated source folio t=
o
> > +      * determine if we migrated a LRU folio. dst was already unlocked
> > +      * and possibly modified by its owner - don't rely on the folio
> > +      * state.
> >        */
> > -     folio_put(dst);
> > +     if (unlikely(!is_lru))
> > +             folio_put(dst);
> > +     else
> > +             folio_putback_lru(dst);
> >
> >       /*
> >        * A folio that has been migrated has all references removed
>
