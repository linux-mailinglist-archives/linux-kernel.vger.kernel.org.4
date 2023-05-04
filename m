Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA986F68C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEDKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEDKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19392128
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81EA662B99
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4669C433EF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683194574;
        bh=21YZ79Gr/0iOXrxXklLKqfvRPun7UvP/FB53D+iAjus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VzC9NLEaUL/qjsc7TPLIlWeNTSX3L3ZXNEuIg/hVwEgDGCb5HeZy9KKkNIyWgojxF
         0OKpdCNB/vlWuo5cLHklP/3TL4In5d9qt32E3H4OAAkxUtMs775KRcV3PPSJg7lNFw
         E3Qy/87JKPUjXS0axUy44ByW+lt4y9y9oEbTuBBN8y7xnwj0WqzDleA6Brjia3Tehq
         TtHpk2q4rZ8lP/ZDyhzzldsh3HusgamhdiT3LFLnE7xgWJkutpCP09bFZ8FzK7RhTv
         uz/v5HiwmcIA20r1DWPy77ZyIWC6diZzZWTrLKqic67aThk/oNH5cYe8iYKVzliw5T
         5BTyglehK7kIw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-546de76c23eso144526eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:02:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDx2ONtZQV+w/6ybxOhjjBjWqn0d/oIlgvEZFEL5lCapYEaX3iLi
        oWs1IZb9CMyn1qDq4O8mBIUsDhze+sS3caJ8MsQ=
X-Google-Smtp-Source: ACHHUZ5MF5yW7zLQkU8Kpn2nqI9gvP3lFM81iQn1Iyo+I/lY6x8HwUSiBjEH/Ez5VgDaF2euPoUDAUaN/xVw7ePphyE=
X-Received: by 2002:a05:6808:1148:b0:38e:8fe6:bc3e with SMTP id
 u8-20020a056808114800b0038e8fe6bc3emr1623091oiu.14.1683194574047; Thu, 04 May
 2023 03:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230504083613.3789010-1-pvorel@suse.cz>
In-Reply-To: <20230504083613.3789010-1-pvorel@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 May 2023 12:02:17 +0200
X-Gmail-Original-Message-ID: <CAK7LNAS_0yOTtw36xfCtnBKFMkG_96nOSoyD4hejfacYUwW3Eg@mail.gmail.com>
Message-ID: <CAK7LNAS_0yOTtw36xfCtnBKFMkG_96nOSoyD4hejfacYUwW3Eg@mail.gmail.com>
Subject: Re: [PATCH v2] uapi/netfilter: Prefer ISO-friendly __typeof__
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, sam@ravnborg.org,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 10:36=E2=80=AFAM Petr Vorel <pvorel@suse.cz> wrote:
>
> typeof() is a GNU extension, UAPI requires ISO C, therefore __typeof__()
> should be used.  Similarly to 31088f6f7906 ("uapi/linux/const.h: Prefer
> ISO-friendly __typeof__") use __typeof__() also in x_tables.h.
>
> Fixes: 72b2b1dd77e8 ("netfilter: xtables: replace XT_ENTRY_ITERATE macro"=
)
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




> ---
> Changes v1->v2:
> * Add Kevin's Reviewed-by:
>   https://lore.kernel.org/lkml/f8bd4212-9cca-03ca-884a-c9dec63bb256@arm.c=
om/
> * Update hash to 31088f6f7906 (Kevin)
> * Add Fixes: 72b2b1dd77e8 (Kevin)
>
>  include/uapi/linux/netfilter/x_tables.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux=
/netfilter/x_tables.h
> index 796af83a963a..d4eced07f2a2 100644
> --- a/include/uapi/linux/netfilter/x_tables.h
> +++ b/include/uapi/linux/netfilter/x_tables.h
> @@ -172,11 +172,11 @@ struct xt_counters_info {
>
>  /* pos is normally a struct ipt_entry/ip6t_entry/etc. */
>  #define xt_entry_foreach(pos, ehead, esize) \
> -       for ((pos) =3D (typeof(pos))(ehead); \
> -            (pos) < (typeof(pos))((char *)(ehead) + (esize)); \
> -            (pos) =3D (typeof(pos))((char *)(pos) + (pos)->next_offset))
> +       for ((pos) =3D (__typeof__(pos))(ehead); \
> +            (pos) < (__typeof__(pos))((char *)(ehead) + (esize)); \
> +            (pos) =3D (__typeof__(pos))((char *)(pos) + (pos)->next_offs=
et))
>
> -/* can only be xt_entry_match, so no use of typeof here */
> +/* can only be xt_entry_match, so no use of __typeof__ here */
>  #define xt_ematch_foreach(pos, entry) \
>         for ((pos) =3D (struct xt_entry_match *)entry->elems; \
>              (pos) < (struct xt_entry_match *)((char *)(entry) + \
> --
> 2.40.0
>


--=20
Best Regards
Masahiro Yamada
