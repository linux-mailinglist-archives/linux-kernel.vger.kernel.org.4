Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C566E471
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjAQRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjAQRH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:07:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076352BEFD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:07:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHpRB-0003GK-8T; Tue, 17 Jan 2023 18:07:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHpR9-006jNY-47; Tue, 17 Jan 2023 18:07:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHpR8-00DesE-4e; Tue, 17 Jan 2023 18:07:50 +0100
Date:   Tue, 17 Jan 2023 18:07:49 +0100
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
Subject: Re: [PATCH v7 00/10] Designware PWM driver updates for OF
Message-ID: <20230117170749.vff5av32m6djc5dz@pengutronix.de>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <46703b00-97d3-c21d-fbe1-71208fb50f73@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7xx7b55ldi3cgzf"
Content-Disposition: inline
In-Reply-To: <46703b00-97d3-c21d-fbe1-71208fb50f73@sifive.com>
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


--m7xx7b55ldi3cgzf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

On Tue, Jan 17, 2023 at 04:39:34PM +0000, Ben Dooks wrote:
> On 23/12/2022 15:38, Ben Dooks wrote:
> > An updated set of patches for the Designware PWM driver
> > split into PCI and OF versions. I think I got all the
> > review issues in this set.
> >=20
> > Sorry for the delay in getting this out, between conferences
> > and other absences there has been little time to deal with
> > this set. I will be now out of office until 3rd Jan 2023.
>=20
> Hi, how's the progress on review and getting this set finalised?

Speaking for me:

Your patch set isn't forgotton. It's just that my time is limited and
reviewing a new driver is time intensive.

I'm sorry I cannot give feedback in a more timely manner, but I will
come to it eventually.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m7xx7b55ldi3cgzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPG1eMACgkQwfwUeK3K
7AlzdQf/QUmeI4a1TFkUr15wS6W3iWDAylkgqXR4laiuB7kf6DN/uGDrCHCmch+n
A7bzpFN16H0i39OSEwM6NLb27z5GDR/NPjjqnq1nXj7/9j2D240JDlYUxMSsnlot
5ZgSEJWhzVWKSPBpgbhx92jPTlCK4qcFwpIcFtGw+UoTCZjK7ZN/cLDcRxl+szwj
wDkA1cGwM21N7xZ9dtHXRMUJM45ReXU+BBCN6bbzNyFh/apiYkOH/bYwy4g4ssy+
TgThWOBWOaxu8NGnegQjIcHK3eTPWVm5U3YTQm8l4ld8vvKOsk26oaUPxq7sXpjS
f7LR0ThbA9nPrT/p/mnm3K1YCgXEYA==
=HF7T
-----END PGP SIGNATURE-----

--m7xx7b55ldi3cgzf--
