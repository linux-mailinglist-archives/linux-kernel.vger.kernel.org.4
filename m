Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E95A723CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjFFJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFFJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:16:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14206E76
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:16:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53404873a19so3037120a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686043001; x=1688635001;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah2zhbL7HyNfNMLyCJlZsl1+8Ty4BOz43t9+LJgTCHg=;
        b=ryrCzJG30j61sGFl6c7bZZF4wXWpbxoPEcD26ngT1SxTpoyPc6VR0oPv+08gWU+cSu
         mhvgCVcu0KlLlKhfMXL8rXT6CRwQVh+doXz3yqrth1+yWsL+EQ9yGeO2LtHLXCGh8ZPz
         T0DezVLAE3CiBc0agNM5CyzLd+BkXeB91nYWVTUYBaIV1mxlXJ7g1ePEgSmRY/TuMgDZ
         af7JPAjrjPSiTmOqSLR2RUTlp4mgZVVqKYWZ2HDr0skp29j0TaGQDlA5I4YhiWwCDeWF
         iCGYvW2NW8qvkKma8uQhgaLJG1rx/NvBlsWKcnN+qOazoFTn5YiW0LqeFS34GNTIdLBQ
         H1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686043001; x=1688635001;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ah2zhbL7HyNfNMLyCJlZsl1+8Ty4BOz43t9+LJgTCHg=;
        b=lub6ABK/O6ICGxG1lGlUSL019qLwLtuHfaQkOYCdcq7WuVraQRzXxvboyTaWZp99r2
         ILmfs06sPRNPWjypxGpxBxIllCanUIMKPourx0H7YTAqwncDraJS5B/uw8WbRubcMdPr
         gZflLBL5PCna+YSpEGbP2S0l84HHBVeW2lGtoLF1ErW+VrqZz/7YsybOnZHNRYdkLmJE
         /Klm9/2e/otPhDhqIeYR4dvSmg8c+0vWYCcm/EQkxlo7hLN2dUePTMOPn1EnFsAPT+FM
         L6OtFvcSCWFWnnnxxraJHnpVB5B06fOyNO1WytztVF6KOOKvRqcm7ujyJ/EkQES2f28M
         S5Mg==
X-Gm-Message-State: AC+VfDxhg+HDX+xWVPmmMjTsUXxSkiizzht53wr07yydejcsy/H/xAZt
        VxFdAZSJvz++xzoq0z8QAkLyDaCTYhOZ8A==
X-Google-Smtp-Source: ACHHUZ6SERKFytLvIZERSMLk/IwvxuJKwbZjn3t2jyy1qwOa9lZVAlJGduBPqky8qiUl82UmebzqpA==
X-Received: by 2002:a17:903:1c9:b0:1a9:86ca:38cd with SMTP id e9-20020a17090301c900b001a986ca38cdmr870663plh.2.1686043001430;
        Tue, 06 Jun 2023 02:16:41 -0700 (PDT)
Received: from localhost (58-6-230-127.tpgi.com.au. [58.6.230.127])
        by smtp.gmail.com with ESMTPSA id jk19-20020a170903331300b001b0aec3ed59sm7997002plb.256.2023.06.06.02.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:16:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 19:16:36 +1000
Message-Id: <CT5GCZLAL3QC.URC3KKG0M0WR@wheely>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/4] powerpc/kuap: Refactor static branch for disabling
 kuap
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.14.0
References: <1a3c69e38349b687c6c65240d7c09a7817a797d8.1685963081.git.christophe.leroy@csgroup.eu> <4d775047675e9f8ae2a9db9cb8a0cc8216a309b8.1685963081.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4d775047675e9f8ae2a9db9cb8a0cc8216a309b8.1685963081.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 5, 2023 at 9:04 PM AEST, Christophe Leroy wrote:
> All but book3s/64 use a static branch key for disabling kuap.
> book3s/64 uses a memory feature.
>
> Refactor all targets except book3s/64.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/32/kup.h     |  7 -------
>  arch/powerpc/include/asm/book3s/64/kup.h     |  1 +
>  arch/powerpc/include/asm/kup.h               | 15 +++++++++++++++
>  arch/powerpc/include/asm/nohash/32/kup-8xx.h |  7 -------
>  arch/powerpc/include/asm/nohash/kup-booke.h  |  7 -------
>  arch/powerpc/mm/book3s32/kuap.c              |  3 ---
>  arch/powerpc/mm/init-common.c                |  3 +++
>  arch/powerpc/mm/nohash/kup.c                 |  3 ---
>  8 files changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/incl=
ude/asm/book3s/32/kup.h
> index 466a19cfb4df..8da9997a67ba 100644
> --- a/arch/powerpc/include/asm/book3s/32/kup.h
> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
> @@ -11,8 +11,6 @@
> =20
>  #include <linux/jump_label.h>
> =20
> -extern struct static_key_false disable_kuap_key;
> -
>  static __always_inline bool kuep_is_disabled(void)
>  {
>  	return !IS_ENABLED(CONFIG_PPC_KUEP);
> @@ -25,11 +23,6 @@ static __always_inline bool kuep_is_disabled(void)
>  #define KUAP_NONE	(~0UL)
>  #define KUAP_ALL	(~1UL)
> =20
> -static __always_inline bool kuap_is_disabled(void)
> -{
> -	return static_branch_unlikely(&disable_kuap_key);
> -}
> -
>  static inline void kuap_lock_one(unsigned long addr)
>  {
>  	mtsr(mfsr(addr) | SR_KS, addr);
> diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/incl=
ude/asm/book3s/64/kup.h
> index 1b0215ff3710..f8b8e93c488c 100644
> --- a/arch/powerpc/include/asm/book3s/64/kup.h
> +++ b/arch/powerpc/include/asm/book3s/64/kup.h
> @@ -233,6 +233,7 @@ static __always_inline bool kuap_is_disabled(void)
>  {
>  	return !mmu_has_feature(MMU_FTR_BOOK3S_KUAP);
>  }
> +#define kuap_is_disabled kuap_is_disabled

Is there any point to doing this pattern since the code is in places
that have ifdef PPC6 S etc?

> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.=
c
> index 119ef491f797..74e140b1efef 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -32,6 +32,9 @@ EXPORT_SYMBOL_GPL(kernstart_virt_addr);
>  bool disable_kuep =3D !IS_ENABLED(CONFIG_PPC_KUEP);
>  bool disable_kuap =3D !IS_ENABLED(CONFIG_PPC_KUAP);
> =20
> +struct static_key_false disable_kuap_key;
> +EXPORT_SYMBOL(disable_kuap_key);
> +

That's going to define it on 64s?

Nice refactoring though.

Thanks,
Nick
