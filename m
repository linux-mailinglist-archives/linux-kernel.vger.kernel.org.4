Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8146973910E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjFUUsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFUUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0710D2;
        Wed, 21 Jun 2023 13:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C414616C9;
        Wed, 21 Jun 2023 20:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201D1C433C8;
        Wed, 21 Jun 2023 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687380506;
        bh=x/FU7pTH02A/OJPh+r4Bb3ys608yccmPQe4IL9IqKvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DanPLswI9+BpMshF3wm24UDTKIb+rxNjf3B8AGGAJ38uhda+PoVApZrxioMUt7mnQ
         zjYU1ORGDTt/11TTt2SPFL3tbEaOPPz1FBGrGaTTnlKLzzc1si2hHt2vNlnNhBaFi8
         1z4Ed7JLPNR5hr4e83cYeMU+I3qOyVrUDdV4AF75GBi7mohMxc1ghwZW7HGm+YYN+N
         qhmX2BA32vwSNMvC+LNg0zqoZc/8GshmqljDh69yqYhiUn71+z7o+ABdg1W3rEc0fv
         C7PC/dfNhB2sgphwYtoVDileXNiic63kgu/Je2JWCB5TRDIXCMEgBHY9tA0u7WtYPK
         sELT2Bc+IsRVg==
Date:   Wed, 21 Jun 2023 21:48:18 +0100
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
Subject: Re: [PATCH v2 3/5] dt-bindings: timer: gpt: Support 3rd clock for
 i.MX6DL
Message-ID: <20230621-reunion-unusual-7905860c9b14@spud>
References: <20230621093245.78130-1-o.rempel@pengutronix.de>
 <20230621093245.78130-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AX1gljKbRPqQ/JuA"
Content-Disposition: inline
In-Reply-To: <20230621093245.78130-4-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AX1gljKbRPqQ/JuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 11:32:43AM +0200, Oleksij Rempel wrote:
> Add support for a 3rd clock, 'osc_per', for i.MX6DL to the 'fsl,imxgpt'
> binding to resolve the following dtbs_check warning:
> imx6dl-alti6p.dtb: timer@2098000: clocks: [[2, 119], [2, 120], [2, 237]] =
is too long
> imx6dl-alti6p.dtb: timer@2098000: clock-names: ['ipg', 'per', 'osc_per'] =
is too long
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--AX1gljKbRPqQ/JuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNiEgAKCRB4tDGHoIJi
0ryPAQCIjKC9cEDRCqtFXCvRypza5RV7Z/2hT5yHVs/S4vdrigEAjx+v6VO3+K57
LQu6u2ng9rECgETGDrHZESQ8LSz6MAk=
=Qoem
-----END PGP SIGNATURE-----

--AX1gljKbRPqQ/JuA--
