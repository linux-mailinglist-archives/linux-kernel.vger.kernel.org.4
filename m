Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692F864FC67
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 22:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiLQVT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 16:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLQVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 16:19:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D911152;
        Sat, 17 Dec 2022 13:19:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEBD160C38;
        Sat, 17 Dec 2022 21:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED7CC433D2;
        Sat, 17 Dec 2022 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671311992;
        bh=p/0nO9i7GWqBqP87EvUQ61fph64TmmdkKS0Iw0gBMf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bz5PZ2l/VGVQ4Qw9cdvifYU0i4S+hG/Vx7q7Sgk73dE4fG7YrMYew4xxcme68A5dV
         rTkxZL1Fk+trrwZO7pFgikOmFCDz75hJyt88mVINoNXlnGZSUl5PCYz7IhMDnp19f8
         WQZ/nd7Z9LTOjfDuiJ0ShXacfZkg4er+YmnBdiERmkoGBBRxNQ3lrbR/0hboveUZ63
         XSWjNhN3hs7eMtrDfVF9ZdkKjSkgU7tr6BXpqbpbwR4k1hrcV0NCoxut+CxWYWiDfD
         nKXinX8JVsKSpFe35gNiNkOaU6QX6AjdAbDW+5bwAfBg/ei/mgPpESr/VaE/kgkid2
         SAb+/IE6MbB5Q==
Date:   Sat, 17 Dec 2022 21:19:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 3/6] riscv: errata: Add Andes alternative ports
Message-ID: <Y54ycZdMLjU5QVn5@spud>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2szLuNpf/dOaMo1j"
Content-Disposition: inline
In-Reply-To: <20221212115505.36770-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2szLuNpf/dOaMo1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2022 at 11:55:02AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add required ports of the Alternative scheme for Andes CPU cores.
>=20
> I/O Coherence Port (IOCP) provides an AXI interface for connecting extern=
al
> non-caching masters, such as DMA controllers. IOCP is a specification
> option and is disabled on the Renesas RZ/Five SoC due to this reason cache
> management needs a software workaround.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4 -> v5
> * Sorted the Kconfig/Makefile/Switch based on Core name
> * Added a comments
> * Introduced RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT ID to check if
>   CMO needs to be applied. Is there a way we can access the DTB while pat=
ching
>   as we can drop this SBI EXT ID and add a DT property instead for cmo?
>=20
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/Kconfig.erratas           | 22 +++++++
>  arch/riscv/errata/Makefile           |  1 +
>  arch/riscv/errata/andes/Makefile     |  1 +
>  arch/riscv/errata/andes/errata.c     | 93 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h |  3 +
>  arch/riscv/include/asm/errata_list.h |  5 ++
>  arch/riscv/kernel/alternative.c      |  5 ++
>  7 files changed, 130 insertions(+)
>  create mode 100644 arch/riscv/errata/andes/Makefile
>  create mode 100644 arch/riscv/errata/andes/errata.c
>=20
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 69621ae6d647..f0f0c1abd52b 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -1,5 +1,27 @@
>  menu "CPU errata selection"
> =20
> +config ERRATA_ANDES
> +	bool "Andes AX45MP errata"
> +	depends on !XIP_KERNEL
> +	select RISCV_ALTERNATIVE
> +	help
> +	  All Andes errata Kconfig depend on this Kconfig. Disabling
> +	  this Kconfig will disable all Andes errata. Please say "Y"
> +	  here if your platform uses Andes CPU cores.
> +
> +	  Otherwise, please say "N" here to avoid unnecessary overhead.
> +
> +config ERRATA_ANDES_CMO
> +	bool "Apply Andes cache management errata"
> +	depends on ERRATA_ANDES && MMU && ARCH_R9A07G043
> +	select RISCV_DMA_NONCOHERENT
> +	default y
> +	help
> +	  This will apply the cache management errata to handle the
> +	  non-standard handling on non-coherent operations on Andes cores.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  config ERRATA_SIFIVE
>  	bool "SiFive errata"
>  	depends on !XIP_KERNEL
> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index a1055965fbee..6f1c693af92d 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -1,2 +1,3 @@
> +obj-$(CONFIG_ERRATA_ANDES) +=3D andes/
>  obj-$(CONFIG_ERRATA_SIFIVE) +=3D sifive/
>  obj-$(CONFIG_ERRATA_THEAD) +=3D thead/
> diff --git a/arch/riscv/errata/andes/Makefile b/arch/riscv/errata/andes/M=
akefile
> new file mode 100644
> index 000000000000..2d644e19caef
> --- /dev/null
> +++ b/arch/riscv/errata/andes/Makefile
> @@ -0,0 +1 @@
> +obj-y +=3D errata.o
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/e=
rrata.c
> new file mode 100644
> index 000000000000..3d04f15df8d5
> --- /dev/null
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Erratas to be applied for Andes CPU cores
> + *
> + *  Copyright (C) 2022 Renesas Electronics Corporation.
> + *
> + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/errata_list.h>
> +#include <asm/patch.h>
> +#include <asm/sbi.h>
> +#include <asm/vendorid_list.h>
> +
> +#define ANDESTECH_AX45MP_MARCHID	0x8000000000008a45UL
> +#define ANDESTECH_AX45MP_MIMPID		0x500UL
> +#define ANDESTECH_SBI_EXT_ANDES		0x0900031E
> +
> +#define RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND	0
> +
> +static long ax45mp_iocp_sw_workaround(void)
> +{
> +	struct sbiret ret;
> +
> +	ret =3D sbi_ecall(ANDESTECH_SBI_EXT_ANDES, RZFIVE_SBI_EXT_IOCP_SW_WORKA=
ROUND,
> +			0, 0, 0, 0, 0, 0);

Seeing as you need a new version for some of the other bits, I think it
would be good to add a minor comment here somewhere (be it here or the
commit message) that links to the SBI specs for this.
I think this looks pretty good though.
Thanks,
Conor.

> +
> +	return ret.error ? 0 : ret.value;
> +}
> +
> +static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id,=
 unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> +		return false;
> +
> +	if (arch_id !=3D ANDESTECH_AX45MP_MARCHID || impid !=3D ANDESTECH_AX45M=
P_MIMPID)
> +		return false;
> +
> +	if (!ax45mp_iocp_sw_workaround())
> +		return false;
> +
> +	/* Set this just to make core cbo code happy */
> +	riscv_cbom_block_size =3D 1;
> +	riscv_noncoherent_supported();
> +
> +	return true;
> +}
> +
> +static u32 andes_errata_probe(unsigned int stage, unsigned long archid, =
unsigned long impid)
> +{
> +	u32 cpu_req_errata =3D 0;
> +
> +	/*
> +	 * In the absence of the I/O Coherency Port, access to certain peripher=
als
> +	 * requires vendor specific DMA handling.
> +	 */
> +	if (errata_probe_iocp(stage, archid, impid))
> +		cpu_req_errata |=3D BIT(ERRATA_ANDESTECH_NO_IOCP);
> +
> +	return cpu_req_errata;
> +}
> +
> +void __init_or_module andes_errata_patch_func(struct alt_entry *begin, s=
truct alt_entry *end,
> +					      unsigned long archid, unsigned long impid,
> +					      unsigned int stage)
> +{
> +	u32 cpu_req_errata =3D andes_errata_probe(stage, archid, impid);
> +	struct alt_entry *alt;
> +	u32 tmp;
> +
> +	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return;
> +
> +	for (alt =3D begin; alt < end; alt++) {
> +		if (alt->vendor_id !=3D ANDESTECH_VENDOR_ID)
> +			continue;
> +		if (alt->errata_id >=3D ERRATA_ANDESTECH_NUMBER)
> +			continue;
> +
> +		tmp =3D BIT(alt->errata_id);
> +		if (cpu_req_errata & tmp) {
> +			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> +
> +			riscv_alternative_fix_offsets(alt->old_ptr, alt->alt_len,
> +						      alt->old_ptr - alt->alt_ptr);
> +		}
> +	}
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/as=
m/alternative.h
> index 1bd4027d34ca..e3a8e603eb5a 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -43,6 +43,9 @@ struct errata_checkfunc_id {
>  	bool (*func)(struct alt_entry *alt);
>  };
> =20
> +void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *=
end,
> +			     unsigned long archid, unsigned long impid,
> +			     unsigned int stage);
>  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry =
*end,
>  			      unsigned long archid, unsigned long impid,
>  			      unsigned int stage);
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 4180312d2a70..2ba7e6e74540 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -9,6 +9,11 @@
>  #include <asm/csr.h>
>  #include <asm/vendorid_list.h>
> =20
> +#ifdef CONFIG_ERRATA_ANDES
> +#define ERRATA_ANDESTECH_NO_IOCP	0
> +#define ERRATA_ANDESTECH_NUMBER		1
> +#endif
> +
>  #ifdef CONFIG_ERRATA_SIFIVE
>  #define	ERRATA_SIFIVE_CIP_453 0
>  #define	ERRATA_SIFIVE_CIP_1200 1
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> index e12b06940154..0a09cbbc2593 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -40,6 +40,11 @@ static void __init_or_module riscv_fill_cpu_mfr_info(s=
truct cpu_manufacturer_inf
>  #endif
> =20
>  	switch (cpu_mfr_info->vendor_id) {
> +#ifdef CONFIG_ERRATA_ANDES
> +	case ANDESTECH_VENDOR_ID:
> +		cpu_mfr_info->patch_func =3D andes_errata_patch_func;
> +		break;
> +#endif
>  #ifdef CONFIG_ERRATA_SIFIVE
>  	case SIFIVE_VENDOR_ID:
>  		cpu_mfr_info->patch_func =3D sifive_errata_patch_func;
> --=20
> 2.25.1
>=20

--2szLuNpf/dOaMo1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY54ycQAKCRB4tDGHoIJi
0iv5AP99jz5cQnHGHH6DPtSjUP6Rzlll+McB7Ac8uT/xyqPVeAEAt3UThuSjPMng
LtVjLJqskflbKy53J/P02f96qTWBpgo=
=XQz9
-----END PGP SIGNATURE-----

--2szLuNpf/dOaMo1j--
