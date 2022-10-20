Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA96606513
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJTPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJTPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:51:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598DA57570
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:51:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXp3-0007mt-Eq; Thu, 20 Oct 2022 17:51:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXoz-000LfJ-Vs; Thu, 20 Oct 2022 17:51:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXp1-009MN7-M1; Thu, 20 Oct 2022 17:51:03 +0200
Date:   Thu, 20 Oct 2022 17:51:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v6 02/10] pwm: dwc: allow driver to be built with
 COMPILE_TEST
Message-ID: <20221020155103.tdqsxo2uwrsihp4b@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-3-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5b6aanlbsfteqtwm"
Content-Disposition: inline
In-Reply-To: <20221020151610.59443-3-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5b6aanlbsfteqtwm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 04:16:02PM +0100, Ben Dooks wrote:
> Allow dwc driver to be built with COMPILE_TEST should allow
> better coverage when build testing.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

(forwarded from v4)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5b6aanlbsfteqtwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNRbmQACgkQwfwUeK3K
7Ak9lwgAgAuO1JUYT2rplVcXHsuTwa6mp0c9MuAG9GQfq6fwkH86Zy6navhNcbFj
QDJAiCFCSfasnOcK2G1bSSmd/A/qmIm2G+GhIBCVw+pyHMcMERlMJFSrUUCYxsOK
RZSW/hOvC7Oz46gkmlyTJ98Hjs9+qNOGyB6O85Oxd4CDxx3dAgE86fPAtb8uzJTc
BAP76XqdS1ICvxf3ZIjM86M0s1TSoFf5AxanyHDqBVtwJQTD6NUqfalBtOCwkMmT
8cci9K/hK1ZZ4QjKGOoYnfGI3m30G4i9yb2v0QBr/IDBS05fAfyA1HCwGKvzzALQ
YQEabEKJ5RPIrS+l11JHPReymIr+YA==
=bcw4
-----END PGP SIGNATURE-----

--5b6aanlbsfteqtwm--
