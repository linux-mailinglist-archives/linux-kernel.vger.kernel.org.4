Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D473E647
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFZRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjFZRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:18:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2D73AAE;
        Mon, 26 Jun 2023 10:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C1960F0E;
        Mon, 26 Jun 2023 17:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126D4C433C8;
        Mon, 26 Jun 2023 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687799805;
        bh=8059eygYXUGESJrlTDcfhmLR43khYpXnsgBg/+/Am1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYi5nd0oIT09XyUPi7Ii818TZbuL+v152d/cmWR431S0REOjyDEaJ14zKrbDjm5gp
         AVJtkXWllIMRTKqN5f+WTlqcBXfSM/N61vPRC2XCjClr0CDD8Kl7FCCdqzs1P0UMzK
         2hYVOvIO+7OoKVv3CgLWsJvuYtsdaLQ/lBCKHL48xg3dVBJCIN2jL9+rjlwxhVth+F
         uYjsrJLHRT2aODj+F7uS087TNgaHkRCdIaTXFmhN1ZAUnI8yNoV+C2YJHB68Xu4Tpc
         KBq9n98Y6oGusx7eLPaHn/81li34Hlo84KooOcFaV6ZAIvLQ+/b3tABL33CKm09+iX
         Ms+MJxroLigbA==
Date:   Mon, 26 Jun 2023 18:16:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Manikandan.M@microchip.com
Cc:     Nicolas.Ferre@microchip.com, krzysztof.kozlowski@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Message-ID: <20230626-coping-criteria-e5aa8b2ae212@spud>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
 <a0b059d1-df4d-10ce-fb7c-7acea0a20793@linaro.org>
 <20230613-slider-coherent-d508d67afc91@spud>
 <423eef3c-54f0-5c88-9bc9-82c0198b6da6@microchip.com>
 <3a3f4463-981a-e8d8-8ec4-06f2abfa3b4d@microchip.com>
 <ef09246c-9220-4c71-4ac2-2792d9ca519d@microchip.com>
 <1252fa40-dd8e-73f3-18b7-7010a7f8085e@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1j/2jjguTlX+Xhnw"
Content-Disposition: inline
In-Reply-To: <1252fa40-dd8e-73f3-18b7-7010a7f8085e@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1j/2jjguTlX+Xhnw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 05:31:59AM +0000, Manikandan.M@microchip.com wrote:
> On 21/06/23 13:17, Nicolas Ferre wrote:
> > On 16/06/2023 at 08:44, Manikandan M - I67131 wrote:
> >> On 14/06/23 20:10, Nicolas Ferre wrote:
> >>> On 13/06/2023 at 20:21, Conor Dooley wrote:
> >>>> On Tue, Jun 13, 2023 at 08:17:13PM +0200, Krzysztof Kozlowski wrote:
> >>>>> On 13/06/2023 09:04, Manikandan Muralidharan wrote:
> >>>>>> Add new compatible string for the XLCD controller on SAM9X7 SoC.
> >>>>>>
> >>>>>> Signed-off-by: Manikandan Muralidharan<manikandan.m@microchip.com>
> >>>>>> ---
> >>>>>> =A0=A0 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
> >>>>>> =A0=A0 1 file changed, 1 insertion(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> >>>>>> b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> >>>>>> index 5f8880cc757e..7c77b6bf4adb 100644
> >>>>>> --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> >>>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> >>>>>> @@ -8,6 +8,7 @@ Required properties:
> >>>>>> =A0=A0=A0=A0=A0 "atmel,sama5d3-hlcdc"
> >>>>>> =A0=A0=A0=A0=A0 "atmel,sama5d4-hlcdc"
> >>>>>> =A0=A0=A0=A0=A0 "microchip,sam9x60-hlcdc"
> >>>>>> +=A0=A0 "microchip,sam9x7-xlcdc"
> >>>>> Google says sam9x7 is a series, not a SoC. Please add compatibles f=
or
> >>>>> specific SoCs, not for series.
> >>>> We had this one a few weeks ago, see
> >>>> https://lore.kernel.org/all/add5e49e-8416-ba9f-819a-da944938c05f@mic=
rochip.com/
> >>>> and its parents. Outcome of that seemed to be that using "sam9x7" was
> >>>> fine.
> >>>
> >>> And it's where it begins to be funny, as the LCD is precisely one asp=
ect
> >>> where we differentiate between sam9x75, sam9x72 and sam9x70...
> >>> So please Manikandan sort this out if difference between these chips
> >>> will be better handled with different compatibility string, in
> >>> particular about //, LVDS and MIPI-DSI variants!
> >> Yes Sure, I will replace the compatible as s/sam9x7/sam9x75/g to handle
> >> the different variants of sam9x7 better.
> >=20
> > Moving to sam9x75 is probably good. But what is your plan for=20
> > differentiating parallel and LVDS (on sam9x72) and precisely this=20
> > sam9x75 variant which in addition has MIPI-DSI?
> In sam9x75 with support for LVDS and MIPI, Parallel interfacing=20
> peripherals, the additions performed on the LCD controller driver is the=
=20
> same.Considering the LCDC IP used in sam9x75, there are no registers=20
> sets that needs modification per connecting peripheral variants, only=20
> the clock and DRM_ENCODER_MODE_XXX (set by connecting peripheral driver)=
=20
> differs, which can be handled in DT, atmel-lcdc MFD driver and=20
> peripheral driver.
>=20
> In future, sam9x72 with XLCD controller can be differentiated with=20
> sam9x72 compatible string and with a IP version flag(is_xlcdc_v2) in its=
=20
> driver data if an upgraded XLCD IP is used with difference in bits or=20
> register set exist compared to current IP.

Trying to covert that into what the binding will look like...
sam9x72 & sam9x75 each get their own compatibles for the lcd controller.
=46rom there, we permit `compatible =3D "microchip,sam9x75-foo"` in
isolation. It *sounds* like the basic featureset of the sam9x75 is
compatible with the sam9x72, so for that we permit
`compatible =3D "microchip,sam9x72-foo", "microchip,sam9x75-foo"`.
Although, if the hardware for the sam9x72 isn't set in stone yet, it
might be best to hold off on documenting it until things settle down,
and only add the sam9x75 for now.

Cheers,
Conor.

--1j/2jjguTlX+Xhnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJnH9gAKCRB4tDGHoIJi
0vJeAQCKTNo8DxOHcmMtCltpTrHcnzIsZYChyQOAwNVVzXJhJwEAuZ+yPxkQmRc/
3vViIUv3oFaK8ps5UbhrKrBYzz5BQA4=
=3Eob
-----END PGP SIGNATURE-----

--1j/2jjguTlX+Xhnw--
