Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F16FCDCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjEIS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEIS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DCDB4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B4A63638
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28902C433D2;
        Tue,  9 May 2023 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683656976;
        bh=/dkH0X9QFvdWzyFSW87BMSJow12Yf5GCpIFiBdDHDpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZZzIsmsQtHwsHlw/HAnmw/XQIzODFlap9ibuHqQ7d+4MyNzAgXSa4IhFmuv9WTan
         kLODFH2dHAYpeVZGqePoQH80qhgv2tSj5jU4oXXUwtyZRNKi+07c6Ndj1M/+BgEQY1
         BHbdnmDbJZSMjbPezMB/Fr69QlsRexHcUfu3s41BFHwM2TPIYsxRWWic1zmI6S0I6a
         xgHw7G4QLxsnGNiq2qC/4jbMR/4SEINam4e6G9OtZ+oOozm9lQxpkOI356BEhYng2M
         oncHyeecju7244lihby6HIRKlVZnviZ10+bD8P1jkLZvcvjJwje/WpotJ8AWmFT7qF
         ngQ/6IO3mCE9w==
Date:   Tue, 9 May 2023 19:29:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] RISC-V: Add Zba, Zbs extension probing
Message-ID: <20230509-exclusion-crested-67dad91b7055@spud>
References: <20230509182504.2997252-1-evan@rivosinc.com>
 <20230509182504.2997252-2-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B6X/AADM6tnISOtQ"
Content-Disposition: inline
In-Reply-To: <20230509182504.2997252-2-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B6X/AADM6tnISOtQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 11:25:01AM -0700, Evan Green wrote:
> Add the Zba address bit manipulation extension and Zbs single bit
> instructions extension into those the kernel is aware of and maintains
> in its riscv_isa bitmap.
>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Given you added the lads, rather than ignoring them due to the Zbs
change, I think you forgot my R-b from v1?
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> ---
>=20
> Changes in v2:
>  - Add Zbs as well
>=20
>  arch/riscv/include/asm/hwcap.h | 2 ++
>  arch/riscv/kernel/cpu.c        | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 ++
>  3 files changed, 6 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e0c40a4c63d5..6b2e8ff4638c 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -46,6 +46,8 @@
>  #define RISCV_ISA_EXT_ZICBOZ		34
>  #define RISCV_ISA_EXT_SMAIA		35
>  #define RISCV_ISA_EXT_SSAIA		36
> +#define RISCV_ISA_EXT_ZBA		37
> +#define RISCV_ISA_EXT_ZBS		38
> =20
>  #define RISCV_ISA_EXT_MAX		64

Heh, gonna start getting tight on bits here soonish :)

>  #define RISCV_ISA_EXT_NAME_LEN_MAX	32
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index c96aa56cf1c7..bd294364390d 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -184,7 +184,9 @@ static struct riscv_isa_ext_data isa_ext_arr[] =3D {
>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index b1d6b7e4b829..a1954c83638f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -236,7 +236,9 @@ void __init riscv_fill_hwcap(void)
>  				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
>  				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
>  				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
> +				SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
>  				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>  				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
>  				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> --=20
> 2.25.1
>=20

--B6X/AADM6tnISOtQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFqRCwAKCRB4tDGHoIJi
0nC4AQDHsQlCVjBd4jkD1jLd+iPE4qxOG+r9snQk1olq+ZEgKgEA3KF1DHY+2APQ
FwjrrVJr0kk42/XLN6nO4bjwDcd4uQk=
=MHIQ
-----END PGP SIGNATURE-----

--B6X/AADM6tnISOtQ--
