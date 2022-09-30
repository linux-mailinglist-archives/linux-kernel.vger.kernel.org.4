Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2915F0D09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiI3OGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiI3OGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:06:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A521169E54
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:06:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGet-00019Q-Is; Fri, 30 Sep 2022 16:06:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGet-003oRz-T3; Fri, 30 Sep 2022 16:06:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGer-004gaS-Mc; Fri, 30 Sep 2022 16:06:29 +0200
Date:   Fri, 30 Sep 2022 16:06:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220930140629.nwdode4j2nwdsqay@pengutronix.de>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
 <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
 <Yyh8v+MtHuc0LLf0@wendy>
 <20220930091316.kdkf4oeu6uvxzqa6@pengutronix.de>
 <Yza61MO9hbuFytmM@wendy>
 <20220930133933.br5kanbh3clvahvr@pengutronix.de>
 <Yzbz2N28RJ8Yyg2v@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kgnvrla44hq55m67"
Content-Disposition: inline
In-Reply-To: <Yzbz2N28RJ8Yyg2v@wendy>
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


--kgnvrla44hq55m67
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 02:49:12PM +0100, Conor Dooley wrote:
> Would you rather I waited until after the mw to send v11?

I don't see much sense in waiting.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kgnvrla44hq55m67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM29+IACgkQwfwUeK3K
7AkptAf/d9crouuQX84NiO5X1kjB0WdSbZ+NO8rvlPLh91ySVJz9eNKGFC6SPB2w
L6NV1P1zvZQ2By+1H0EstkcZ1nd+uQK1IlyoYPS0ra6TYUltqPS4cHremYkh3eHo
GUeGfzhvi6lcVdYbNIrhCkvYFacuZAg+M8XkXVl3ewLL8kk6jKleHMlOEio+A+C4
SG75tQQ/3hzEVZk+UXx//Dbid+zmg+e4FckUC1vKha66RU/lZToogjmvMYxN2eO7
qNKYI4EjTyRIvsbbWf/j7Zxmm7p++m3Uh/GZarUxObOKg9VK3qskHm/X/X5jv1ey
OszmsaZZlKNZezj2iEqSXBdpMgrt2w==
=OKFN
-----END PGP SIGNATURE-----

--kgnvrla44hq55m67--
