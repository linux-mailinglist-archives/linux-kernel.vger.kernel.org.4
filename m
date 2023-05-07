Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0436F9BDD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjEGVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEGVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048519BC;
        Sun,  7 May 2023 14:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 863B661D0F;
        Sun,  7 May 2023 21:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD96C433D2;
        Sun,  7 May 2023 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683494541;
        bh=n+A3dtb3nK000xa3YMeU3TXFFoE4yQ+c+JORr+T4xv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RI7cpln+tUfrANGxsALxEIQrh6US0fDULpVuTvw5L+xfcN4oLwDRckm0C5C2jtyib
         ms9guuJ5LWLMov6ih1V6f6HtrcF3rF3EBedJ0BgjMhIKGeYf7V6/HnyYRIiETTwV9w
         oNIdwsyThITdsqsgKYudSlVuFBT1lE+gf/nDjduT0Ylb3ZBFjD9aH0n0qbDJ5RIsFa
         Sg05k9/cXW+ew+A/jwvOBjkZrdsjMl8LevLyOEUW5T53WHyeIjvSuHzQGyvztsPWoN
         NnHEmIJ+nb9qe1voJU9+liuaye1MOzAoikt8LFsf++q1ge49DUKHUeu9OA7CZ7OV+G
         lzAzI//0XzlNw==
Date:   Sun, 7 May 2023 22:22:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 2/5] riscv: Add the T-HEAD SoC family Kconfig option
Message-ID: <20230507-sleeve-tacky-21e817e31fb2@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jrkrBkm/YeYz2rXP"
Content-Disposition: inline
In-Reply-To: <20230507182304.2934-3-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jrkrBkm/YeYz2rXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 02:23:01AM +0800, Jisheng Zhang wrote:
> The first SoC in the T-HEAD series is light(a.k.a th1520), containing
> quad T-HEAD C910 cores.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig.socs | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1cf69f958f10..ce10a38dff37 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -41,6 +41,12 @@ config ARCH_SUNXI
>  	  This enables support for Allwinner sun20i platform hardware,
>  	  including boards based on the D1 and D1s SoCs.
> =20
> +config ARCH_THEAD

Could you please add a defconfig patch, adding this option, so that we
build support for this platform by default?

Thanks,
Conor.

> +	bool "T-HEAD RISC-V SoCs"
> +	select ERRATA_THEAD
> +	help
> +	  This enables support for the RISC-V based T-HEAD SoCs.
> +
>  config ARCH_VIRT
>  	def_bool SOC_VIRT
> =20
> --=20
> 2.40.0
>=20

--jrkrBkm/YeYz2rXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFgWiAAKCRB4tDGHoIJi
0iYyAP4njvOYRRa08I4r7u+EAHBTYOvxzZg42jjwm4oahDttLwD9GbTZVsJ8sb5H
fxAAXzP8UwaotzseIur9awULm87JPQE=
=oUoi
-----END PGP SIGNATURE-----

--jrkrBkm/YeYz2rXP--
