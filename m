Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB66C4F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCVPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjCVPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65E515CD;
        Wed, 22 Mar 2023 08:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C9C621A0;
        Wed, 22 Mar 2023 15:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEB5C4339B;
        Wed, 22 Mar 2023 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679499365;
        bh=DZy9l2qyDKre9adLwkTIGVd6PoEOrq5ypuDZNWHxbJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWqGKRZENH6xhp47Uo6JUmbc8rMcVyCGI1wIWS9Ycu1PR1v0i/Lz6WE6+ITRbtQWP
         KAnd/amMvGloOOH7kvjSXNEUHUkGA1gaJqAMqsveJtnl/L2r+/wOKA/YOupxvhpISe
         P3FgL3ojHPObXM2v0pgehfxYKLrp39ovS8Ar51V52vhsmGInrbpfA4Mrw4C/S1FFTA
         DuFz4tYaXZxzg234CCAJ1GVEhXEQhPTgYATpEzg3nAgPu9x9So32+zEkijfb7Br4SN
         tkUOZaFPXlyyZwFHfh4HFM89T11cJdwBtYwAxhUy9nBxJT+LzAxHv3YCLVfdDX6RzX
         lx0Mz43ukmzFg==
Date:   Wed, 22 Mar 2023 15:35:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        heiko@sntech.de, vineetg@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/6] RISC-V: hwprobe: Add support for
 RISCV_HWPROBE_BASE_BEHAVIOR_IMA
Message-ID: <8e132bed-c85a-4bfd-bff8-5147db1cec32@spud>
References: <20230314183220.513101-1-evan@rivosinc.com>
 <20230314183220.513101-4-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r+TYFFM1/Jo8CP9z"
Content-Disposition: inline
In-Reply-To: <20230314183220.513101-4-evan@rivosinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r+TYFFM1/Jo8CP9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 11:32:17AM -0700, Evan Green wrote:
> We have an implicit set of base behaviors that userspace depends on,
> which are mostly defined in various ISA specifications.
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> @@ -125,6 +126,25 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>  	case RISCV_HWPROBE_KEY_MIMPID:
>  		hwprobe_arch_id(pair, cpus);
>  		break;
> +	/*
> +	 * The kernel already assumes that the base single-letter ISA
> +	 * extensions are supported on all harts, and only supports the
> +	 * IMA base, so just cheat a bit here and tell that to
> +	 * userspace.
> +	 */
> +	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
> +		pair->value =3D RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
> +		break;
> +
> +	case RISCV_HWPROBE_KEY_IMA_EXT_0:
> +		pair->value =3D 0;
> +		if (has_fpu())
> +			pair->value |=3D RISCV_HWPROBE_IMA_FD;
> +
> +		if (elf_hwcap & RISCV_ISA_EXT_c)

Random thought while reviewing another patch, and I kinda felt a bit
stupid following the existing code to try and make sure, but should this
become a call to riscv_isa_extension_available(NULL, c)?
It may be nice to propagate that helper, if it works, than check the bit
directly.

Cheers,
Conor.

> +			pair->value |=3D RISCV_HWPROBE_IMA_C;
> +
> +		break;
> =20
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> --=20
> 2.25.1
>=20

--r+TYFFM1/Jo8CP9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBsgXwAKCRB4tDGHoIJi
0uXwAPwO6vaB4a7jTfh6cwcjIbakPGbW2KoWTWyZNWCElUCFGgEA/czXfGY7/Z9G
0R/BZly3E44aKfHbp8z2S2DhkztM8QU=
=2y2o
-----END PGP SIGNATURE-----

--r+TYFFM1/Jo8CP9z--
