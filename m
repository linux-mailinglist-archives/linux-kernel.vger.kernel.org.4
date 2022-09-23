Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B175E748C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIWHIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiIWHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:08:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F867121643
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:08:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso7129624pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=LZZ+DFcc0llvJVRrXIipCqbT3nWDNjH2GYv6SFsu7to=;
        b=kRbvrL9AJnktY9aS5QS918bp2JUVCwAi+7X6OH2jM2hXMFmXBIPyKV+WqClPPxqFUD
         6leBHKdZxnDRq6Hjx3gwIv5bRruNBEmkbiekRtwEHod8Ri21iYQcBePcWaLI223L5RQl
         xT4ARIiRWLq4pHZdFf2Q8Nx6E+wf9HQcCE1j2szYrHoxbNxKnVpFEybfkrnL6G1wq3EA
         wLXI57uLu7uTE3M+FxJs2nviFYHymI8wP//GiSOuiLN9fwvbwDvf4sRqv7LTpPswtMUV
         mDUr+IKEq+Hfpt00BsvQw3D/ScocwtLjZIg6YWYCF7y5+eoVnr1Msww8SBc+Xp35Inlh
         P7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=LZZ+DFcc0llvJVRrXIipCqbT3nWDNjH2GYv6SFsu7to=;
        b=GJWzh5UC/V8t4ujCVmD+zaAZhuKF1NlXghhwbzk4h4VnrYNTEJ7SK8nCsIuuaNwIEZ
         pM8oBPox3wVVpk+c16xe4T8vXC25O/i/mz+wkpaJZnztTBs83FzvKVOxZ0A1Lgp8vxvf
         XpmdMtiWKb2qluF23MyJDHA2Qa2TdNwd4COz3JSq2Zc0Ce1Tu9DhoSwh6tIDDxE2FGNf
         ZjLMjLW+bwap/+xkK+eVr3ITgzPNia03DrrnrShALLCZP/BBB1fIXIqejZf5UG18BN5v
         +yVTcbQqokd4bUUQKh3HIYWmea5Va/lLb07tW87UWYb5rhcRXAMEMjBcCdamqDZ1Up6t
         RKyQ==
X-Gm-Message-State: ACrzQf3gOhfIaoGgLjNNcFHBuMl8Zed1Uby9lQHC0vlsvH2iDoz9OIhk
        7vEgK/TD3L6NAYI6RF0K5ig=
X-Google-Smtp-Source: AMsMyM7Zdp3FkT+V1HHoTww6RvyocVYeqOaa3XmpVCunWZBszIAGwRYpHQ+DEwfFK/GzwcrJxgyG8g==
X-Received: by 2002:a17:90b:4a82:b0:200:a89e:6f1f with SMTP id lp2-20020a17090b4a8200b00200a89e6f1fmr19165256pjb.13.1663916899651;
        Fri, 23 Sep 2022 00:08:19 -0700 (PDT)
Received: from localhost (27-32-155-116.static.tpgi.com.au. [27.32.155.116])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b0016c574aa0fdsm5262530plg.76.2022.09.23.00.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 00:08:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 23 Sep 2022 17:08:13 +1000
Message-Id: <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/irq: Modernise inline assembly in
 irq_soft_mask_{set,return}
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.11.0
References: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu>
In-Reply-To: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 20, 2022 at 4:41 PM AEST, Christophe Leroy wrote:
> local_paca is declared as global register asm("r13"), it is therefore
> garantied to always ever be r13.
>
> It is therefore not required to opencode r13 in the assembly, use
> a reference to local_paca->irq_soft_mask instead.
>
> This also allows removing the 'memory' clobber in irq_soft_mask_set()
> as GCC now knows what is being modified in memory.

The code matches the changelog AFAIKS. But I don't know where it is
guaranteed it will always be r13 in GCC and Clang. I still don't know
where in the specification or documentation suggests this.

There was some assertion it would always be r13, but that can't be a
*general* rule. e.g., the following code:

struct foo {
#ifdef BIGDISP
        int array[1024*1024];
#endif
        char bar;
};

register struct foo *foo asm("r13");

static void setval(char val)
{
        asm("stb%X0 %1,%0" : "=3Dm" (foo->bar) : "r" (val));
}

int main(void)
{
        setval(10);
}

With -O0 this generates stb 9,0(10) for me for GCC 12, and with -O2
-DBIGDISP it generates stb 10,0(9). So that makes me nervious. GCC
does not have some kind of correctness guarantee here, so it must not
have this in its regression tests etc., and who knows about clang.

If it is true for some particular subset of cases that we can guarantee,
e.g., using -O2 and irq_soft_mask offset within range of stb offset and
we can point to specification such that both GCC and Clang will follow
it, then okay. Otherwise I still think it's more trouble than it is
worth.

Thanks,
Nick

>
> Using %X modifier will give GCC a bit more flexibility on the code
> generation.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index e8de249339d8..dbe037ff4474 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -115,10 +115,7 @@ static inline notrace unsigned long irq_soft_mask_re=
turn(void)
>  {
>  	unsigned long flags;
> =20
> -	asm volatile(
> -		"lbz %0,%1(13)"
> -		: "=3Dr" (flags)
> -		: "i" (offsetof(struct paca_struct, irq_soft_mask)));
> +	asm volatile("lbz%X1 %0,%1" : "=3Dr" (flags) : "m" (local_paca->irq_sof=
t_mask));
> =20
>  	return flags;
>  }
> @@ -147,12 +144,7 @@ static inline notrace void irq_soft_mask_set(unsigne=
d long mask)
>  	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
>  		WARN_ON(mask && !(mask & IRQS_DISABLED));
> =20
> -	asm volatile(
> -		"stb %0,%1(13)"
> -		:
> -		: "r" (mask),
> -		  "i" (offsetof(struct paca_struct, irq_soft_mask))
> -		: "memory");
> +	asm volatile("stb%X0 %1,%0" : "=3Dm" (local_paca->irq_soft_mask) : "r" =
(mask));
>  }
> =20
>  static inline notrace unsigned long irq_soft_mask_set_return(unsigned lo=
ng mask)
> --=20
> 2.37.1

