Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29B06D6E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjDDUrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjDDUrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A73525B;
        Tue,  4 Apr 2023 13:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 039CB6386C;
        Tue,  4 Apr 2023 20:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FF1C433EF;
        Tue,  4 Apr 2023 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680641221;
        bh=M7AEWkhrz5m+HYdpjj6qhbiE8Cg4ln7oJCOBbFTIiRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKSVKmxvX+In5+aTFI38lD3mTwWpaROD+kYBh9cbnPJJlG3HlwLgZUz9omWVs9Ixr
         bruMbiboP0WvSmcfxUXXTJ4jZSZKstsJmEs66wU1pV7eQ6vEkAjBy3wYs489g5Gt77
         BteQHqtKWc2qqQaQmF8UyZX3irxIPZYxj2UeBS7GIXTuJjg+zHo/IM6Yi7thekeHrw
         R7+jl9kAL9xldbbtpzij3Q6BWjM4Ph7bgidogmBKQGiDvrXaGj6zpNU7XQirvkUyuD
         IZawGhwRO/Pp617SDrAWVKWBcrVNdcVvtiarwAekDRjP77OX+oq8QTewmM8N2FyfGT
         Qy2lX1fAAXYTg==
Date:   Tue, 4 Apr 2023 21:46:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Weili Qian <qianweili@huawei.com>,
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
Subject: Re: [PATCH V4 12/23] RISC-V: cpufeature: Avoid calling
 riscv_of_processor_hartid()
Message-ID: <20230404-pavestone-skinless-2f466941a95b@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-13-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kgJ+/uDheNc4jGb7"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-13-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kgJ+/uDheNc4jGb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 11:50:26PM +0530, Sunil V L wrote:
> riscv_fill_hwcap() finds hartid of each cpu but never really uses
> it. So, remove this unnecessary call.

"Never uses it" or "never really uses it"?
This commit message misses the point though I think - is this here to
get the hartid, or is it here to do all the property validation that
riscv_of_processor_hartid() does for a cpu node?

This was added all the way back in 4.20 in commit 732e8e4130ff ("RISC-V:
properly determine hardware caps").
As the loop is a for_each_of_cpu_node(), I don't think this change is
actually valid - there's no guarantee that the cpu we are iterating over
is actually available and the riscv_of_processor_hartid() check is used
to skip "bad" cpus AFAICT.

Perhaps I am missing something, I don't think you can do this until you
switch the loop to use something that only uses cpus that you know are
valid.

Cheers,
Conor.

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 59d58ee0f68d..63e56ce04162 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -91,7 +91,6 @@ void __init riscv_fill_hwcap(void)
>  	char print_str[NUM_ALPHA_EXTS + 1];
>  	int i, j, rc;
>  	unsigned long isa2hwcap[26] =3D {0};
> -	unsigned long hartid;
> =20
>  	isa2hwcap['i' - 'a'] =3D COMPAT_HWCAP_ISA_I;
>  	isa2hwcap['m' - 'a'] =3D COMPAT_HWCAP_ISA_M;
> @@ -109,10 +108,6 @@ void __init riscv_fill_hwcap(void)
>  		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>  		const char *temp;
> =20
> -		rc =3D riscv_of_processor_hartid(node, &hartid);
> -		if (rc < 0)
> -			continue;
> -
>  		if (of_property_read_string(node, "riscv,isa", &isa)) {
>  			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>  			continue;
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--kgJ+/uDheNc4jGb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCyMvQAKCRB4tDGHoIJi
0hpGAP4pgJiMrwEE4MqFKel0RfYzkzWShHChGkcaYXuq9E+PjwEA5j0+IIN4EnD3
iGmXBcTRH2L8dBKnu+t39ju3V81nRQs=
=z9Dv
-----END PGP SIGNATURE-----

--kgJ+/uDheNc4jGb7--
