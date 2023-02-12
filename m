Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD51693830
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBLPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBLPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:48:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3F74C29
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C6460D37
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 15:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC434C433EF;
        Sun, 12 Feb 2023 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676216910;
        bh=Vukdoymwm/wEA58+hycxqrl3bmx2LN+x0akzNw5Yu2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4hRk23TmcLpC3qBZrOU7D2TKEUlF7xHXzs3SYhgVfrPxWvNBDxb2dvz/pbrehLJ5
         ibjxhOPLcd/aUKIHHA1rK9qmS1W+ilXlxSnSAB90r2GzrogU0/PQoVDbYP8FOQ6pMu
         ho4fp2QY+4mJnQGoYqPj0cVZQrEobBnIlodAHaSLR7u7QhXuM9BJm3flou3ajE0b3V
         RO9IXfldG2mgrpJ5UDLsln9X64bd/kUzM5uNTBoVY9gDXF9d0PnUDjXYGxIhR1aK7N
         +xTDGqNAXTXgdMYkGuHn927KUviECLNxqll2KcUXjocfIKRUqVLgKHeK6CTJqkTToG
         gxFxDyC6rPnLQ==
Date:   Sun, 12 Feb 2023 15:48:25 +0000
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
Subject: Re: [PATCH 1/2] riscv: Fix early alternative patching
Message-ID: <Y+kKSTuyvpw06VCG@spud>
References: <20230212021534.59121-1-samuel@sholland.org>
 <20230212021534.59121-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZZwqfOBoXuz7+HRs"
Content-Disposition: inline
In-Reply-To: <20230212021534.59121-2-samuel@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZZwqfOBoXuz7+HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2023 at 08:15:32PM -0600, Samuel Holland wrote:
> Now that the text to patch is located using a relative offset from the
> alternative entry, the text address should be computed without applying
> the kernel mapping offset, both before and after VM setup.
>=20
> Fixes: 8d23e94a4433 ("riscv: switch to relative alternative entries")

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  arch/riscv/errata/thead/errata.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index c0bea5c94128..1dd90a5f86f0 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -102,9 +102,7 @@ void __init_or_module thead_errata_patch_func(struct =
alt_entry *begin, struct al
> =20
>  			/* On vm-alternatives, the mmu isn't running yet */
>  			if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> -				memcpy((void *)__pa_symbol(oldptr),
> -				       (void *)__pa_symbol(altptr),
> -				       alt->alt_len);
> +				memcpy(oldptr, altptr, alt->alt_len);
>  			else
>  				patch_text_nosync(oldptr, altptr, alt->alt_len);
>  		}
> --=20
> 2.37.4
>=20

--ZZwqfOBoXuz7+HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+kKSQAKCRB4tDGHoIJi
0hTXAP9igWO796XC6hLAXjhirFkpfB6Cxc4+Iy3v0XaTjWbkKQD43amLsSE0ma63
mWwEfULUWh6gbSdqjnv3HsVqCG9+DA==
=O9Y0
-----END PGP SIGNATURE-----

--ZZwqfOBoXuz7+HRs--
