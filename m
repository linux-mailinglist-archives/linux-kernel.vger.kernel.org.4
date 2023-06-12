Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECDF72D358
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjFLVbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjFLVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7379D90;
        Mon, 12 Jun 2023 14:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B3E62CC5;
        Mon, 12 Jun 2023 21:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9D9C433EF;
        Mon, 12 Jun 2023 21:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605479;
        bh=O9RBysrUumVN/DTH5e2pJQMxqAPMNksXtgzMomVPQAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmU9zIQCMdF5nTt+08NLNJUXuyfYyOZr60Wfs6HioS/Wj3V9W3oOZx41ecaV3uYiI
         gZyNX8Jgv3DukOR+bbxpUH2MZ/2FHcUbXlP/zbhrZ9HdaFyzhVU9CR7aHkpyriVG1V
         PtLvXDxGfRk5KAaQ/vilfaTd3VzghS0eNluO+3qkb5FNogWphZxi/Y/V23VVqEXbsr
         TBcXcD4Z0zSD09WtBaiTvx7qXn/Y5bee9COAoGe4UJtwJvmKmRDarB+8Yq8EevXnf4
         /Ybg8z/13LTqg/x/F/QIRe+6BXAlVtbbX2iK+j4y4Ox2yB4mEXdehgEVxNgvOoPAiI
         83KAr4EMfZoqQ==
Date:   Mon, 12 Jun 2023 22:31:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v5 1/4] RISC-V: add Zbc extension detection
Message-ID: <20230612-unstable-tilt-1835f84363b1@spud>
References: <20230612210442.1805962-1-heiko.stuebner@vrull.eu>
 <20230612210442.1805962-2-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UWhf0UVrM2ZeKQ9k"
Content-Disposition: inline
In-Reply-To: <20230612210442.1805962-2-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UWhf0UVrM2ZeKQ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Heiko,

On Mon, Jun 12, 2023 at 11:04:39PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> Add handling for Zbc extension.
>=20
> Zbc provides instruction for carry-less multiplication.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/Kconfig             | 22 ++++++++++++++++++++++
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpu.c        |  1 +
>  arch/riscv/kernel/cpufeature.c |  1 +
>  4 files changed, 25 insertions(+)

Plumbing into the hwprobe stuff would be nice, but that's not a
requirement for getting stuff merged :)

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a3d54cd14fca..754cd154eca5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -523,6 +523,28 @@ config RISCV_ISA_ZBB
> =20
>  	   If you don't know what to do here, say Y.
> =20
> +config TOOLCHAIN_HAS_ZBC
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zbc)
> +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zbc)
> +	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> +	depends on AS_IS_GNU
> +
> +config RISCV_ISA_ZBC
> +	bool "Zbc extension support for bit manipulation instructions"
> +	depends on TOOLCHAIN_HAS_ZBC
> +	depends on !XIP_KERNEL && MMU
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZBC

Nit: s/ZBC/Zbc/

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--UWhf0UVrM2ZeKQ9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIeOogAKCRB4tDGHoIJi
0tpIAQCV/FZ+x6SOlWpZAMOONuMlLShKsDnc2kMiK0ixTAKecwEAkLKsrJ8vMbbV
MwLaqeQ8ZaHFMuCiBvp57j+/D951AA8=
=pn8b
-----END PGP SIGNATURE-----

--UWhf0UVrM2ZeKQ9k--
