Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B36DB29C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjDGSOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDGSOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:14:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F752C646
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:14:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso2083437pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680891247; x=1683483247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR5vun52tcsHLu1HJ14aemGaEMgXlWM8Oo3dvfzO2C0=;
        b=pVC015NAFlm36VYuUzCVo7FdrkP9+B47UDv1WQ1JPnMH/MjAtw3BfDGoGD3UvUBZjC
         aMC9N8wJZ/c5RfgQZldgZ48Zg5D/Up2C0Orm7M+3bUN/lT3bpUZQpfF+QQ3v06aqkJ3B
         yv1VUtMc3cQdGv1TX+i81BtOLFy78JMXUxY0L8GRuZGZTUD2DWHR15kXfHR27IfYHP5h
         b3/IKGz8GhmAtVFbYtPYtIaO8WNxuS6rmizR23p3tycGPLnEHn9rwo30JDEff6qXAeIC
         yRe8434Ae3ve7S7J+JIO6mrEJOorbPE3mhC205z91p0k0+dbPSy/YTMW4uWIbBR29DXW
         EtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680891247; x=1683483247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR5vun52tcsHLu1HJ14aemGaEMgXlWM8Oo3dvfzO2C0=;
        b=o6QlaEzzQj8F7jYRIGTOUu/jgpEmFPV+/0d7B2ev/QbDgLDM/3RSIxEQJ2g1oScpQe
         o9gwYqNTMaRZYrt12zvxdFb7JKXKSPGe2gju9OpufvNi1BbtIvcB2zjROYOu69mOhIn0
         BLv0ebGcPGvg7O8JTn8NMB9PYR0Bl2iNb4ioaNhcK/gfqj5lzMwevje+gxB21h2o+KwQ
         QhlCqf8oDGZ2pVcclLqlIVUcLMjRzLyeWRrNape7rY8WN1aNwufsnGqvabsokSI+lpn2
         cPHOlFB/4MAnDVytTdsl3WHnJGoeJ/v+HG0ef6nUiMy5oCOi4Q/23PtfEdRwWdZsgt1d
         DC+g==
X-Gm-Message-State: AAQBX9fxgkHNmWzxjR6WoqWfwwlvLfOU5tnfvBBH4y6qpQNhBTUhJa9Q
        YOvrJTj5/KOsnhjdyebc39fsQ/FLll3zO9NNd2LrBQ==
X-Google-Smtp-Source: AKy350aU/IB5VaFU/u0WokhO/SJsHANiJN00OQm3BFmMJ5+gRJY7lFGGFFaR/6e05KbtL6SErczy8rwQ7E/M0c3HNSw=
X-Received: by 2002:a17:90b:3641:b0:244:987c:a873 with SMTP id
 nh1-20020a17090b364100b00244987ca873mr822309pjb.7.1680891246608; Fri, 07 Apr
 2023 11:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230331001208.1846731-1-trix@redhat.com>
In-Reply-To: <20230331001208.1846731-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:13:55 -0700
Message-ID: <CAKwvOdmBu_foPCtXBNoA+ZDd-kU4X5-c65NVJb-MSrgoMKNJxw@mail.gmail.com>
Subject: Re: [PATCH] bus: fsl-mc: remove unused free_count variable
To:     Tom Rix <trix@redhat.com>
Cc:     stuyoder@gmail.com, laurentiu.tudor@nxp.com, nathan@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 5:12=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/bus/fsl-mc/fsl-mc-allocator.c:560:6: error: variable
>   'free_count' set but not used [-Werror,-Wunused-but-set-variable]
>         int free_count =3D 0;
>             ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!

Fixes: commit d8e026a44919 ("staging: fsl-mc: remove some superfluous WARN_=
ONs")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Check out
commit 364069556901 ("staging: fsl-mc: move resource pool init/cleanup
into allocator")
to see the original logic.

> ---
>  drivers/bus/fsl-mc/fsl-mc-allocator.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/f=
sl-mc-allocator.c
> index dced427ca8ba..f1351237a9d5 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -557,12 +557,9 @@ static void fsl_mc_cleanup_resource_pool(struct fsl_=
mc_device *mc_bus_dev,
>         struct fsl_mc_bus *mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
>         struct fsl_mc_resource_pool *res_pool =3D
>                                         &mc_bus->resource_pools[pool_type=
];
> -       int free_count =3D 0;
>
> -       list_for_each_entry_safe(resource, next, &res_pool->free_list, no=
de) {
> -               free_count++;
> +       list_for_each_entry_safe(resource, next, &res_pool->free_list, no=
de)
>                 devm_kfree(&mc_bus_dev->dev, resource);
> -       }
>  }
>
>  void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev)
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
