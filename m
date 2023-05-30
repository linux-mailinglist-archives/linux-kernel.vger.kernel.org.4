Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66854716C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjE3S1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjE3S1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:27:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F9E4C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:27:22 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6261616efd2so15794696d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685471241; x=1688063241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgX1FQ0z8o/q+NS4H/4WUbgQk3q74ANklOJUqgkv+F4=;
        b=mhdTq7lwqRXFPgouNWrj3sd3x47u+PVzoR/3WdAaU3N+crD+MwB7Qm0kdEkPLHjqjW
         W4F0duuGeDlidiDPIdJ/Y+tpet57jzCFYNQys4CBusazL+U/2RosfxnMn3TZkfnXc3hb
         m0ngGLoWLTKG2IbAqGdSMWnNVG2q1YLH16Fmbdl2azcthxLwBE5aruMT6JPRYr4eEPRk
         XwqHJVbPzMoe9kQDYpGxGtAhheouckh19XowqaLvhotx98KARim8+I/KxfT+SQPS9D1K
         cSHjZ7NTQOLi432RnCLWNMpXNbnnVJ/jad8fTU0cNg+lVM+lqvwQrEyGtTIFPqTTpI9Q
         Ru5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685471241; x=1688063241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgX1FQ0z8o/q+NS4H/4WUbgQk3q74ANklOJUqgkv+F4=;
        b=ireVKZtAxyeKVdscwhgKI4V3+NJPR/m4+BeQAsJPWuqTisPfHQQsYfGUZGGv6Mq5I8
         QUIAZ97b3fhTG8RtMFV3B3rh+WLktI01ISAqqJKXm5HS+1hOfxOOx1Aq8lTtkmOJSU3e
         YkMb972UQUoJEyyMcNj6c86aNucDD/8Gd5HUD6e5+TAdCLAoRZzngDtafUc84/VQOidJ
         4Sl37BTwsp5cEdm2eMGRqqzF1m64UgGnbf3PvUtCsrrG7DrZYWX/XcVa71p/V9Sl0juT
         hRqhoZdWLyJc9HRDISwtC17Fb9Yuv+lntxiBnzhX70GnhVDJXCtquw9QBrvcn53/BI6p
         FO+g==
X-Gm-Message-State: AC+VfDx9C35k+QE5BxjrK9klLWeTQUUAxZkmetgNIlaMWJNzI5aMj9s0
        PjDmvIxovllIb3nttascbzp7ZvWR5krZ5XP2kK4=
X-Google-Smtp-Source: ACHHUZ7JWv5UFJgNlPKuN5ECgH8o17J83GhtqrLglAJUcmV9Ngrua9ObhQyYFWsv6JmkVRvum5VYSG1wQ6L3MzlZA5g=
X-Received: by 2002:a05:6214:2627:b0:623:c96a:e735 with SMTP id
 gv7-20020a056214262700b00623c96ae735mr3740707qvb.1.1685471241425; Tue, 30 May
 2023 11:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com> <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
In-Reply-To: <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 30 May 2023 11:27:10 -0700
Message-ID: <CAKEwX=OK5qK9DTYLKZUefE0eq8KooygT-nbkgUZaYjK72SKzFQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
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

On Tue, May 30, 2023 at 9:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, May 30, 2023 at 9:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > Before storing a page, zswap first checks if the number of stored pages
> > exceeds the limit specified by memory.zswap.max, for each cgroup in the
> > hierarchy. If this limit is reached or exceeded, then zswap shrinking i=
s
> > triggered and short-circuits the store attempt.
> >
> > However, if memory.zswap.max =3D 0 for a cgroup, no amount of writeback
> > will allow future store attempts from processes in this cgroup to
> > succeed. Furthermore, this create a pathological behavior in a system
> > where some cgroups have memory.zswap.max =3D 0 and some do not: the
> > processes in the former cgroups, under memory pressure, will evict page=
s
> > stored by the latter continually, until the need for swap ceases or the
> > pool becomes empty.
> >
> > As a result of this, we observe a disproportionate amount of zswap
> > writeback and a perpetually small zswap pool in our experiments, even
> > though the pool limit is never hit.
> >
> > This patch fixes the issue by rejecting zswap store attempt without
> > shrinking the pool when memory.zswap.max is 0.
> >
> > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/memcontrol.h | 6 +++---
> >  mm/memcontrol.c            | 8 ++++----
> >  mm/zswap.c                 | 9 +++++++--
> >  3 files changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 222d7370134c..507bed3a28b0 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(struct obj=
_cgroup *objcg,
> >  #endif /* CONFIG_MEMCG_KMEM */
> >
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
> >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> >  #else
> > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >  {
> > -       return true;
> > +       return 0;
> >  }
> >  static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
> >                                            size_t size)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 4b27e245a055..09aad0e6f2ea 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] =3D {
> >   * spending cycles on compression when there is already no room left
> >   * or zswap is disabled altogether somewhere in the hierarchy.
> >   */
> > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >  {
> >         struct mem_cgroup *memcg, *original_memcg;
> > -       bool ret =3D true;
> > +       int ret =3D 0;
> >
> >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >                 return true;
> > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objc=
g)
> >                 if (max =3D=3D PAGE_COUNTER_MAX)
> >                         continue;
> >                 if (max =3D=3D 0) {
> > -                       ret =3D false;
> > +                       ret =3D -ENODEV;
> >                         break;
> >                 }
> >
> > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objc=
g)
> >                 pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE=
_SIZE;
> >                 if (pages < max)
> >                         continue;
> > -               ret =3D false;
> > +               ret =3D -ENOMEM;
> >                 break;
> >         }
> >         mem_cgroup_put(original_memcg);
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 59da2a415fbb..7b13dc865438 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned type, =
pgoff_t offset,
> >         }
> >
> >         objcg =3D get_obj_cgroup_from_page(page);
> > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > -               goto shrink;
> > +       if (objcg) {
> > +               ret =3D obj_cgroup_may_zswap(objcg);
> > +               if (ret =3D=3D -ENODEV)
> > +                       goto reject;
> > +               if (ret =3D=3D -ENOMEM)
> > +                       goto shrink;
> > +       }
>
> I wonder if we should just make this:
>
> if (objcg && !obj_cgroup_may_zswap(objcg))
>         goto reject;
>
> Even if memory.zswap.max is > 0, if the limit is hit, shrinking the
> zswap pool will only help if we happen to writeback a page from the
> same memcg that hit its limit. Keep in mind that we will only
> writeback one page every time we observe that the limit is hit (even
> with Domenico's patch, because zswap_can_accept() should be true).
>
> On a system with a handful of memcgs,
> it seems likely that we wrongfully writeback pages from other memcgs
> because of this. Achieving nothing for this memcg, while hurting
> others. OTOH, without invoking writeback when the limit is hit, the
> memcg will just not be able to use zswap until some pages are
> faulted back in or invalidated.
>
> I am not sure which is better, just thinking out loud.
>
> Seems like this can be solved by having per-memcg LRUs, or at least
> providing an argument to the shrinker of which memcg to reclaim from.
> This would only be possible when the LRU is moved to zswap.

I totally agree! This seems like the logical next step in zswap's evolution=
.
I actually proposed this fix with this future development in mind - with
a per-memcg LRU, we can trigger memcg-specific shrinking in
place of this indiscriminate writeback. It seems less drastic a change
(compared to removing shrinking here now, then reintroducing it later).

Thanks for the feedback, Yosry!

>
>
> >
> >         /* reclaim space if needed */
> >         if (zswap_is_full()) {
> > --
> > 2.34.1
> >
> >
