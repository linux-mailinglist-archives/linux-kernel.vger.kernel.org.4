Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283EB645F31
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLGQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLGQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:45:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937D25E3C2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1670431500; bh=UycZekzkSjqnF2N5+loQlLUpBO/scCgp/bD64AOybyw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BhhUIxINl8Jin6/mwCEUM7+dbZN6yi2VAO45J06SPoSCB9MDlINUrh83Isd5+InfZ
         aqNRg3rmXuoQv7Ex16e95I/AgndaqxuDuzpHHpgTNY59mW0ckAHld8ABNGZKCZHPNy
         0JWUBqUJoLFos45S2jD9wHJP3bfxAp7wKxbQ/HEC7WikZ+ZUJJS3Z0IZRK2OZjP9/u
         aZdzxtZwDMNWKJlnbaP++K1kytAffpq+1j0A3So6V6GF2rO2V/xlWdrt5z+MqgJunt
         +vmHhJ/EYRxL1us8B/4Nno3Bb3EBaQkVnFIIubQSUWiNG9X9Q8tGd3r34+4hjG+eKp
         uEwZdq2OAwYMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1pUhZZ2M8j-00RmKU; Wed, 07
 Dec 2022 17:45:00 +0100
Date:   Wed, 7 Dec 2022 17:44:58 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5DDCmXnamC6Zikx@probook>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9eeF8hcRYDtZ6Gsw"
Content-Disposition: inline
In-Reply-To: <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
X-Provags-ID: V03:K1:Qyv1+6D31pbICyUtF8wJztcfBXIPqJfe5tRyNZfKUhTGLW7WYST
 Uso18McbxZmJrI3w+NBRAg49NmEMFua1O04lTfSlb6wQ8aWRKrqmqL2bZbX7B+1dUT/6rNS
 ZCpacMs4BMsDMAbCDw+UuukBNPDSyUCnjiAXwNFr5GaLgTbnYCeuY8vh20EA5vqrW5KRjsr
 KOG8mKIipL2Hg0yn5PkTw==
UI-OutboundReport: notjunk:1;M01:P0:rRQQ3ODs+YY=;a8Hh2vyzQ7USdBEBAUMStghykh5
 9texXMvOcDkCu8solosQbttnpoMTVgI4ykoA2eluNlEt4CtAnzDTvDuFDK/zcyhUg9QcoU4tZ
 5orj/JWK/qakSIVDTqhJbjydXtUQOVx78tf49Cs031SFgTELIkRGgt4aoI1uw4PUbHZSZJRNJ
 ATOxDwn0f/VxtNeWK2LTN8u7++JPI4c1lx+gOALCiGlCqR1WF15IAlBIAmWMAWsLVtowvl4Rl
 EjjFfx/PLI1mMlGsF66X5HzUfINLTmq/P2hZIjm/nHa3/0nw/3u6qzVZuX8jIJrP1+OO8gSLf
 9ZtYLxfYP3395rWSq0w8j1g9dOq8Ghv3jnPhvZ6y75i+lJszTxN8ccdGRt5FhBAVa+ilMuZPN
 U7qaqhLm7RrmW/GKOyq/T4HVwie2Jun77TsEgHhlMe+WBHinyjwpUdtFNc7xKo1aGNwkPtQ1w
 26ysLkTmyeaObEPHQeZaZdH7YwcLi+zN5acwT2bJT8WvIiW7YrTpUrIjF+wTlWjJQ4P/Q9fN/
 M+kL/0WM0H9ukg0iPQ1wQrEg1B/meT04jyrfPU69cBCCpyVlfqd9Snm1nOEN5UysHe+GkoI4V
 w3YE2Ck7h9ZGOm2Vx3qlTR8jUDH4Q0xFEA7P00e/r0MQ4ia+A4AH2SHFi3+wTwQO0Y4C2DS1R
 1wq4myLmA3tHo9bMXZYcv3jqYR240XBMI1oEwpyvG75huGi82z0OgZ8Bo7R9gbj7wvWQ77GsY
 vw5vPHOL5NoU3mZchaa5d1IYpIBE4tVji7v+hnGKR8kga4eEfgAnD5oRbqKngPLKxBRaIi8Py
 W602uN+0Sxo1l1WI2vnCq6GeurGQw92UVMTnk1uFrEuQgKbDCg99w3/oYnJ3ORQg6Bv+S1sQ+
 RjDAQ9DROz6UYIDawKbFpAFw/xOaQRo6JuABSk08DidQJKiC7d6c+4LopxNBayRcLTykYh2GH
 v8mE3Cp1wnSM8iYLdBvf8ft8chg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9eeF8hcRYDtZ6Gsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:41:11PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 07, 2022 at 04:28:07PM +0100, Andrew Lunn wrote:
[...]
> > How are the registers arranged?
>=20
> As documented in drivers/gpio/gpio-pxa.c - it'll be easier for you to
> look there rather than for me to explain it - but suffice it to say
> that the pinctrl registers are amongst the GPIO registers.
>=20
> > Is 0x40e00000-0x40e0ffff simply too
> > large, and making it smaller would fix the issue? Or are the registers
> > interleaved?
>=20
> They're interleaved. Looking at the .dtsi file for PXA25x, it seems
> that the pinctrl claims just the addresses that it needs, but the GPIO
> controller has no reg property in the .dtsi, so I'm not sure what fills
> that information in.

The GPIO reg property is in pxa2xx.dtsi.

>=20
> DT could describe the region for PXA25x, which is just:
>=20
> 	0x40e00000 - 0x40e00054
>=20
> Later PXA have more banks, so would require additional resources to be
> listed.
>=20
> However, first, we need to know what provides the iomem resource for
> this:
>=20
>                 gpio: gpio@40e00000 {
>                         compatible =3D "intel,pxa25x-gpio";
>                         gpio-ranges =3D <&pinctrl 0 0 84>;
>                         clocks =3D <&clks CLK_NONE>;
>                 };
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!


Jonathan

--9eeF8hcRYDtZ6Gsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOQwwoACgkQCDBEmo7z
X9vPtQ//W+FQ7O1MJS7Wep4GMQxQyamklotEVos/5WUxWxRXD3RE9PP8w0tEyLzP
bNUTba+1rJDZO+NL9CJlYLwvD+B8V1gzSpGBc6ak4+4ANGd9GLxdAWM8/rt5QAXv
AeGrzXNM1v5gpY+yBQgLf1uW17Aecg3evFasblbjVUXhZiWToyYwbju+83inIAip
bQ+49Oru0jdXUIJiygFGqRyUCpOa1BK9Ami5XNBNQo8XtharZTlMBKQFtmS5VdGo
cpplEVnwiGJ0BSNzwy93lU+TzRsxSesqPyJja4Lgb5jixtP3CxMy4Jxoi3AU7nOz
t9SFVPN2Ps/tBznQkvoz5942TrXAC/5yTzs8cfDHt9zDbXmNaj8QNXG11QTgtrP+
nrElbbI2eYnH1q87ZhwoeBnEA9Fu5jKz2cfCKbXAmNNHIhkOnKEBi/yz/HpySbHY
DM+scWSdwnbWIC1u4zFMk0ArZfMcBvLJmUIK04KTUdjVRjjCvR2bmMwN4O/xNQ22
RxQQ4ugZSFYs99AheaAjMHAeWqrWmM88b+HdtH/YreOQ4wlSlfOsHrWdb0jw8Qh5
phqAq5MqSibWgfx+x1FXSl2byQXoqdsDGAStiidsMmu7rNS5vgmGDKgMQvmbYxoW
D8VBOKUVEIheoZWGrouRleVDOwamaJc9PpklNSB41hrz0LJJv4E=
=o/Ap
-----END PGP SIGNATURE-----

--9eeF8hcRYDtZ6Gsw--
