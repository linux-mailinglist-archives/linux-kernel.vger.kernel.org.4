Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB96B5004
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCJSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCJSXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:23:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF91386A4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:22:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahMt-0005Ir-Oi; Fri, 10 Mar 2023 19:21:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahMr-003EWX-GI; Fri, 10 Mar 2023 19:21:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahMq-003rZL-SN; Fri, 10 Mar 2023 19:21:24 +0100
Date:   Fri, 10 Mar 2023 19:21:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        devicetree@vger.kernel.org, jarkko.nikula@linux.intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: (subset) [PATCH v7 00/10] Designware PWM driver updates for OF
Message-ID: <20230310182123.o5inpde7bvvbzqpr@pengutronix.de>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <167664644976.3317584.11838750253013149302.b4-ty@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ul54juyfdssbpzak"
Content-Disposition: inline
In-Reply-To: <167664644976.3317584.11838750253013149302.b4-ty@gmail.com>
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


--ul54juyfdssbpzak
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 04:08:09PM +0100, Thierry Reding wrote:
> On Fri, 23 Dec 2022 15:38:10 +0000, Ben Dooks wrote:
> > An updated set of patches for the Designware PWM driver
> > split into PCI and OF versions. I think I got all the
> > review issues in this set.
> >=20
> > Sorry for the delay in getting this out, between conferences
> > and other absences there has been little time to deal with
> > this set. I will be now out of office until 3rd Jan 2023.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [01/10] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-ti=
mers-pwm2
>         commit: 0f03bf300833c05d914ab7f5ab3d8bc8564e9912
> [02/10] pwm: dwc: allow driver to be built with COMPILE_TEST
>         commit: c901a57e39db555ad7950fd61e1470cdecc8e654
> [03/10] pwm: dwc: change &pci->dev to dev in probe
>         commit: 8f3c7ab881ed7329003e10a2dd58f735abda2259
> [04/10] pwm: dwc: move memory alloc to own function
>         commit: a4218d7cf8978f397e731d1f15ef33d28f77e42b
> [05/10] pwm: dwc: use devm_pwmchip_add
>         commit: 7a77daf8223e772a225d6aa6202a5b1ae2392caf

I had some comments for patches #6 and #10. Patches #7 - #9 are still
marked as new in the PWM patchwork, but I will mark them as
changes-requested in the assumption that you'll have to rework them to
address my feedback for the other two patches anyhow.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ul54juyfdssbpzak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLdSAACgkQwfwUeK3K
7AmlCQf/ag5HM1MNCGGGZcXkTe/Ws77umzxCHqok6cf07JtNyq1IxL1L25/YIwAg
46Kq24k59OmkprRS2S9h/tcwm7+5XwnX/PI921kBIer7XSSqG1lOQRu1k+J29us2
nog8snXGnycefWxy5aHRsrRiM+TgJdRJ0aA9sGA13WdOmtpHYxfjLpqEu5X/Ka6F
ipHb+Wg1CwF84rP4hO5CIumX8m2VDlvGPhrSrqJnPJ8qy/bhBKI/2aWuJzwSz0CJ
2ISORXY/lGcGB/fkLYmob5Lswpc32EYMniwaC1d+XfYiqrXgyXIqkOtymKz84rnM
zRTMdAqDQqH5IKU3xw5HBd4T4VBCxA==
=c1R2
-----END PGP SIGNATURE-----

--ul54juyfdssbpzak--
