Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CE468A8BD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjBDHGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjBDHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:06:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F41DB99;
        Fri,  3 Feb 2023 23:05:56 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g9so5180908pfk.13;
        Fri, 03 Feb 2023 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMCAPt/b5VPCgN4+hLU0BP6Oe4JKzymPkGz4kOFePo8=;
        b=Ltny29cs0aZfYU/CfyTMoV14isVocxOPPbGJA/Uj2vp7i+x7SPypIkbeRyM6uRZ7sI
         BxVYPPBtK0hTDpysAHPf6IMXjKm0zmnCEBI8WO3TbdY9KwB67DLz4S+bAbm8gS7gbzLK
         xVqxyI5sJNfBvjQLEEeHKE3ck5YQoOyjQUOcPxb6H7/p0MZJwPhlbMeN6D/x52Ro/LWJ
         I1AfVWK7KefNT30h0hvIRCuit0nojy7HYk1/FjMZDP76BaQAeJNFsF6hPX3916OEsZVP
         34Xb5mXGTdulvFuH2Tb8Hs5utk85if7RImuNXH3ZILAz3XFVKAjAv5UWXRnO288a1CAn
         c7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMCAPt/b5VPCgN4+hLU0BP6Oe4JKzymPkGz4kOFePo8=;
        b=AY9qloitBNp0i5N9r855ZvVJ2M28XALQ+OIIBEr8f3wmsBdxRs3g1+HQ4aNXQ1GD4o
         Fm7TI9oyk3nbgp6RADjr47SpcvXOAvmoOFjtaRN1vXEV6XwBhf/tlkfAMsZDTRTx+OGy
         y7LA7/FRkQw8q2v8Oiho3VD6iNdM4WnL7qwu1vrORSrCoRF9fQN/rVR6em9ZqI19s+tE
         u/ztSY5qgkvZJW4N5isnsiQMrgXY+JyGJHXHVR0vLf8BVMdF+q5MA8Ol4ooxILo77NtO
         6ET3CaJEKVQeFZntNjgBlUxjLR8gHtAwTZxKhSeSMLlJSFlJVgnWyEYU1MtZIONxM/si
         FaKw==
X-Gm-Message-State: AO0yUKXBfZlGzabMChy83ALK2+YXheFwW5LHlBi218PS7IKYXdYPYC2i
        4QQXMByQv8/4OYA1Us3Gial1h04NjFnDj2vz
X-Google-Smtp-Source: AK7set9rNfIlI8abkCYTXaQr110+N8/QgDhqoaFskR51jpv92PaRMhlw9KPuamOi0PBXPuBgolPE+Q==
X-Received: by 2002:aa7:946d:0:b0:593:dc84:531a with SMTP id t13-20020aa7946d000000b00593dc84531amr12935281pfq.30.1675494355666;
        Fri, 03 Feb 2023 23:05:55 -0800 (PST)
Received: from [127.0.0.1] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id 131-20020a621489000000b00593cad8566fsm2947951pfu.132.2023.02.03.23.05.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2023 23:05:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2] sh: init: use OF_EARLY_FLATTREE for early init
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <20230204055116.22591-1-rdunlap@infradead.org>
Date:   Sat, 4 Feb 2023 16:05:47 +0900
Cc:     "D. Jeff Dionne" <djeffdionne@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8F0719C-0C0A-45F0-A4DA-66DE807DECDA@gmail.com>
References: <20230204055116.22591-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy, which SH3 chipset target are you building for?  Of course all =
that stay need to be converted to device tree, but a DT SH3 proof of =
existence that you build for already will surely cover good swath of the =
missing drivers.

J.

> On Feb 4, 2023, at 14:51, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
> SH3 build fails with a call to early_init_dt_scan(), so in
> arch/sh/kernel/setup.c and arch/sh/kernel/head_32.S, use
> CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF_FLATTREE.
>=20
> Fixes this build error:
> ../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
> ../arch/sh/kernel/setup.c:262:26: error: implicit declaration of =
function 'early_init_dt_scan' [-Werror=3Dimplicit-function-declaration]
>  262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {
>=20
> Fixes: 03767daa1387 ("sh: fix build regression with CONFIG_OF && =
!CONFIG_OF_FLATTREE")
> Fixes: eb6b6930a70f ("sh: fix memory corruption of unflattened device =
tree")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Rich Felker <dalias@libc.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> ---
> v2: use Suggested-by: for Rob.
>    add more Cc's.
>=20
> arch/sh/kernel/head_32.S |    6 +++---
> arch/sh/kernel/setup.c   |    4 ++--
> 2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff arch/sh/kernel/setup.c arch/sh/kernel/setup.c
> diff -- a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -244,7 +244,7 @@ void __init __weak plat_early_device_set
> {
> }
>=20
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
> void __ref sh_fdt_init(phys_addr_t dt_phys)
> {
> 	static int done =3D 0;
> @@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
> 	/* Let earlyprintk output early console messages */
> 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
>=20
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
> #ifdef CONFIG_USE_BUILTIN_DTB
> 	unflatten_and_copy_device_tree();
> #else
> diff -- a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
> --- a/arch/sh/kernel/head_32.S
> +++ b/arch/sh/kernel/head_32.S
> @@ -64,7 +64,7 @@ ENTRY(_stext)
> 	ldc	r0, r6_bank
> #endif
>=20
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
> 	mov	r4, r12		! Store device tree blob pointer in r12
> #endif
> =09
> @@ -315,7 +315,7 @@ ENTRY(_stext)
> 10:	=09
> #endif
>=20
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
> 	mov.l	8f, r0		! Make flat device tree available early.
> 	jsr	@r0
> 	 mov	r12, r4
> @@ -346,7 +346,7 @@ ENTRY(stack_start)
> 5:	.long	start_kernel
> 6:	.long	cpu_init
> 7:	.long	init_thread_union
> -#if defined(CONFIG_OF_FLATTREE)
> +#if defined(CONFIG_OF_EARLY_FLATTREE)
> 8:	.long	sh_fdt_init
> #endif
>=20

