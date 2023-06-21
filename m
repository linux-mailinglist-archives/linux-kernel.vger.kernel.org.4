Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220BB739106
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjFUUrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24019B5;
        Wed, 21 Jun 2023 13:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FF99614D2;
        Wed, 21 Jun 2023 20:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECE5C433C0;
        Wed, 21 Jun 2023 20:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687380437;
        bh=QDn3BjmKWv4AYihBvKk88ti9HewVjJsY4tfU8BbJQFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PozMih9BDoXw8jhzqu5Od08ocZ4+8b0IMfrRB6iICJRvh9WR3MEuKyn1+ysuR8Hcg
         zlds2JYZACEc9Qbg7qLL4UG6W9chb2bLj2rx3Mzrwha8oA43+29xNkh2y7+4JdM73G
         f5EBrE2fLH3sZt/y+IuINqmhW9POc9p0Ko0lCn/y5XEaomis8kdpGyhCY98nIV1qXP
         Ug1v5cu8G4ubCN7vp5SOin6HgFOvVQlU8BU60LGxMnyuuEtJ74k+8ZnhhGPwRV3Nve
         OK20qVAIQlQzgWV8Qt602qGUcbFa34kYek3GCibNi8JffQFrcCWPYGWGP+/HoHA+Fv
         HIfIz1hyS7NfA==
Date:   Wed, 21 Jun 2023 21:47:10 +0100
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
Subject: Re: [PATCH v2 2/5] dt-bindings: timer: gpt: Add i.MX6UL support
Message-ID: <20230621-hypocrite-setup-4996aae9dd7d@spud>
References: <20230621093245.78130-1-o.rempel@pengutronix.de>
 <20230621093245.78130-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cG9zPIwmumeL3YFj"
Content-Disposition: inline
In-Reply-To: <20230621093245.78130-3-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cG9zPIwmumeL3YFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Oleksij,

On Wed, Jun 21, 2023 at 11:32:42AM +0200, Oleksij Rempel wrote:
> Add 'fsl,imx6ul-gpt' compatible to resolve the following dtbs_check
> warning:
> imx6ull-jozacp.dtb:0:0: /soc/bus@2000000/timer@2098000: failed to match a=
ny schema with compatible: ['fsl,imx6ul-gpt', 'fsl,imx6sx-gpt']

hmm, "imx6ull-jozacp" but the compatible is "imx6ul-gpt".
Is that not incorrect in the first place?

Also, this diff has already made it in - it is in next as 451d69d2f1f9
("dt-bindings: imxgpt: add imx6ul compatible"), applied on 20.05.2023
or similar.

Cheers,
Conor.

>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Do=
cumentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index 716c6afcca1fa..685137338ac99 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -34,6 +34,9 @@ properties:
>                - fsl,imxrt1050-gpt
>                - fsl,imxrt1170-gpt
>            - const: fsl,imx6dl-gpt
> +      - items:
> +          - const: fsl,imx6ul-gpt
> +          - const: fsl,imx6sx-gpt
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.39.2
>=20

--cG9zPIwmumeL3YFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNhzgAKCRB4tDGHoIJi
0oCiAQCYUiA0mVKTYKWZ7uOESNp411Rgg9k3SX1exIATPxSvTgD9HL1qwOp5K68G
/q4Q4ZiJW47D+b1lAI277RiLUVXxlQI=
=CPZC
-----END PGP SIGNATURE-----

--cG9zPIwmumeL3YFj--
