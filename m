Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0479A6608E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbjAFVpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAFVo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:44:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4C182F43;
        Fri,  6 Jan 2023 13:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B55EDB81C4A;
        Fri,  6 Jan 2023 21:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23669C433EF;
        Fri,  6 Jan 2023 21:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673041493;
        bh=S6o14xUMpNWT1FgKozp+8Mj2OtyQejRW1OZhSS08KNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaXnKMegaaP8z9ayDQcvrAUoCm6q92bglcPk8+v4XdHgqBfWpX8/c7mIncuC7ZPho
         8INfXpMJNIhSCG72NGM3///9N6KJ1Rbxhg8r9i9vguk2uFn9hTbwVZx4o32zo2t5Oj
         kL41IACjKWCbf98FhpuXG0+S73YkTqnOLzWqb3tlRJlIHd3lakCeaCQ37G2pnUB5wQ
         lKFXYZ955FGncx/r01DjVLO6b2p14tp+Ho+tQqoWHFzNFS4b7KBQMFbEvhvoMJeP3A
         rk23L8zlMc5hO6W4stjqdZHOkpenZQtdvzPZa5BIOtVE0FkRaDu0B8/I/sJgDsQFQG
         cPf+lSTSscrkQ==
Date:   Fri, 6 Jan 2023 21:44:47 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v6 3/6] riscv: errata: Add Andes alternative ports
Message-ID: <Y7iWTwZwNLiU8USP@spud>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zd9zzwISgem4Gol8"
Content-Disposition: inline
In-Reply-To: <20230106185526.260163-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zd9zzwISgem4Gol8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 06:55:23PM +0000, Prabhakar wrote:
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
> v5 -> v6
> * Dropped patching alternative and now just probing IOCP
>=20
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
>  arch/riscv/Kconfig.erratas           | 22 +++++++++
>  arch/riscv/errata/Makefile           |  1 +
>  arch/riscv/errata/andes/Makefile     |  1 +
>  arch/riscv/errata/andes/errata.c     | 71 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h |  3 ++
>  arch/riscv/kernel/alternative.c      |  5 ++
>  6 files changed, 103 insertions(+)
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

Ideally we would not need errata to turn this stuff on at all, but, as
you pointed out to me off-list, arch_setup_dma_ops() complains if we
have not set up.

I'm happy to commit to trying to sort that out in follow on work w/ MPFS,
since in that case it really isn't errata, and not require it for this
series as you do fit that particular bill IMO.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--Zd9zzwISgem4Gol8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7iWTwAKCRB4tDGHoIJi
0olEAPoCdBHN/hX+YSUm1Fjy2xwp6TNGBBXu8o1krE1zIfywRAD/Zgo9xhRo3YEq
gijazhkKQDRtERVdc8B/eqvdErFkDgo=
=DDRQ
-----END PGP SIGNATURE-----

--Zd9zzwISgem4Gol8--
