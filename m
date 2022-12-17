Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530BB64FC50
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 21:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLQUwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 15:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 15:52:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE5BE39;
        Sat, 17 Dec 2022 12:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A401760C49;
        Sat, 17 Dec 2022 20:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510E7C433EF;
        Sat, 17 Dec 2022 20:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671310339;
        bh=9VVTBzXnV6KBWlFAwdUE+9TcYF61FDpIXiV69L6AWhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJ6DFyt1J9sIoVrokFvRQ0j0HxF75kWqacdFE0Y7N4TLyk3tklsOk2NyKY+DZhvRj
         +NjndODjOpYBTZKhkCDOwgHcrlTSmfV5Ojd/yev/9NXRCHMUqMMN8FKsGCawBboj+R
         6D9ASfHdpz024mPaRZJvYV0ceGpcH7ssRfyws5JFSUfQwpNjAWnIv6OJMW984QHglz
         v37GdIra5YgPuUEqhhVfCvXeHhYvg6xHYY35AHfem++xf6liTvdvkuDtlZ+zn+MVl6
         w8KjY0hz9VJFp5ILS5SG5/fU2KqIeYJjvPDvM+J0S8obeGuArENTP3ZOTt7uVB+Qm+
         1caRWivvAnFag==
Date:   Sat, 17 Dec 2022 20:52:11 +0000
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
Subject: Re: [PATCH v5 4/6] riscv: mm: dma-noncoherent: Pass direction and
 operation to ALT_CMO_OP()
Message-ID: <Y54r+5lkSvgA9IxR@spud>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xwBsLtrovXDxZRvK"
Content-Disposition: inline
In-Reply-To: <20221212115505.36770-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xwBsLtrovXDxZRvK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Prabhakar,

On Mon, Dec 12, 2022 at 11:55:03AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Pass direction and operation to ALT_CMO_OP() macro.
>=20
> Vendors might want to perform different operations based on the direction
> and callbacks (arch_sync_dma_for_device/arch_sync_dma_for_cpu/
> arch_dma_prep_coherent) so to handle such cases pass the direction and
> operation to ALT_CMO_OP() macro. This is in preparation for adding errata
> for the Andes CPU core.

This patch seems to break the build on top of the most recent
linux-next:
=2E....../stuff/linux/arch/riscv/mm/pmem.c:13:53: error: too few arguments =
provided to function-like macro invocation
        ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
                                                           ^
/stuff/linux/arch/riscv/include/asm/errata_list.h:127:9: note: macro 'ALT_C=
MO_OP' defined here
#define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)          \
        ^
=2E.  CC      block/partitions/sgi.o
=2E+...+/stuff/linux/arch/riscv/mm/pmem.c:13:2: error: use of undeclared id=
entifier 'ALT_CMO_OP'
        ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
        ^
/stuff/linux/arch/riscv/mm/pmem.c:19:53: error: too few arguments provided =
to function-like macro invocation
        ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
                                                           ^
/stuff/linux/arch/riscv/include/asm/errata_list.h:127:9: note: macro 'ALT_C=
MO_OP' defined here
#define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)          \
        ^
=2E..........  AR      lib/math/built-in.a
=2E/stuff/linux/arch/riscv/mm/pmem.c:19:2: .error: use of undeclared identi=
fier 'ALT_CMO_OP'
        ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
        ^
=2E.4 errors generated.

The pmem stuff is new so that'd be why it has not come up before.

(FWIW, clang allmodconfig)

>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4 -> v5
> * Updated commit message.
>=20
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/include/asm/cacheflush.h  |  4 ++++
>  arch/riscv/include/asm/errata_list.h |  8 ++++++--
>  arch/riscv/mm/dma-noncoherent.c      | 15 ++++++++++-----
>  3 files changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm=
/cacheflush.h
> index 03e3b95ae6da..e22019668b9e 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -8,6 +8,10 @@
> =20
>  #include <linux/mm.h>
> =20
> +#define NON_COHERENT_SYNC_DMA_FOR_DEVICE	0
> +#define NON_COHERENT_SYNC_DMA_FOR_CPU		1
> +#define NON_COHERENT_DMA_PREP			2
> +
>  static inline void local_flush_icache_all(void)
>  {
>  	asm volatile ("fence.i" ::: "memory");
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 2ba7e6e74540..48e899a8e7a9 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -124,7 +124,7 @@ asm volatile(ALTERNATIVE(						\
>  #define THEAD_flush_A0	".long 0x0275000b"
>  #define THEAD_SYNC_S	".long 0x0190000b"
> =20
> -#define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
> +#define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)		\
>  asm volatile(ALTERNATIVE_2(						\
>  	__nops(6),							\
>  	"mv a0, %1\n\t"							\
> @@ -146,7 +146,11 @@ asm volatile(ALTERNATIVE_2(						\
>  			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
>  	: : "r"(_cachesize),						\
>  	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
> -	    "r"((unsigned long)(_start) + (_size))			\
> +	    "r"((unsigned long)(_start) + (_size)),			\
> +	    "r"((unsigned long)(_start)),				\
> +	    "r"((unsigned long)(_size)),				\
> +	    "r"((unsigned long)(_dir)),					\
> +	    "r"((unsigned long)(_ops))					\
>  	: "a0")
> =20
>  #define THEAD_C9XX_RV_IRQ_PMU			17
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index d919efab6eba..e2b82034f504 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -19,13 +19,16 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size=
_t size,
> =20
>  	switch (dir) {
>  	case DMA_TO_DEVICE:
> -		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
>  		break;
>  	case DMA_FROM_DEVICE:
> -		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
>  		break;
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
>  		break;
>  	default:
>  		break;
> @@ -42,7 +45,8 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t si=
ze,
>  		break;
>  	case DMA_FROM_DEVICE:
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_CPU);
>  		break;
>  	default:
>  		break;
> @@ -53,7 +57,8 @@ void arch_dma_prep_coherent(struct page *page, size_t s=
ize)
>  {
>  	void *flush_addr =3D page_address(page);
> =20
> -	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size,
> +		   0, NON_COHERENT_DMA_PREP);
>  }
> =20
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> --=20
> 2.25.1
>=20

--xwBsLtrovXDxZRvK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY54r+wAKCRB4tDGHoIJi
0h2gAP0erGWo9T3Karis7yeYncpvuKo03HROZmPadrJUGiSFWwD/YfCL5tWNgToO
cSJbl11wYttzxvo472uETFhyjvdMSQo=
=dpsF
-----END PGP SIGNATURE-----

--xwBsLtrovXDxZRvK--
