Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7558D60F7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiJ0MpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiJ0MpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:45:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE45FAA;
        Thu, 27 Oct 2022 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666874696; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kh0g3/J/6DLJMf8jwmOmCdggEbcljmLSqAgl2NE0IWk=;
        b=amhdwXenV1vs5UCnHQyoh4J7NX1m28frDJ4bkoLkQeYjq5RJ4MQ3y9oJLdcEn5WsESsEHE
        cUw0W+4gmGZIufRtPWGBs1FNY5Z75Bho7MfzoQEP8O5IUQuO3lp64KDUGUsG1jl+AdgMvV
        o/xOj13uNvjfEC0U+HphQ8cY7LkMC/g=
Date:   Thu, 27 Oct 2022 13:44:45 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 6/6] clk: ingenic: Minor cosmetic fixups for X1000
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <LQWEKR.EVQMBDQ994GL1@crapouillou.net>
In-Reply-To: <20221026194345.243007-7-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
        <20221026194345.243007-7-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le mer. 26 oct. 2022 =E0 20:43:45 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Remove redundant -1 entries from the parents array and fix
> a couple indentation / whitespace issues.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/clk/ingenic/x1000-cgu.c | 49=20
> ++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/x1000-cgu.c=20
> b/drivers/clk/ingenic/x1000-cgu.c
> index 95d5e3a44cee..feb03eed4fe8 100644
> --- a/drivers/clk/ingenic/x1000-cgu.c
> +++ b/drivers/clk/ingenic/x1000-cgu.c
> @@ -216,7 +216,7 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_APLL] =3D {
>  		"apll", CGU_CLK_PLL,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK },
>  		.pll =3D {
>  			.reg =3D CGU_REG_APLL,
>  			.rate_multiplier =3D 1,
> @@ -239,7 +239,7 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_MPLL] =3D {
>  		"mpll", CGU_CLK_PLL,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK },
>  		.pll =3D {
>  			.reg =3D CGU_REG_MPLL,
>  			.rate_multiplier =3D 1,
> @@ -289,7 +289,7 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>  		 * system; mark it critical.
>  		 */
>  		.flags =3D CLK_IS_CRITICAL,
> -		.parents =3D { X1000_CLK_CPUMUX, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_CPUMUX },
>  		.div =3D { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
>  		.gate =3D { CGU_REG_CLKGR, 30 },
>  	},
> @@ -301,7 +301,7 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>  		 * disabling it or any parent clocks will hang the system.
>  		 */
>  		.flags =3D CLK_IS_CRITICAL,
> -		.parents =3D { X1000_CLK_CPUMUX, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_CPUMUX },
>  		.div =3D { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
>  	},
>=20
> @@ -320,13 +320,13 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_AHB2] =3D {
>  		"ahb2", CGU_CLK_DIV,
> -		.parents =3D { X1000_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_AHB2PMUX },
>  		.div =3D { CGU_REG_CPCCR, 12, 1, 4, 20, -1, -1 },
>  	},
>=20
>  	[X1000_CLK_PCLK] =3D {
>  		"pclk", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_AHB2PMUX },
>  		.div =3D { CGU_REG_CPCCR, 16, 1, 4, 20, -1, -1 },
>  		.gate =3D { CGU_REG_CLKGR, 28 },
>  	},
> @@ -393,13 +393,13 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_MSCMUX] =3D {
>  		"msc_mux", CGU_CLK_MUX,
> -		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL},
> +		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL },
>  		.mux =3D { CGU_REG_MSC0CDR, 31, 1 },
>  	},
>=20
>  	[X1000_CLK_MSC0] =3D {
>  		"msc0", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_MSCMUX, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_MSCMUX },
>  		.div =3D { CGU_REG_MSC0CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate =3D { CGU_REG_CLKGR, 4 },
>  	},
> @@ -413,8 +413,7 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_OTG] =3D {
>  		"otg", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents =3D { X1000_CLK_EXCLK, -1,
> -					 X1000_CLK_APLL, X1000_CLK_MPLL },
> +		.parents =3D { X1000_CLK_EXCLK, -1, X1000_CLK_APLL, X1000_CLK_MPLL },
>  		.mux =3D { CGU_REG_USBCDR, 30, 2 },
>  		.div =3D { CGU_REG_USBCDR, 0, 1, 8, 29, 28, 27 },
>  		.gate =3D { CGU_REG_CLKGR, 3 },
> @@ -422,7 +421,7 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_SSIPLL] =3D {
>  		"ssi_pll", CGU_CLK_MUX | CGU_CLK_DIV,
> -		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
> +		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL },
>  		.mux =3D { CGU_REG_SSICDR, 31, 1 },
>  		.div =3D { CGU_REG_SSICDR, 0, 1, 8, 29, 28, 27 },
>  	},
> @@ -435,7 +434,7 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_SSIMUX] =3D {
>  		"ssi_mux", CGU_CLK_MUX,
> -		.parents =3D { X1000_CLK_EXCLK, X1000_CLK_SSIPLL_DIV2, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK, X1000_CLK_SSIPLL_DIV2 },
>  		.mux =3D { CGU_REG_SSICDR, 30, 1 },
>  	},
>=20
> @@ -456,37 +455,37 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_EMC] =3D {
>  		"emc", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_AHB2, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_AHB2 },
>  		.gate =3D { CGU_REG_CLKGR, 0 },
>  	},
>=20
>  	[X1000_CLK_EFUSE] =3D {
>  		"efuse", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_AHB2, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_AHB2 },
>  		.gate =3D { CGU_REG_CLKGR, 1 },
>  	},
>=20
>  	[X1000_CLK_SFC] =3D {
>  		"sfc", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_SSIPLL, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_SSIPLL },
>  		.gate =3D { CGU_REG_CLKGR, 2 },
>  	},
>=20
>  	[X1000_CLK_I2C0] =3D {
>  		"i2c0", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_PCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_PCLK },
>  		.gate =3D { CGU_REG_CLKGR, 7 },
>  	},
>=20
>  	[X1000_CLK_I2C1] =3D {
>  		"i2c1", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_PCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_PCLK },
>  		.gate =3D { CGU_REG_CLKGR, 8 },
>  	},
>=20
>  	[X1000_CLK_I2C2] =3D {
>  		"i2c2", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_PCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_PCLK },
>  		.gate =3D { CGU_REG_CLKGR, 9 },
>  	},
>=20
> @@ -498,43 +497,43 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>=20
>  	[X1000_CLK_UART0] =3D {
>  		"uart0", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK },
>  		.gate =3D { CGU_REG_CLKGR, 14 },
>  	},
>=20
>  	[X1000_CLK_UART1] =3D {
>  		"uart1", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK},
>  		.gate =3D { CGU_REG_CLKGR, 15 },
>  	},
>=20
>  	[X1000_CLK_UART2] =3D {
>  		"uart2", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK },
>  		.gate =3D { CGU_REG_CLKGR, 16 },
>  	},
>=20
>  	[X1000_CLK_TCU] =3D {
>  		"tcu", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK },
>  		.gate =3D { CGU_REG_CLKGR, 18 },
>  	},
>=20
>  	[X1000_CLK_SSI] =3D {
>  		"ssi", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_SSIMUX, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_SSIMUX },
>  		.gate =3D { CGU_REG_CLKGR, 19 },
>  	},
>=20
>  	[X1000_CLK_OST] =3D {
>  		"ost", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK },
>  		.gate =3D { CGU_REG_CLKGR, 20 },
>  	},
>=20
>  	[X1000_CLK_PDMA] =3D {
>  		"pdma", CGU_CLK_GATE,
> -		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents =3D { X1000_CLK_EXCLK },
>  		.gate =3D { CGU_REG_CLKGR, 21 },
>  	},
>  };
> --
> 2.38.1
>=20


