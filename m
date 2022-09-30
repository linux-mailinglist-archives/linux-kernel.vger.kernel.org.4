Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF115F0F34
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiI3PsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI3PsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:48:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F78D1A88D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:48:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeIF4-0001O6-4j; Fri, 30 Sep 2022 17:47:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeIF4-003pOi-Ou; Fri, 30 Sep 2022 17:47:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeIF2-004hZQ-DL; Fri, 30 Sep 2022 17:47:56 +0200
Date:   Fri, 30 Sep 2022 17:47:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [RFC v4 02/10] pwm: dwc: allow driver to be built with
 COMPILE_TEST
Message-ID: <20220930154756.qestmqgekkvc5jmi@pengutronix.de>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-3-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hsqqpq2axr4ef664"
Content-Disposition: inline
In-Reply-To: <20220816211454.237751-3-ben.dooks@sifive.com>
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


--hsqqpq2axr4ef664
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, Aug 16, 2022 at 10:14:46PM +0100, Ben Dooks wrote:
> Allow dwc driver to be built with COMPILE_TEST should allow
> better coverage when build testing.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

You marked this patch as "changes requested" without feedback. This
patch is part of a bigger series, but makes sense to be applied stand
alone, too.

Ditto for patch #3 IMHO.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hsqqpq2axr4ef664
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM3D6kACgkQwfwUeK3K
7Alj0Qf+PGyZlI2MRcoZJZ9qMLavu1JCUuyDaC+rxuE/7VLz6mzI2zSFXgA2S9+0
jJJ6oaoliC4Ot9EOfa/oaiprgxJnq2294AP3xLUQIXZb4rjZsjonmsicCC25wMAU
5iC9Eq9ZWkzgIWnY9MyAEpsKLg7VMSthqNGFJVfzmwdHki3NqEIRyMeLJ08THxjc
fgw2LyTarJBMVqAo+dDkWRY+GTOTLcEqRs7Tkg9pJsti0BpKyUAMpl9APYi8J66e
jB6RYum68LZ2jLzs1opgYHonDChEmebNUvtpETdVWUrREMLJ/pWtFPdHBltGh6In
ouhc8Un7zOFUybWH9uELZhsbSKizmw==
=d3oj
-----END PGP SIGNATURE-----

--hsqqpq2axr4ef664--
