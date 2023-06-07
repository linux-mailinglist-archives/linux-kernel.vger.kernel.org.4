Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B021C726997
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjFGTRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjFGTRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:17:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7071B0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:17:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977cc662f62so685285066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686165466; x=1688757466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlNPfUGJaJXwGH3zT3CXSvGGYrKjJY2HsEiv2gCp6wE=;
        b=M6gHFChilLuhyziiQ5zZWWjemKbhPpQCL3D4MW9xDElImH0+UaLSYJ+yMom5eNJsWq
         eUpnOweSHmdRU4DSs2Pdfz+WYjHsm+j9GNfNsYShBDbN2R3mHJMPaFGAIhOG/jAQ6XI7
         qWl01TwAzWqbeD9NaVkTAeLLwarteMaWyFR67Btu4kFjIU/fw/+vIyXodS/NoZkJ9c8m
         dQwUUZ4yVT415ffGPtQozlyXXPJUHQdXuVrM/wlUWNAiN5Kayc1ULd+TRDY5dLUUkgNS
         8ksmVl1aYBbWynEQ0bnsh6dWyvOKTaaX4gkBOpiDtNnYgV1WRcMdj4LsWZ5ecRUzIm3p
         Fa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686165466; x=1688757466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlNPfUGJaJXwGH3zT3CXSvGGYrKjJY2HsEiv2gCp6wE=;
        b=ZVe877EfzbX4ZrnPlN11QNdaAWVHNAFq5kCltOm30HicsR0ndKLCyA4BOyaZpjViFS
         8nW0iP+cBEBVMwplvyQUkjjdtH7Ab4cgRkIOGWN/JhowvRPuLUNiz3j1CASFcc7yAFUs
         L6UElpzd2ShzOSFp57o/HfRyUqdxlbi63muMbNSVqv2Q3MIuBlFPVRIs4X+nuP9lMeHh
         ROigJd8pYmOAL2QmsP59lwPtPPlMceJmSHphyDnD/0JefcsRvJYkCn9hqzAJG2oQVCLT
         nvAmadzg4Eb9mwEzQ4VPr47PTUsJGnPslj4lw37/HEcXMODk0zKuvOC84ekJKRIb0Dld
         lJZg==
X-Gm-Message-State: AC+VfDzK278EHCLnSHSvHh34uxPAyc9Ef2XQ/0ml2wfAHVzslcyK9m7z
        2DjTUFuf3NjqZ4ppfFyaJWVLnAEKk/E+z5YRr5i24w==
X-Google-Smtp-Source: ACHHUZ5p7ispZs6AsV3pu9jxIahSyqwTK4y6N4ljjf17XsO/YDywPzs48rV28fo/aDq0GbaLX8dqMCO19fyY0yAGLtI=
X-Received: by 2002:a17:907:8a04:b0:973:daa0:315 with SMTP id
 sc4-20020a1709078a0400b00973daa00315mr7493679ejc.1.1686165466307; Wed, 07 Jun
 2023 12:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com> <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <CAKEwX=OK5qK9DTYLKZUefE0eq8KooygT-nbkgUZaYjK72SKzFQ@mail.gmail.com>
 <CAJD7tkZUc=h+h4f1a+nas8KruFBaGMuaq67jZLk+LkdbwZVqKQ@mail.gmail.com> <20230607120939.c1256fac4bb4e081811c02da@linux-foundation.org>
In-Reply-To: <20230607120939.c1256fac4bb4e081811c02da@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 12:17:09 -0700
Message-ID: <CAJD7tkbsy7X08zp8FF-XYn2krd6hDgWVz7t2ZoFr+RAm_Zcn4w@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
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

On Wed, Jun 7, 2023 at 12:09=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> It's unclear (to me) whether we should proceed with this.  Thoughts, plea=
se?

This version looks good to me. I added my Reviewed-by on some version,
but I guess it got lost with all the versions and fixlets :)

>
> Here's what I presently have in mm-hotfixes-unstable:
>
>
> From: Nhat Pham <nphamcs@gmail.com>
> Subject: zswap: do not shrink if cgroup may not zswap
> Date: Tue, 30 May 2023 15:24:40 -0700
>
> Before storing a page, zswap first checks if the number of stored pages
> exceeds the limit specified by memory.zswap.max, for each cgroup in the
> hierarchy.  If this limit is reached or exceeded, then zswap shrinking is
> triggered and short-circuits the store attempt.
>
> However, since the zswap's LRU is not memcg-aware, this can create the
> following pathological behavior: the cgroup whose zswap limit is 0 will
> evict pages from other cgroups continually, without lowering its own zswa=
p
> usage.  This means the shrinking will continue until the need for swap
> ceases or the pool becomes empty.
>
> As a result of this, we observe a disproportionate amount of zswap
> writeback and a perpetually small zswap pool in our experiments, even
> though the pool limit is never hit.
>
> More generally, a cgroup might unnecessarily evict pages from other
> cgroups before we drive the memcg back below its limit.
>
> This patch fixes the issue by rejecting zswap store attempt without
> shrinking the pool when obj_cgroup_may_zswap() returns false.
>
> [akpm@linux-foundation.org: fix return of unintialized value]
> [akpm@linux-foundation.org: s/ENOSPC/ENOMEM/]
> Link: https://lkml.kernel.org/r/20230530222440.2777700-1-nphamcs@gmail.co=
m
> Link: https://lkml.kernel.org/r/20230530232435.3097106-1-nphamcs@gmail.co=
m
> Fixes: f4840ccfca25 ("zswap: memcg accounting")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  mm/zswap.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --- a/mm/zswap.c~zswap-do-not-shrink-if-cgroup-may-not-zswap
> +++ a/mm/zswap.c
> @@ -1174,9 +1174,16 @@ static int zswap_frontswap_store(unsigne
>                 goto reject;
>         }
>
> +       /*
> +        * XXX: zswap reclaim does not work with cgroups yet. Without a
> +        * cgroup-aware entry LRU, we will push out entries system-wide b=
ased on
> +        * local cgroup limits.
> +        */
>         objcg =3D get_obj_cgroup_from_page(page);
> -       if (objcg && !obj_cgroup_may_zswap(objcg))
> -               goto shrink;
> +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +               ret =3D -ENOMEM;
> +               goto reject;
> +       }
>
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
> _
>
