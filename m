Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83223723926
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjFFHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjFFHiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:38:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D430711A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:38:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6RGY-000429-Kk; Tue, 06 Jun 2023 09:38:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6RGW-005SAa-EX; Tue, 06 Jun 2023 09:38:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6RGV-00BdDq-O8; Tue, 06 Jun 2023 09:38:03 +0200
Date:   Tue, 6 Jun 2023 09:38:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     thierry.reding@gmail.com, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, hkallweit1@gmail.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH] pwm: meson: compute cnt register value in proper way
Message-ID: <20230606073803.xdzc4b5ulisb4etq@pengutronix.de>
References: <20230602103211.2199283-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pob5pwp43u57lf6p"
Content-Disposition: inline
In-Reply-To: <20230602103211.2199283-1-gnstark@sberdevices.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pob5pwp43u57lf6p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a small note: This patch wasn't sent to the pwm mailing list and so
is missing in our patchwork instance. I didn't follow the discussion,
but please (and in your own interest) make sure to Cc:
linux-pwm@vger.kernel.org for the next revision (or resend if the
conclusion of the discussion is that the patch is fine).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pob5pwp43u57lf6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR+4loACgkQj4D7WH0S
/k53xwf/ZsSFSwI9yH9jFUwkiPcV8xE6bq5/9cMSntTT1UN/NyLFXpeccJ2o/KBp
2AxzYRkKpFzCeq8RwkNsC8g/PBWDpdT61u7CdEp04kUJbqQDveK5Y56P0zOrquxJ
r2fsjHLxQLP6HuOt0qeTVnAeWPRttgh5NjsDRQ0uWFSa9ZDX5O1V8un4V1cj4Thg
lGaz2Vt+8VkSl9K9HViX8/E4OFhuf/Qkqy6kDUDllmq/NMYoBQZuSWl79VSKdbow
+hbPl1215X/C/hbyKDfFzdlFpPpm7KWsbwTO6OqCjCYtvYgnf2VbHpeUXCnV2Qqj
AhoY64uXfKzHqmMk/Nv1Fs5DSh0yQw==
=WjHa
-----END PGP SIGNATURE-----

--pob5pwp43u57lf6p--
