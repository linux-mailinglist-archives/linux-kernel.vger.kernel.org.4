Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30B6B730E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCMJq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCMJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:46:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B7334F58
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:46:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbekf-0001xo-DD; Mon, 13 Mar 2023 10:45:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbeke-003okY-2i; Mon, 13 Mar 2023 10:45:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbekd-004Utn-Ao; Mon, 13 Mar 2023 10:45:55 +0100
Date:   Mon, 13 Mar 2023 10:45:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 01/30] clk: mediatek: Make mtk_clk_simple_remove() return
 void
Message-ID: <20230313094555.5w36kjkybiukan5j@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
 <20230312161512.2715500-2-u.kleine-koenig@pengutronix.de>
 <d0a2eb84-4420-8b6c-bd97-e58aa47be289@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nats3dcih3a6v62j"
Content-Disposition: inline
In-Reply-To: <d0a2eb84-4420-8b6c-bd97-e58aa47be289@collabora.com>
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


--nats3dcih3a6v62j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Angelo,

On Mon, Mar 13, 2023 at 09:54:07AM +0100, AngeloGioacchino Del Regno wrote:
> Il 12/03/23 17:14, Uwe Kleine-K=F6nig ha scritto:
> > mtk_clk_simple_remove() returned zero unconditionally. Make it return no
> > value instead and convert the respective drivers to .remove_new.
> >=20
> > This makes the semantics in the callers of mtk_clk_simple_remove() clea=
rer
> > and prepares for the quest to make platform driver's remove function re=
turn
> > void.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Hello Uwe,
>=20
> since there's a big cleanup series that is well reviewed and that is touc=
hing
> practically all MediaTek clock drivers, can you please rebase this commit=
 over
> [1]?

I'll wait a bit until this series is in and then rebase and resend.
Thanks for letting me know.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nats3dcih3a6v62j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQO8NAACgkQwfwUeK3K
7AlSiAf/USrTyLSCOBQ/pxTpNaDcBd1ckdBpfIm3VyM/+KK5lPesPql8tHCB5xbo
zwj78lmc3iBA2w5KuR8Hg3oxPVvXCysR/XmSBMizRzotJyts7D3zl/0geMWok5w8
uGeXfeWjsEvuWWEbYP87D6c2H3A+gT2xMC3Rj822nrOFbedND9UwK4FZAtMBrqm+
tYPONXJcv2lxQ8pcgpRRdZ6jfsT508k4EZ4o1lZPywn+72KwcrRX3shcCyd4k586
EnRNPqoDKmJZ44a/Bq86qh/BoTsqlqpv5DV1lKwIjHceR551lBS2hnIbT1O5FV6w
AE+mTyE2NCdTZpOO38xyNT6tKqouVA==
=fX9n
-----END PGP SIGNATURE-----

--nats3dcih3a6v62j--
