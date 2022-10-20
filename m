Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3864A606523
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJTP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJTPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:55:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E050187DEF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:55:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXtf-0008CZ-L2; Thu, 20 Oct 2022 17:55:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXtc-000Lfh-FH; Thu, 20 Oct 2022 17:55:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXtd-009MPT-SP; Thu, 20 Oct 2022 17:55:49 +0200
Date:   Thu, 20 Oct 2022 17:55:49 +0200
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
Subject: Re: [PATCH v6 05/10] pwm: dwc: use devm_pwmchip_add
Message-ID: <20221020155549.brikj6hxvrfub7ww@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-6-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="254k6qamuyagu5zv"
Content-Disposition: inline
In-Reply-To: <20221020151610.59443-6-ben.dooks@sifive.com>
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


--254k6qamuyagu5zv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 04:16:05PM +0100, Ben Dooks wrote:
> Use devm_pwmchip_add() to add the pwm chip to avoid having to manually
> remove it (useful for the next patch which adds the platform-device
> support).
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--254k6qamuyagu5zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNRb4IACgkQwfwUeK3K
7Annwwf/aZ6FhiKUzpFEinL0TqzCycO4iSWP/J8gEEp4Sr5vJpfxfo/Utp3iw2Yx
UhR8MHXeZF+oCPLfLzhP8wRufKHbTPkWU8exp88HHhEZedwni4Lj9toO11OqbiJg
KuzY+kW3ZCTtJSiKDPbs/Bu8N/aMUgaScWRtQw5Bnxvn0T69qNTEvytLNjjULIAX
Zr4G9ycY4bnP3aandfnc9kasvGOJGrUh//Vt5njPQqNZR+NDI7axNL7f2xpSKFgM
nWONBWFakNWpSnlR8wmOBOGVB607ycmx9u8hDCyVvf+gZKcjhYNxDk6vRyqXGs7X
wlsHmk8NskBDaiVfHs1Wsdxr4D593A==
=NrE0
-----END PGP SIGNATURE-----

--254k6qamuyagu5zv--
