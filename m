Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2876D202D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjCaMZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjCaMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:25:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100761EA35;
        Fri, 31 Mar 2023 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680265499; x=1711801499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZC2TiUJ6vJPwXEcNjYqansieGSLZd4+5qeXsm1kRXw=;
  b=nZYnlYIVklbq2B0UgkaO5OwKf7yyK64lc7EZhswRR8vI5Puh6qrVXza4
   jQxiLlxLOb4l1b5bGUftJ1ITv7vh2EGkKcIpiOX9G8ilqf9g2DRXD7+sp
   SLK8Ni1sqkno9l+0WfikM3f1QBYITJdqcVfmCczTHGRwVgZduuM9ptKP7
   rMyKOUrXygz5iYBZPOxuHbG9gF81+K1NQhodOpocIpgDxJFAX3uKfNwXT
   lKbcIu6qFwBL7zod5sKe1pmkukTn705fIQFq6MMFGu6kdcv+wFkEYuvzn
   DQ2j+e3B09bfZ+Y2uzF86be02Hge6/VfYRU0b2Irc2WNh+VfjUeOFuiZ2
   A==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="207583725"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 05:24:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 05:24:57 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 05:24:54 -0700
Date:   Fri, 31 Mar 2023 13:24:41 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Message-ID: <f12f9773-77b5-4ba6-9e9e-adbc67ca0110@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NYzJoNNExCmWWzsp"
Content-Disposition: inline
In-Reply-To: <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NYzJoNNExCmWWzsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

I think most of what I wanted to talk about has been raised by Arnd or
Geert, so I kinda only have a couple of small comments for you here.

On Thu, Mar 30, 2023 at 09:42:12PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Currently, selecting which CMOs to use on a given platform is done using
> and ALTERNATIVE_X() macro. This was manageable when there were just two
> CMO implementations, but now that there are more and more platforms coming
> needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageable.
>=20
> To avoid such issues this patch switches to use of function pointers
> instead of ALTERNATIVE_X() macro for cache management (the only drawback
> being performance over the previous approach).
>=20
> void (*clean_range)(unsigned long addr, unsigned long size);
> void (*inv_range)(unsigned long addr, unsigned long size);
> void (*flush_range)(unsigned long addr, unsigned long size);

So, given Arnd has renamed the generic helpers, should we use the
writeback/invalidate/writeback & invalidate terminology here too?
I think it'd be nice to make the "driver" functions match the generic
implementations's names (even though that means not making the
instruction naming).

> The above function pointers are provided to be overridden for platforms
> needing CMO.
>=20
> Convert ZICBOM and T-HEAD CMO to use function pointers.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v6->v7
> * Updated commit description
> * Fixed build issues when CONFIG_ERRATA_THEAD_CMO=3Dn
> * Used static const struct ptr to register CMO ops
> * Dropped riscv_dma_noncoherent_cmo_ops

> * Moved ZICBOM CMO setup to setup.c

Why'd you do that?
What is the reason that the Zicbom stuff cannot live in
dma-noncoherent.[ch] and only expose, say:
void riscv_cbom_register_cmo_ops(void)
{
	riscv_noncoherent_register_cache_ops(&zicbom_cmo_ops);
}
which you then call from setup.c?

> v5->v6
> * New patch
> ---
>  arch/riscv/errata/thead/errata.c         | 76 ++++++++++++++++++++++++
>  arch/riscv/include/asm/dma-noncoherent.h | 73 +++++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h     | 53 -----------------
>  arch/riscv/kernel/setup.c                | 49 ++++++++++++++-
>  arch/riscv/mm/dma-noncoherent.c          | 25 ++++++--
>  arch/riscv/mm/pmem.c                     |  6 +-
>  6 files changed, 221 insertions(+), 61 deletions(-)
>  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h

> +#ifdef CONFIG_RISCV_ISA_ZICBOM
> +
> +#define ZICBOM_CMO_OP(_op, _start, _size, _cachesize)				\
> +	asm volatile("mv a0, %1\n\t"						\
> +		     "j 2f\n\t"							\
> +		     "3:\n\t"							\
> +		     CBO_##_op(a0)						\
> +		     "add a0, a0, %0\n\t"					\
> +		     "2:\n\t"							\
> +		     "bltu a0, %2, 3b\n\t"					\
> +		     : : "r"(_cachesize),					\
> +			 "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
> +			 "r"((unsigned long)(_start) + (_size))			\
> +		     : "a0")
> +
> +static void zicbom_cmo_clean_range(unsigned long addr, unsigned long siz=
e)
> +{
> +	ZICBOM_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> +}
> +
> +static void zicbom_cmo_flush_range(unsigned long addr, unsigned long siz=
e)
> +{
> +	ZICBOM_CMO_OP(flush, addr, size, riscv_cbom_block_size);
> +}
> +
> +static void zicbom_cmo_inval_range(unsigned long addr, unsigned long siz=
e)
> +{
> +	ZICBOM_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> +}
> +
> +const struct riscv_cache_ops zicbom_cmo_ops =3D {
> +	.clean_range =3D &zicbom_cmo_clean_range,
> +	.inv_range =3D &zicbom_cmo_inval_range,
> +	.flush_range =3D &zicbom_cmo_flush_range,
> +};
> +
> +static void zicbom_register_cmo_ops(void)
> +{
> +	riscv_noncoherent_register_cache_ops(&zicbom_cmo_ops);
> +}
> +#else
> +static void zicbom_register_cmo_ops(void) {}
> +#endif

I think all of the above should be prefixed with riscv_cbom to match the
other riscv_cbom stuff we already have.
Although, given the discussion elsewhere about just falling back to
zicbom in the absence of specific ops, most of these functions will
probably disappear (if not all of them).

Cheers,
Conor.

--NYzJoNNExCmWWzsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCbRCAAKCRB4tDGHoIJi
0iABAP0Trlhgk1WaIkkfLh4tD9+60uHDfVxoza/L6pLJeFjFHQEA3/A12eco/Ys/
47yBDYcaX9uUeMwY1iHDMykWNK0fCQM=
=fsaO
-----END PGP SIGNATURE-----

--NYzJoNNExCmWWzsp--
