Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF8687C1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBBLWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBBLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:22:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5149426
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:22:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNXfg-0001dt-3R; Thu, 02 Feb 2023 12:22:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNXfd-0029u4-Cq; Thu, 02 Feb 2023 12:22:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNXfd-000GOV-Tw; Thu, 02 Feb 2023 12:22:25 +0100
Date:   Thu, 2 Feb 2023 12:22:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: mediatek: add mediatek,mt7986
 compatible
Message-ID: <20230202112225.r4wg2nqbcocbnmec@pengutronix.de>
References: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
 <20230202095733.kxh6jd5hbshhif44@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mysq7dcqb7ly26qb"
Content-Disposition: inline
In-Reply-To: <20230202095733.kxh6jd5hbshhif44@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mysq7dcqb7ly26qb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2023 at 10:57:34AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Wed, Feb 01, 2023 at 07:25:57PM +0000, Daniel Golle wrote:
> > Since commit 241eab76657f ("pwm: mediatek: Add support for MT7986")
> > support for the 2 PWM channels implemented in MediaTek MT7986 SoCs has
> > been added. Also add the compatible string to dt-bindings now that
> > they have been converted to YAML.
> >=20
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > This patch has previously been submitted, but we decided to deferr it u=
ntil
> > after the conversion to YAML which has now been done via commit
> > 3e98855ca0cf ("dt-bindings: pwm: mediatek: Convert pwm-mediatek to DT s=
chema")
> > See
> > https://patchwork.ozlabs.org/project/devicetree-bindings/patch/Y39PjU1B=
qBB8tZ98@makrotopia.org/
>=20
> This commit is currently in next via the pwm tree. The easy options are
> to take this commit via pwm, too, or wait till after tne next merge
> window. I'm fine with the former.
>=20
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

However it wasn't sent to the linux-pwm list, so it doesn't appear in
the pwm patchwork :-\

I bounced it, but not sure that will make it appear there.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mysq7dcqb7ly26qb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPbnO4ACgkQwfwUeK3K
7AlNKwgAlGG0ra8OtKfzugGoSYMltYXKZt32d4XG1V7KBQMvvLHn7Yhs3zZXI/A0
FFlpdyo0qBzFmmddOmKvh5yaA6oVNANGuRpBebxRvcJ9XQuGH84EHMvAaDRlZeN3
5hSHfqAvXtrs8XqXRrvC2nKrJMrEwLnj5u4kX3EUWbibwHMsGfZw9NXERkQHU7Tv
CoeQKCWJElp9H3JC7QxGpu7YUo9VNuJ6tIpjf/kpxkzOSFAAkXJJ2PPWsQG+zgfv
HnUbrzkwd5S1kQqNW8EIdH5tmE566AnZUPzTkHXBSRCpZWnDdnFsIlVYkn5a6xNE
TwIihOEGnlogkwybgio3Ugh0A5coNw==
=btCZ
-----END PGP SIGNATURE-----

--mysq7dcqb7ly26qb--
