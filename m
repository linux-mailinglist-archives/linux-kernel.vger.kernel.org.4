Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB755B786D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiIMRnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiIMRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:42:45 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F96AA3A;
        Tue, 13 Sep 2022 09:36:33 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28DGZuEj006897;
        Wed, 14 Sep 2022 01:35:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28DGZuEj006897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663086957;
        bh=ADulXANGWbXPhSuERT5kyHgMKpGhhXIJxmRYD92iQDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gt9ym76sdIvLNPo6jEcjx2gCzgZyEMgnOfVf2H18G0/E+hH7nHHwxc+/SV0mzxVjQ
         Dx1RTrlOn6aqU63Fj6NEagWCFP2v7Ev1LbJV5E6nOnCwP8jNmjMlyWNSdjAjMRvQdN
         B+nk/+wmCi8jeyYaz8QXAlPbGxztus+gdkSMoi3Brg+Cw6esC11bb776lPeXEaap18
         p5Pf19IOKqt/ZDfmHVlccLjnC4otsSk6wzCguKwLEPmcAFGpQXRhJ1VCo5HyUJ2aZK
         h8huIN+zK/jF8cZ7p6z9AiV1UyEDw5Qg9h/1taKlV7J/5k9UMpRIa5yiX6MKC0gu8z
         5NXjgsRaZ1cig==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-127d10b4f19so33560074fac.9;
        Tue, 13 Sep 2022 09:35:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo3oyqQtcG2g77jxyzhLOlbP/6fwfkX95MJXjddFbF/pB83I2KGO
        6JtQ0NgnZ6YXev2c+8oiY6CmKPhpKoADoemHAMQ=
X-Google-Smtp-Source: AA6agR7n/cZvE4GxSypV7Qgl9LMXnS/mCPITjccFtlHEheSI02RUL9w9LzGU7Hxm2md2KoHfR1yfWB3kHipXV0030kg=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr96316oab.194.1663086955884; Tue, 13
 Sep 2022 09:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220912094838.2398580-1-zengheng4@huawei.com> <20220912094838.2398580-2-zengheng4@huawei.com>
In-Reply-To: <20220912094838.2398580-2-zengheng4@huawei.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Sep 2022 01:35:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrH740T45VvbOZyfxF3C8aqMesbMBkEyBsv78Sz4D1AQ@mail.gmail.com>
Message-ID: <CAK7LNASrH740T45VvbOZyfxF3C8aqMesbMBkEyBsv78Sz4D1AQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] Kconfig: remove unused argment 'ch'
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 6:41 PM Zeng Heng <zengheng4@huawei.com> wrote:
>
> Remove unused argment 'ch' in sym_set_choice_value
>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>


Can you remove sym_set_choice_value() and
call sym_set_tristate_value(chval, yes) directly?





> ---
>  scripts/kconfig/conf.c | 2 +-
>  scripts/kconfig/lkc.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 4178065ca27f..635265a18a07 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -551,7 +551,7 @@ static int conf_choice(struct menu *menu)
>                         print_help(child);
>                         continue;
>                 }
> -               sym_set_choice_value(sym, child->sym);
> +               sym_set_choice_value(child->sym);
>                 for (child = child->list; child; child = child->next) {
>                         indent += 2;
>                         conf(child);
> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> index fa8c010aa683..279d56a44136 100644
> --- a/scripts/kconfig/lkc.h
> +++ b/scripts/kconfig/lkc.h
> @@ -124,7 +124,7 @@ static inline struct symbol *sym_get_choice_value(struct symbol *sym)
>         return (struct symbol *)sym->curr.val;
>  }
>
> -static inline bool sym_set_choice_value(struct symbol *ch, struct symbol *chval)
> +static inline bool sym_set_choice_value(struct symbol *chval)
>  {
>         return sym_set_tristate_value(chval, yes);
>  }
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
