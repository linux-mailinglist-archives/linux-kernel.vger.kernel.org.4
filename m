Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5861F63E35D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiK3WXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiK3WXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:23:42 -0500
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41425133B;
        Wed, 30 Nov 2022 14:23:41 -0800 (PST)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-04.nifty.com with ESMTP id 2AUMLqOd026581;
        Thu, 1 Dec 2022 07:21:52 +0900
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2AUMLOOd009632;
        Thu, 1 Dec 2022 07:21:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2AUMLOOd009632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669846885;
        bh=k5TnRkjFmB+0wMVTITyaBsYH4EkERxs/m8UlcytiUqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wezRxcPL57rNZmvQDUfqHkvrnpWW6KcJuM5zkvY4DWlVXSwmILOWeW7EnKHIcGxzC
         Agu37VlemU6SjxxPDu2gzZkCd6+lmu4SGVFvnj/6TuP1qTJ6Ixxx1LWcc1BuEYdaDS
         AWh6/yLOw1gJak/wKaB4+oSl7NWcw14iYftsWMV0Q2gsBJRHKZkFPu0EophkAljJux
         mINa+xUJRAZT9gqXFGcF3C61zUb4LCrL7l53DdX6btf1Y1sslZci2kZUBNkhRxNurc
         1dAItGSzvagxjhaNwL+7czO78HV9CtUYzRXVUIKQ4xOX7Zp1+hNUplWXoin6hsBYvQ
         hAnxvKLakmEVA==
X-Nifty-SrcIP: [209.85.167.181]
Received: by mail-oi1-f181.google.com with SMTP id e205so107913oif.11;
        Wed, 30 Nov 2022 14:21:24 -0800 (PST)
X-Gm-Message-State: ANoB5pmfhMnS5kaptKTFtrTkWpHb3y8hVikpXz0fOpkll9gFD56Z/q0P
        v992ooR41laL9M+wMNBfSSFfOtvtQsIKhenqEBI=
X-Google-Smtp-Source: AA0mqf6or5JAcRyjvHHEkc7ygsMt2uCHycUgQSriEZZOcXQJpheBCozq7ScqXqGnuUQJLwC7n8y7iHcjChYlkCgNDz8=
X-Received: by 2002:aca:1c06:0:b0:354:28ae:23b3 with SMTP id
 c6-20020aca1c06000000b0035428ae23b3mr21855293oic.287.1669846883543; Wed, 30
 Nov 2022 14:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20221129190123.872394-1-nathan@kernel.org> <20221129190123.872394-2-nathan@kernel.org>
In-Reply-To: <20221129190123.872394-2-nathan@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 1 Dec 2022 07:20:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMtRu00GYwJW_VvTSTcY6eqnx=4EEj8PFC5adrnHunSw@mail.gmail.com>
Message-ID: <CAK7LNATMtRu00GYwJW_VvTSTcY6eqnx=4EEj8PFC5adrnHunSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] padata: Do not mark padata_mt_helper() as __init
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 4:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building arm64 allmodconfig + ThinLTO with clang and a proposed
> modpost update to account for -ffuncton-sections, the following warning
> appears:



How to enable -ffuncton-sections for ARCH=arm64 ?
(in other words, how to set CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ?)

In upstream, it is only possible for mips and powerpc.

./arch/mips/Kconfig:82: select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
./arch/powerpc/Kconfig:237: select HAVE_LD_DEAD_CODE_DATA_ELIMINATION



Is there another proposal to add it for arm64,
or is this about a downstream kernel?





>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
>   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
>
> In both cases, an __init function calls padata_work_init(), which is not
> marked __init, with padata_mt_helper(), another __init function, as a
> work function argument.
>
> padata_work_init() is called from non-init paths, otherwise it could be
> marked __init to resolve the warning. Instead, remove __init from
> padata_mt_helper() to resolve the warning.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: linux-crypto@vger.kernel.org
> ---
>  kernel/padata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/padata.c b/kernel/padata.c
> index e5819bb8bd1d..c2271d7e446d 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -45,7 +45,7 @@ struct padata_mt_job_state {
>  };
>
>  static void padata_free_pd(struct parallel_data *pd);
> -static void __init padata_mt_helper(struct work_struct *work);
> +static void padata_mt_helper(struct work_struct *work);
>
>  static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
>  {
> @@ -425,7 +425,7 @@ static int padata_setup_cpumasks(struct padata_instance *pinst)
>         return err;
>  }
>
> -static void __init padata_mt_helper(struct work_struct *w)
> +static void padata_mt_helper(struct work_struct *w)
>  {
>         struct padata_work *pw = container_of(w, struct padata_work, pw_work);
>         struct padata_mt_job_state *ps = pw->pw_data;
> --
> 2.38.1
>


-- 
Best Regards
Masahiro Yamada
