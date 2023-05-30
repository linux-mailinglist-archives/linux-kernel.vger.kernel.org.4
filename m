Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A937170D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjE3Whh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjE3Whe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:37:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDE5E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:37:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f8d485ef3so785671566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685486252; x=1688078252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FboEU1CkVwXltLGLCCWwSeN6ivraaVY6culNTHoYYKs=;
        b=ubY4da6wd2iDhpbYhSe4ROFvsRt+fF8tfL4FWHQaQ+L4zXrUXcQny//D8sMNYTMsCw
         PqQZqc+PZQEPCx84OgHVbJXcxaGfZLHEcIeRGYerRGYNmN9C2IbgM33xQZ2thgW6BPQK
         gCssbE4OdIVfJwW6htV716ZVoGk0x/thL/kWrrKQ+QEkNR8XhE7KUTfi89BC03Rk0fvi
         KL71rDqD7b5Tm4n+8ImtDTIOj1dkusxEPiWYhAg0F/x2pAm/BsPaR3lNWwJIH6skJ4p/
         x9ZLeELJN83P1ZUfNLpYvi6qQZcAwTOITRQz6NaGvGCVt/9hZBrjnMDWgQf4ITxtwG0K
         3UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486252; x=1688078252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FboEU1CkVwXltLGLCCWwSeN6ivraaVY6culNTHoYYKs=;
        b=E1ic6U9PIDH29OxOKTT8WhJCyUE86PwwJ6y0u9lLjD5sUW4Pwc0Y9RAO7Z8aZhUjHw
         xdPDAXuP1owPaJV3l66PGJb4JrXm1aNt0SczjNtLkn/o2GHSWquki3A5waxDmo3vyeJq
         EKjX1nFUwgY1r7Q9r29KaAMeimXo1dJYEcmgGyee47msLGZNHIdm4y+oHmY5BlUpfji+
         N0FnsnjXn8Xtx0gLjB8FY8d/qyiBzp8J7axH/+I4ChQJRWgfRNLnJ9+MZwizAIzAa1JD
         m21TRqlBVN31DmBN6OcnUvYVif3++9MicMVUIWCJWvaHcPecddo2U3hwjn+uZdMoDm4u
         T++g==
X-Gm-Message-State: AC+VfDws6GPI9tOcj+9CvEVS47MjxXqFryNQz65HzEn/bMvY2K+T5bJO
        y3OO6bIEZTVuoJfJwX3S3qgWfZlcFCx6kXXbIwRPiA==
X-Google-Smtp-Source: ACHHUZ5rincErcVqOc8V3DItvsdWvDR95KKXLS5s/ouCVauIKh/djhVUDt11i0mD8SL6udii2uGbUp6CUegi51KSXjk=
X-Received: by 2002:a17:907:8692:b0:973:7dfc:f052 with SMTP id
 qa18-20020a170907869200b009737dfcf052mr3122689ejc.30.1685486251914; Tue, 30
 May 2023 15:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAKEwX=PrqV+cCGmdTcFPMqP-48Y=abQTkSOUzJnOWWpc4rR4cA@mail.gmail.com>
 <20230530222440.2777700-1-nphamcs@gmail.com>
In-Reply-To: <20230530222440.2777700-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 15:36:55 -0700
Message-ID: <CAJD7tkaveZ44agL0-iLfHdX1Pm_xEwBSYo=n5Tnm7pVWbsdTug@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink if cgroup may not zswap
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
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

On Tue, May 30, 2023 at 3:24=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Before storing a page, zswap first checks if the number of stored pages
> exceeds the limit specified by memory.zswap.max, for each cgroup in the
> hierarchy. If this limit is reached or exceeded, then zswap shrinking is
> triggered and short-circuits the store attempt.
>
> However, since the zswap's LRU is not memcg-aware, this can create the
> following pathological behavior: the cgroup whose zswap limit is
> reached will evict pages from other cgroups continually, without
> lowering its own zswap usage. This means the shrinking will continue
> until the need for swap ceases or the pool becomes empty.

This pathological behavior will only happen if the zswap limit is 0.
Otherwise, we will see a different pathological behavior where we
unnecessarily evict X pages from other cgroups before we drive the
memcg back below its limit.

Perhaps we should clarify this?

>
> As a result of this, we observe a disproportionate amount of zswap
> writeback and a perpetually small zswap pool in our experiments, even
> though the pool limit is never hit.

I am guessing this is also related to the case where the limit is 0.
It would be useful to clarify this.

>
> This patch fixes the issue by rejecting zswap store attempt without
> shrinking the pool when obj_cgroup_may_zswap() returns false.
>
> Fixes: f4840ccfca25 ("zswap: memcg accounting")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59da2a415fbb..cff93643a6ab 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1174,9 +1174,14 @@ static int zswap_frontswap_store(unsigned type, pg=
off_t offset,
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
>         if (objcg && !obj_cgroup_may_zswap(objcg))
> -               goto shrink;
> +               goto reject;
>
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
> --
> 2.34.1
>

With commit log nits above:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
