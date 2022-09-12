Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77005B5956
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiILLaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiILLaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:30:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DAEAE72;
        Mon, 12 Sep 2022 04:29:59 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B3956601FDD;
        Mon, 12 Sep 2022 12:29:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662982198;
        bh=9LRXbQvMgfpznHmdCJDSxftL9OPSQs+KCSqhr83pcdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kw0wSxm8DOSqvRuJu5XaM/m6+lPdJah0R9U3Iu/OdNmtnFXk45vQUQfpQ4GJYsXv2
         yNZQ0VT37tjXM1RPQrlqSdlnEC5cVaJAFdO4/i7jA1GSGKBmXvTvAVAUUqKcIOxd4h
         BIobcIMEWsoz7JRXGwKIdQl3Azjzf3qrol2Am1LaDXdIL5+iRVMGlqhf7b26H6orHk
         2lgU+L/ZFNfLbiSWa07hplksSuG/IxwtDDwmlU+LmH5pf72PsHL850soNMbxiYGijb
         R36t0EPBgQ3wKRSN38gUFQkMfMKm9S/n8lYQwRHM7ClH9XFjpidSRL+B7vEigBHAwv
         O8+H3AvxW1zyw==
Received: by mercury (Postfix, from userid 1000)
        id 9550D106084A; Mon, 12 Sep 2022 13:29:55 +0200 (CEST)
Date:   Mon, 12 Sep 2022 13:29:55 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Documentation: power: rt9471: Document exported
 sysfs entries
Message-ID: <20220912112955.cpbzov6h7am4m37b@mercury.elektranox.org>
References: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
 <1661742391-11378-4-git-send-email-u0084500@gmail.com>
 <20220912111201.nxjgqzpa7pftzwlb@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ymscnol6svlolmlt"
Content-Disposition: inline
In-Reply-To: <20220912111201.nxjgqzpa7pftzwlb@mercury.elektranox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ymscnol6svlolmlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 12, 2022 at 01:12:01PM +0200, Sebastian Reichel wrote:
> On Mon, Aug 29, 2022 at 11:06:31AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >=20
> > Document the settings exported by rt9471 charger driver through sysfs e=
ntries:
> > - sysoff_enable
> > - charge_term_enable
> > - port_detect_enable
> >=20
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 44 +++++++++++++++++++++=
++++++++
> >  1 file changed, 44 insertions(+)

I forgot to mention: custom driver properties are described in their
own files, see Documentation/ABI/testing/sysfs-class-power-*. But
are to be avoided if possible. So first of all I want to make sure
you actually need any of these.

-- Sebastian

> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentatio=
n/ABI/testing/sysfs-class-power
> > index a9ce63c..1f8afe5 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -768,3 +768,47 @@ Description:
> > =20
> >  		Access: Read
> >  		Valid values: 1-31
> > +
> > +What:		/sys/class/power_supply/rt9471-*/sysoff_enable
> > +Date:		Sep 2022
> > +KernelVersion:	6.1
> > +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> > +Description:
> > +		This entry allows enabling the sysoff mode of rt9471 charger devices.
> > +		If enabled and the input is removed, the internal battery FET is tur=
ned
> > +		off to reduce the leakage from the BAT pin. See device datasheet for=
 details.
> > +
> > +		Access: Read, Write
> > +		Valid values:
> > +		- 1: enabled
> > +		- 0: disabled
>=20
> This is not a very good description of what the control does. When
> do you expect users to control this?
>=20
> > +What:		/sys/class/power_supply/rt9471-*/charge_term_enable
> > +Date:		Sep 2022
> > +KernelVersion:	6.1
> > +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> > +Description:
> > +		This entry allows enabling the charge termination function of rt9471=
 charger
> > +		devices. If enabled, the battery charging current, and the battery v=
oltage
> > +		reachs charge termination condition, the internal battery FET will b=
e turned off
> > +		to optimize the battery life. See device datasheet for details.
> > +
> > +		Access: Read, Write
> > +		Valid values:
> > +		- 1: enabled
> > +		- 0: disabled
>=20
> Just write 0 to .../charge_term_current to disable it.
> No need for a custom property.
>=20
> > +What:		/sys/class/power_supply/rt9471-*/port_detect_enable
> > +Date:		Sep 2022
> > +KernelVersion:	6.1
> > +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> > +Description:
> > +		This entry allows enabling the USB BC12 port detect function of rt94=
71 charger
> > +		devices. If enabled and VBUS is inserted, device will start to do th=
e BC12
> > +		port detect and report the usb port type when port detect is done. S=
ee
> > +		datasheet for details.
> > +
> > +		Access: Read, Write
> > +		Valid values:
> > +		- 1: enabled
> > +		- 0: disabled
>=20
> Why would one want to disable this?
> Can't the driver just enable it unconditionally?
>=20
> -- Sebastian



--ymscnol6svlolmlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMfGDIACgkQ2O7X88g7
+prZwQ/+NXJus5HU1qmf8FZGctjdhjvy0rwDan4qyyO1fU4f34xqLOrRZG7ziIf4
OsKmmmluNJWfKN+BTDaValdiKP5ix7j67L5QrHNdv6YrYaT7zjwmdTjNiinJGCCw
U9hy3KNG8Z5HIWf2Hp33WxpTeewHKJmAyPKb9UfJ3DqXq1uQppARxpqbA1Bz9f2i
A80TP+iafDtK4lM5wbBt/S/DYmO7mYuImuf51MkblzhzV8U+yRpdLMapxZXcO086
6plEnbazd6trCoicFhEO6Z7JRWUDZqBD9MvSNZFd9Xq56aJWqeIXK9F6sphkRTQm
MwCgGH0Qi0I7AYrxgySOWVxr1MBy5EsX3XoN3kCT4gC2FxVtN6pDtUJ0Px9GX6Im
+vsGPY9tLh8U25yzxKwMTxiDvN3HYyNRISlhvtq8d2LYg2Yr8TrbcCbvrpWfHFTr
OgT90iX/xHuxPlcJvojChcFnOSH9LWe/AAxzUe7RK59D17JQ2oLn0kzYgQdY/rfa
xGfssnkb9pgUQA7kZtN4cbajkP/AZema/czavruAEDXLKkAaW54Q4jbwPiEHDBmx
20QWc4GQ4dEnwVgnxRZ/rnOM6WtpDYj8crjD3lnqVMPdfNKt0THvGSVf1FB+Hcky
MsvBcq+f5k67lRKYFttZ1Y0cYj779j4n/4py2/F1OwxrUWpUD7w=
=2n5i
-----END PGP SIGNATURE-----

--ymscnol6svlolmlt--
