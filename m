Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F264EAB7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiLPLir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLPLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:38:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA321807
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:38:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p692x-0007kU-FG; Fri, 16 Dec 2022 12:38:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p692u-004uXs-HA; Fri, 16 Dec 2022 12:38:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p692u-005WRG-EK; Fri, 16 Dec 2022 12:38:32 +0100
Date:   Fri, 16 Dec 2022 12:38:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: imx: Describe drm binding
 for fsl,imx-lcdc
Message-ID: <20221216113832.6qvyzlrwfzrlhker@pengutronix.de>
References: <20221214115921.1845994-1-u.kleine-koenig@pengutronix.de>
 <20221214115921.1845994-2-u.kleine-koenig@pengutronix.de>
 <0f3e755f-954a-9722-6898-181170deb2c3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vomqdkuv5b6duabq"
Content-Disposition: inline
In-Reply-To: <0f3e755f-954a-9722-6898-181170deb2c3@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vomqdkuv5b6duabq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2022 at 11:41:30AM +0100, Krzysztof Kozlowski wrote:
> On 14/12/2022 12:59, Uwe Kleine-K=F6nig wrote:
> > Modify the existing (fb-like) binding to support the drm-like binding in
> > parallel.
>=20
> Aren't you now adding two compatibles to the same hardware, just for two
> Linux drivers? One hardware should have one compatible, regardless of
> Linux display implementation.

The (up to now unopposed) idea was to use the opportunity to pick a
better name for the compatible. The hardware component is called LCDC
and I guess fsl,imx21-fb was only picked because the linux driver is
called imxfb. Unless I understood Rob wrong, he insisted to describe
both variants in a single binding document only.

> > +if:
>=20
> Put it under allOf. It grows pretty often so this would avoid future
> re-indents.

ok.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vomqdkuv5b6duabq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOcWLUACgkQwfwUeK3K
7Al9/wf/ZOo18OuIXv1lM+hxI9+4bUYsHMvey+G65EOqkXqkRZfOFZjeVsypRYEX
rk9Ws23MqhB6lYN7sUVwxiwtFJxtgJJ4rzwSisF83nCfnEnTiA1nkj1N5aJLAoEy
nzBN4aWkSmUisjB1dUgz702jYUAdEwaPqf7Mbe+jqTKFhm99A4pPCCfYWqJSGDKI
c8IupblZq2X59wlWnRKRbfIJQXujGomVE/lTzBdLvQDuiyYpXTqDVjM/bx7DTwtF
k2U8AEDM/DSl5ByO5esfQcCDV1Z/jjZh1F+OI1IFn60cI7j194c34m6cK5uIENPu
D6XB0+QlReZYOa72RW/ejUDOTgpyQA==
=tu0Y
-----END PGP SIGNATURE-----

--vomqdkuv5b6duabq--
