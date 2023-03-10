Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F056B3768
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCJHcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCJHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:32:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B483410A4CA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:32:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paXEX-0002G3-W2; Fri, 10 Mar 2023 08:32:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paXES-0037ox-Nl; Fri, 10 Mar 2023 08:32:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paXES-003jf4-1H; Fri, 10 Mar 2023 08:32:04 +0100
Date:   Fri, 10 Mar 2023 08:32:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: Re: [PATCH v1 00/16] gpio: Use string_choices.h
Message-ID: <20230310073203.2mpd24pxe5rvm4e7@pengutronix.de>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Me-FMZ3e=EaUA1kimEonz=HVHBp7coxCz53bJK9NYBuFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vlcr3xdkx227as3g"
Content-Disposition: inline
In-Reply-To: <CAMRc=Me-FMZ3e=EaUA1kimEonz=HVHBp7coxCz53bJK9NYBuFg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vlcr3xdkx227as3g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bart, hi Andy,

On Thu, Mar 09, 2023 at 04:22:19PM +0100, Bartosz Golaszewski wrote:
> I've been thinking about this and I must say it doesn't make much
> sense to me. Not only does it NOT reduce the code size (even if we
> assume the unlikely case where we'd build all those modules that use
> the helpers) but also decreases the readability for anyone not
> familiar with the new interfaces (meaning time spent looking up the
> new function). The "%s", x ? "if" : "else" statement is concise and
> clear already, I don't see much improvement with this series. And I'm
> saying it from the position of someone who loves factoring out common
> code. :)
>=20
> I'll wait to hear what others have to say but if it were up to me, I'd
> politely say no.

Interpreting this as request to share my view: I'm having the same
doubts. While I'm not a big fan of the ?: operator, it's semantic is
more obvious here.

What I find most difficult about

	str_high_low(plr & BIT(j))

(from patch #6) is: Does this give me "high" or "low" if the argument is
zero? You could tell me, and judging from the patch I'd hope that it
would give me "low". But if I stumble over this code in two weeks I
have probably forgotten and have to look it up again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vlcr3xdkx227as3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQK3PAACgkQwfwUeK3K
7AmKrQgAi8eFePklYAe1Wkc5DrOA8FgxUuMACZnge32N4GuJ70WGZLkl0kmPTU1b
ljClqGfUibetO51uLK9T73BwZNJYXSjcEQ70XwdyiSIronRbhlzw13m6+/JdGD6y
b//gxazdUU3qw70JoLbKZwfBHea/9CPDEJdcb6OvqkrVbH6GMjg5Lsyf3SW4dfRe
Td4CSACc7My0VurOCjOPWw0Ui3gUws20Zs5/dKgZCHzjYlykGC9rS2mmn5CZP2oB
L5AriYmEQodEt6FLgbkYhp1gDE2ONqYwm64RsHUJcWcBKZahBDFuXAoGZLVjgeXo
YMvSCemK36RkwM5w3AHNzK63ETBAIA==
=s9xY
-----END PGP SIGNATURE-----

--vlcr3xdkx227as3g--
