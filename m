Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B2620FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiKHL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiKHL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:59:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC51209D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:59:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1osNGB-0005Z5-PF; Tue, 08 Nov 2022 12:59:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osNG8-0032oU-5I; Tue, 08 Nov 2022 12:59:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osNG8-00FAop-B0; Tue, 08 Nov 2022 12:59:16 +0100
Date:   Tue, 8 Nov 2022 12:59:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Erwan LE RAY <erwan.leray@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] STM32 configure UART nodes for DMA
Message-ID: <20221108115916.hlmbvyrnmkxymeed@pengutronix.de>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
 <cc7633c5-de5f-0abf-4ac8-64a74633dfcc@pengutronix.de>
 <f5aec360-c33c-0145-6596-541003e305b2@foss.st.com>
 <98823363-710c-6286-8e63-ba8e5dcadeba@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c7xl74gxbk272rwu"
Content-Disposition: inline
In-Reply-To: <98823363-710c-6286-8e63-ba8e5dcadeba@foss.st.com>
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


--c7xl74gxbk272rwu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2022 at 04:41:55PM +0100, Erwan LE RAY wrote:
> On 2/4/22 2:22 PM, Alexandre TORGUE wrote:
> > Hi Ahmad
> >=20
> > On 2/3/22 18:25, Ahmad Fatoum wrote:
> > > Hello Erwan,
> > >=20
> > > On 03.02.22 18:10, Erwan Le Ray wrote:
> > > > Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
> > > > remove it at board level to keep current PIO behavior when needed.
> > > > For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
> > > > (no HW flow control pin available) are kept in PIO mode, while USAR=
T3
> > > > is now configured in DMA mode.
> > > > UART4 (console UART) has to be kept in irq mode, as DMA support for
> > > > console has been removed from the driver by commit e359b4411c28
> > > > ("serial: stm32: fix threaded interrupt handling").
> > >=20
> > > Do I understand correctly that your first patch breaks consoles of
> > > most/all boards, because they will briefly use DMA, which is refused
> > > by the stm32-usart driver and then you add a patch for each board
> > > to fix that breakage?
> >=20
> > We have two solutions and both have pro/drawbacks. The first one (Erwan
> > ones, can break the boot if the patch is taken "alone". Your proposition
> > avoids this breakage but deletes a non define property (which is a bit
> > weird). However I prefer to keep a functional behavior, and keep Ahmad
> > proposition. Ahmad, just one question, dt-bindings check doesn't
> > complain about it ?
> >=20
> > Cheers
> > Alex
> >=20
> > >=20
> > > Such intermittent breakage makes bisection a hassle. /delete-property/
> > > is a no-op when the property doesn't exist, so you could move the fir=
st
> > > patch to the very end to avoid intermittent breakage.
> > >=20
> > > I also think that the driver's behavior is a bit harsh. I think it wo=
uld
> > > be better for the UART driver to print a warning and fall back to
> > > PIO for console instead of outright refusing and rendering the system
> > > silent. That's not mutually exclusive with your patch series here,
> > > of course.
> > >=20
> > > Cheers,
> > > Ahmad
> > >=20
>=20
> The driver implementation will consider the request to probe the UART
> console in DMA mode as an error (-ENODEV), and will fallback this UART pr=
obe
> in irq mode.

> Whatever the patch ordering, the boot will never be broken. The board dt
> patches aim to get a "proper" implementation, but from functional
> perspective the driver will manage a request to probe an UART console in =
DMA
> mode as an error and fall it back in irq mode.

I didn't debug this further yet, but my machine (with an out-of-tree
dts) fails to boot 6.1-rc4 without removing the dma properties from the
console UART. This is a bug isn't it? The same dts created a working
setup with stm32mp157.dtsi from 5.15 + kernel 5.15.

I can debug this further, but maybe you know off-hand what the problem
is?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c7xl74gxbk272rwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNqRJEACgkQwfwUeK3K
7AlviAf/aWq+f5jZ43D9mr3TUb0MZkP1KLvPgtrpBfPs15Bp8S74wsXD2uMZcX82
CtouQO0Y39ByPVDx1rWTJt5PUIGObQsAuQe9J9jVj2dKecRqa5amu8OueqZX0rMs
VrLueFarS1+Jj95JwpTXaDMWmD7u7Mzh643Xr1aIQ2RPajOkMtaeGuSwqAHhGPTw
Du5FdhPlIPpetKNn3L+TLHJ3sXWHyQa/BL/wqHjvg575tSiLFLCXGjnYNs9Wqk4h
BJcHXwFi0hkE37vCKHT6chnyRwF93xR7ZWCJI49KenTK7AC0tSqVZHdFFFD/wV1m
/g8RuN7EB/xJFEYSrPbtnhILSKTC/Q==
=yKut
-----END PGP SIGNATURE-----

--c7xl74gxbk272rwu--
