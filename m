Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F655EC9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiI0Qs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiI0Qsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:48:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB75A808
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:47:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1odDkJ-000683-KF; Tue, 27 Sep 2022 18:47:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odDkJ-003G7n-Ie; Tue, 27 Sep 2022 18:47:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odDkH-003wFM-6t; Tue, 27 Sep 2022 18:47:45 +0200
Date:   Tue, 27 Sep 2022 18:47:42 +0200
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
Subject: Re: [RFC v4 00/10] RFC on synpsys pwm driver changes
Message-ID: <20220927164742.3ulbkcwxqpukibla@pengutronix.de>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cebenyd2jeyttlqg"
Content-Disposition: inline
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
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


--cebenyd2jeyttlqg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

there was some feedback to individual patches that require a rework. I'm
marking the whole series as "changes requested" in the expectation that
you will resend them all once you addressed the feedback.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cebenyd2jeyttlqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMzKSsACgkQwfwUeK3K
7AnCFAgAmJ4HLsrTpLjkl+OWM/r9rlcJKQiu1UZxcaBQ/DwW6jUhVvk5T1Eg8ql8
R+4D2R6scINcebshZXulqmKPAnBW6C9c/giXh4qQeissnbuFMgnc6Ia9bVkpodtU
+6XoTwGKuT68RBtPy7YKUsCMg3X4gJpU6KVeOkgSXOeZwCV793thK2kU4K8LDGx6
7INE7NsLr7jDnkY7rAbhxH5BQbgBlr9sJPmxmNdp2qourT/U3vKufvfpxTO61bSE
80TUmL0DG8Sy4xpCx11PJP9hFYU9rCk+fbJ9Ptzei2TRXrZm6+Wsipq0Dc9E9wid
/5hhjlsPqRptgwnSx9tfrdQaGdJLfA==
=9u23
-----END PGP SIGNATURE-----

--cebenyd2jeyttlqg--
