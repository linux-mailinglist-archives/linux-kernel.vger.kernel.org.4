Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009360FD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiJ0Q04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiJ0Q0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:26:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10499A449;
        Thu, 27 Oct 2022 09:26:52 -0700 (PDT)
Received: from mercury (dyndsl-091-096-035-205.ewe-ip-backbone.de [91.96.35.205])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED58D6602395;
        Thu, 27 Oct 2022 17:26:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666888011;
        bh=4mcg24t9AjJNzQ806Gbikq/czDGpzAU9xHPk2spH4KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6qskPNbfIp5J5LYfBzEocQDyMIYQRpbjRzm8pWGOvNgLoRHSN1Uq6nPsIxs59Pvh
         GNCau0kov+9zLKz08poBrrYzSYdCPVfeFxIQAPSR8K7yya3C5Pi6+kk0UJWSFRlzBq
         Lah90qDwyULFaEyA+9s6idK9Vmc5DpuMVwO9rNmIeYtlxP5KPdSUpjCqTd1v+Ui4jF
         w7BQcZazoB/xp5Sv0+Xjvn5vyAKC2WdHMQznPlM0nNpjpczfQnE29u4LDKLFFXzaX4
         JpM13Eowk3Ud5e+qoBOo7wj9xkpDJYHtwomGDH2A4bKZuXn6B5cOS3n0IZyVjszjNn
         2lOSdYz4NdAZQ==
Received: by mercury (Postfix, from userid 1000)
        id 64F7D10607E8; Thu, 27 Oct 2022 18:26:48 +0200 (CEST)
Date:   Thu, 27 Oct 2022 18:26:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to
 json-schema
Message-ID: <20221027162648.mowz2lefcajv3s2q@mercury.elektranox.org>
References: <20221021170605.85163-1-sebastian.reichel@collabora.com>
 <a5db8a34-acd0-e262-36f0-0b904468bd1f@linaro.org>
 <20221024185049.GA2034297-robh@kernel.org>
 <20221024220559.dddihmq4xg55h26w@mercury.elektranox.org>
 <1a9e1bfb-0437-fcd9-8d41-a1e07aced0e3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i5gncsormhwaemm6"
Content-Disposition: inline
In-Reply-To: <1a9e1bfb-0437-fcd9-8d41-a1e07aced0e3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5gncsormhwaemm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 27, 2022 at 06:11:19PM +0200, Johan Jonker wrote:
> On 10/25/22 00:05, Sebastian Reichel wrote:
> > On Mon, Oct 24, 2022 at 01:50:49PM -0500, Rob Herring wrote:
> >> On Fri, Oct 21, 2022 at 07:59:26PM -0400, Krzysztof Kozlowski wrote:
> >>> On 21/10/2022 13:06, Sebastian Reichel wrote:
> >>>> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> >>>> Schema format.
> >>>>
> >>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>>> ---
> >>>>  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
> >>>>  .../bindings/rtc/haoyu,hym8563.yaml           | 55 ++++++++++++++++=
+++
> >>>>  2 files changed, 55 insertions(+), 30 deletions(-)
> >>>>  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8=
563.txt
> >>>>  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8=
563.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt=
 b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> >>>> deleted file mode 100644
> >>>> index a8934fe2ab4c..000000000000
> >>>> --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> >>>> +++ /dev/null
> >>>> @@ -1,30 +0,0 @@
> >>>> -Haoyu Microelectronics HYM8563 Real Time Clock
> >>>> -
> >>>> -The HYM8563 provides basic rtc and alarm functionality
> >>>> -as well as a clock output of up to 32kHz.
> >>>> -
> >>>> -Required properties:
> >>>> -- compatible: should be: "haoyu,hym8563"
> >>>> -- reg: i2c address
> >>>> -- #clock-cells: the value should be 0
> >>>> -
> >>>> -Optional properties:
> >>>> -- clock-output-names: From common clock binding
> >>>> -- interrupts: rtc alarm/event interrupt
> >>>> -
> >>>> -Example:
> >>>> -
> >>>> -hym8563: hym8563@51 {
> >>>> -	compatible =3D "haoyu,hym8563";
> >>>> -	reg =3D <0x51>;
> >>>> -
> >>>> -	interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
> >>>> -
> >>>> -	#clock-cells =3D <0>;
> >>>> -};
> >>>> -
> >>>> -device {
> >>>> -...
> >>>> -	clocks =3D <&hym8563>;
> >>>> -...
> >>>> -};
> >>>> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yam=
l b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..b0b6126b12dd
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> >>>> @@ -0,0 +1,55 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>
> >>> Dual license please. I don't think you copied any content from origin=
al
> >>> bindings... unless the example?
> >>>
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Haoyu Microelectronics HYM8563 RTC
> >>>> +
> >>>> +maintainers:
> >>>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: haoyu,hym8563
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  interrupts:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  "#clock-cells":
> >>>> +    const: 0
> >>>> +
> >>>> +  clock-output-names:
> >>>> +    description: From common clock binding to override the default =
output clock name.
> >>>
> >>> You need maxItems for this.
> >>>
> >>>> +
> >>>> +  wakeup-source:
> >>>> +    description: Enables wake up of host system on alarm.
> >>>> +
> >>>> +allOf:
> >>>> +  - $ref: rtc.yaml
> >>>> +
> >>>> +unevaluatedProperties: false
> >>>> +
> >>>
>=20
> >>> Would be great if you could also correct DTS using these bindings (see
> >>> warning from Rob).
> >>
> >> It looked to me like 'clock-frequency' should be added to the schema.
> >=20
> > I've sent PATCHv2, which removes clock-frequency from all hym8563
> > users. My reasoning is, that the old txt binding does not describe
> > it and the current Linux driver does not handle it as far as I can
> > see.
>=20
> Didn't note you were doing a conversion as well...
> From my abandonment patch serie
>=20
>   clock-frequency:
>     enum: [1, 32, 1024, 32768]
>=20
> The data sheet shows that it can generate 4 different frequencies.
> Rockchip mostly uses 32768, but that doesn't mean someone else is
> not alowed to set what he/she prefers.

As far as I can tell 32768 has been cargo copied by everyone, but
the driver is not parsing this at all and I would expect the clock
API to be used for requesting a specific frequency.

-- Sebastian

--i5gncsormhwaemm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNasT8ACgkQ2O7X88g7
+poQUw//bQfdjxGXbjRBq+lN70cB2SjuiDFxd1XPTJL6y/FKW62jsNJFy3E/urDl
stP6I+dxmcc0OOflL8MkliHFR9+DD3Brfv8hmRexfhL/nTauQ+jeV2b6QEe7NFcS
QbC4EgRPUn+4mgJMDVel6ZNllBPXJwnw3bjx/bYDOSdi+tQMvIw38qkZ5v+2Aw8W
nWw0USHSLoUBHg1Lon6Sx5A/H2BSFpg+xNH8A9ufNei4u6wjT1cGvRVgS3chtfX+
VD/QIeYt34ubJI7X+Y+xGeJJ1+yFPVyhNAS6TqQePrJrsTbt7eXmnjhtg8QsnVYO
GgDVp3DiWceC/CVXH3zSXsWk13pemDQUr+lXd9olSOsB6a1PDrHck72aaKXpk2UF
00Ytx3KjHToYLaKbmLZrHDFP/0RfxCoMuSkaeKbzImt51VLzz9Sx6oWA8OfEfpss
YopFtMG2JE1fghtP3LpPAiLi2UNihBvGJ4uxER1q7yVILLoEPc1PpdN1tp+DTqGL
bTQbZvnz/LzJBdr1I4nhKGgssrr2aWthejbQQbjdNi+7SfjDf9K5RpwzRg0qQiOC
s/0TtOe0JqiqXM15p+MjXH6Nz2/GgLCi78NvZjFLvoYs6IGoqBbSlakgG5TvOeEZ
QLfydVH9Fd8NtshY9yBqm1fiZKpngWer8BbB5zjRUtIzo1LxqIM=
=lqdc
-----END PGP SIGNATURE-----

--i5gncsormhwaemm6--
