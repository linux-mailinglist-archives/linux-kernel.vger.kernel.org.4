Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A53D65C661
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjACSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjACSjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:39:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2C910545
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:39:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCmBr-0008Go-Py; Tue, 03 Jan 2023 19:39:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCmBq-003cXe-HH; Tue, 03 Jan 2023 19:39:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCmBp-009zIB-QZ; Tue, 03 Jan 2023 19:39:09 +0100
Date:   Tue, 3 Jan 2023 19:39:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de, Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Joel Stanley <joel@jms.id.au>, Vlastimil Babka <vbabka@suse.cz>
Subject: linux-next: Tree for Jan 03
Message-ID: <20230103183909.dfhjtwsxaedfe3p4@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="736ld4u5xamjy6hy"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--736ld4u5xamjy6hy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

after Vlastimil's report in reply to my next tree from 2022-12-26 I was
curious where the problem was. (My best guess so far is PEBKAC. (i.e. my
keyboard and my chair) So I slightly improved my script and created a
tree for today.

Only the following two conflicts happend:

 - In arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts between

        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ma=
ster
        62d127eeac27 ("ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add=
 GPIO line names")

   and

        https://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc for-next
        220a041d4cca ("ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add=
 GPIO line names")

   which is a problem because both commits are the same but not
   identical and the second tree has some more commits touching the
   file. (This one already happend for next-20221226.)

 - In drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
   and drivers/thermal/intel/x86_pkg_temp_thermal.c between

   	git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-=
next
	58374a3970a0 thermal/x86_pkg_temp_thermal: Add support for handling dynami=
c tjmax
	983eb370cb87 thermal/x86_pkg_temp_thermal: Use Intel TCC library
	d91a4714e54e thermal/int340x/processor_thermal: Use Intel TCC library

   and

	git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/li=
nux-next
	03b2e86a24aa thermal/drivers/intel: Use generic thermal_zone_get_trip() fu=
nction
	e503a68ebfe3 thermal/intel/int340x: Replace parameter to simplify

   I looked at the conflict only shortly and failed to find the right
   resolution. So I skipped merging the thermal tree.

The conflicts in mm/ are gone, so still don't know why I failed there
last year.

The resulting tree is available from

	https://git.pengutronix.de/git/ukl/linux tags/next-20230103

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--736ld4u5xamjy6hy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO0dkoACgkQwfwUeK3K
7AkpJwf/SMdoC3aToEq5StkXne2EGM04qboXabHGMy/2ktjRW6TRNafbohaD+zUv
AKpKNX17+ox/ajgknkPanc7SxXfCiAdVZplTl53598Woae6ZOkxwfy/TUpZyAeZP
wc4KTxcWUjcqNyZeOTpbX2C3AphgbSO37oi5mnGmhsJmtkcia48LEi7hQ2Mbmc+a
FA0LjOmMN+AMgyVqqb5DEi5xlQxuihqYUkWab1MR0SH+ysjjYGCXwXVldIsY4dhw
er0BwVJlMohhy5++OI8jiEtFySVN2q8IBbnYcn9ADZWAIs7ylaOme0mE2Ephrxtj
eJmGusV3Ytls1hwb4osBf9FMVq0s1g==
=FiyP
-----END PGP SIGNATURE-----

--736ld4u5xamjy6hy--
