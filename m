Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50171F1DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjFASWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjFASWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9381D97;
        Thu,  1 Jun 2023 11:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2861D61238;
        Thu,  1 Jun 2023 18:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E01C433D2;
        Thu,  1 Jun 2023 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685643753;
        bh=w4NuGuxH0hV5RX32sGnngGHbSyJb+f8LzmAmm52CRdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTcGKa/rfL64j4NSRql0AX3AGqFXe9mynWzyCWQvsUr2bO3GRrPccojwXNFcYF8CZ
         4pDsvkbeKAZBMLxhNuNEuvvB/fSWIxdsuWq5JmfmiBfQOe891U+tEED6oTP0nRcwqe
         QQ4OBslEjanrWKMyIql4As4CBcElG4d2I2r6Ow1MbT4nkKmswtQhrKAwDGQrn9WA3p
         QIq6rrGHvm9FJWJH0LJ8x7JLqhijPQENXbdzUidZJbbDJit34Mlx+BXaEOFTOoBnaA
         023xKLjKT5jU5UBugPxva9GCXX8pWKQrEyQLVCxHnOJ5j6rGnX08J5oAdndOliCG65
         JPtNkeHErT5Bg==
Date:   Thu, 1 Jun 2023 19:22:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>, Marek Vasut <marex@denx.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v1 3/7] dt-bindings: timer: gpt: Support 3rd clock for
 i.MX6DL
Message-ID: <20230601-rising-motocross-19f7164e2933@spud>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwtaAij7TnQhIoFB"
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-4-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wwtaAij7TnQhIoFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 12:14:47PM +0200, Oleksij Rempel wrote:
> Add support for a 3rd clock, 'osc_per', for i.MX6DL to the 'fsl,imxgpt'
> binding to resolve the following dtbs_check warning:
>   imx6dl-alti6p.dtb: timer@2098000: clocks: [[2, 119], [2, 120], [2, 237]]
>     is too long
>   From schema: Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
>   imx6dl-alti6p.dtb: timer@2098000: clock-names: ['ipg', 'per', 'osc_per']
>     is too long
>   From schema: Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.yaml | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Do=
cumentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index adf617b8f353..21ff51c3f38f 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -46,14 +46,24 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    items:
> -      - description: SoC GPT ipg clock
> -      - description: SoC GPT per clock
> +    anyOf:
> +      - items:
> +          - description: SoC GPT ipg clock
> +          - description: SoC GPT per clock
> +      - items:
> +          - description: SoC GPT ipg clock
> +          - description: SoC GPT per clock
> +          - description: SoC GPT osc_per clock
> =20
>    clock-names:
> -    items:
> -      - const: ipg
> -      - const: per
> +    anyOf:
> +      - items:
> +          - const: ipg
> +          - const: per
> +      - items:
> +          - const: ipg
> +          - const: per
> +          - const: osc_per

Hmm, should we not do per-compatible enforcement here so that the extra
clock is only used on the appropriate platforms?

Cheers,
Conor.

> =20
>  required:
>    - compatible
> --=20
> 2.39.2
>=20

--wwtaAij7TnQhIoFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHjh4QAKCRB4tDGHoIJi
0gOHAP9vFLSM4KpeYpQ+vt2ySbilt1rP9cF+jqhusEWI0eMDzQD+NFwqAPbALLh2
ge4iyvHlYUvDu4omcsDjRDVRY0S7owI=
=XlPE
-----END PGP SIGNATURE-----

--wwtaAij7TnQhIoFB--
