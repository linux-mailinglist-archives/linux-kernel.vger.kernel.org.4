Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B371485E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjE2LNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjE2LNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:13:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508FCD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685358815; x=1716894815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8a8bLWcWa4E6Z5SMzPm8KuTfSTZ7L4/MciWyy2gXm34=;
  b=Q778iV6EePWj90HwEZzwe/O5s3xQ+V3if5vPdtqqEWZEuXjBHULIyxj9
   GFjTWaawD4/rjCrsnOKEccFi3gJQnAoTIX7k+wmk0UnCveSDKiR5z+KSZ
   k7PvxzyJlcCV+ev8Mia+f1Yh+8zLjRwbxe4e4mWBoA3MbcqjCB3dEGXt8
   J9fB4XzLf6CAZIAKnmNSM+5pNwRkyII5i657Ty4fhaXOkd2blJ0tqzurX
   MGPgebsalYYMk2F9dpaGkojkR/J0baAi1IHm9HGNKYU+6dN+c71F5cDBH
   V9UE6E5xpIwV/Lzz1oteqbT/7Sq4/XrEy6WDJkhPu8L/PeYHIJixKqtpo
   g==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="227432476"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 04:13:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 04:13:34 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 04:13:33 -0700
Date:   Mon, 29 May 2023 12:13:10 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/6] riscv: mm: pass noncoherent or not to
 riscv_noncoherent_supported()
Message-ID: <20230529-gainfully-ribbon-48520d25ef6e@wendy>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LdIjfd9IkuqYWybD"
Content-Disposition: inline
In-Reply-To: <20230526165958.908-5-jszhang@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--LdIjfd9IkuqYWybD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Sat, May 27, 2023 at 12:59:56AM +0800, Jisheng Zhang wrote:
> We will soon take different actions by checking the HW is noncoherent
> or not, I.E ZICBOM/ERRATA_THEAD_CMO or not.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/errata/thead/errata.c    | 19 +++++++++++--------
>  arch/riscv/include/asm/cacheflush.h |  4 ++--
>  arch/riscv/kernel/setup.c           |  6 +++++-
>  arch/riscv/mm/dma-noncoherent.c     | 10 ++++++----
>  4 files changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index be84b14f0118..c192b80a5166 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -36,21 +36,24 @@ static bool errata_probe_pbmt(unsigned int stage,
>  static bool errata_probe_cmo(unsigned int stage,
>  			     unsigned long arch_id, unsigned long impid)
>  {
> -	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_CMO))
> -		return false;
> -
> -	if (arch_id !=3D 0 || impid !=3D 0)
> -		return false;
> +	bool cmo;
> =20
>  	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>  		return false;
> =20
> +	if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO) &&
> +	    (arch_id =3D=3D 0 && impid =3D=3D 0))
> +		cmo =3D true;
> +	else
> +		cmo =3D false;
> +
>  	if (stage =3D=3D RISCV_ALTERNATIVES_BOOT) {
> -		riscv_cbom_block_size =3D L1_CACHE_BYTES;
> -		riscv_noncoherent_supported();
> +		if (cmo)
> +			riscv_cbom_block_size =3D L1_CACHE_BYTES;
> +		riscv_noncoherent_supported(cmo);
>  	}
> =20
> -	return true;
> +	return cmo;

I don't really understand the changes that you are making to this
function, so that is tries really hard to call
riscv_noncoherent_supported(). Why do we need to always call the function
in the erratum's probe function, if the erratum is not detected, given
that riscv_noncoherent_supported() is called immediately after
apply_boot_alternatives() in setup_arch()?

>  }
> =20
>  static bool errata_probe_pmu(unsigned int stage,
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm=
/cacheflush.h
> index 8091b8bf4883..9d056c9b625a 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -54,9 +54,9 @@ extern unsigned int riscv_cboz_block_size;
>  void riscv_init_cbo_blocksizes(void);
> =20
>  #ifdef CONFIG_RISCV_DMA_NONCOHERENT
> -void riscv_noncoherent_supported(void);
> +void riscv_noncoherent_supported(bool cmo);

I think it would "read better" if you renamed this variable to
"have_cmo".

>  #else
> -static inline void riscv_noncoherent_supported(void) {}
> +static inline void riscv_noncoherent_supported(bool cmo) {}
>  #endif
> =20
>  /*
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 36b026057503..565f3e20169b 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -264,6 +264,7 @@ static void __init parse_dtb(void)
> =20
>  void __init setup_arch(char **cmdline_p)
>  {
> +	bool cmo;
>  	parse_dtb();
>  	setup_initial_init_mm(_stext, _etext, _edata, _end);
> =20
> @@ -298,7 +299,10 @@ void __init setup_arch(char **cmdline_p)
>  	apply_boot_alternatives();
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
>  	    riscv_isa_extension_available(NULL, ZICBOM))
> -		riscv_noncoherent_supported();
> +		cmo =3D true;
> +	else
> +		cmo =3D false;
> +	riscv_noncoherent_supported(cmo);

As a nit, could you put a newline before the call to
riscv_noncoherent_supported()?

>  }
> =20
>  static int __init topology_init(void)
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index d51a75864e53..0e172e2b4751 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -72,9 +72,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_ba=
se, u64 size,
>  	dev->dma_coherent =3D coherent;
>  }
> =20
> -void riscv_noncoherent_supported(void)
> +void riscv_noncoherent_supported(bool cmo)
>  {
> -	WARN(!riscv_cbom_block_size,
> -	     "Non-coherent DMA support enabled without a block size\n");
> -	noncoherent_supported =3D true;
> +	if (cmo) {
> +		WARN(!riscv_cbom_block_size,
> +		     "Non-coherent DMA support enabled without a block size\n");
> +		noncoherent_supported =3D true;
> +	}

The other places that we do a WARN() because of screwed up devicetrees
for CMO things, we do a WARN_TAINT(CPU_OUT_OF_SPEC). Should we do the
same here too?

Cheers,
Conor.

--LdIjfd9IkuqYWybD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSIxgAKCRB4tDGHoIJi
0r2zAP4/o/UdOXXE7NUjsPH3algfaH5WPaPWMlf34Kf0XaUz6gEAiUjI+hLqacnX
ZCETuX7h2+mM54YLt6LmbMmincPwBgA=
=jVix
-----END PGP SIGNATURE-----

--LdIjfd9IkuqYWybD--
