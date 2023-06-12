Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C972BD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjFLJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjFLJtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:49:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A728276E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:35:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8dvJ-0007lJ-Kv; Mon, 12 Jun 2023 11:33:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8dvI-006r1G-Db; Mon, 12 Jun 2023 11:33:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8dvH-00DTIu-Ns; Mon, 12 Jun 2023 11:33:15 +0200
Date:   Mon, 12 Jun 2023 11:33:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: drop unneeded quotes
Message-ID: <20230612093315.gbabepl5qg44xf5d@pengutronix.de>
References: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ywa6wsg5cd34k7qa"
Content-Disposition: inline
In-Reply-To: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ywa6wsg5cd34k7qa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 09, 2023 at 04:07:09PM +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.

in my book quoting everything instead of dropping quotes is the better
option. While that policy adds more quotes, it prevents surprises like:

	$ yaml2json << EOF
	> countrycodes:
	>  - de
	>  - fr
	>  - no
	>  - pl
	> EOF
	{
	  "countrycodes": [
	    "de",
	    "fr",
	    false,
	    "pl"
	  ]
	}

And if you use the "only-when-needed" rule of yamllint you have to write
the above list as:

	countrycodes:
	 - de
	 - fr
	 - "no"
	 - pl

which is IMHO really ugly.

Another culprit is "on" (which is used e.g. in github action workflows),
so yamllint tells for example for
https://github.com/pengutronix/microcom/blob/main/.github/workflows/build.y=
ml:

	  3:1       warning  truthy value should be one of [false, true]  (truthy)

and there are still more surprises (e.g. version numbers might be
subject to conversion to float). So at least in my bubble the general
hint is to *always* quote strings. Note that required: true is also the
default for yamllint's quoted-strings setting, proably for pitfalls like
these.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ywa6wsg5cd34k7qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSG5loACgkQj4D7WH0S
/k6ArQf/b00Bh9jtwpjsQUidCR7aV3sXe4wGk2E2np3MSScx9uTV5nNd3PEwuDXA
gyH3OxCa59XjEAv4ldnNRq0vzgzg/+C3QazJbBNgK52hrNNJWcq0qmEUEJb7s1Xo
HwZuUlIBzijuWwXTganvs3MT8/gihXcJZFJh1pYpaBW1cAPIaOivtOVgBEkG8Clh
1/MuNXFbwuOECYdB/+EVU/L18k0UvHzOcPMkoG8PiNe7Qlrc4SRoMHKoQ2ODTg+e
KnajlqePGTyRrawgZYlyQikCpnCR8RIEfuVe+kpM3c6bU6nXXCituhHEJqW0Cetv
O3CieA77s+5NvHqazJ19xF+pYDaVPg==
=r9PT
-----END PGP SIGNATURE-----

--ywa6wsg5cd34k7qa--
