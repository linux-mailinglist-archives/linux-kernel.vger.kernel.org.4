Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACBE739133
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFUU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFUU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164831FCF;
        Wed, 21 Jun 2023 13:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3D9616D6;
        Wed, 21 Jun 2023 20:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FDBC433C9;
        Wed, 21 Jun 2023 20:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687381011;
        bh=uUMIRg6z98KEl6ZuwozW2mAxxkwDl0n2oYknJb1Q4cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcK4BpgOWQ2tti4tGUbSn+Hyepk8P6MyyKF2t8O+lYTg3R+UOn3BbBQP4G5bcRYBO
         MbJyQpZjAq6bVAVK6n8+VW+yxP5upQtrlLGMAxTTQsauLt7VzceMBdHWrwTSjdMdnx
         EyhxXMbK3Ol9zYh2g+h6pPs+4p/a6UWuAeQ/duhv3eJnBIhPhHbo38ZPp+pBeKKWHK
         CG1ccGoJGdr0rb7gUVbSjeaestvIoN9gDuPJ1va4dweyFUF/8bXVCdIbKiV8ID4c5Q
         TZ6w80ZMBlyNzqWZsQT/oItZB6+M3+tD/FhcAxlImmBGSmsd6H/76izpi2CdxUv8zW
         I54HcBFG+8+NA==
Date:   Wed, 21 Jun 2023 21:56:43 +0100
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
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: imx6ul: Support optional
 enet*_ref_pad clocks
Message-ID: <20230621-upheld-numerous-b15d77f5b1e1@spud>
References: <20230621093245.78130-1-o.rempel@pengutronix.de>
 <20230621093245.78130-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="owWJ4crf85zQgxme"
Content-Disposition: inline
In-Reply-To: <20230621093245.78130-5-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--owWJ4crf85zQgxme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 11:32:44AM +0200, Oleksij Rempel wrote:
> Extend the 'clocks' and 'clock-names' properties to support optional
> 'enet1_ref_pad' and 'enet2_ref_pad' clocks to resolve the following
> dtbs_check warning:
> imx6ul-prti6g.dtb: clock-controller@20c4000: clocks: [[17], [18], [19], [=
20], [21]] is too long
> imx6ul-prti6g.dtb: clock-controller@20c4000: clock-names: ['ckil', 'osc',=
 'ipp_di0', 'ipp_di1', 'enet1_ref_pad'] is too long
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/clock/imx6ul-clock.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/=
Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> index be54d4df5afa2..3b71ebc100bf6 100644
> --- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> @@ -28,18 +28,24 @@ properties:
>      const: 1
> =20
>    clocks:
> +    minItems: 4
>      items:
>        - description: 32k osc
>        - description: 24m osc
>        - description: ipp_di0 clock input
>        - description: ipp_di1 clock input
> +      - description: Optional lenet1_ref_pad or enet2_ref_pad clocks
> +      - description: Optional lenet1_ref_pad or enet2_ref_pad clocks
                                 ^
Is the l intentional?
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> =20
>    clock-names:
> +    minItems: 4
>      items:
>        - const: ckil
>        - const: osc
>        - const: ipp_di0
>        - const: ipp_di1
> +      - pattern: '^enet[12]_ref_pad$'
> +      - pattern: '^enet[12]_ref_pad$'
> =20
>  required:
>    - compatible
> --=20
> 2.39.2
>=20

--owWJ4crf85zQgxme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNkCwAKCRB4tDGHoIJi
0k5nAP47t0q8ImnClSi84ieDatbmvbBowQPSfGluP2hK9UcplgEA4uEpQgHdKMoi
vohLztlsb6xWY9kiRChHlJ2UoWINtw4=
=5ZOK
-----END PGP SIGNATURE-----

--owWJ4crf85zQgxme--
