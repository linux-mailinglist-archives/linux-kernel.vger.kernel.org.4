Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A56FA162
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjEHHrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjEHHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:47:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5CE62
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:47:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pvvan-0002lg-T8; Mon, 08 May 2023 09:47:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pvvam-001wDU-MW; Mon, 08 May 2023 09:47:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pvval-002Kt8-VO; Mon, 08 May 2023 09:47:31 +0200
Date:   Mon, 8 May 2023 09:47:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: get_maintainer broken for a few entries in MAINTAINERS
Message-ID: <20230508074731.jlzuvx6yr336xmvp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a7coq2w4czmxmb4d"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a7coq2w4czmxmb4d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

on v6.3 and v6.4-rc1 I experience:

	$ scripts/get_maintainer.pl -f drivers/gpu/drm/arm/display/komeda
	"James (Qian) Wang" <james.qian.wang@arm.com> (supporter:ARM KOMEDA DRM-KM=
S DRIVER)
	Liviu Dudau <liviu.dudau@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
	Mihail Atanassov <mihail.atanassov@arm.com> (supporter:ARM KOMEDA DRM-KMS =
DRIVER)
	Brian Starkey <brian.starkey@arm.com> (supporter:ARM MALI-DP DRM DRIVER)
	David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
	Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
	 (open list:ARM KOMEDA DRM-KMS DRIVER)
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
	linux-kernel@vger.kernel.org (open list)

The 7th entry is broken. I didn't try to debug that in the script. Doing

-L:     Mali DP Maintainers <malidp@foss.arm.com>
+L:     malidp@foss.arm.com

(twice) in MAINTAINTERS fixes the output.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--a7coq2w4czmxmb4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRYqRMACgkQj4D7WH0S
/k4Nzwf/e2tIWWq5osNUowVOK+ribh2SdoMT+bBVf3mM83eU1pwrf7mJbqf0hTuu
QmWYLKlOAHF0QQuXpRDTE4WoAwaBeMaFYS0EURQzB8v7v6gKb74GB96v/Pty7g3M
rZE7zvThPoT1YzzhYMgsS5zF8u3Ve5HNzck7CLNB9hK34Ig6L8FsmiidVQqVWatE
gmScROWawj5hQ6GcxTMMWKAA4PD0ornzA9a5porxQWHWB7Axfo/gX/IEep77Anof
++41FUxpnwBELILGOEhkYpk32xAuG6CWBKbZKJ0pMFWRJ6LARTb4gOOnalB+a0Vl
E3NA4uX/IeipwNXiBCJhTvmvuozuVA==
=KnG2
-----END PGP SIGNATURE-----

--a7coq2w4czmxmb4d--
