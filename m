Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BCA71F19C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFASTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA29D123;
        Thu,  1 Jun 2023 11:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1486092E;
        Thu,  1 Jun 2023 18:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2EDC433EF;
        Thu,  1 Jun 2023 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685643567;
        bh=/CK27flDY47U9lo7ftBUe3wetfThrrS+44Dya7xRhks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX5vaKSIFeGsVAbmZqOmygsriHFVK9+q/wK2+M16dDzxQr5d9SbGjanBw6b8Y7eZj
         JuIvxn8yISFQ8lBVn3DM14V5HM7JYTW0oNGl1510mMnC9cjzSoAnhdGNxZERke5ceZ
         H21Fd7hQvs8faGG2riBJ+f++mfl7kShaC3FqGni6S/lnmCs2aVyN79Vl35n+OpPWew
         Qo4JGyNhKZwo90NpjbbRaIfRGjr88jC6olJnm5vMO5DDIFBxS6ySBLnwb+vSdvtylB
         6MEVZnvm+NIgyU/XwZ6JLZ7egvlpyeU6UGyDR8hafjOEf8eSgj8FdKhRi8h4W0Be53
         zMgCydbTIMqLA==
Date:   Thu, 1 Jun 2023 19:19:19 +0100
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
Message-ID: <20230601-skyrocket-catalyze-b0ebd3b04059@spud>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-2-o.rempel@pengutronix.de>
 <20230601-obnoxious-sterility-e89541412bb4@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="armD+pG4iw0tHnlQ"
Content-Disposition: inline
In-Reply-To: <20230601-obnoxious-sterility-e89541412bb4@spud>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--armD+pG4iw0tHnlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 07:18:31PM +0100, Conor Dooley wrote:
> On Thu, Jun 01, 2023 at 12:14:45PM +0200, Oleksij Rempel wrote:
> > Add the 'fsl,imx6ul-usdhc' value to the compatible properties list in
> > the fsl-imx-esdhc.yaml file. This is required to match the compatible
> > strings present in the 'mmc@2190000' node of 'imx6ul-prti6g.dtb'. This
> > commit addresses the following dtbs_check warning:
> >   imx6ul-prti6g.dtb: mmc@2190000: compatible: 'oneOf' conditional faile=
d,
> >     one must be fixed: ['fsl,imx6ul-usdhc', 'fsl,imx6sx-usdhc'] is too =
long
> >     'fsl,imx6ul-usdhc' is not one of ['fsl,imx25-esdhc', 'fsl,imx35-esd=
hc',
> >     'fsl,imx51-esdhc', 'fsl,imx53-esdhc', 'fsl,imx6q-usdhc',
> >     'fsl,imx6sl-usdhc', 'fsl,imx6sx-usdhc', 'fsl,imx7d-usdhc',
> >     'fsl,imx7ulp-usdhc', 'fsl,imx8mm-usdhc', 'fsl,imxrt1050-usdhc',
> >     'nxp,s32g2-usdhc']
> >   From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b=
/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index fbfd822b9270..090e781705d3 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -30,6 +30,7 @@ properties:
> >            - fsl,imx6q-usdhc
> >            - fsl,imx6sl-usdhc
> >            - fsl,imx6sx-usdhc
> > +          - fsl,imx6ul-usdhc
>=20
> How come this gets added as a standalone compatible _and_ one that
> should fall back to imx6sx?

Whoops, sent too soon.
I meant to point out that the only user in-tree uses the fallback to
imx6sx.

Cheers,
Conor.

> >            - fsl,imx7d-usdhc
> >            - fsl,imx7ulp-usdhc
> >            - fsl,imx8mm-usdhc
> > @@ -42,6 +43,7 @@ properties:
> >            - enum:
> >                - fsl,imx6sll-usdhc
> >                - fsl,imx6ull-usdhc
> > +              - fsl,imx6ul-usdhc
> >            - const: fsl,imx6sx-usdhc
> >        - items:
> >            - const: fsl,imx7d-usdhc
> > --=20
> > 2.39.2
> >=20



--armD+pG4iw0tHnlQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHjhJwAKCRB4tDGHoIJi
0vraAQCCWwhkoXHpm6VQ1+XJQj7It+kXow+pgrvs3mdgMeywHgEAo3OaIlLrqkrf
+FJa/mvB1vUq1J3B9hs35Ukc0D2YrgU=
=b6CQ
-----END PGP SIGNATURE-----

--armD+pG4iw0tHnlQ--
