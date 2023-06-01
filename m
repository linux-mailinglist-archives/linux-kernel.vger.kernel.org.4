Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B2C71F1DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjFAS0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjFAS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF05193;
        Thu,  1 Jun 2023 11:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57802648CF;
        Thu,  1 Jun 2023 18:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE23C433EF;
        Thu,  1 Jun 2023 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685643971;
        bh=TBbu7osvFBKuf66WBcBQLyIQCCJTf+5qdAP5tofTIaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9cmwW9ZU12QuOvLrFst3R1eecB/8LMV1FSykLyAWafIGCHBHtUxGHDDh+w2tozEN
         guuJt/TO+te54HWzOFDRDpuYAUmqtNMFaIa/jK1bCdncLCkd2CRSe+EMKrItwoqTdu
         Ri+VlwuL5pq3ChHAptv2CHRF9T4jNMUpUqOXZSxwrzJ4MfRrQC37bwVgo02bJvSA3a
         F9uK8PF4RIU1kvZ7oDBgC4kljOq9Ec5nAJlv0W2mX0ZCRPX3XphjJ/uyCiJDBa/PYd
         cX/uuGz+t6YmYK9/UCGKYH4pidln7BunKPHyJIk79yq3C7vtNGhIexTE9hulS7Ke/k
         cV3Lr97berdVg==
Date:   Thu, 1 Jun 2023 19:26:03 +0100
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
Subject: Re: [PATCH v1 4/7] dt-bindings: crypto: fsl-dcp: Add i.MX6SL,
 i.MX6SLL, and i.MX6ULL support
Message-ID: <20230601-deranged-whole-5f5d5b2b6db1@spud>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XbJH3SC5GDn8KS5H"
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-5-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XbJH3SC5GDn8KS5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 12:14:48PM +0200, Oleksij Rempel wrote:
> Add support for i.MX6SL, i.MX6SLL, and i.MX6ULL to the 'fsl-dcp' binding
> to address the following dtbs_check warning:
>   imx6ull-jozacp.dtb: crypto@2280000: compatible:0: 'fsl,imx6ull-dcp' is
>     not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
>   From schema: Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
>=20
>   imx6ull-jozacp.dtb: crypto@2280000: compatible: ['fsl,imx6ull-dcp',
>     'fsl,imx28-dcp'] is too long
>   From schema: Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/crypto/fsl-dcp.yaml   | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml b/Docu=
mentation/devicetree/bindings/crypto/fsl-dcp.yaml
> index 99be01539fcd..8af393b9f3ca 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
> @@ -11,9 +11,22 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx23-dcp
> -      - fsl,imx28-dcp
> +    oneOf:
> +      - const: fsl,imx23-dcp
> +      - const: fsl,imx28-dcp
> +      - const: fsl,imx6sl-dcp
> +      - const: fsl,imx6sll-dcp
> +      - const: fsl,imx6ull-dcp

Confused again here chief, why allow these to appear on their own if
their are all compatible with the imx28-dcp?

> +      - items:
> +          - enum:
> +              - fsl,imx6sl-dcp
> +              - fsl,imx6sll-dcp
> +              - fsl,imx6ull-dcp
> +          - const: fsl,imx28-dcp
> +      - items:
> +          - enum:
> +              - fsl,imx28-dcp
> +          - const: fsl,imx23-dcp

I don't get this either. Why set the imx23-dcp as the fallback for the
imx28-dcp, when the imx28-dcp is being used as the fallback for the imx6
stuff?

I get the impression that some of the devicetrees should be fixed up,
rather than adding these sorta odd conditions to the bindings.

To me it'd make sense to swap everything that uses imx28-dcp as a
fallback to use imx23-dcp instead, since that is the most generic one?

What am I missing?

Cheers,
Conor.

> =20
>    reg:
>      maxItems: 1
> --=20
> 2.39.2
>=20

--XbJH3SC5GDn8KS5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHjiuwAKCRB4tDGHoIJi
0t4oAP4t/nOvAEHSbADUVQoAIkzwjFhYsOKHRpmygBC9qWhAxQEAmbN2h5I3sx6y
F0mOajZCVnZv5KCYbI53mIwOL2voPAg=
=iUTA
-----END PGP SIGNATURE-----

--XbJH3SC5GDn8KS5H--
