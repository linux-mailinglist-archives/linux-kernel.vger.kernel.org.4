Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384626B5079
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCJTAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCJTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:00:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33AEFF76
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:59:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahxm-0000tP-KT; Fri, 10 Mar 2023 19:59:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahxj-003EcA-Ny; Fri, 10 Mar 2023 19:59:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahxi-003ri8-GQ; Fri, 10 Mar 2023 19:59:30 +0100
Date:   Fri, 10 Mar 2023 19:59:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: hibvt: Explicitly set .polarity in .get_state()
Message-ID: <20230310185928.trh5iztpm3rkscqm@pengutronix.de>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
 <20230228135508.1798428-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hmth72snlkiftkqf"
Content-Disposition: inline
In-Reply-To: <20230228135508.1798428-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hmth72snlkiftkqf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[dropped yuanjian from To, as their address bounced when I submitted
this patch]

On Tue, Feb 28, 2023 at 02:55:05PM +0100, Uwe Kleine-K=F6nig wrote:
> The driver only both polarities. Complete the implementation of

s/only/supports/

> .get_state() by setting .polarity according to the configured hardware
> state.
>=20
> Fixes: d09f00810850 ("pwm: Add PWM driver for HiSilicon BVT SOCs")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hmth72snlkiftkqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLfg0ACgkQwfwUeK3K
7AlxOggAjJQPL+XmvTCDwsRTIC5E63sCSpvQvwC9Pc6H+sJYmuJO//7DdFKQxUb0
vXolTRYy0BABGrYuXpaztenwRxqgE+2wPTsmyFYSxwUn2ecqUwArqYq6GMnJ/ya8
9eFao7opLFSAzHJafUou7ys1mvvjzAamie35BFm6839pV8obl+m4atFuy8dGSLwT
gEEDn8TuvXLTZB/PRLSxRjdeDOaEyjhXlZ1iSIQ/2EJx2b2pvyLTXwmEpB/lc/vB
jtK84ukjcjBGb+KfFcbSMx4yaFfoUDsiOJBm4chE+MMFABsv7sT4Igg3468ZvwtZ
odYczfQStUqyaow1a4yckEQL+JWL6w==
=oVET
-----END PGP SIGNATURE-----

--hmth72snlkiftkqf--
