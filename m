Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8F6D734F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbjDEETo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjDEETl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:19:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AFD10F9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 21:19:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r11so34824882wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 21:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1680668377;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BjpitaAtSgkqnnZepwdAnWUHtXKGCm4ypPOIBhTYG4=;
        b=e4BiLC+K4OYu8TIu0STxll21APg+0MALOyXN2SMFNO5cMHrJpvXOAIvzfiUxo2q+V5
         WDvHh+QslH4AhH+2TjZuYkNkEaTLztytVL2f0UYCH/TmJEd/0TAAlr//N84HDPO+XfkD
         bvPR0eoq113cOieEQrQOeDXLnxrzu4Jx3aEwesqPJ349gVeRWz3Da6iqV4pSU/2Y4iNt
         MnRmqCgCxV0aZLY7aaRW/N/kl8M1sH1Tu+WzfPMLUDgArZTNBjGppJ3nUd1FX9TI0JaZ
         seEVGGKFa1LrcmSBIBRzX4kFY1havHXXvqCKrIitnLfe41G3TACDVnWYFtLdpqNQBFsi
         ii4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680668377;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BjpitaAtSgkqnnZepwdAnWUHtXKGCm4ypPOIBhTYG4=;
        b=n/i9zcL0GPP0uW+dIZ+MSIqash427YhnLiKSM6SecPv/eCkfJyhq81wqKITziuOeUs
         CdXTu+Ro7EzNT/oQWRoJDLj2/T9s4wz1JrSp3AEBGmzdwdUX1OUAkzxUh3i3aAhu0mxq
         W/Rgm+8vjbwGku7xsfAvVO1lGZud4VTO2Ur6eI7mRFNp6f5duOHG455/I9epbiXy241v
         jahe5UtbKEam/C/D2cglJZGTPtseFryMuNuA0/FUkjN81E/vtzJUu4URYXH/OBxV0Cxk
         H5RJPIRLSLfcGdKwnr9tITKO+hIJkt46kzw4MKWrjaTIRvMCNF1PlBL/ezIp8EwguOAX
         ygog==
X-Gm-Message-State: AAQBX9dTKcUp3wYFby/SYtfw8V1Z1rPqFabaKcjD2ScwgwOpubrbePXR
        Y3UWKQtttnAe9auHXYz3tiebrw==
X-Google-Smtp-Source: AKy350blw7YP4lnrKWGeXu58qdeqpEXA8gM8aenLdDfKqAQOydoUR5t2gTdnK43PxXcc1htfiqIEPA==
X-Received: by 2002:a5d:6b91:0:b0:2e5:9101:e3af with SMTP id n17-20020a5d6b91000000b002e59101e3afmr3411038wrx.31.1680668377340;
        Tue, 04 Apr 2023 21:19:37 -0700 (PDT)
Received: from smtpclient.apple (global-5-142.n-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003ee42696acesm797550wmj.16.2023.04.04.21.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2023 21:19:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH V4 22/23] platform/surface: Disable for RISC-V
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230404182037.863533-23-sunilvl@ventanamicro.com>
Date:   Wed, 5 Apr 2023 05:19:35 +0100
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev,
        Weili Qian <qianweili@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAC85F14-B1DA-4358-9042-A607436D582A@jrtc27.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-23-sunilvl@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2023, at 19:20, Sunil V L <sunilvl@ventanamicro.com> wrote:
>=20
> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled
> in allmodconfig build. However, RISC-V doesn't support sub-word
> atomics which is used by this driver.

Why not? Compilers and libatomic do, so surely the Linux kernel should
too.

> Due to this, the build fails
> with below error.
>=20
> In function =C3=A2=E2=82=AC=CB=9Cssh_seq_next=C3=A2=E2=82=AC=E2=84=A2,
>    inlined from =C3=A2=E2=82=AC=CB=9Cssam_request_write_data=C3=A2=E2=82=
=AC=E2=84=A2 at drivers/platform/surface/aggregator/controller.c:1483:8:
> ././include/linux/compiler_types.h:399:45: error: call to =
=C3=A2=E2=82=AC=CB=9C__compiletime_assert_335=C3=A2=E2=82=AC=E2=84=A2 =
declared with attribute error: BUILD_BUG failed
>  399 |         _compiletime_assert(condition, msg, =
__compiletime_assert_, __COUNTER__)
>      |                                             ^
> ./include/linux/compiler.h:78:45: note: in definition of macro =
=C3=A2=E2=82=AC=CB=9Cunlikely=C3=A2=E2=82=AC=E2=84=A2
>   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>      |                                             ^
> ././include/linux/compiler_types.h:387:9: note: in expansion of macro =
=C3=A2=E2=82=AC=CB=9C__compiletime_assert=C3=A2=E2=82=AC=E2=84=A2
>  387 |         __compiletime_assert(condition, msg, prefix, suffix)
>      |         ^~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:399:9: note: in expansion of macro =
=C3=A2=E2=82=AC=CB=9C_compiletime_assert=C3=A2=E2=82=AC=E2=84=A2
>  399 |         _compiletime_assert(condition, msg, =
__compiletime_assert_, __COUNTER__)
>      |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro =
=C3=A2=E2=82=AC=CB=9Ccompiletime_assert=C3=A2=E2=82=AC=E2=84=A2
>   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), =
msg)
>      |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro =
=C3=A2=E2=82=AC=CB=9CBUILD_BUG_ON_MSG=C3=A2=E2=82=AC=E2=84=A2
>   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>      |                     ^~~~~~~~~~~~~~~~
> ./arch/riscv/include/asm/cmpxchg.h:335:17: note: in expansion of macro =
=C3=A2=E2=82=AC=CB=9CBUILD_BUG=C3=A2=E2=82=AC=E2=84=A2
>  335 |                 BUILD_BUG();                                    =
        \
>      |                 ^~~~~~~~~
> ./arch/riscv/include/asm/cmpxchg.h:344:30: note: in expansion of macro =
=C3=A2=E2=82=AC=CB=9C__cmpxchg=C3=A2=E2=82=AC=E2=84=A2
>  344 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                   =
        \
>      |                              ^~~~~~~~~
> ./include/linux/atomic/atomic-instrumented.h:1916:9: note: in =
expansion of macro =C3=A2=E2=82=AC=CB=9Carch_cmpxchg=C3=A2=E2=82=AC=E2=84=A2=

> 1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>      |         ^~~~~~~~~~~~
> drivers/platform/surface/aggregator/controller.c:61:32: note: in =
expansion of macro =C3=A2=E2=82=AC=CB=9Ccmpxchg=C3=A2=E2=82=AC=E2=84=A2
>   61 |         while (unlikely((ret =3D cmpxchg(&c->value, old, new)) =
!=3D old)) {
>      |                                ^~~~~~~
>=20
> So, disable this driver for RISC-V even when ACPI is enabled for now.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
> drivers/platform/surface/aggregator/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/surface/aggregator/Kconfig =
b/drivers/platform/surface/aggregator/Kconfig
> index c114f9dd5fe1..88afc38ffdc5 100644
> --- a/drivers/platform/surface/aggregator/Kconfig
> +++ b/drivers/platform/surface/aggregator/Kconfig
> @@ -4,7 +4,7 @@
> menuconfig SURFACE_AGGREGATOR
> 	tristate "Microsoft Surface System Aggregator Module Subsystem =
and Drivers"
> 	depends on SERIAL_DEV_BUS
> -	depends on ACPI
> +	depends on ACPI && !RISCV

If you insist on doing this, at least make it some new config variable
that=E2=80=99s self-documenting and means this automatically gets =
re-enabled
when arch/riscv fixes this deficiency? Hard-coding arch lists like this
seems like a terrible anti-pattern.

Jess

> 	select CRC_CCITT
> 	help
> 	  The Surface System Aggregator Module (Surface SAM or SSAM) is =
an
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

