Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8D744217
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjF3SV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjF3SV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D3BD;
        Fri, 30 Jun 2023 11:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A36617DF;
        Fri, 30 Jun 2023 18:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D34C433C8;
        Fri, 30 Jun 2023 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688149315;
        bh=sM46dcengp7YkqfFo0VJUNN08NUrJCfycUaS2/3Woo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odJQMvmZ0rqdXgLbMO87OefdaC4QW3lgA/RWvCb/rfwsahLGiH1t1dFswomLcQIru
         Z0hBWjgnZ4rt6sPNx3V8LxMtVy2Ea0AYR17S54qnwtCXCduR8Vzmj3bxKwY4gSOjLg
         YNB3P8zD9A7gOORxtd68UVGihekQbl0Qh1aZHXURJ6emhf1E/qigeW/mxttRgdfrea
         81V/O4GOJsty2zQALa/JSvuUCVsywnp+AlWB2/P0nJVbaXJDR4gbWY18dY+vQt7y31
         CWmuZQJZ2wMA7ugKXOyZTsgUClPKgyj4vM9CKlxoKsGdRtmB2cZWsHbayTW4kJZOqU
         tgUTP5fwxGz2Q==
Date:   Fri, 30 Jun 2023 19:21:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Message-ID: <20230630-trowel-pleat-5312a869dda2@spud>
References: <20230629054523.7519-1-stanley_chang@realtek.com>
 <20230629054523.7519-4-stanley_chang@realtek.com>
 <20230629164220.GA3146341-robh@kernel.org>
 <f17378f003144f4ba50ec08e0ad38c0b@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aEhlxy1fUgPMd5+/"
Content-Disposition: inline
In-Reply-To: <f17378f003144f4ba50ec08e0ad38c0b@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aEhlxy1fUgPMd5+/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 07:33:45AM +0000, Stanley Chang[=E6=98=8C=E8=82=B2=
=E5=BE=B7] wrote:
> Hi Rob,
>=20
> > On Thu, Jun 29, 2023 at 01:45:12PM +0800, Stanley Chang wrote:
> > > Add the documentation explain the property about Realtek USB PHY driv=
er.
> >=20
> > In the subject, drop "the doc about the". It's redundant. And perhaps a=
dd 'DHC
> > RTD SoC' if this isn't for *all* Realtek SoCs.
> >=20
> > > Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> > > controller. Added the driver to drive the USB 2.0 PHY transceivers.
> >=20
> > driver? This is a binding for the h/w.
>=20
> I mean, the driver is drivers/phy/realtek/phy-rtk-usb2.c
> I will revise as
>     dt-bindings: phy: realtek: Add the Realtek DHC RTD SoC USB 2.0 PHY
>=20
>     Add the documentation explain the property about Realtek USB PHY driv=
er.
>=20
>     Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
>     controller and uses phy-rtk-usb2 as driver for USB 2.0 PHY transceive=
r..

No, you should mention nothing to do with how a particular operating
system chooses to structure its code here. Bindings describe hardware,
and the commit message should reflect that.

>=20
> > > +$id: http://devicetree.org/schemas/phy/realtek,usb2phy.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Realtek DHC SoCs USB 2.0 PHY
> > > +
> > > +maintainers:
> > > +  - Stanley Chang <stanley_chang@realtek.com>
> > > +
> > > +description:
> >=20
> > You need '|' if formatting (line breaks) are important.
>=20
> I think I need it. I will add it.
>=20
> > > +  realtek,inverse-hstx-sync-clock:
> > > +    description:
> > > +      For one of the phys of RTD1619b SoC, the synchronous clock of =
the
> > > +      high-speed tx must be inverted.
> >=20
> > "invert" assumes I know what non-inverted means. I do not. Better to st=
ate in
> > terms of active high, low, falling edge, rising edge, etc.
>=20
> Meaning, the clock must be reversed.

Maybe that means something to Rob, but "reversed" doesn't seem any more
meaningful than inverse. I agree that it should be described in terms of
"active high" etc, as they have well understood meanings.

> > > +    type: boolean
> > > +
> > > +  realtek,driving-level:
> > > +    description:
> > > +      Control the magnitude of High speed Dp/Dm output swing.
> > > +      For a different board or port, the original magnitude maybe not
> > meet
> > > +      the specification. In this situation we can adjust the value t=
o meet
> > > +      the specification.
> >=20
> > What are the units?
>=20
> There is no unit. It is only a gain for adjusting the magnitude.

Gain has units too.

> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    default: 8
> > > +    minimum: 0
> > > +    maximum: 31
> > > +
> > > +  realtek,driving-compensate:
> >=20
> > compensate what?
>=20
> It is to compensate the driving level.

Should it be called "driving-level-compensate" then?

> In other word, to adjust the driving level.

So, "realtek,driving-level" sets the gain and
"realtek,driving-compensate" adjusts the driving level.
By that logic, is this also a gain?

Also this property is only for the RTD1315e? That should be
described in/constrained by the binding itself, not in the text
description alone IMO.


--aEhlxy1fUgPMd5+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8dPQAKCRB4tDGHoIJi
0lmUAP45sQ9AK7ogaqK+eH+Y4Gn7Emg+7aM7bHUQwQztSG0w/AD/ZtzuQIET/Qsw
9vk5lYfiSF8wdLIPvZ1gQ5IVcpEEHAM=
=Acbb
-----END PGP SIGNATURE-----

--aEhlxy1fUgPMd5+/--
