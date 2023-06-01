Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4480C71F1A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjFASSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFASSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D45123;
        Thu,  1 Jun 2023 11:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE036484B;
        Thu,  1 Jun 2023 18:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCAEC433D2;
        Thu,  1 Jun 2023 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685643519;
        bh=SBQxh2+ToyiB9ICBSOpcMeGoo9NUjEEwMfXF8u7aW30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=an/91JvUBIgIJIIKiGflzBrkvpPoX2M2hXeuZLim/QIu6MldFN+9xZb83MQxB0gaO
         a3IMs9izaGmlLwmU9vtB9oL3u09jUYRphLtEOZCds/q4ibS6EQYo39wQy46v+8IM83
         ndsuhXHlCCAuOzhKuHSTSAfDR7l8q7ri0o4ontB3uggNjKRZr3g1nwQjuu8csyDnRt
         Oo0USOkwzYd7G+7q/nF6ojshA/tKnUon5EmqQAq/r2gARqvKwwydptJaHtEgpJGpJ+
         5mrk0Y4hW2b1178a8GxGssEjZ3uKEv1daL3MXHl4YANJBBvRDIc1R4Vn70tb1cgfzT
         SRpR5vEhL9TZQ==
Date:   Thu, 1 Jun 2023 19:18:31 +0100
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
Subject: Re: [PATCH v1 1/7] dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul
 support
Message-ID: <20230601-obnoxious-sterility-e89541412bb4@spud>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="biMuZ975ln5b9eCw"
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--biMuZ975ln5b9eCw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 12:14:45PM +0200, Oleksij Rempel wrote:
> Add the 'fsl,imx6ul-usdhc' value to the compatible properties list in
> the fsl-imx-esdhc.yaml file. This is required to match the compatible
> strings present in the 'mmc@2190000' node of 'imx6ul-prti6g.dtb'. This
> commit addresses the following dtbs_check warning:
>   imx6ul-prti6g.dtb: mmc@2190000: compatible: 'oneOf' conditional failed,
>     one must be fixed: ['fsl,imx6ul-usdhc', 'fsl,imx6sx-usdhc'] is too lo=
ng
>     'fsl,imx6ul-usdhc' is not one of ['fsl,imx25-esdhc', 'fsl,imx35-esdhc=
',
>     'fsl,imx51-esdhc', 'fsl,imx53-esdhc', 'fsl,imx6q-usdhc',
>     'fsl,imx6sl-usdhc', 'fsl,imx6sx-usdhc', 'fsl,imx7d-usdhc',
>     'fsl,imx7ulp-usdhc', 'fsl,imx8mm-usdhc', 'fsl,imxrt1050-usdhc',
>     'nxp,s32g2-usdhc']
>   From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/D=
ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index fbfd822b9270..090e781705d3 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -30,6 +30,7 @@ properties:
>            - fsl,imx6q-usdhc
>            - fsl,imx6sl-usdhc
>            - fsl,imx6sx-usdhc
> +          - fsl,imx6ul-usdhc

How come this gets added as a standalone compatible _and_ one that
should fall back to imx6sx?

>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
>            - fsl,imx8mm-usdhc
> @@ -42,6 +43,7 @@ properties:
>            - enum:
>                - fsl,imx6sll-usdhc
>                - fsl,imx6ull-usdhc
> +              - fsl,imx6ul-usdhc
>            - const: fsl,imx6sx-usdhc
>        - items:
>            - const: fsl,imx7d-usdhc
> --=20
> 2.39.2
>=20

--biMuZ975ln5b9eCw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHjg9wAKCRB4tDGHoIJi
0ut/AP9F46XeYtXvp51EgPcfCAk62B/ruwOmoh+FIfvQ2uIYUAEAr+BafXmYjdXA
178tOtlxudsrD3V6ICAbE3GNJ3ipyAA=
=oCZ8
-----END PGP SIGNATURE-----

--biMuZ975ln5b9eCw--
