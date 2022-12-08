Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0298D6475AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLHSgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLHSgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:36:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA2BE1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1670524570; bh=ArOKgVB2dEMsvvQv2MSw6kaArsHw6nVYY30UErZ/gVQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Tqaec27XhTxt5jki6hIn4Vwbih5daALP/AOGZBLn0XQy9Kwsm7bme5sAbWVccADs0
         8HXItdNwAKvMw1G2/srGuzPyxRWsGnKV8VG4zo4UJ9PNgaOixj20F/bKXdGn9htqT0
         FEPTRYFoH56NqkoRsc8b7O6DFNLNGwr/T/o4gk9dWXyFClppAbvD5v/EMAGoqezJ4W
         BCp2Qjv8Qj78MB4d7LqjlcySY+vd/sKHz7XuLhiUKHVXUO/NYjdXBmZ9lFVacZaQyZ
         TftcgjX7xqMFpBeeH0FgIGPVbHIeU6IrepyHx4Yjm/YC7VqX6UlkT8BBpcX3LhC9Sb
         cK2FkUFwiGx/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63VY-1osWyA2JeC-016SqM; Thu, 08
 Dec 2022 19:36:10 +0100
Date:   Thu, 8 Dec 2022 19:36:04 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5IulKoRctcrWBzl@probook>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
 <Y5DDCmXnamC6Zikx@probook>
 <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rc/mWC0E3+AOr2MX"
Content-Disposition: inline
In-Reply-To: <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk>
X-Provags-ID: V03:K1:XDwb+F6BLWnqqpTS+GM/JLMzpIFPPyPZWLFjHy6b9uK2DWgHdCy
 ZyNOlUWKlt367QEHYfOwMGuMwOQcb99XUUQGLOqIL3JdUsvvGi4EbZJuLWyee5VrzGv/dqS
 AyJsaNPMciT373dmGpvoXYfat9mP3y5LUgeTjWM9MvAXCx1HPu12GFDpjuMzTgUjIX8ahlH
 KBe2IThWsXrVkhB9z0e4w==
UI-OutboundReport: notjunk:1;M01:P0:cbYmOp7ZiqE=;lw4M7yo4Pj3NBk/nY/2eEMc/LM6
 rSe4mFIYzQW5LyW03vj6HqpLGHblh7ouZn1b4uCpyEJrR69yyppl2/3Gb+R2ztjhzW4lD+6by
 Q7mBO5tRMBjuP3A/RHJWyKrBXq1fvsVJIDO+3MIBO8Vw4Yhry2EnNxDHTQ8bE9ZqsJzPOW/Wj
 Zv9K4UynPINkjV15f3O3Pb+sZoGzTL9YmLm6kMafjaC2AnaVKFFfiVuk5gz78Eed9n0MBPqNq
 jT2jp84PnuxBQ/8QY++IZHL1c3TD826Q3XT6rb6nO1yoO/DBY6P3JSzGf7je3DZLndSAD/cda
 1P42d9hUKOGJM1gPJWk2aTsxfp65sOj07kyYwGMuGQTNZiqxRHEyfWCnp5I57G4kajy3wyy2S
 z37R2DUs7Xkss2uK3Izczh6XN8CfAAU8F7dQZxFowAh2TsNM9xMPXAAn1GlPFL+AtBcwxSDXk
 aQn1nvO0cDUMQgjzhENS34g+CEcnDk0JwO60eZtDASO9KAjab5zzCzHO6r95ZqCzQLVQwNyKZ
 emdSAtgH/WmVKq6+ba3pWjrH3Xo4SMAtaHX8kYz4LpAsoPDOaktKsK+f/13Q5vTumV5SpD9/k
 dVs+h3q2N/b3ymcIRoUa95BtbDA21iFfrJ/RLs/+vs8gqY01LvKE3uZT8f7UE/O91YJasyVQA
 aaJjzM866LTpINcxGQo7Sutr08mwttoReMMfwyqo97uXed4ZYGpE3b4W38RimA9UoEP3jYkUz
 hhqz/BNCM0J/P7pCBdtd1yoPoX697qMtNlbW9lXZ2bantao7yg97oICY4GPLev/0RlVf9jPLM
 Y9Pnl7sTBzVxGZES5lIxOlv2Aqrt6GxsCChrgA1je56Aicgs0ux0gWttCJzNoLgiWBSBO7fxT
 T6WPoa+P0GpA0bZ3URBPLWH1q6LPB4603Xax1T2EM6o4me730Yj3Bz38DEjQl3nBikOMtOn+f
 hDGSXQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rc/mWC0E3+AOr2MX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 06:27:52PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 07, 2022 at 05:44:58PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > On Wed, Dec 07, 2022 at 03:41:11PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Dec 07, 2022 at 04:28:07PM +0100, Andrew Lunn wrote:
> > [...]
> > > > How are the registers arranged?
> > >=20
> > > As documented in drivers/gpio/gpio-pxa.c - it'll be easier for you to
> > > look there rather than for me to explain it - but suffice it to say
> > > that the pinctrl registers are amongst the GPIO registers.
> > >=20
> > > > Is 0x40e00000-0x40e0ffff simply too
> > > > large, and making it smaller would fix the issue? Or are the regist=
ers
> > > > interleaved?
> > >=20
> > > They're interleaved. Looking at the .dtsi file for PXA25x, it seems
> > > that the pinctrl claims just the addresses that it needs, but the GPIO
> > > controller has no reg property in the .dtsi, so I'm not sure what fil=
ls
> > > that information in.
> >=20
> > The GPIO reg property is in pxa2xx.dtsi.
>=20
> Looks to me like pxa25x should override the reg property with a smaller
> range (0x54) and  pxa27x probably should have used a second set of
> entries in reg the subsequent group of 3 gpio blocks at offset 0x100.

Without further code changes this wouldn't be sufficient, because the
pinctrl driver also touches the GPIO direction registers at offset
0x0c-0x14.


Jonathan

--Rc/mWC0E3+AOr2MX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOSLnIACgkQCDBEmo7z
X9sDcw/+NOGItwyuFjYli1yeq2yxp94FYbLj2r8Y8GQKQBAecd8TVbVKGS0S/FFI
o7udq8vqtWuPzomlglonHSvRNLW2RS39IjsPnSsWz6bb6SvGSi6jfeeEJuyCA+yV
foifZI1H7crTIRyGaDpYFsZSfh3JIhLMxmLPf+AYctvFDuldqlY0XHfLPWqKZhuI
Cs6Qq8XPL4IoNDKdfZpRGMA6AkEljogUqkOl6d7L/CR4aA6hb69lvwGIfPz4/psc
hQjbzFPx40iJ5fCqUz7TUhwtS3latC9v3XRRuuIKjJmS6fgbn3ftWaTwKFspgRQZ
Oy5SjDPuT2gIZs6Z6uZAi3v3q+wfGpsFE2sw9FUGUqMbikMQ7KR5ExOIiIxiJte3
2pAJ5ea/G4CbX1oi/o+wEpRfrd/memiyymbgKAyLhLnJAHRlG65rf8UbFSxeTZ8p
mT0MyGzUMwtuQTgeHxR2UP+N8FO8+ivfq+KVHfgIg3+7eKF2cFKIJLCPNHFegKDg
JlhbsPlPs+K76iljbOu/iGzNm5fgIUWhi9Q1XZzRPdBDrliCJekEXAMPsKk24WRb
c4FdDNOmnSB9v5hWNmyWytYq1m+SehufCejfNRMwK79T85kFXp6gTqa+cSlSb7Hd
kJIGYtAIlWhjVZv01h06N4pGIxBhXo4rG+Yym8u7ItBBSPNj6po=
=BF1n
-----END PGP SIGNATURE-----

--Rc/mWC0E3+AOr2MX--
