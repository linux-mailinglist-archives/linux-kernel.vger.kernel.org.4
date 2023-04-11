Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE16DE58C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDKUO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9955B8;
        Tue, 11 Apr 2023 13:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 874BE62795;
        Tue, 11 Apr 2023 20:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE61C433D2;
        Tue, 11 Apr 2023 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681244038;
        bh=Go38pLLq5GEQ4fnek+7AtmPJ9Vnzlf80dUigltv0auc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOeV7199OPPV636mEmFgB8EpXl9tgfXARIWX7dTH4zKfpK/FObQ4b764/okxsDPp9
         dIPC6tumBvsqsXqMVvlWuer/PA2b+7cIsZpGVSIAN8XPgkxqA9OD1vvOVPROzG7eAX
         S9hxeQL9qMg4odmAfTEQ5vnaj9YrG8sY84IIHtBgG/LH4uFh8zSHZNFnixijNVjdbv
         tJGw415Ioa6DA8sIOMvMyZ8p1uJ25sAJyQh90jF3YA+yYDMGhEZG5RdTmJ6xDZUmLF
         BKHX3dZzUqoT7KDY8pmoJGiYrQ0cam1lP6F34rNuTD5zIl/lnq5TSDGu3peG6urMFu
         3gzIpqASn6QWQ==
Date:   Tue, 11 Apr 2023 21:13:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/7] soc: starfive: Replace SOC_STARFIVE with
 ARCH_SATRFIVE
Message-ID: <20230411-battered-detract-8fb2ae64448b@spud>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-3-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6b218k5iSPj9BmNv"
Content-Disposition: inline
In-Reply-To: <20230411064743.273388-3-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6b218k5iSPj9BmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 11:47:38PM -0700, Changhuang Liang wrote:
> Using ARCH_FOO symbol is preferred than SOC_FOO.
>=20

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/soc/starfive/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
> index bdb96dc4c989..1e9b0c414fec 100644
> --- a/drivers/soc/starfive/Kconfig
> +++ b/drivers/soc/starfive/Kconfig
> @@ -3,8 +3,8 @@
>  config JH71XX_PMU
>  	bool "Support PMU for StarFive JH71XX Soc"
>  	depends on PM
> -	depends on SOC_STARFIVE || COMPILE_TEST
> -	default SOC_STARFIVE
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	default ARCH_STARFIVE
>  	select PM_GENERIC_DOMAINS
>  	help
>  	  Say 'y' here to enable support power domain support.
> --=20
> 2.25.1
>=20

--6b218k5iSPj9BmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDW/gQAKCRB4tDGHoIJi
0te2AP4kM5Y/0lvQ10q82NEuhilKvUKcJD03pAWm+EeYpLCfpgEAnNbKqhYX2alb
2+ea64ItRx5J8x5vhzbVf3VjndzWegU=
=OCBn
-----END PGP SIGNATURE-----

--6b218k5iSPj9BmNv--
