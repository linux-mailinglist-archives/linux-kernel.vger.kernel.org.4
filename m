Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9184723D48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbjFFJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbjFFJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:27:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B4E10D9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:27:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-256e1d87998so5005240a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686043628; x=1688635628;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj5cfddeuLbFxFPU3j4YyWVdfQSP61amx4yxE5TB5b8=;
        b=nzO5P+tABXIgVwKbob6pzJjXU5AmQ/Ntk0CjOjXWHCi3pdq4rC8ZTx/rqiY9TwGbpc
         UXR9O3p9HoMQuIsMvJmKKhmoReR+tC69I8rDe7evM7zfhZC1zmol4znhri/PZi4YZWUz
         olbOO8qtJ3xTbJzPbJ20Vn8pAOqOQEr3SwYqcXsVWAdcBK4J5oWMCFeTHck+Mrvl0CiQ
         RbU57GTLqaF8uCPMsV62tnvvwRnUPsQIQfeY0ISGcdzwIsFFi7Z/HujuilCDy9sxwEqH
         ScGhC9cvh+0Zbkfp2VEwJ8lZfVwI9bWCLonow31f32cdQCqELPnml/6M0hcCtuRyHbfu
         pDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686043628; x=1688635628;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fj5cfddeuLbFxFPU3j4YyWVdfQSP61amx4yxE5TB5b8=;
        b=U52vRiEm1pB4EuqJeiQlBN9+T2Mjdy6+5iwTOuOF70kMfXhFmT9ZISccEKDzB1V+0s
         ZXXIoZc0rQDuRHy6KM5HZLD+pD+iM0Nx+xi4a1EiNIBrc+pwlFrZd4uVHydgAUpJCGgT
         mWBV0im9xkzvCHluTTq+etrXaNv3rGAMMv3V/pBQACntGtr82w4r1XUNrREbc1EhOGFb
         Z7JfBN+Pfh3q96HAXgBcxr7tSCNVKkx6fxXkQP9eiNt/vm/HwIOhh1msLzAKM93FxSeL
         px1iP+IrTjogNKZNthbi/l08wpeSrP+YOU+mO1m+jfPyuQ0UTgUT+ZG3n41Z/Bbug+kE
         67ag==
X-Gm-Message-State: AC+VfDxOd80MY9iVAv7cbJs+Brje9u7fdpPBp21vASScRrsc47oqa3yx
        oEfLUzVX03mzF9bkdZvMUh3bUhhuDcWVYg==
X-Google-Smtp-Source: ACHHUZ69dTB14PGDXn+rLlYLlncYLqzKXJX1kqbwLbJrAGPR8YOis4ZN98koiW32GjQZcGxEIlte/Q==
X-Received: by 2002:a17:90a:540d:b0:259:17ba:e89a with SMTP id z13-20020a17090a540d00b0025917bae89amr1416109pjh.34.1686043628235;
        Tue, 06 Jun 2023 02:27:08 -0700 (PDT)
Received: from localhost (58-6-230-127.tpgi.com.au. [58.6.230.127])
        by smtp.gmail.com with ESMTPSA id nk23-20020a17090b195700b00256dff5f8e3sm7153055pjb.49.2023.06.06.02.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:27:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 19:27:03 +1000
Message-Id: <CT5GKZN6D21R.3US3D2GZWGLS2@wheely>
Subject: Re: [PATCH 4/4] powerpc/kuap: Make disabling KUAP at boottime
 optional
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.14.0
References: <1a3c69e38349b687c6c65240d7c09a7817a797d8.1685963081.git.christophe.leroy@csgroup.eu> <8d5438da7174ecb32e1c28cdb49987648df6ef15.1685963081.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8d5438da7174ecb32e1c28cdb49987648df6ef15.1685963081.git.christophe.leroy@csgroup.eu>
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
> It is possible to disable KUAP at boottime with 'nosmap' parameter.
>
> That is implemented with jump_label hence adds a 'nop' in front
> of each open/close of userspace access.
>
> From a security point of view it makes sence to disallow disabling
> KUAP. And on processors like the 8xx where 'nop' is not seamless,
> it saves a few cycles.
>
> So add a CONFIG item to make it optionnal.

I love counting cycles, but a CONFIG option for one nop... I think
you have me beat.

Is that sustainable? What if instead of the static branch you patched in
nops to the lock/unlock asm? AFAIKS there does not look like much (any?)
C code in the kuap enabled branches.

Thanks,
Nick

>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/kup.h         |  2 +-
>  arch/powerpc/mm/init-common.c          |  3 +++
>  arch/powerpc/platforms/Kconfig.cputype | 10 ++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/ku=
p.h
> index 74b7f4cee2ed..f3280169aeec 100644
> --- a/arch/powerpc/include/asm/kup.h
> +++ b/arch/powerpc/include/asm/kup.h
> @@ -53,7 +53,7 @@ extern struct static_key_false disable_kuap_key;
> =20
>  static __always_inline bool kuap_is_disabled(void)
>  {
> -	return static_branch_unlikely(&disable_kuap_key);
> +	return IS_ENABLED(CONFIG_PPC_KUAP_BOOTTIME) && static_branch_unlikely(&=
disable_kuap_key);
>  }
>  #endif
>  #else
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.=
c
> index 74e140b1efef..994ee58f0092 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -48,6 +48,9 @@ early_param("nosmep", parse_nosmep);
> =20
>  static int __init parse_nosmap(char *p)
>  {
> +	if (!IS_ENABLED(CONFIG_PPC_KUAP_BOOTTIME))
> +		return 0;
> +
>  	disable_kuap =3D true;
>  	pr_warn("Disabling Kernel Userspace Access Protection\n");
>  	return 0;
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platfo=
rms/Kconfig.cputype
> index 45fd975ef521..f75c2d5cd182 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -502,6 +502,16 @@ config PPC_KUAP
> =20
>  	  If you're unsure, say Y.
> =20
> +config PPC_KUAP_BOOTTIME
> +	bool "Allow disabling Kernel Userspace Access Protection at boottime"
> +	depends on PPC_KUAP
> +	default y
> +	help
> +	  Allow the user to disable Kernel Userspace Access Protection (KUAP)
> +	  at boot time using 'nosmap' kernel parameter.
> +
> +	  If you're unsure, say Y.
> +
>  config PPC_KUAP_DEBUG
>  	bool "Extra debugging for Kernel Userspace Access Protection"
>  	depends on PPC_KUAP
> --=20
> 2.40.1

