Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786A261F29C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiKGMMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiKGMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:12:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C02B3E;
        Mon,  7 Nov 2022 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667823128; bh=TthCH3MyFeU/53rL5fOF2FHb0MHylxKNaTSlZ2AoxCA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Z33AKJoE+TjApwXXXAJcGicSIS3Ap3+hGcQ1cx6c05oLHC5/Sk927mE7S6vzBmiCY
         CTRIIRGeoSoUHfetu0bjdbV+VLU3AYxBrma53If3tqk1lBPYhLaIUypHu2luFK+GWZ
         GLIoqHFY/uom68aZHgYeIDs7l+ptFNeSsy+NxQzHOpAVqybJdEvFVqhhgCSrgGiTwP
         2GNssV2qyaDgOBw0WVyZQrGAcEyxEbroN02xDyjYQbBMauuRttCqIlksvQlB4s7Wjm
         CXdokptZalPCIUtwMqUt8KDxDcrVBpC+HxIO3R7OE5vIDTi87z6chwHjOkfe9g25FJ
         q4qz1gc9rjqzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1pSRnZ1vdt-00ajmS; Mon, 07
 Nov 2022 13:12:08 +0100
Date:   Mon, 7 Nov 2022 13:12:08 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Message-ID: <Y2j2GDKsvXwAdzg/@probook>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <20221105185911.1547847-4-j.neuschaefer@gmx.net>
 <066919b1-c43d-f8ed-0191-cce8c575ee37@linaro.org>
 <Y2fIjSKAGleEtjHe@probook>
 <2400e167-073e-65fa-7fe6-b64a34bce256@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sBTt7LkDM7vI6FGs"
Content-Disposition: inline
In-Reply-To: <2400e167-073e-65fa-7fe6-b64a34bce256@linaro.org>
X-Provags-ID: V03:K1:CsGqJgqR4n1lj798VMfbtLWI75P+FvbQ2ahoJ149atUQXYkWxQR
 A+UfigcIimbggR3yNWJeKwgQmf/dEBheHvGowYCRl6nlPWgplkuKBRMmJ4WePrVrc/qutMb
 Lg2DAcLqqVTraSFi/SSuWkfwZbE4G1XQhpySgkO76qjCp4VlvBd1mlreoxVBEtfXLBBGPf0
 628UrCUYOYvaDhOjDV8UQ==
UI-OutboundReport: notjunk:1;M01:P0:wRs6Hd/unZ0=;EydYN8ey+yFLMSg/dNiej0V9srE
 KGKBb7MhjVqdRbiR75GhTayTFWzoTxoMNmm6z6dJeddfVuesQ5TaRsraIrZn/lNdtUerv47kO
 3vT4gLZEFDJu7cpfiGXSlAGoWQhP4Fkl7z2hra1TYgFf5wpccd3gR+jLhRtVRGpRJt0xgyr9h
 Q//ngvTNbgXwQzESDaKeIQYzB9MWS1OSymAV+aA+YU+uxvJdhLd9IkDSdYwHZDKneMS0hmKWw
 i+nM6i/UX089oX3Ik9Ajmkd8iHVy5kL2VlEfK5ztGh+R6O3nsADy0ItLGQnjMCPXNBBtJP2Sm
 bnSOYGx7fvZApCyKwuEZ8Rko45M/saYGnPBFBxM6KDVzOSivpL6bQeXqBU7otv7IJQKocLoaZ
 QrTwcmvzZ223VenExdiKmdGQow2ZGLA8IYxbdaubukBLWkhYiya447qsAxi09LH3EH5is/LEx
 yGpxX7KifIGcnTxyO2tS7lfwKOgdIMKO8iw+TVph2BXv7LwygikyphNYAcuxuJfuHQHg3R4Xf
 RURkv2AEaZTY5BDqU8q/60JukDxbJPvI7vKMXlJehFvqsLzyNZO4YomVboLumUY3HPhrgSiQo
 q1xMN0CZj1Yr740sLdAoIPPXZ6Un0nF7dyz+Z8Qy4DKOUzqchkNdMzq2YM0c/sTu7GNLjBDM8
 4+dWDq0ZTDNAvTF1qAgRJQCrUTdp9ceRX6+6tOalQchgdtVGfrHMDc4ibsIJdqdZEe94KMhPs
 xHbp14ovlvOPE8Cnr2TVs6UFsjT+fA+2eDfWWypSUy0PcLfk6uX6hrF06atgI4xoAhRC4tGW8
 T5UJr8A9bfuGAG2FsDhjvMHpeULUiBOJsmFP6AxPnGWBpn3w+KWzNMy2YMJlxGhb3TWJUlW9e
 KGnZ4ZW/R022o7IeEMb6h1WsdZYwluA7wnjepV9aqjSxfILJZt0hpcoejR8Lll/aq0w+cgEKx
 JyNyvw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sBTt7LkDM7vI6FGs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 09:09:15AM +0100, Krzysztof Kozlowski wrote:
> On 06/11/2022 15:45, Jonathan Neusch=C3=A4fer wrote:
> > On Sun, Nov 06, 2022 at 10:38:45AM +0100, Krzysztof Kozlowski wrote:
[...]
> >> This is rather obvious, so what you should comment is WHY or WHEN seco=
nd
> >> resource can be omitted.
> >=20
> > Ok, I'll add more reasoning, which is basically: The "memory" mapping is
> > only an optimization for faster access, knowledge of it is not necessary
> > for full operation of the device.
> >=20
> >> Not every instance on the hardware has it?
> >=20
> > AFAIK every instance has it, and there's unlikely to be any variation on
> > this fact anymore, because newer Nuvoton SoCs replaced the FIU with a
> > redesigned and incompatible version.
> >=20
> > I admit that the value of making the "memory" mapping optional is rather
> > theoretical, and I'm open to making this reg item mandatory to simplify
> > the binding.
>=20
> If every instance has it, then regardless whether it is actually used or
> not, just require second address?

Alright, I'll do that.

Thanks,
Jonathan

--sBTt7LkDM7vI6FGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNo9fYACgkQCDBEmo7z
X9vrUg//Z2MgjUNH8jTRkS6zluTyC4TV47t+R9TD7rUExJ54x4AOrnXEcjVursL1
ERyEDEOzRqDne+xXjv4d5UfGBK2bBfmd4+lZzyx0BfKa/QdN/LDVc+XQzCYC1CEA
xWdH1Gy50GQhUUa3hB87zZ3diCH8/fhnwhT0DFshIuf1C6n/zwmPt2vVdam2wSzo
Gck72bz1T4ZHHtoofDcv++FvDNw9gDiiX1Tu6DjBi2N4JUn08xuYm7tDE8EJaYhU
4DLguem72fiZCQ1nJ3u5Y79k/7woIhmcRgYSW8Q0oVXB1wLltCYkwphuR3UEMMrZ
db6K1P0JzFYDyOn140AsmOSrqN9NFQXAGf4FApuq5SqCIUuHoJwI6yPegaagnO2w
Zz6gllxTwhZ2W7U+nxY1I3BGwcHT368D+VuXY6B91qT7MU0VzjaFHbIke3mlceuq
34NaYgrJq4EZbAz3F3P54x9AIfp1z474EmavNF4/6cb5el3xDreexxmcPmUvd1ua
fxmcBmZvc1vjFAUC7r9vKWUWkckcluJUTepmyoZp0O0RCn0c1xHMgzebGMh6dkLN
4svAXrvnLQeLCSeVqDe808ZyqUjwNYRrzcK7ExZ4isQBUOHL3tzJ0s1jKBtu5kGK
wVqovMtUD7l6/R6KxXbPjNdi6mJDGz4d9DGV17KlnO/h4kZudb0=
=snOc
-----END PGP SIGNATURE-----

--sBTt7LkDM7vI6FGs--
