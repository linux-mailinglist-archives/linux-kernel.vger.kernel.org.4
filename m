Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D263D345
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiK3K0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiK3K0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:26:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040838A6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:26:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p0KI6-0001nn-E9; Wed, 30 Nov 2022 11:26:10 +0100
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:38ad:958d:3def:4382])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A547612DD26;
        Wed, 30 Nov 2022 10:26:09 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:26:09 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH] can: ctucanfd: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221130102609.dqycpv7lo7r5j2xx@pengutronix.de>
References: <20221124141604.4265225f@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pgd73saj4j7iljey"
Content-Disposition: inline
In-Reply-To: <20221124141604.4265225f@endymion.delvare>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--pgd73saj4j7iljey
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.11.2022 14:16:04, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
>=20
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: Ondrej Ille <ondrej.ille@gmail.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pgd73saj4j7iljey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOHL74ACgkQrX5LkNig
011OpQf/eIn7tSHmyVNCFKoH9IoQecv3Sd1tN1dtSLuTW4LGsBEmVEa4CN4c5mvb
zzGUZVFd/SMOGxriNCgOgYe/lT+DoRbQ0JNo6BKv3hBS/hz810Tjp2AnZyjLzAbF
YUSYjd6+JXn5ZtFQJW0RdsXLkivwE2+hpXq+cXl01Pv39H4hnMAg9j0ZobA39Dqd
Ua+a5dno1HrrfThnQKVskvOgbZF4Zx2vNhia4fMAl9qQQitIUbth0FdxTTgal3RA
halKppDRPeunAjtpLf8X/lEMCf05vKez9Mg8a5xhcR91xvu6cr1LFPR+puI4rSUE
p4ZIuPFKYgyK3wlN3WSecXyRWXffUA==
=x0ce
-----END PGP SIGNATURE-----

--pgd73saj4j7iljey--
