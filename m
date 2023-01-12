Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFBA668658
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjALWHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjALWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:06:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764C3D1CE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:55:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG5XV-0005Zm-5Q; Thu, 12 Jan 2023 22:55:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG5XU-005cqG-81; Thu, 12 Jan 2023 22:55:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG5XT-00CN2u-D8; Thu, 12 Jan 2023 22:55:11 +0100
Date:   Thu, 12 Jan 2023 22:55:11 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/3] soc: tegra: cbb: Drop empty platform remove function
Message-ID: <20230112215511.gjmplw4kcq55g6zy@pengutronix.de>
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
 <20221212222549.3779846-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ehjeverzqerdm3oz"
Content-Disposition: inline
In-Reply-To: <20221212222549.3779846-4-u.kleine-koenig@pengutronix.de>
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


--ehjeverzqerdm3oz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 12, 2022 at 11:25:49PM +0100, Uwe Kleine-K=F6nig wrote:
> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.

the other two patches in this series were applied individually to their
matching trees. For this one I didn't get feedback yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ehjeverzqerdm3oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPAgbwACgkQwfwUeK3K
7Amyewf9FgKfvBDPvMGtUFCt3uF8BhdWXQ3azJZiwvT/ijx2xjP82Y1l/aabxIsF
CEFUMq11W2UWFp3vf7uAbDJwupsWyF8QZPpkkOKNYFkw19Ivp2SNu32gkF6dOqxK
7xmCKWTNpaKnhSp3da6jiEkxnddjzBzaPN9Cp96JaJcGmLRZYVo5dPs9hh8G+g2M
BIXqgDfgkHuu0/GILCoJWheQkGOHWQzpCUHxFZYUQJFfYzXYfrrSwY+uYvuxFvf4
l3nV2KFsnagpSzdvanPsUNuVVSsBvJWC1u6obi88Gu7E8Tvmrv2LJJRVHWOL0g78
BajKKuOohSncE0t3MRnzsFRHs08bJw==
=SuTw
-----END PGP SIGNATURE-----

--ehjeverzqerdm3oz--
