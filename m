Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4806B6F1EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbjD1T2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbjD1T2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:28:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFF46BB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B4F614B5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CACBC433D2;
        Fri, 28 Apr 2023 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682710078;
        bh=7wgkY/dxImmFTnUyxZ6D6op5XwpEyk/vwX3PdYYrflA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pb87yG3MkWmgDXYqcqzRp7Sj2wNrOoJlbeknUQ6w8dTFaGe7h/nri/F8imiK8Mjwv
         FdJ9gSeyhwvVZ3WRJ1wuIX6Vc9TAeizmPeYe6SGgV1jxyrtRKYeaWwJba2T/BEdoVd
         aUCJZcft9Y4X38CxnNr2prDAdW+hEBpnsL/bTWvHqRjJsApAsX/WJ3yr0/bWTWrEWY
         /ifovNzu7EWmVekRtjX0q3V314xpxymbXNzZobrrvwSgsvY9Bb0BFsarb7Xaciqh74
         Tx7pReV1YSJdFB/t+/WF4N+dGAWFklATT1tV25ZS/yXT+gVBM9i77dg2h4epOycocc
         P06fjaO+JpRPA==
Date:   Fri, 28 Apr 2023 20:27:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH v2 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <20230428-cryptic-bunkhouse-6ec8a568e611@spud>
References: <20230428141601.678489-1-cyy@cyyself.name>
 <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CVevN+a3If2P0ES5"
Content-Disposition: inline
In-Reply-To: <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CVevN+a3If2P0ES5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Yangyu,

On Fri, Apr 28, 2023 at 10:16:00PM +0800, Yangyu Chen wrote:
> According to RISC-V Hart Capabilities Table (RHCT) description in UEFI
> Forum ECR, the format of the ISA string is defined in the RISC-V
> unprivileged specification which is case-insensitive. However, the
> current ISA string parser in the kernel does not support ISA strings
> with uppercase letters.
>=20
> This patch modifies the ISA string parser in the kernel to support
> case-insensitive ISA string parsing.

@Palmer, @Sunil
Just to note, we probably should get this applied *before* we enable ACPI,
right?

>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/kernel/cpu.c        |  3 ++-
>  arch/riscv/kernel/cpufeature.c | 25 ++++++++++++-------------
>  2 files changed, 14 insertions(+), 14 deletions(-)

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 59d58ee0f68d..d1991c12e546 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -119,13 +119,10 @@ void __init riscv_fill_hwcap(void)
>  		}
> =20
>  		temp =3D isa;
> -#if IS_ENABLED(CONFIG_32BIT)
> -		if (!strncmp(isa, "rv32", 4))
> +		if (IS_ENABLED(CONFIG_32BIT) && !strncasecmp(isa, "rv32", 4))
>  			isa +=3D 4;
> -#elif IS_ENABLED(CONFIG_64BIT)
> -		if (!strncmp(isa, "rv64", 4))
> +		else if (IS_ENABLED(CONFIG_64BIT) && !strncasecmp(isa, "rv64", 4))
>  			isa +=3D 4;
> -#endif
>  		/* The riscv,isa DT property must start with rv64 or rv32 */
>  		if (temp =3D=3D isa)
>  			continue;
> @@ -136,6 +133,7 @@ void __init riscv_fill_hwcap(void)
>  			bool ext_long =3D false, ext_err =3D false;
> =20
>  			switch (*ext) {
> +			case 'S':

Capital S should never be emitted by QEMU, so there's no need to have
this use the workaround, right? IOW, move it between s & X.

Otherwise, this looks good to me:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--CVevN+a3If2P0ES5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEweOQAKCRB4tDGHoIJi
0kikAP9Zd2rab5bwbeP53M44AqQ025jpc+jS4dQVmzf1hk/xHgD+IA3jTvzYz+AJ
w2YcvK37/yqAxG6/KZz641KO/UH8rA0=
=LUE1
-----END PGP SIGNATURE-----

--CVevN+a3If2P0ES5--
