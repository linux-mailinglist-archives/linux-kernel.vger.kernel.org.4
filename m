Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863C6692C61
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBKBDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKBDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:03:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8975F53
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1676077372; bh=h9iRnnmz+au0uoHOkYRgjHWYNPXCTbWchki9HlQ7vCs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XMsKel/LgYxg5gBJx2FqGhwVIJiQDIT9RYNZpbopP6uWTYAlcre7xsL01jy3wlC17
         WiNAZQnkkNk5BKfWuQHGYn5PuIqRqeI1DX2MfXKgZne08NoHpYt9HaNRU7kSLZRwfA
         qJ6KRTBO4uCbPgq84JTL0Y5+3W4vmED3YWoJyvvIyUFLMO/V9G0GiaYvkQElKiIMMn
         SX2/r4uvK1sz02IC7MYhr0mtN9/eQF6M615rhPknsOwkVHWdNY9+cDMGMp0Ya7L8ie
         NB9Js4gmU01frX4yxCAUMPm3sLz7J84o3VJaKcPt51bufqeQhk9gNpq0S2II5WnW/E
         KoY3N7slBPVDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1p4q2H1crB-00V8Vu; Sat, 11
 Feb 2023 02:02:52 +0100
Date:   Sat, 11 Feb 2023 02:02:48 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Hector Martin <marcan@marcan.st>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] soc: nuvoton: Add SoC info driver for WPCM450
Message-ID: <Y+bpODkxY3FlCjPg@probook>
References: <20221103213420.1395507-1-j.neuschaefer@gmx.net>
 <CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="suy5uVTWSR/PXvzP"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com>
X-Provags-ID: V03:K1:x+bnmnUA6Wnd4taLkZE1mdHQ40oAKiDPlIKBBolMSfpYjr+qsvk
 zi9pS6SbXorBT1NtKZfDROeKSVJf1o7nO3ab72LSJ5ie4fHMYS9gcOmIxXBGwDp1VLuvxSH
 UDhEM4P5Uh3HHUs6kihpzuqhIFXjQvczPK1ObM/C/SHwDSpBcb+sJcwGcIA2g7kj2EGXl0e
 fy34Wahg8P4pFlHA4iYSw==
UI-OutboundReport: notjunk:1;M01:P0:EAxsbrScdYo=;c1kIHzZppqSP1ttBHiquTIqqR9K
 tfYWMAVtXJ7Vh+o9tsRZiatOZo21cPo1ALOFnaxfBZMYtkqHDFLyFp4fm9h8/56O/o4UmCqh9
 JoXJ2Y41uykEQMXPFcqu6rgeSkApwhG13S6qoBzi0yRn1pfPv46IBl3vxnJu/AYc3v2h1A7EG
 q35G3yx7zFXdD7/Q54CgXEiWIFd+feMqnYgeV8Cd6wtkmQz/yaD2XD47xe07uKDMnXdAZuxwZ
 6WILDSZ5epzy/lSbW+9c5kr6Axswe1Q331mPs67+OVNHDcHMaqW8VsV5Fu443taqG9SUvRykB
 HOIlcmmKM40apPuOklgEh+scO2M6dYj7pXw4kptGetx2l4WKUw4DVGQ/IDvt/UqEJA3C3ZFL/
 hQ1ApdtET0ekW4Fy2zoTcyis73NoE5bkXVhcwrXQkN0QzXo94JOtrGJ8TrfjFr+NJ//UTND7Q
 5FGexCOALPJB6r0NjfI0Z71vWnFosNDEJ5w6rItOCjKHWBlgP/fAT+ZL1w7L7dVipE+wkZCw8
 5wblNRS/2qRxdY9SFIWS+DvSfmUavSIwjRZHk2e8JyuCoeJarJbOKr0C5lPx2uzi1P0DWVQ2W
 6716Fbb455TZjKM7HxR+3ddWd7A/12X995uaSFG71rsxh3ztmlsBgD4j7Jd9jDUqohvV+Ty33
 IUkuMJn3wM9gCwwdhF7irVCRuS21IIBsjuEPeJRMwWqT6ZEp/j9r/tUVABRm/HwxYz+EaAPkj
 +NNxLEw465xTcTtu4mDXLa9cnb05ZAIA8q7zYWR3p29MM5ml7vStPGV414xyoSrQ8f0x6tj8r
 au4Io3j4R+P+uSrpQZJ6BhhNUCGGdPCVbHidw+1Dm5p0PDit0hzZ3zbY5+2aCtpKH892WDvEO
 qTjwq0se/PRK2SoMSQtdoVuhRfUOFA2yv8cXjJKrN2NsSrCpO9QCToIGLcb+LdCT9LHSp/eU7
 m73gYuM5nX7d267fhL73VFAxtOI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--suy5uVTWSR/PXvzP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2023 at 11:26:28AM +0100, Geert Uytterhoeven wrote:
> Hi Jonathan,
>=20
> On Thu, Nov 3, 2022 at 10:37 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> > information such as the SoC revision.
> >
> > Usage example:
> >
> >   # grep . /sys/devices/soc0/*
> >   /sys/devices/soc0/family:Nuvoton NPCM
> >   /sys/devices/soc0/revision:A3
> >   /sys/devices/soc0/soc_id:WPCM450
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> > v6:
> > - Select REGMAP
> > - Rearrange Kconfig structure a bit
>=20
> Thanks for your patch!
>=20
> Unfortunately Joel seems to have sent v5 to Arnd instead of v6?
> https://lore.kernel.org/all/20230201051717.1005938-1-joel@jms.id.au
>=20
> Which is now commit 7dbb4a38bff34493 ("soc:
> nuvoton: Add SoC info driver for WPCM450") in soc/for-next...
>=20
> > --- /dev/null
> > +++ b/drivers/soc/nuvoton/Kconfig
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +menu "Nuvoton SoC drivers"
> > +       depends on ARCH_NPCM || COMPILE_TEST
>=20
> ... and lacks the above dependency, hence appearing on my radar.
>=20
> > +
> > +config WPCM450_SOC
> > +       tristate "Nuvoton WPCM450 SoC driver"
> > +       default y if ARCH_WPCM450
> > +       select SOC_BUS
> > +       select REGMAP
> > +       help
> > +         Say Y here to compile the SoC information driver for Nuvoton
> > +         WPCM450 SoCs.
> > +
> > +         This driver provides information such as the SoC model and
> > +         revision.
> > +
> > +endmenu
>=20
> Do you plan to send a follow-up patch?

Yes, hopefully I'll get around to it a few days after rc1, when the dust
of the (upcoming) merge window has settled a bit.

Or should I rather send it earlier?

Jonathan

> Thanks!
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

--suy5uVTWSR/PXvzP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmPm6RYACgkQCDBEmo7z
X9t+Lw/8Csj0p+ONQQe47wx/OAvlRe9hoGziD1htFIxGfVuSAvg0Jhy/Ydcp+ktb
B1gkaeNO7VgO2ltX8MDhewGhZsYwywWKSYZBkR7fVzoGPNwnbi0qlOMrqXM26YAc
3MG64d+EAzAaufdlq8d3v/ww6VUZVciaI7b6CMG7F69/b7j79DYxj2LysOrW/26J
sQbk/wdo63CurmgXOrHH+Pq2urgotTGIsw4ivT5z+242s4t3kMnEqpZ2nNkmetBq
4p7mKK9aCYS3H17eJuc39kvnLaFonkpOb/EQgnb6vCA6m+PxxWezcT/asEgh8epB
6aAhi/fZvW6Pi4UbxO7bWvu4tkPFcIIAbj+XvknHuNbJ9hBZNEU/7SlNvOSmfgYs
jev3jlE+l6caEJpsgtaVPQRotUXcomZ/va/QZNl8LtO0WsSkuXbBKcWFmK7epbqL
bodJFMIYm3f4go+4YctiIk5+jsu61ezndJyIqv2/2/g+HQvl4zTLGSRGChiVnuvx
vXnRC32Jf8vxauAyAmw0DmybVKPHeqIjLrAFP2Cki1lKsb1apYepmxeZOm/GpNKf
mmhpMhJZUkPZ8VU+wkARebWp0MZeFbS7CjK5FZhImzygwCBwpcyKJpn+v0ujTOF6
Oev+SPDtZpS75q+/N4qjpA830FgHv0d5HvV1JoQLniwg0j6bHvs=
=jGHM
-----END PGP SIGNATURE-----

--suy5uVTWSR/PXvzP--
