Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62163C53B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiK2Qej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiK2Qei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:34:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736645DBA0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:34:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p03Yz-00042W-PT; Tue, 29 Nov 2022 17:34:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p03Yx-0017IJ-Hm; Tue, 29 Nov 2022 17:34:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p03Yx-001Gqu-NB; Tue, 29 Nov 2022 17:34:27 +0100
Date:   Tue, 29 Nov 2022 17:34:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v8 4/4] hwmon: (max6639) Add pwm support
Message-ID: <20221129163427.dxnqfay6ur6mvivu@pengutronix.de>
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
 <20221129161134.2672474-5-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o2cqtdhvh46rznt7"
Content-Disposition: inline
In-Reply-To: <20221129161134.2672474-5-Naresh.Solanki@9elements.com>
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


--o2cqtdhvh46rznt7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 05:11:34PM +0100, Naresh Solanki wrote:
> Add pwm support for max6639. Also configure pwm fan speed based on pwm
> provided in DT.

Did you do anything to resolve the questions I had in reply to v5? If
yes, I must have missed it.

Note that maintainer time is scarce and with sending new versions of a
patch with no sign that you improved in the aspects that were critized
before, you're burning that scarce time and loosing the good will of the
responsible maintainers.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o2cqtdhvh46rznt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOGNJAACgkQwfwUeK3K
7Anr6wf+LujaKKCc8Linrm35vtpuM76BeNTyq/Vjsyfg0GyXnqeYZyaUTnjLixiS
lZTjWsGvcfgVqWWfQCP5s2bT8F9RGxLwvF9Ceda4MRv/aySVCBR6aqo8PJDKPLK/
ifGHPpRaIvEBJa3lRisIsuIyGLIiYw5Z1flNZAjnsarVySycOK6LalreLcOait/x
W1Do36jTgSFCMiCdSEZnrnp9XuocxkjDEA63fU8+orcOKiJwVKgFzJf144VV+Sdl
JMZPQXcDEFUZ5bV3CyXFZgWg3x6Uqb/59Vm0ws9aC5J0D+qSPrS3wAWqu3hDMWZw
0VZcYe6mS6mzvM8PEqXL2wXW0jPLvA==
=NgQw
-----END PGP SIGNATURE-----

--o2cqtdhvh46rznt7--
