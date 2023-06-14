Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE22372FA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjFNKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjFNKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:12:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53EE4A;
        Wed, 14 Jun 2023 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686737522; x=1718273522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uD8/gYwMDSCsMRFNcUWFBwbUbtR8k/3vS7WndAmhn9w=;
  b=Udac43X5jGVAfoW0ahH0WictImDDGpY5mEppdbL7bYMHOIYGIdLrMGyP
   VvLDWojtdwQKsvYmhveS8Po+yrIm/hFd36HCKmcKnFwgsO2U4t9jcanUZ
   jee1DQ7J8CLeHKpr6iL8pZSFfqqjZxEsNs1T8A7xC9QY7uHV/T2N1tDtr
   fSeQG3M7jiVqJ9tPKAa4enysdpstQ/LkW7q8liQtUDPzCuT+oVLaK4eUy
   /7/kHyTQsinKQFC1myVSEP5mkTED0t3CJayF9jX7Tac5+luEaoRmZDuw9
   XGddwSUDzPfW/VClKX8NI2WilZHmJFd4AfXrPilAlN1TDjEarsA5uv8xR
   w==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="asc'?scan'208";a="218425827"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 03:12:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 03:12:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 14 Jun 2023 03:11:56 -0700
Date:   Wed, 14 Jun 2023 11:11:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <sam@ravnborg.org>,
        <bbrezillon@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Message-ID: <20230614-sterling-staff-5c9c03392a2c@wendy>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
 <20230613-scouting-barricade-56cadb14657c@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MxL6TWAcPPWIl+0J"
Content-Disposition: inline
In-Reply-To: <20230613-scouting-barricade-56cadb14657c@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MxL6TWAcPPWIl+0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 07:18:25PM +0100, Conor Dooley wrote:
> On Tue, Jun 13, 2023 at 12:34:18PM +0530, Manikandan Muralidharan wrote:
> > Add new compatible string for the XLCD controller on SAM9X7 SoC.
>=20
> You should probably indicate here why this is not compatible with the
> existing SoCs that are supported. To hazard a guess, it is the HLCDC IP
> (I forget the exact letters!)?

Manikandan pointed out off list that this was not clear.
Looking at it again, I think I actually truncated my sentence - it
should've been something like "it is the HLCDC IP ... is not a subset of
the XLCDC IP." Sorry for that Manikandan.

> If so,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Cheers,
> Conor.
>=20
> >=20
> > Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Do=
cumentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> > index 5f8880cc757e..7c77b6bf4adb 100644
> > --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> > +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >     "atmel,sama5d3-hlcdc"
> >     "atmel,sama5d4-hlcdc"
> >     "microchip,sam9x60-hlcdc"
> > +   "microchip,sam9x7-xlcdc"
> >   - reg: base address and size of the HLCDC device registers.
> >   - clock-names: the name of the 3 clocks requested by the HLCDC device.
> >     Should contain "periph_clk", "sys_clk" and "slow_clk".
> > --=20
> > 2.25.1
> >=20



--MxL6TWAcPPWIl+0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZImSUwAKCRB4tDGHoIJi
0nVyAQDnv7lrFojIn1tU/unzTD77IuY5h3hrvcCGgDe30HmP4QD8D+26ukUo6Woe
6Krnu+i2ZCkcn7QoUXiR9c179UNQ6w8=
=TYyE
-----END PGP SIGNATURE-----

--MxL6TWAcPPWIl+0J--
