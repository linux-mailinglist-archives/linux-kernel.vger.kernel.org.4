Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB736F24E6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjD2NlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjD2Nk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5694;
        Sat, 29 Apr 2023 06:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B988C60BAF;
        Sat, 29 Apr 2023 13:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC39C433EF;
        Sat, 29 Apr 2023 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682775657;
        bh=TynLopTcb8di6ibyHhf1tgDO6WehYIBtAquyYxiAUq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peZz0opZ/qSonIT40w/rOKy2WlYQqUaa70QwLzgK75PW4Wpl11vg1QjD4Crr5UP1g
         xS0A+yuexgVOEG6rKfU+1Lz9r4OtJdL1w3hXCIdiJkxLgGkq3KnRK3GaBUhkTgzRxf
         6wPMWLI0ao8rpT4bQk/2y8xpY31zMf/qTcDZa+vzS2pEzi/6QDTiJbhrWMYD7d0xUu
         575oums0ukMnia5OEzYHd7WS6B0Ji4NBfdSFr8DHTaMJPv6Nngz6K+joEYZ3SIGx81
         T6J2YcmRgsXPI/uSaR9a4GtMRjboZaJS4jiBjMc2egULHnazMhKAURaryMJgIWymPr
         jVUSbCBr5WRlQ==
Date:   Sat, 29 Apr 2023 14:40:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] RISC-V: hwprobe: Expose Zba and Zbb
Message-ID: <20230429-gruffly-chrome-fd94628cc5ff@spud>
References: <20230428190609.3239486-1-evan@rivosinc.com>
 <20230428190609.3239486-4-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HFnFzu3h5zI+4bvt"
Content-Disposition: inline
In-Reply-To: <20230428190609.3239486-4-evan@rivosinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HFnFzu3h5zI+4bvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 12:06:08PM -0700, Evan Green wrote:
> Add two new bits to the IMA_EXT_0 key for ZBA and ZBB extensions. These
> are accurately reported per CPU.
>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> ---
>=20
>  Documentation/riscv/hwprobe.rst       |  7 +++++
>  arch/riscv/include/uapi/asm/hwprobe.h |  2 ++
>  arch/riscv/kernel/sys_riscv.c         | 43 ++++++++++++++++++++++-----
>  3 files changed, 45 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprob=
e.rst
> index 9f0dd62dcb5d..21f444a38359 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -64,6 +64,13 @@ The following keys are defined:
>    * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as def=
ined
>      by version 2.2 of the RISC-V ISA manual.
> =20
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZBA`: The Zba address generation extensi=
on is
> +       supported, as defined in version 1.0 of the Bit-Manipulation ISA
> +       extensions.
> +
> +  * :c:macro:`RISCV_HWPROBE_IMA_ZBB`: The Zbb extension is supporte, as =
defined

Why is one EXT_ZBA and the other is IMA_ZBB? You do not use IMA below,
so I assume this is a copy-paste mistake.

Also, s/supporte/supported.

Otherwise, looks fine.
Cheers,
Conor.

> +       in version 1.0 of the Bit-Manipulation ISA extensions.
> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains perfor=
mance
>    information about the selected set of processors.
> =20
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 8d745a4ad8a2..ef3b060d4e8d 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -25,6 +25,8 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
>  #define		RISCV_HWPROBE_IMA_FD		(1 << 0)
>  #define		RISCV_HWPROBE_IMA_C		(1 << 1)
> +#define		RISCV_HWPROBE_EXT_ZBA		(1 << 2)
> +#define		RISCV_HWPROBE_EXT_ZBB		(1 << 3)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 5db29683ebee..adfcb6b64db7 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -121,6 +121,41 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pa=
ir,
>  	pair->value =3D id;
>  }
> =20
> +static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> +			     const struct cpumask *cpus)
> +{
> +	int cpu;
> +	u64 missing =3D 0;
> +
> +	pair->value =3D 0;
> +	if (has_fpu())
> +		pair->value |=3D RISCV_HWPROBE_IMA_FD;
> +
> +	if (riscv_isa_extension_available(NULL, c))
> +		pair->value |=3D RISCV_HWPROBE_IMA_C;
> +
> +	/*
> +	 * Loop through and record extensions that 1) anyone has, and 2) anyone
> +	 * doesn't have.
> +	 */
> +	for_each_cpu(cpu, cpus) {
> +		struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
> +
> +		if (riscv_isa_extension_available(isainfo->isa, ZBA))
> +			pair->value |=3D RISCV_HWPROBE_EXT_ZBA;
> +		else
> +			missing |=3D RISCV_HWPROBE_EXT_ZBA;
> +
> +		if (riscv_isa_extension_available(isainfo->isa, ZBB))
> +			pair->value |=3D RISCV_HWPROBE_EXT_ZBB;
> +		else
> +			missing |=3D RISCV_HWPROBE_EXT_ZBB;
> +	}
> +
> +	/* Now turn off reporting features if any CPU is missing it. */
> +	pair->value &=3D ~missing;
> +}
> +
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
>  	int cpu;
> @@ -164,13 +199,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>  		break;
> =20
>  	case RISCV_HWPROBE_KEY_IMA_EXT_0:
> -		pair->value =3D 0;
> -		if (has_fpu())
> -			pair->value |=3D RISCV_HWPROBE_IMA_FD;
> -
> -		if (riscv_isa_extension_available(NULL, c))
> -			pair->value |=3D RISCV_HWPROBE_IMA_C;
> -
> +		hwprobe_isa_ext0(pair, cpus);
>  		break;
> =20
>  	case RISCV_HWPROBE_KEY_CPUPERF_0:
> --=20
> 2.25.1
>=20

--HFnFzu3h5zI+4bvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE0eYwAKCRB4tDGHoIJi
0koSAP9bP1fzFIGsPCX0j+PX7ftZF2eVkUU0UDTEFyAJZIf93wEAzlQ1crbGpXtZ
ijYEkDiku4jfnhlzX1T7sXY/VtDj5Q0=
=yGMa
-----END PGP SIGNATURE-----

--HFnFzu3h5zI+4bvt--
