Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD5647843
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLHVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHVxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:53:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78819D880
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1670536399; bh=usCMTrZjiIwM1lRfTZffD3w0hmuMtpXUMwNSzLgXt+M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=rlOnymt7Oa3WSWdgC33J4EpKNphVRfxaemFqFbWUdiZy6yl1JnhWTzByujYcQ9d2V
         EvgpGRvX3rP8TqnwDnEJs250DzOMrPbyVspnx3x5KZZKHWW1BPHuVR7OWsjc78ucW0
         t1uGDJtsiiGWVb8gUwfGMvo/Gc9/bhF4/0RfKkAvTegk5L2G1zKT1hQRCWpw6ssD5s
         RlJnNAxsnpsjlRZrH27qCXSpwU7YGFR0dvy1d3yTQUfzgAAqbOjXEFVGXEGcEgvhoa
         H4BYOor7eg5qdYuT63LtojkleWC36TsvI4PYsRqtjATZypUb6l2vtTxlZE3rjYUwIf
         Iy7QxRQWbU8vA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1ozWwr1ltG-006AA0; Thu, 08
 Dec 2022 22:53:19 +0100
Date:   Thu, 8 Dec 2022 22:53:15 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5Jcy2AFqR8xH+fJ@probook>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
 <Y5DDCmXnamC6Zikx@probook>
 <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk>
 <Y5IulKoRctcrWBzl@probook>
 <m2wn71emze.fsf@sopl295-1.home>
 <Y5I2oQexHNdlIbsQ@shell.armlinux.org.uk>
 <m2pmcteilg.fsf@sopl295-1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvNQ2cIy/TDQfs2f"
Content-Disposition: inline
In-Reply-To: <m2pmcteilg.fsf@sopl295-1.home>
X-Provags-ID: V03:K1:qa3IkENNkYr7uZVqGPM6P1P3Jvgouj3y8oFsQ6gwZFjkmCKyrSv
 ogebXeVFegHAF2myKKAyc75jYsCP7TSviriwZ8O928027q7CO4U6/vIGOofi0mWSRTdYbPn
 GBNadZarAaXneJkB3QSYdxr/+jKRC7+5u6//iYuC5RFc/3csY7fz6OcVT5vD5O6sXI/kjv8
 ov6dQwl9cwCSgEC86bpYA==
UI-OutboundReport: notjunk:1;M01:P0:SMQvbR+e0Kg=;HudH6jxi7xrWmNw9/HfcabnNg70
 EMhf517+i4em2NgC70Qzo3RPpGxEVEXqSLU9z3AkyhNR7M1U+daZhlZy5yE7RVQyYeW0hxr9z
 mOUtUGs6tHFv/HtxR0AaNpbn9u7Xh0PVZWJ99Fi5upBH+i0JRynHMAvOu3G+y0eLl1E75k6Mv
 PiaUHz1L01R+D0mXh7J8aGGeWglWDhwehPpuZCIxNkYn+CU8mydpcpjiYhoIL7i3bfhKBOu8N
 dPNOikBJ2Awls5/I3uhbsoRE+MH2+jrt2FBZGOWeninZBPHBzQy3D9PXDqbc0M/zqwI05iWnX
 Jo3Tuo9W90kXoUkBVARb+cwWZyFOpXyZSUhaWm28faup5vE0deAeVv2qi8OGx6mL/ZXxlRbiv
 +AI+9YNP0c2HR2yr3haGnfpDSJQv08GYLuCv85jgpI6M6Ty2mnMh4NIdPILfZqLwXIwkzmmhl
 Al80wph5dczTNrr16h1g1MrelDn2pk/EkLQ3oND2ZtYb1j7wOzRUEyg7zwdtYGvbn3BVz0ThZ
 r6p1WMqNP52296Sfp+h34dbBWhGl5fqCrh4QfuP5zT28bwbI4uL9NoCKn7mXDyle+6V45yK1P
 UmfDDuB+OxrzA8egAdvbSoRizCnXLQFcRg79Ka02DZy3LB0DDykKIR9pTO1srcf2HaYYagWU6
 ZdrCNhPyXcY8KYzJ09bmRuecEPTwfJ4aZvos5J33RFglVEmv6232RkBiZLOoIqMuFACNSQagy
 llsmCvUWDVgLBUJXN3Sr1iE78LV4kAIIZEZmUceRjbEyy8GVEHQnIKoYWftuGEUHaRp1L4aF9
 4phYoRTHuQb1oZbVVaCORdjpsTZSQHRKZ4ei1Q17OdTIQiKSWK5L5CYuWzd3T8Fuey+CzXQYf
 viZRM8uK+vzhF9hXGMO5eFs8+y1tDpCPU2tU/J91OaZW63Nsoq1zNI8CK0OKSXXFrbApQYjj9
 GGmSTQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvNQ2cIy/TDQfs2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you both for you help!

On Thu, Dec 08, 2022 at 09:19:12PM +0100, Robert Jarzmik wrote:
>=20
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> > From a quick look, I think this commit is to blame:
> >=20
> > 542c25b7a209 drivers: gpio: pxa: use devm_platform_ioremap_resource()
> >=20
> > Someone "helpfully" making this change:
> >=20
> > -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -       if (!res)
> > -               return -EINVAL;
> > -       gpio_reg_base =3D devm_ioremap(&pdev->dev, res->start,
> > -                                    resource_size(res));
> > +
> > +       gpio_reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> >=20
> > which introduces request_mem_region() to the PXA GPIO driver, resulting
> > in this resource clash.
> You're right.
>=20
> Now, as for Jonathan, there are 2 options :
> - first one : revert the patch Russell pointed out

I'll try that first.

> - second one : a lot of work, detailed below :
>=20
> Given that Arnd is removing legacy platformdata code, that will only leave
> the
> device-tree one, which works only with the pinctrl driver enabled.
> That gives the opportunity to drop the use of GPDR from the gpio-pxa driv=
er,
> and now we can map with separate iomem ressources pinctrl-pxa and gpio-px=
a.
>=20
> Therefore, if Jonathan has the will to make a patch, I would :
> - keep the patch identfied by Russell (ie. don't revert it)
> - amend the device-tree descriptions for pxa
>  - pxa2xx.dtsi
> ...
> 		gpio: gpio@40e00000 {
> ...
> 			reg =3D <0x40e00000 0xc>, <0x40e00018 0x3c>, 			<0x40e00100 4>, <0x40e=
00118
> 0x34>;
> - amend the gpio_pxa.c driver, to map the 4 regions (and not only  one as
> before)
> - the pinctrl-pxa25.c and its device-tree are already mapping the  holes =
in
> the
>  previous list
> - check that I didn't mess up the 4 iomem regions, they should  overlap w=
ith
>  "pinctrl: pinctrl@40e00000".

And I might try this as well and see if I hit any additional obstacles.
I'll probably get around to it in january.


Thanks again,
Jonathan

--pvNQ2cIy/TDQfs2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOSXKkACgkQCDBEmo7z
X9vO7Q/+PITGK6dYOw2nHIMDd+sDDAj7Yvbf2vA9qk/WJII7sruO7ygymoJoUj8d
GRtRxIbhdnu/XilOssN0vIADpC+tP23eli0jgegN8Cb7F5jttYqtO5Pa4QH/DtZ0
nf0zWABMh6cXVsL8Pf4HggmPqkOwsN2QIsqEkktrCeHoYKDQZLiR2Qk9jzK5hUMS
5/13EwvqILmOgdWSxi9CAdxLCyjiOQY3AQ+sEyCpguhes0PB6cMBx247xxuY9wE4
jcAoxqhtIoy0isRtryIstLD4aSewVmn9iP2CEAWgEwHh20f8szauKz+CsnXgt5Hh
pRQpSGgOrGO1NQMqiOZ3xgNRPMjyxlh36uzVRXvao5qiClHkcshKa3AxNIDBrAnH
8vlR7BqHOUKuo6VD9N2dWQWPNd9mcIhmpvGFkvHWes0eXFJaAnbCdRe0U2EOH4BA
njSzcs0yRgCycSPftr79Ph3qKjfAdS5lQBNzVtz+9/n0ApU17NFo/IZ5kyldjPk0
T8qZWRcG6DKscLiO8DgOQU78nVELNrx3QN04p70NdjqcgJzZP/kmr8QNKLAwWyrV
It8TYWbQ/37/0dzlGtPaJh4mWF7TtiA3YRggiVb570e+DDl3L+mtJlqNCZG5ZuMT
4aMGfMgHcErr11iaaa9QVJ2+mhe5D7v/nftCr1O9MhEG09ATqqo=
=Y+pO
-----END PGP SIGNATURE-----

--pvNQ2cIy/TDQfs2f--
