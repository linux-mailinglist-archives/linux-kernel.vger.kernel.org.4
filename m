Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602DB63E385
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK3Wg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3Wgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:36:54 -0500
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 14:36:52 PST
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD65802B;
        Wed, 30 Nov 2022 14:36:52 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2AUMaajR030753;
        Thu, 1 Dec 2022 07:36:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2AUMaajR030753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669847797;
        bh=RCOA2Nmk8RchnYckPF/4P1hJEvsAWuR5bSpQkzBr1MI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T0NDgbQuBl8lsVdF+pJOLVK+pE948s/ldkHOx6f4DNRKzEek5HOkHSnh+Zd+7V5VI
         4iVPKRYIWH84jTGcPFYeXdcDn4vp0/z0ltg+FIzOShm9r/+QhZeJSDMCiiq5iuLaKQ
         YuJiSW9fT+bwQW9RJdMl2sMKbaTWCa3sz8BoJrzaHhhwMbx/NrulFYUeAZDYUF0g8U
         uTFhuvuKJTslSvyotDwHEi8AB4ZQnwVGH76bRH/XlaF9kLYcZDlX+yT3xIih/yLzjf
         1ECUf9MJWaPyy2OcE7WuBauXLReuu+cRw52lsitxh3jSU2oduXgE1uA+g7ffdtLe5D
         Q9hPwVdtCfSGQ==
X-Nifty-SrcIP: [209.85.210.48]
Received: by mail-ot1-f48.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so12172406otl.10;
        Wed, 30 Nov 2022 14:36:36 -0800 (PST)
X-Gm-Message-State: ANoB5pm8XwxoaaL3PReD3UrGUEOiwkRyHestzb2jwpwmkBIlcW6ra1AZ
        vdrotlKt0tFtdld2H8VaY9ncLodgRENVyWT2IEY=
X-Google-Smtp-Source: AA0mqf6bqBcmrS+eVxJO24zhJa/RBxv8Svo2IRZ/K95H2IEpB2iBNtH1xgryc3UFbM4saaKjmEq+Ef/miyv+iNxynPw=
X-Received: by 2002:a05:6830:1b67:b0:661:8d9e:1959 with SMTP id
 d7-20020a0568301b6700b006618d9e1959mr31870741ote.225.1669847795651; Wed, 30
 Nov 2022 14:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20221129190123.872394-1-nathan@kernel.org> <20221129190123.872394-2-nathan@kernel.org>
In-Reply-To: <20221129190123.872394-2-nathan@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 1 Dec 2022 07:35:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdOhcTqbnRibPumMH1o+78dxBjLuzLK+JS+AiHyTiY6A@mail.gmail.com>
Message-ID: <CAK7LNASdOhcTqbnRibPumMH1o+78dxBjLuzLK+JS+AiHyTiY6A@mail.gmail.com>
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

This patch seems wrong.

padata_work_init() does not reference to padata_mt_helper()


padata_work_alloc_mt() and padata_do_multithreaded() do.








-- 
Best Regards
Masahiro Yamada
