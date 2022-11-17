Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076562E14B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiKQQPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiKQQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:15:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC1374CC1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:15:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovhXe-0004Y6-FI; Thu, 17 Nov 2022 17:15:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovhXb-004t36-GO; Thu, 17 Nov 2022 17:15:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovhXb-00HKGL-JH; Thu, 17 Nov 2022 17:15:03 +0100
Date:   Thu, 17 Nov 2022 17:15:03 +0100
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
Subject: Re: [PATCH v6 06/10] pwm: dwc: split pci out of core driver
Message-ID: <20221117161503.djk625nosikng2z4@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-7-ben.dooks@sifive.com>
 <20221110152927.olg3oqcnqvskbsli@pengutronix.de>
 <75853d42-faf4-b406-f54e-71871143d61a@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="guobxdbblkuxk6xw"
Content-Disposition: inline
In-Reply-To: <75853d42-faf4-b406-f54e-71871143d61a@sifive.com>
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


--guobxdbblkuxk6xw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 10, 2022 at 04:35:56PM +0000, Ben Dooks wrote:
> On 10/11/2022 15:29, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 20, 2022 at 04:16:06PM +0100, Ben Dooks wrote:
> > > Moving towards adding non-pci support for the driver, move the pci
> > > parts out of the core into their own module. This is partly due to
> > > the module_driver() code only being allowed once in a module and also
> > > to avoid a number of #ifdef if we build a single file in a system
> > > without pci support.
> > >=20
> > > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> > > ---
> > > v6:
> > >   - put DWC_PERIOD_NS back to avoid bisect issues
> > > v4:
> > >   - removed DWC_PERIOD_NS as not needed
> > > ---
> > >   drivers/pwm/Kconfig       |  14 +++-
> > >   drivers/pwm/Makefile      |   1 +
> > >   drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
> > >   drivers/pwm/pwm-dwc.c     | 158 +----------------------------------=
---
> > >   drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
> > >   5 files changed, 207 insertions(+), 157 deletions(-)
> > >   create mode 100644 drivers/pwm/pwm-dwc-pci.c
> > >   create mode 100644 drivers/pwm/pwm-dwc.h
> > >=20
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 3f3c53af4a56..a9f1c554db2b 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -175,15 +175,23 @@ config PWM_CROS_EC
> > >   	  Controller.
> > >   config PWM_DWC
> > > -	tristate "DesignWare PWM Controller"
> > > -	depends on PCI || COMPILE_TEST
> > > +	tristate "DesignWare PWM Controller core"
> > >   	depends on HAS_IOMEM
> > >   	help
> > > -	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> > > +	  PWM driver for Synopsys DWC PWM Controller.
> >=20
> > Currently pwm-dwc doesn't contain a driver but is only a library used by
> > pwm-dwc-pci (and later the of driver). As such it doesn't make sense to
> > be user-selectible, does it?
>=20
> I suppose the PWM_DWC should select the original driver an a new
> PWM_DW_CORE should build the actual core driver.

Sounds about right.

I will discard the complete v6 series from the PWM patchwork in the
expectation that you will send a new round with all patches.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--guobxdbblkuxk6xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2XgQACgkQwfwUeK3K
7AkeUAgAmgfdnMpPhA/hTFZHUUp/Ol9rRIHyo+JKbF8r42g5/gpJ0B0KMYj6wLZn
FvF3IccAGIfMqZ7QOi3w2stY5v1k9rdrsT5fcwnw5sU3RTLmXp1ez9zgEFA1HREQ
HGHf9veJaFwEmlm9Kb5dXxb82Waq6e8yuf2fReyN3ECxLlYm++0/GGeAVs/Zwpjr
4x+V5/joJUu0WTae3DuriTS2dfwOqSEQFRdiQAZwZghbRd4yLBnSPnFp3djcw0rl
o8LsTe9sELxdP6I9doowh7bLWAoO+mgP8vfG0CUx9PpotL9ddqkX8McVzFL2y0Ba
m1kQD/7LCvenQ8RD9tNY/aZE9Ik+sQ==
=J/rz
-----END PGP SIGNATURE-----

--guobxdbblkuxk6xw--
