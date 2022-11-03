Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6206182C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiKCP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiKCP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:28:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2761AF22
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667489264; bh=91iatK0bFe164TIbmDTaQyHZyVvPOTcArPtTqSE8u4w=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j+gAjkAD6A/tF7e+qfh2/rtCGHI637bbBEDhiEKyN4Zp3YYmESdb5ijOgDBvfAO2C
         chfmNhp6jI84lWYpQeT8y8jfhtNw7jHfO5I597APb1GD9xh27b3dE5eXOFxPPO0SP1
         +PONSQSRc4Bb6t2zk2+FBLtwV3jkXuDFSI/bALQkmMscyjiSYyF8a8rBZoH94ZkEhY
         UHZhkGaYDwg924w88Uxwhe2BxpKG/QyZSUUDZaOwi74EfFCVZnslDb8jmlPVJZOzrX
         BCUOHUXBDXNmqfQNjDD2XYmLHc2/DRHqb48s5frAcZtkFmzEQwXZmEzwBjHCd98eDP
         Ja2XrNUJiCPlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsj7-1obxOf08bt-00LELe; Thu, 03
 Nov 2022 16:27:44 +0100
Date:   Thu, 3 Nov 2022 16:27:42 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3] ARM: Add wpcm450_defconfig for Nuvoton WPCM450
Message-ID: <Y2Pd7vIkOu0ptVMb@probook>
References: <20221101112134.673869-1-j.neuschaefer@gmx.net>
 <CACPK8XfnRExua7ZhyAkMNUNwUtmcXrBL3phf9ZMCzpBMN452hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RxxJ9eg+2o8pr/p9"
Content-Disposition: inline
In-Reply-To: <CACPK8XfnRExua7ZhyAkMNUNwUtmcXrBL3phf9ZMCzpBMN452hw@mail.gmail.com>
X-Provags-ID: V03:K1:6/15tKCEE1SgwOughob2r71Cgpa2Iy2CW+UvY3wS41dgyU3QgPB
 nN17U46GHNzgiDywo9D6t1u3pWZxjR2c8/PxNuwet0hmqsMCvFUr3I+FOaCOhDhIATtUNsG
 iaGWaQNpPvz+SA1cFuRO9hBCqmkS6DPS/mOZFFLDW/d05D/YVBlvRt60o5lO+G5bFr9zhSn
 YhXVtMrZZoQJopX/ndiYg==
UI-OutboundReport: notjunk:1;M01:P0:N1LbXc4a9XE=;WrOyN4FTith+9lFxFza3HlLqBVL
 O+WJQplvss8Wpf6fW5ff6DI1Mkb6wsTEc4u+daSJCR+HGldi5tucOYxNZ1vboj/Q4S4GC68EW
 lPXsOVC5ru0xaRXL7yHuN0FtBWgFjoACpW8pBCKwCGlkVram0vD2TZFHqT22Jf8aK85RaIGTt
 Tf2VJ2sV2QIhE4bOEysehcvDMvw/gqwfNk+3hluW0PS1EQ2lRwF9lKKfIgv68KaSlfKLmIbkZ
 boAnkXCpK9OI9bcoY9y24O6v0XoByLWuBiJUHDT7F+OvBFje2RCOE1x/ue3mdPq/iQGFftJZ0
 w9huIFHq79KKRnMFKrs1leCO14+gw/9gqC72KOKuHlZ0aw+tMSNSfcP20FgAsLLVuGEwaWyQj
 O8m7we1GoF/sDqP4/Rz3Ef7kw8qlvg0yp3dAl7YgF452/ZMK1eyw6dif/wDfY1kV2fZfqUDXu
 0mwRKtSsx25Cb1UZqb7RMHml0CJOgcAYhwsNKz0Mds439ACyCaLUFUZCRw4goCrWCWMUJyzFF
 amA4sYOaow4ikitTP8PJgYFIvAdSakYjCZ+IeWzjdteMFsZUYWK5IyzF4BkOUycG3TVBNjfV5
 ZddbRCfHuXS1f9Ixb/rY/64qF1mgcHzAWyRBnsra8U/HvGpp6gfY1Gx87zeheN4KaPPICG4kP
 1x650I0YFWYIH2gH5xZ+WXGicFfhXmQoz+itNaJP9RMmY+8aPZGKyB+PpPyGCOFLzHxYsQi/v
 OzIbWWra6aM9KX9OkAkJHLpXlBwhOgC3soJumljqdQg6WEsCEd174gxaozKJFMuktS2iRhyoi
 dQ71eYnMxwdcDdvoO3YjZ/r2aSQjmEashl4ujUKNag3mV+FnFK5BoFQLajgpZ5fQ1LQsUFL0z
 MS0PJ9M8MrNaq89lAnlaQn17QRngcKsIFQm86s+JycI6/4suL23A8vaXHWjvtyom5zUbrqu4L
 zAp//XP/wusY3TAGCH5nTtJshww=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RxxJ9eg+2o8pr/p9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 10:29:58PM +0000, Joel Stanley wrote:
> On Tue, 1 Nov 2022 at 11:22, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.=
net> wrote:
> >
> > This defconfig aims to offer a reasonable set of defaults for all
> > systems running on a Nuvoton WPCM450 chip.
>=20
> I was going to ask if we could instead have a common nuvoton
> defconfig, but this is an ARMv5 part so we can't also select the ARMv7
> npcm750.

Correct.

>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>=20


> > +CONFIG_ARM_APPENDED_DTB=3Dy
>=20
> Do you use this? OpenBMC systems tend to just use FIT, so we don't
> need this option.

I use this, because there is no modern U-Boot port for WPCM450 yet
(as far as I'm aware).

> > +CONFIG_KEXEC=3Dy

I also use kexec, it's useful during development, but I see that it's
not so useful for the BMC usecase.

> > +CONFIG_CPU_FREQ=3Dy
>=20
> Does the wpcm do frequency scaling? If not you could disable this.

No, as it currently stands the clock driver is read-only except for the
clock gates, and there is no cpufreq. I'll disable this option.

CPU_IDLE could plausibly be implemented on WPCM450, but currently isn't.


Thanks,
Jonathan

--RxxJ9eg+2o8pr/p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNj3c0ACgkQCDBEmo7z
X9s1ig//cf6cPlBR4q5XbP91hHqmEBlAhpVFYFjdtzHlcqJgZlhbhtwwEa3OiPoP
5JBodEaW2k3YWU6t2hM7UxiltcBNNCrz7uEhDscO1NHS6S04Dq43DU4rqyNGpVIS
+KC4WQJz7TAliY5ejuwfmS0b5iipVVA8piG8iXXl9nKe0i09cepbQHID7twJ3xZo
uMAWSVUJvu5Kv1qusulgjnI3O47QnZdR+cCHH3s0PyP0pox74+VKjfj6PzjOOw+Z
LqqggLiymX4o3OAeYZlGbemhWzfTgoln/FhcNMjZbMof/wjtu/lZxVbLmQ/el7LN
hVEuj+ViS/lZ1CO+y+K5effZPvMTURCxRDBzQalyynPSCrsEswVtIT/QQoI5uwP9
wbyFv09N+HItJIn7TRNl+lRI6I7PMmalMrHEFfGQRYPfPJomq2w68M+XvwVpOTr7
cVzAzLtr9KUjkHug/ILgN5qaUWn99oGkNXV1yyHhsOfWDc3hwwjEUsmoj8yI/Jg4
Q22mTyqwU1LlYc05cvJiJ9jbZYaQeuRHxqb2m+WIQd20IZM6jUuTFzIZhNgLVOSL
0+KKPRtGfUs0hjUzi3aXTC3N3Ibl/huFCv0/9zWQZhETouS5DHwZly1tZ8dXn0rd
Yeh45DKjbux/qtDyS53ZNeEWadaoI9/+MPehpDy1RfMtiNxmeEo=
=GC/b
-----END PGP SIGNATURE-----

--RxxJ9eg+2o8pr/p9--
