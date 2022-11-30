Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821F563CC70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiK3APJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3APF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:15:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E1FFD35;
        Tue, 29 Nov 2022 16:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363EF61983;
        Wed, 30 Nov 2022 00:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBADC433D6;
        Wed, 30 Nov 2022 00:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669767303;
        bh=H/2t/TlHvc4K4sre/K0UhKQ88srXw0W4/lDh1R/X2tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MspaSxnJJSoSOwj9fUNrIeeVwo0WaBY312xhh94JKZC9I3Vf+RXTzHZt1Ac4GDpam
         RqexdYWeNSYUU1YcWjkTcv+PwRfd0X5k4UjoqmKkyXdsfAIVzz4cRtmStzI55BBhKW
         T6VN1AM1emcQxRM3lsWkn9l6QOtkyU1amUUnXh1k8Tm7esOGEsdvByOjiji0mthstl
         opvz4tVuUqnKK6ZvNipGD/NNuYSeMV19MBmpm+GAHZlqQjxGwmhjLOOXyRAopzJVlT
         vg1JTBhnZtz03Y7AEnUAJxHO1WHA6SiYLgK3FyW9ChaqJeoCOC7V7ujAkJLnRrk3HC
         NeEYW9gH6vs7g==
Received: by mercury (Postfix, from userid 1000)
        id 96BDB1060ABA; Wed, 30 Nov 2022 01:14:59 +0100 (CET)
Date:   Wed, 30 Nov 2022 01:14:59 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for
 worldsemi,ws2812b-spi
Message-ID: <20221130001459.3wyxnwpjaxvla6oj@mercury.elektranox.org>
References: <20221129140955.137361-1-gch981213@gmail.com>
 <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmdzep2trkfkvvse"
Content-Disposition: inline
In-Reply-To: <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rmdzep2trkfkvvse
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 29, 2022 at 05:54:52PM +0100, Krzysztof Kozlowski wrote:
> On 29/11/2022 15:09, Chuanhong Guo wrote:
> > This patch adds dt binding schema for WorldSemi WS2812B driven using SPI
> > bus.

Nice, I have a hobby project for something similar (SK6812, which is
basically WS2812 with an extra white channel). I will switch to this
work and extend it once it lands :)

[...]

> > +      default-intensity:
> > +        description: |
> > +          An array of 3 integer specifying the default intensity of ea=
ch color
> > +          components in this LED. <255 255 255> if unspecified.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        minItems: 3
>=20
> Drop minItems.... but:
>=20
> > +        maxItems: 3
> > +        items:
> > +          minimum: 0
> > +          maximum: 255
>=20
> default: 255

I would argue, that the default should be 0 (off) instead of 255
(full power).

> What controls the intensity? Don't you have PWM there?

WS2812 is a RGB led, which contains a small Microcontroller. The =B5C
takes 24 byte intensity data from a serial input and then passes on
any following bits to the next LED. SPI clk and chip-select are
ignored (chip-select support can be trivially added though).

You can find them everywhere nowadays, since they are quite cheap
(a few cents per LED) and need only one MOSI pin to control hundreds
of LEDs.

[...]

-- Sebastian

--rmdzep2trkfkvvse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOGoH8ACgkQ2O7X88g7
+poJJQ//X8hmZkrh48XT+dRJLR8a5G7WUcLLK1WRND4rk6RJcqy/JsjuSHazWTJV
kMFobY+cxU3zSejn2E+PaU5yt9x4tnRGc1nao4Ugs4P+IcSZkpqw+ycmnU3YQny6
Obn/I04SryQfdrYzaJEjn7HrwwNYXxL88cvc8gHXjTdOQnvEVlpCuU7+Yh0lSVpr
A4q0j2mW9KjyfBQLWQp+T0fptCBCJ+nxZi7DimcX8IFDisy4FnDEtnwBEvX6Av8+
F6l9+0/uOp8u3ZFdOdhei375heO7lf8BLBLUHEjx3bEC+rc2LAJv0q7gw4sYhS+U
OWAfcl7dfyIfONU1on+I/rTn5gH3ht0oVUFQ76t/+R0qaTwFx8hJQr22Svm2/NVu
Y6V0ptJBbjb2Pz/5Nwl/jt9lV0z/Oe1KEGaPMk/MuRFFpkK1boay/2UVQLi1va3p
JWqlbx8DMyD+kLDxmDLFD9Kjg6h8tP/enYPlNEjOFHif8X35egp7ZDAaPvEGr9bU
pkRSj003U2QgLhRIQ9esK74rQk3Q2LUVABeIC61Kfe0nwSCE3PPyF8Bzv3I+FXTx
hLsR3+unWoMWBzkqp72X2W8KhwbMXWXReSy4EjYlglXXR2ki7+vyF2ZsDmbNYUfS
icZPdyYrO9NwcOWJCnRlYPpDQ3rNOcZay/gZs0+qngrV+4Xv5LE=
=TvgO
-----END PGP SIGNATURE-----

--rmdzep2trkfkvvse--
