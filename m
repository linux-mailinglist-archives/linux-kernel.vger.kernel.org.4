Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6CC7390F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFUUmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898B10D2;
        Wed, 21 Jun 2023 13:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC796152D;
        Wed, 21 Jun 2023 20:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AD5C433C0;
        Wed, 21 Jun 2023 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687380171;
        bh=6mOvkf1tp0MaXc78Yx6yn5b2RwNgMbnASYqk7mMraHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHsypfLla1qIozwVaf6pPL0hFaTxPr2r08Af/ATLBEFwIkLbb3itX5nmgUuQhbeJv
         OTSTwEEUkdUIMZb+9uiXI5Emjr6BtAWYPLakMixJWhLffDBqYXJ791CQG3UUhrm/5y
         UZ64WWzHjHE9RefbopX4YrwBD2E0qvXWGwDv7xrR8l9ksERieQ568NgJaIS/5gh2GW
         XSXTSBh+pWS3TZPuNaw08r8fVipvUrhtB+PewlTA2IUYSq97IoqfufVasnVHOZ7j/6
         RKElVCwr9XwkeRv4w97pBJ8UXvybN6BWn7RLyzr56B+YWrrJYOgDOn7ByXvnsRCm+v
         Vfjqb/GBHjWKg==
Date:   Wed, 21 Jun 2023 21:42:43 +0100
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
        Marek Vasut <marex@denx.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul
 support
Message-ID: <20230621-data-smirk-36bba6f815ad@spud>
References: <20230621093245.78130-1-o.rempel@pengutronix.de>
 <20230621093245.78130-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J8TbsuUfMTbP6whp"
Content-Disposition: inline
In-Reply-To: <20230621093245.78130-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J8TbsuUfMTbP6whp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 11:32:41AM +0200, Oleksij Rempel wrote:
> Add the 'fsl,imx6ul-usdhc' value to the compatible properties list in
> the fsl-imx-esdhc.yaml file. This is required to match the compatible
> strings present in the 'mmc@2190000' node of 'imx6ul-prti6g.dtb'. This
> commit addresses the following dtbs_check warning:
> imx6ul-prti6g.dtb:0:0: /soc/bus@2100000/mmc@2190000: failed to match any =
schema with compatible: ['fsl,imx6ul-usdhc', 'fsl,imx6sx-usdhc']
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Seems harmless...
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/D=
ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index fbfd822b92707..82eb7a24c8578 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -42,6 +42,7 @@ properties:
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

--J8TbsuUfMTbP6whp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNgwwAKCRB4tDGHoIJi
0i1RAQCBFDAYqoL3pPW8t2IB/dJd8QozfffhqAJ1rwSqKOZ1OAD9GX1AAM2VhBky
PxulAKMfPnn876al0CLlGePgEVXE+AI=
=ouzy
-----END PGP SIGNATURE-----

--J8TbsuUfMTbP6whp--
