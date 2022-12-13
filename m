Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67A64B7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiLMOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbiLMOyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:54:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C16421822;
        Tue, 13 Dec 2022 06:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1670943238; bh=p2V7s/+ws7X71BvYRIZHw7xsRmehJjPbd5XZsH+u/kY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EfYG+kjIktEbtgitzOXzPiOmwbfKYZrdBcFfzvLXgM5ccUgKcRm6x57W46TG7PxBB
         ORQ3ZDeBcniVBw3lYH0D9U6yORuMyftys+LFinsIWieI369Y/ZA9rzE7JFqMbTTizb
         QbmeSraKJGkxs9N/AkewwQeI5upq0QdhwJEfi2gdKMQp9cN0cuEHiqJrV31NzAEY5D
         taWNh7m8/ySvMNLj/QVXRUode3imfeaY6FB3rky6iD3CrE+HWIe0udQRr0PU8Mei7Q
         BvwneEl4BmvQESWI9oqsCkW79E1sSzh/Dn/dqPS1DlGDURcZ+B9VUPM9bmcYiRV+6g
         lvzJK8mURDP9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.166.74.222]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1pLggE305k-00Kvo9; Tue, 13
 Dec 2022 15:53:58 +0100
Date:   Tue, 13 Dec 2022 15:53:54 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 5/6] clk: wpcm450: Add Nuvoton WPCM450 clock/reset
 controller driver
Message-ID: <Y5iSAmJimekv1vkZ@probook>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
 <20221104161850.2889894-6-j.neuschaefer@gmx.net>
 <CAP6Zq1hjbPpLMWST4cYyMQw_-jewFoSrudOC+FPP5qOxJz4=xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BUhB5f8R8Qwj7WNX"
Content-Disposition: inline
In-Reply-To: <CAP6Zq1hjbPpLMWST4cYyMQw_-jewFoSrudOC+FPP5qOxJz4=xw@mail.gmail.com>
X-Provags-ID: V03:K1:qAZlPKx9k174kKCeqsHXUbFKERd19qHGzg2rpCT1Cq/gwIE/rSl
 FRD4UBzf2HLKJoR7aa60QRyfVkCJGa9VbOQ1jjer8b+RJcBuIPAQhHQ0jL39MfHu+s3D9fJ
 bopLEv1LIDJV/csOPud+R4TcdnTC6IBl3Z9+aenIAy4/0aMtUHaRO2Na30U0jwK/AiwBf60
 uzB6JKiSf4O9zNEpE5zRg==
UI-OutboundReport: notjunk:1;M01:P0:gGW4xdaesKw=;SkdxK5f2/9uUDiqfD41ZIZwzBaU
 cYDhwjj/Jlo5LplNONkgLkYWeDsGvV4zmUl05FeLi9Z1Aw+9eEUW5d/Z/8mGS3mIVGxQRqsfO
 jnXj/vjUwUnuighzSRS6OB0Xv+di8nE4pT3SV6bNVkdah57Mub8AehzI9UKff5R8AXpre6Cdq
 TibfIcKqI1Eq8EjF4zLyYtBzmLbo1Q5WgOFJeClw5s6bKzZHlO40S4i8ecPhKsNNORdsh/cgJ
 vlj0zIE0pebxFiTRPjvgu68m+fkx1Z0uhzJM5HqvYpgbUTg1HjWI/xYqEywwOjFNv+yVL7K97
 tKAiMLlz75qVZDugaXs/12CO3KCR+lestoqmmmfdWlsEvk/Yib09e5GbZ+P496ssNcE55EgJ4
 /oxp1bioFkHob84fR1Swd9oiU6f6eEe6AW9QrW/PemtTx8T+vEl/1etfOaX0DkrLSybXLpOMD
 0T4HR1nJJyI7r1QEuT7WBUawXbj7l0Rd4vtK57d7lCY7qNu3nhFT5h1PTZbl+Bda4mhj83b5m
 w9qYEH9i8TfmqhevkTNz+F+NMEVr6rMCvAcxGqRLG6ljpMErZDmSbfbloRvIvh2YBrRwGHsoL
 O9tvF8m5QHXNJy403labgjzI1g+C4D1Xg6gNUkTbFaTWMfPDNbf/x6hRpzerHjDTV+wLpJOUO
 rn5/+BphkMigEtQ/xOu7oW8KLmWflIhcbYs5p2/Px2xE7fHyDYEpf6MoVitcQgoFb2pMmrF0i
 tbKdpfafkRkCf45kkdIupk1C94XzaqQygbBQX25RWsugFZrcLTgGzWbXX6EodQumGbVb3ArWw
 OZVfLeDkk0MDEV9y0gYBW2CP0wMs0Yk5C9EhIrSy1vMFldnR/XgpIML/BSJyenzy1+ejnlsSC
 oNR4o0IP1E7X1dDkFFj+pIoLuxgsRvaxpHhNcbLQWb5I/ti6sQV9XYSRT0Amjq3H9mXpEDuNf
 iorfu+Sxl1bq1yzK2mrnmRmZcms=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BUhB5f8R8Qwj7WNX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2022 at 09:30:46AM +0200, Tomer Maimon wrote:
> Hi Jonathan,
>=20
> Thanks for your patch, and sorry for the late reply.
>=20
> On Fri, 4 Nov 2022 at 18:19, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.=
net> wrote:
[...]
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index de176c2fbad96..de5662830fce8 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -208,7 +208,7 @@ config RESET_SCMI
> >
> >  config RESET_SIMPLE
> >         bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
> > -       default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REAL=
TEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
> > +       default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REAL=
TEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC || =
ARCH_NPCM
> Please modify the default ARCH_NPCM to the specific Hermon use,
> ARCH_WPCM450, since NPCM7XX and NPCM8XX use a specific NPCM reset
> driver.
> https://elixir.bootlin.com/linux/v6.1-rc8/source/drivers/reset/reset-npcm=
=2Ec
> we prefer not to have two reset drivers when compiling ARCH_NPCM.

Good point. I'll fix that.


Thanks,
J.

--BUhB5f8R8Qwj7WNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOYkdgACgkQCDBEmo7z
X9sOfw//QKFWxH0SCpUDv5aBRt3V5G0f9oCvOuHlRz1crGkrzdIWLF78mm+rva0m
y+bUvpCoUuzhLTf8BGSfrnoaORrjzr4PgJXSaCMjjweSBMiG9PETkMtWKSA4rDCS
X1vaU/OeVHy2eW4qhkgTKAmapy95wnk8lmRgjdeLLRWuuz06bX10wrnJWE8WOox8
68QJNfQy76Ih5e/yh4lvhaWskzaUxuvLahWoZMMkX7xdUaV+bGfd4ad4tQXHwBy9
BPHh63CTwUk/aGpPjOJuycdJX0MMZ4h1UNmuHfN/z2f+/rdLF3DtGMS9CYSK+N6z
rosdZLiuzz3SQ3kB2IoCMbPq/RMtkqGlDTu/qvDh00mZd8DjaXS57u5Si4ElGjPH
cj9b6YhDhWJO4hQbnHPaHY4hFt6PGqN/odIWYbIxa/ekiEUY8hP9h/LZMAb3d26N
IUfbqHmb4iQqqLPL/E9NvAsMtrDbZcyHUtMztFThq16yNNEvWv1wqbO+UddcsfK1
6d45sgggdIbGz2nnvzAf4Ex+SUsp3pVnbqfMmDYmRpGYkwZdOBSXJejqG/OEXzYY
NVzMQcabti/Kw/u0rxyIYJUPgtdvR/lKWCtEACM7t6zqeVM/4DTsGGfmNXjyP+tJ
uMivMhp96c6eW9lkZTeMFBMHWyyrA5kGx19FRDbCdURM0qdLr/c=
=rO9G
-----END PGP SIGNATURE-----

--BUhB5f8R8Qwj7WNX--
