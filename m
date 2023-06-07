Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2657269D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjFGTcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjFGTbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:31:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BFD1FE9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:31:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62614f2eee1so58214786d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686166299; x=1688758299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpO4h9gToGZ2J2Y1w87OPJzaWzYtM8DFvL2yfPOMmPY=;
        b=pAxsEq6yofIE8/eHaakeNZIPhLUtBVPFBUMN+Uy+Ir+2tnKUlbUI6sVerE+vrck2VM
         vRSY7Qx/soeXUvZ0j1ucyagDs//ewHRS26henfE3t4H9gy63bxBD3IQuSh4aclh9ovDQ
         EUtW2Lmz7P+jmS3p9kBCbt6z1Fj4YAIZeU/W1eQbTeyKjbggNUZXLnCiV+ExBJ0UhlGp
         MNfqUzQW2dJm2zQ7yBuvOwYGYNambDgF9gEOR0zO+Nvz2qFTaklxIVBRKqjKtqATlJAr
         6dzVtQ0lKNWabk0ooAfNiZMgcQuuKDMNO0uVhSy4RnJy6sPcS90+Cmdatx7PZ+LAm3hF
         4fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686166299; x=1688758299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpO4h9gToGZ2J2Y1w87OPJzaWzYtM8DFvL2yfPOMmPY=;
        b=IYjdh4XyQmA1SpN1AGs6QOJzuxWeVeW8bDxWjNfI9cLD6vftVYFkdO4MzfdnGGSk+W
         PcZykTzrbTHq4BG4sECIfDaX16g3WGCbVAwkWZE/gojMictj02X0HYJxwWIvFZsVg6QW
         PCqq0RCSQIks1pklZjho20kCbWbYbfF687vIm1RoT2PQlAHpdqfc/jfd94C9G3fEi1IQ
         F7feD03SQC2rbO9TO2WV6bcaUyJe7uZ6SPYj1Ifk9Ifyrfegpa5JnUiLxoOfuLOIsjD/
         b+mK6ibb1t7HlJ4BrDxRbDXLtW1byNLdHfcXZuAXeAbiYZixpZXd4kvKztpp6+EmOCG3
         qOiA==
X-Gm-Message-State: AC+VfDyPsKepzISmY0jzqKxIeCOKXB8jpUiLGm4OmPAT5oF2qKTtSnBd
        I3Szg9MAAvyLtX4V+ykAbCfwn7PR47MslpjqFBs=
X-Google-Smtp-Source: ACHHUZ7X/gxrS6PYHIgb2MR1PAxPYCjHDxyBsBT3gU2wJJqzLyFRWcvbVQr4PSpmvblAG+o1dP1GZZ/gEXWG/ATkCqY=
X-Received: by 2002:ad4:5ccf:0:b0:628:c4c8:4afb with SMTP id
 iu15-20020ad45ccf000000b00628c4c84afbmr4686663qvb.60.1686166298687; Wed, 07
 Jun 2023 12:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com> <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <CAKEwX=OK5qK9DTYLKZUefE0eq8KooygT-nbkgUZaYjK72SKzFQ@mail.gmail.com>
 <CAJD7tkZUc=h+h4f1a+nas8KruFBaGMuaq67jZLk+LkdbwZVqKQ@mail.gmail.com> <20230607120939.c1256fac4bb4e081811c02da@linux-foundation.org>
In-Reply-To: <20230607120939.c1256fac4bb4e081811c02da@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 7 Jun 2023 12:31:27 -0700
Message-ID: <CAKEwX=MJ1+nmms6Hm0CLQAne3CbgQcKDBTvCeTTpGYKAH-nuZQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, hannes@cmpxchg.org,
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

On Wed, Jun 7, 2023 at 12:09=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> It's unclear (to me) whether we should proceed with this.  Thoughts, plea=
se?
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

Apologies for lack of clarity - yep this is the final version
I had in mind too.
