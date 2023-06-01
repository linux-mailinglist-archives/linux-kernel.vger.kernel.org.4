Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F371F1A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjFASVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjFASVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF28E7;
        Thu,  1 Jun 2023 11:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B0F648B5;
        Thu,  1 Jun 2023 18:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1F2C433EF;
        Thu,  1 Jun 2023 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685643663;
        bh=3C0SkEpx25LzxKVHKtqAhhDZwiOXn3100Z4jzhaKZPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGzj0WceMqYSr8i1IHs4EHuYp+6wm8D++CmoNk6KtIL8ZDERSMpk3zaZ7EZHDPoWx
         bflTvZ31Q72uUdT1KPfOAlK8GF5NJL7Pj7JXgRzr/HeeL2BDsHNYhNZWq6fu6X2mF8
         cRx2p+gS0o2J8tp8CNRcOGsRQI8MI4wcfDXxJaGrw9VTc3BABSYnMC5H9xq6dZLt3P
         cAsOeJ52thN2bNKAKQQcJkLlzJpR5m9naFUmYCkcKl8gQ08XLjuJMmVOoaIVUMHN6V
         gr+W5Lht0fbISMZ74rDYC+N673thPKCagFQxw+iPBW8coX5nJpUjJA8V0HHnC8/JMB
         qKC6/HFdiIjxQ==
Date:   Thu, 1 Jun 2023 19:20:54 +0100
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
Subject: Re: [PATCH v1 2/7] dt-bindings: timer: gpt: Add i.MX6UL support
Message-ID: <20230601-sulfide-endeared-10611decfc76@spud>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6yJwXEnKcMqUqOyW"
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-3-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6yJwXEnKcMqUqOyW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 12:14:46PM +0200, Oleksij Rempel wrote:
> Add 'fsl,imx6ul-gpt' compatible to resolve the following dtbs_check
> warning:
> /arch/arm/boot/dts/imx6ull-jozacp.dtb: timer@20e8000: compatible:
> 'oneOf' conditional failed, one must be fixed:
>     'fsl,imx6ul-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt',
>     'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Do=
cumentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index 716c6afcca1f..adf617b8f353 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -34,6 +34,10 @@ properties:
>                - fsl,imxrt1050-gpt
>                - fsl,imxrt1170-gpt
>            - const: fsl,imx6dl-gpt
> +      - const: fsl,imx6ul-gpt

Again, why add this as an appears-on its own compatible when it seems to
be used only with a fallback to imx6sx? (In-tree at least)

> +      - items:
> +          - const: fsl,imx6ul-gpt
> +          - const: fsl,imx6sx-gpt
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.39.2
>=20

--6yJwXEnKcMqUqOyW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHjhhQAKCRB4tDGHoIJi
0gKsAP9gnzCEt+UGWDSbNo9A2BliW8T5rVp5tSVVcf0BrFLxZwD+Nlu07GFXv04u
dfRGrbFfaTTS2UgI31rRadiuExMfMwM=
=hpey
-----END PGP SIGNATURE-----

--6yJwXEnKcMqUqOyW--
