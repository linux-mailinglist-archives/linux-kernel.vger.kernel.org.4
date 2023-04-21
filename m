Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66AF6EA6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDUJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjDUJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:25:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043418E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:25:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ppn0h-0002lD-EN; Fri, 21 Apr 2023 11:24:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ppn0d-00ClWe-U6; Fri, 21 Apr 2023 11:24:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ppn0d-00F2bw-70; Fri, 21 Apr 2023 11:24:51 +0200
Date:   Fri, 21 Apr 2023 11:24:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     kernel@pengutronix.de, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: Reset TIM_TISEL and TIM_SMCR
 to their default value
Message-ID: <20230421092451.gzhvwrlyu5v6zdzc@pengutronix.de>
References: <20230412153709.3557323-1-u.kleine-koenig@pengutronix.de>
 <20230420110111.GM9904@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bjnsfkotsoxo2uty"
Content-Disposition: inline
In-Reply-To: <20230420110111.GM9904@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bjnsfkotsoxo2uty
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Thu, Apr 20, 2023 at 12:01:11PM +0100, Lee Jones wrote:
> On Wed, 12 Apr 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > The driver assumes that the input selection register (TIM_TISEL) is at
> > its reset default value. Usually this is the case, but the bootloader
> > might have modified it. Also reset the SMCR register while at it.
> >=20
> > This bases on the effectively same patch submitted by Olivier Moysan for
> > pwm-stm32.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > note that the patch by Olivier Moysan[1] for pwm-stm32 is expected to
> > appear in Thierry's tree soon. It added the definition of TIM_TISEL in
> > the same way, so the two patches should merge just fine. Alternatively
> > you can commit it to a tree that already has the pwm change (and then
> > drop the change to include/linux/mfd/stm32-timers.h from this one).
> >=20
> > Best regards
> > Uwe
> >=20
> > [1] https://lore.kernel.org/linux-pwm/20221213102707.1096345-1-olivier.=
moysan@foss.st.com
> >=20
> >  drivers/counter/stm32-timer-cnt.c | 4 ++++
>=20
> >  include/linux/mfd/stm32-timers.h  | 1 +
>=20
> Acked-by: Lee Jones <lee@kernel.org>

Note there is a v2 at
https://lore.kernel.org/r/20230413212339.3611722-1-u.kleine-koenig@pengutro=
nix.de,
William wrote that he already applied it, so replying with tag in that
thread might be already to late, too.

(nevertheless) Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bjnsfkotsoxo2uty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRCVmIACgkQj4D7WH0S
/k50mQgAk2DRzoWOq3MEG9fmK8vd1LitFammB41nT+Dh8r2Q9oPfxPY2/I4p3GFJ
uO48jePuSswpv3FPeMeVh2eQ+TatlVv0JcTJBq0wBm8SYeX1Nn7muR01ok+HJoa6
v5XJWY49Ok0VBMH53ZIQwawhWmGEQLAWpCUXyysF6+ELz5BvFz3KcRX48KoymejU
Rrvowztodb9mPaK13tvh8q6kPaeOGco+19iQlwDkxrcEL++S1zMv027SK4EQXv8A
0CcvuGE8WixEBiMlLO+F9oq+Nj1UxjUh/90l+R9VK9X/u5ntdLYL2XuG/5af/ZQy
dfXjWeU0mp27O9kpeAb5qY0Y3ST2ZQ==
=w174
-----END PGP SIGNATURE-----

--bjnsfkotsoxo2uty--
