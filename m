Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2E64FC7B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 22:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLQVls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 16:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLQVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 16:41:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3AE10B7D;
        Sat, 17 Dec 2022 13:41:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD48160C50;
        Sat, 17 Dec 2022 21:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC83C433EF;
        Sat, 17 Dec 2022 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671313303;
        bh=FQfM15omrjyZA4dNcbB7Ai/GYY6dSKSm7z3ucZy747g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf2nbSVkMJm05leBFU5yBUdyBRglF/S1CO0UNZeQQ5OZ8uxxAKbHUyMZNEsMSRUxJ
         lThDE0WdEw8XKX8p3NXUthYKnpa8Z4q5IO7eELKeCLyDxv+YCC1C1D2Sd0oavTdMCd
         H/AJYgPN7Bu4zIIfyZ34z9L78vwJxpOFsapcwc3YUzjEFYmVObYkervQlUuIywM6AT
         cghmlLqaKABIm7F1hcYWTj4OP+A3oKBrVmEz79dZ0jyq62QaS46AEUSzSz/QVr8x75
         4QW/7HpoHG4KXNcw0oL8mSxqWn6cGudP63b24O+wxH96G6XK+bvbbr1i55MmkHaxuL
         lKdXtw1mS2T2w==
Date:   Sat, 17 Dec 2022 21:41:36 +0000
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
Subject: Re: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
Message-ID: <Y543kM4070CSDtZi@spud>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9X66vO0ItE/RH9dw"
Content-Disposition: inline
In-Reply-To: <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9X66vO0ItE/RH9dw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2022 at 11:55:00AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Introduce ALTERNATIVE_3() macro.
>=20
> A vendor wants to replace an old_content, but another vendor has used
> ALTERNATIVE_2() to patch its customized content at the same location.
> In this case, this vendor can use macro ALTERNATIVE_3() and then replace
> ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.
>=20
> While at it update comment above ALTERNATIVE_2() macro and make it generic
> so that the comment holds good for any new addition of ALTERNATIVE_X()
> macros.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4->v5
> * Rebased the patch on top of Andrew's series (now in Palmers for next-br=
anch)
> * Updated comment for ALTERNATIVE_x() as suggested by Heiko
>=20
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/include/asm/alternative-macros.h | 46 ++++++++++++++++++---
>  1 file changed, 41 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/inc=
lude/asm/alternative-macros.h
> index 7226e2462584..a5b4691520da 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -50,8 +50,17 @@
>  	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
>  .endm
> =20
> +.macro ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enabl=
e_1,	\
> +				new_c_2, vendor_id_2, errata_id_2, enable_2,	\
> +				new_c_3, vendor_id_3, errata_id_3, enable_3
> +       ALTERNATIVE_CFG_2 \old_c, \new_c_1, \vendor_id_1, \errata_id_1, \=
enable_1,	\
> +                                 \new_c_2, \vendor_id_2, \errata_id_2, \=
enable_2
> +       ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
> +.endm
> +
>  #define __ALTERNATIVE_CFG(...)		ALTERNATIVE_CFG __VA_ARGS__
>  #define __ALTERNATIVE_CFG_2(...)	ALTERNATIVE_CFG_2 __VA_ARGS__
> +#define __ALTERNATIVE_CFG_3(...)	ALTERNATIVE_CFG_3 __VA_ARGS__
> =20
>  #else /* !__ASSEMBLY__ */
> =20
> @@ -98,6 +107,13 @@
>  	__ALTERNATIVE_CFG(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1)	\
>  	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
> =20
> +#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, en=
able_1,	\
> +				   new_c_2, vendor_id_2, errata_id_2, enable_2,	\
> +				   new_c_3, vendor_id_3, errata_id_3, enable_3)	\
> +	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,=
	\
> +                                   new_c_2, vendor_id_2, errata_id_2, en=
able_2)	\
> +	ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
> +
>  #endif /* __ASSEMBLY__ */
> =20
>  #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k)	\
> @@ -108,6 +124,13 @@
>  	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLE=
D(CONFIG_k_1),	\
>  				   new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2))
> =20
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, CON=
FIG_k_1,		\
> +				  new_c_2, vendor_id_2, errata_id_2, CONFIG_k_2,		\
> +				  new_c_3, vendor_id_3, errata_id_3, CONFIG_k_3)		\
> +	__ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLE=
D(CONFIG_k_1),	\
> +				   new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2),	\
> +				   new_c_3, vendor_id_3, errata_id_3, IS_ENABLED(CONFIG_k_3))
> +
>  #else /* CONFIG_RISCV_ALTERNATIVE */
>  #ifdef __ASSEMBLY__
> =20
> @@ -152,15 +175,28 @@
>  	_ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG=
_k)
> =20
>  /*
> - * A vendor wants to replace an old_content, but another vendor has used
> - * ALTERNATIVE() to patch its customized content at the same location. In
> - * this case, this vendor can create a new macro ALTERNATIVE_2() based
> - * on the following sample code and then replace ALTERNATIVE() with
> - * ALTERNATIVE_2() to append its customized content.
> + * ALTERNATIVE_x macros allow providing multiple replacement options
> + * for an ALTERNATIVE code section. This is helpful if multiple
> + * implementation variants for the same functionality exist for
> + * different cpu cores.

I think this last sentence should be:
"This is helpful if multiple implementation variants exist for the same
functionality."
I don't think CPU cores is the right level of "granularity".

> + *
> + * Usage:
> + *   ALTERNATIVE_x(old_content,
> + *      new_content1, vendor_id1, errata_id1, CONFIG_k1,
> + *      new_content2, vendor_id2, errata_id2, CONFIG_k2,
> + *      ...
> + *      new_contentx, vendor_idx, errata_idx, CONFIG_kx)
>   */
>  #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, errata_id=
_1, CONFIG_k_1,		\
>  				   new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)		\
>  	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1=
, CONFIG_k_1,	\
>  					new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)
> =20
> +#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1, errata_id=
_1, CONFIG_k_1,		\
> +				   new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,		\
> +				   new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)		\
> +       _ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1, errat=
a_id_1, CONFIG_k_1,	\
> +                                       new_content_2, vendor_id_2, errat=
a_id_2, CONFIG_k_2,	\
> +                                       new_content_3, vendor_id_3, errat=
a_id_3, CONFIG_k_3)

btw, why is this indented with spaces when the line above it is indented
with tabs? (At least, that is how it appears in mutt).

With those minor bits & the suggested fixes from Drew/Geert:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +
>  #endif
> --=20
> 2.25.1
>=20

--9X66vO0ItE/RH9dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY543kAAKCRB4tDGHoIJi
0h+1AQCWYOSiTUMmLEQOWyuSsja8cTBe0s7E75THHhx5ytR1+wD8DH3FlM6csl5t
HilI1PkreKSHH2mpX6BVpeofVNt0FAQ=
=VgBI
-----END PGP SIGNATURE-----

--9X66vO0ItE/RH9dw--
