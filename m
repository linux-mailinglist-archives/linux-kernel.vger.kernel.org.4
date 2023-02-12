Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B264F6937E8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBLPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBLPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:20:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACBCEF9A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:20:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A14E5B80D22
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 15:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D226FC433D2;
        Sun, 12 Feb 2023 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676215241;
        bh=Q6PfIxygpEI1xYX10zbPzF5LkiAr6uoFoBrtPWMcTBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKgnh11vHYQoUazFUZpNdidBVWeSBiab5pXF+J49+vPZ91ExvB6X4ik6A+F+uGom4
         2SApBSGigp00vFR79lYzhOzE2L30Qwlu+KwE1rdo5cUT4JFn4WAWs1CyGmGtxSpCgP
         hf51r7qckBrCtKXt4mscr7k61lJX+YEEUHsRFrPw4FfbWnfD4Jo3nNBiLzjhHT9cKI
         2MDvP/DE511/J5eA6sa+CEjhymIn6JU48Ogp3iXAfOeFKzOVqApmeU7gFOnFYrO9b8
         B1b1PTIZIeLrChyS7v35W1g/RJF86K5TwHPIOvLmB88bhG4mGgCOvm3pIRisKaZc+F
         XG1lMsOLxsLqg==
Date:   Sun, 12 Feb 2023 15:20:36 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Fix Zbb alternative IDs
Message-ID: <Y+kDxJTe161pQns8@spud>
References: <20230212021534.59121-1-samuel@sholland.org>
 <20230212021534.59121-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4XRBP165aId13kTT"
Content-Disposition: inline
In-Reply-To: <20230212021534.59121-3-samuel@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4XRBP165aId13kTT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2023 at 08:15:33PM -0600, Samuel Holland wrote:
> Commit 4bf8860760d9 ("riscv: cpufeature: extend
> riscv_cpufeature_patch_func to all ISA extensions") switched ISA
> extension alternatives to use the RISCV_ISA_EXT_* macros instead of
> CPUFEATURE_*. This was mismerged when applied on top of the Zbb series,
> so the Zbb alternatives referenced the wrong errata ID values.
>=20
> Fixes: 9daca9a5b9ac ("Merge patch series "riscv: improve boot time isa ex=
tensions handling"")

Re: your question on irc, I think you did the right thing here as
Jisheng did remove them in his series:
https://lore.kernel.org/linux-riscv/20230128172856.3814-5-jszhang@kernel.or=
g/
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  arch/riscv/include/asm/errata_list.h | 5 -----
>  arch/riscv/lib/strcmp.S              | 2 +-
>  arch/riscv/lib/strlen.S              | 2 +-
>  arch/riscv/lib/strncmp.S             | 2 +-
>  4 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index e158439029ce..274c6f889602 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -23,11 +23,6 @@
>  #define	ERRATA_THEAD_NUMBER 3
>  #endif
> =20
> -#define	CPUFEATURE_SVPBMT 0
> -#define	CPUFEATURE_ZICBOM 1
> -#define	CPUFEATURE_ZBB 2
> -#define	CPUFEATURE_NUMBER 3
> -
>  #ifdef __ASSEMBLY__
> =20
>  #define ALT_INSN_FAULT(x)						\
> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> index 8148b6418f61..986ab23fe787 100644
> --- a/arch/riscv/lib/strcmp.S
> +++ b/arch/riscv/lib/strcmp.S
> @@ -9,7 +9,7 @@
>  /* int strcmp(const char *cs, const char *ct) */
>  SYM_FUNC_START(strcmp)
> =20
> -	ALTERNATIVE("nop", "j strcmp_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_=
ZBB)
> +	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_I=
SA_ZBB)
> =20
>  	/*
>  	 * Returns
> diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> index 0f9dbf93301a..8345ceeee3f6 100644
> --- a/arch/riscv/lib/strlen.S
> +++ b/arch/riscv/lib/strlen.S
> @@ -9,7 +9,7 @@
>  /* int strlen(const char *s) */
>  SYM_FUNC_START(strlen)
> =20
> -	ALTERNATIVE("nop", "j strlen_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_=
ZBB)
> +	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_I=
SA_ZBB)
> =20
>  	/*
>  	 * Returns
> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> index 7940ddab2d48..ee49595075be 100644
> --- a/arch/riscv/lib/strncmp.S
> +++ b/arch/riscv/lib/strncmp.S
> @@ -9,7 +9,7 @@
>  /* int strncmp(const char *cs, const char *ct, size_t count) */
>  SYM_FUNC_START(strncmp)
> =20
> -	ALTERNATIVE("nop", "j strncmp_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA=
_ZBB)
> +	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_=
ISA_ZBB)
> =20
>  	/*
>  	 * Returns
> --=20
> 2.37.4
>=20

--4XRBP165aId13kTT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+kDxAAKCRB4tDGHoIJi
0ny1AP0Yt08c7udSKlM5PWcWZxBQFD3ylYVIrGMDejmq57eXpgEA1wmER8+7QeqZ
6c9gTh4d/jJH88lUVSMpNfSw0J4QJwU=
=ANME
-----END PGP SIGNATURE-----

--4XRBP165aId13kTT--
