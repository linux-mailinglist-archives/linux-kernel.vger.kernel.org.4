Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6186B66F2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCLNrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCLNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:47:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2A4E5D3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:46:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbM2F-0000uj-4v; Sun, 12 Mar 2023 14:46:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbM2C-003dPR-RX; Sun, 12 Mar 2023 14:46:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbM2C-004I1i-1y; Sun, 12 Mar 2023 14:46:48 +0100
Date:   Sun, 12 Mar 2023 14:46:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: rcar: drop of_match_ptr for ID table
Message-ID: <20230312134647.kmjcbilb3puumcu6@pengutronix.de>
References: <20230311173735.263293-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ry4hqmtm567b2zyc"
Content-Disposition: inline
In-Reply-To: <20230311173735.263293-1-krzysztof.kozlowski@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ry4hqmtm567b2zyc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 06:37:34PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>=20
>   drivers/pwm/pwm-rcar.c:252:34: error: =E2=80=98rcar_pwm_of_table=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]

The commit log text sounds like a harmless optimisation, but the error
message here either means you're fixing a compile failure, or (and?) the
patch was sent out before the commit log was finalized.

Looking at it this is the error message that triggers if you compile
this driver with OF unset. I'd like to have that mentioned, then the
patch looks fine. Ditto for the 2nd patch in this series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ry4hqmtm567b2zyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQN18MACgkQwfwUeK3K
7AkCaQf/Zcv/KYxblrH3aDeQO/6BnoG2tnTCFOREJzbHJT9wbABf71+IvleN+HI0
he+ejf1n+gKyzTmrmSngNEXiSfT6Z8jZdVepJCpnVb2lt1f7Sd9EVZ1GqeLJ7jqj
bgww3ZAmOQuOhADi2MJBtlhu4x7heTawGZLxknJ++xA8Wxv7LuPrTdLE4S6gCZLd
mge7RqJdxzqs4KEj2nNR1tohpMrhketyaYuB2Qu2E9uiKEkeenTUMK5SAe9ZiHJ0
ko1w+GMD8PVZperHjC03DhyBpHB++ouHj9TBKMdacuMH0ragPGuSj/lRGYDIOS7W
gmntN00GFCOd4Ij1UIrW6dl+KdN6mQ==
=kRBA
-----END PGP SIGNATURE-----

--ry4hqmtm567b2zyc--
