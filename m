Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920A36C584E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjCVU7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCVU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:59:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10FCDCA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:59:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf5YW-0005rt-9F; Wed, 22 Mar 2023 21:59:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf5YU-005zzw-Eb; Wed, 22 Mar 2023 21:59:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf5YT-0078Fw-PF; Wed, 22 Mar 2023 21:59:33 +0100
Date:   Wed, 22 Mar 2023 21:59:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] pwm: rcar: drop of_match_ptr for ID table
Message-ID: <20230322205933.saslubwinqm47esk@pengutronix.de>
References: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
 <20230312154210.ovm54x2qtcv7fp7r@pengutronix.de>
 <74309bed-e46c-69fc-e0c7-6d06c30fbc4f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="676sr5ayrq6huzkl"
Content-Disposition: inline
In-Reply-To: <74309bed-e46c-69fc-e0c7-6d06c30fbc4f@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--676sr5ayrq6huzkl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Wed, Mar 22, 2023 at 07:12:08PM +0100, Krzysztof Kozlowski wrote:
> On 12/03/2023 16:42, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Sun, Mar 12, 2023 at 02:51:19PM +0100, Krzysztof Kozlowski wrote:
> >> The driver can match only via the DT table so the table should be alwa=
ys
> >> used and the of_match_ptr does not have any sense (this also allows AC=
PI
> >> matching via PRP0001, even though it might not be relevant here).  This
> >> also fixes !CONFIG_OF error:
> >>
> >>   drivers/pwm/pwm-rcar.c:252:34: error: =E2=80=98rcar_pwm_of_table=E2=
=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > Hmm, I wonder what else is required here to trigger that warning. On
> > amd64 I also disabled CONFIG_MODULES as otherwise rcar_pwm_of_table is
> > used by
> >=20
> > 	MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
>=20
> 1. x86_64 allyesconfig, remove CONFIG_OF
> 2. Build with W=3D1 (this was GCC)

Ah right, it's not that CONFIG_MODULES must be unset, but the driver
must not be configured as module. So I suggest

	This also fixes the compiler warning

		drivers/pwm/pwm-rcar.c:252:34: error: =E2=80=98rcar_pwm_of_table=E2=80=99=
 defined but not used [-Werror=3Dunused-const-variable=3D]

	for builds with CONFIG_OF=3Dn, CONFIG_PWM_RCAR=3Dy and W=3D1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--676sr5ayrq6huzkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQbbDQACgkQj4D7WH0S
/k5vkwf/VfSDx0uwwyfdw08DuNrDF4Mi8n9gNP3Wdjlk+PBoIRLFRO1DpA/O4Wu0
OEocITy3TYc8o5gYSM6SjZ239My3Is0zgB2pZyXXkCD5hpP/RMEVv5k4L60wfjj8
Ay0KI8qFx8CwNTWLq/ipFUMAvoXA44z9MfsU9sGITN3rVdvMyPlMI6V5ESndSuzV
x5t+ZmkxTMoh3zZFQZjBUymmwbRHTtno8bccgJNB0fcmQA5gRiXsBcjCvJZQJg9E
E6ocyw3Jd/rtEtdc/Url44Y05hvpNNST+MRKlq+8le633fRHFl8a4osdNbPCxceF
5QtGpfDt4ihJm/SeCWwjJuJSHvKFQw==
=mK6h
-----END PGP SIGNATURE-----

--676sr5ayrq6huzkl--
