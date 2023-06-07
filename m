Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975E725AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjFGJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjFGJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:36:29 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFC1BE8;
        Wed,  7 Jun 2023 02:36:09 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686130568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHbDoPntY8rQli1Ts2fRuiAoXXD0B+JipbbpnA9vAgs=;
        b=eGQ0NF915O7i6T9mpLNfb9/1dCJ1f5hmxGuZY4UbmVa7sRZxXLsTZ0IY2OAb0Xya0sW4Bw
        fdxadbzR4sNDPT+WXTwCV95HjAqA5pVZoKO/PbQiddvHIlype5TqN2Aeh0UKdgvG23l70A
        SUOVHBz9fz+IDbyGPXPHiphK2KoTUbmUa4zBJA3Z1TWxlq2gjfTF24CsgU2yop6Ay0VBo2
        KrD1jAJjv+2nlYkY86ds4muSAzHsSZ7AuCvGt+BlsPDFYoceJVSbrCzJmrqT2xlciThgQZ
        1hmdVmsEJu+ab3BTfWsMVH8NLEwJSHoUP0ug9pP+tZ85SKqdqsRicafpRZaV7w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBD1CC0011;
        Wed,  7 Jun 2023 09:36:06 +0000 (UTC)
Date:   Wed, 7 Jun 2023 11:36:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Message-ID: <20230607113605.50a992bb@xps-13>
In-Reply-To: <5ca9eb2b-4bc8-5883-a029-3eeca905fe6e@sberdevices.ru>
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
        <20230607095802.3adcd4f9@xps-13>
        <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
        <08da4e86-433a-7d2e-25ff-ffa24221abdf@linaro.org>
        <835a3587-1e0f-64d7-1d1a-b639ae8b7307@sberdevices.ru>
        <2ca6e619-1d57-8fff-6176-9ee890e0d167@linaro.org>
        <5ca9eb2b-4bc8-5883-a029-3eeca905fe6e@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Wed, 7 Jun 2023 12:04:29 +0300:

> On 07.06.2023 12:08, Krzysztof Kozlowski wrote:
> > On 07/06/2023 10:57, Arseniy Krasnov wrote: =20
> >>
> >>
> >> On 07.06.2023 11:53, Krzysztof Kozlowski wrote: =20
> >>> On 07/06/2023 10:40, Arseniy Krasnov wrote: =20
> >>>> Hello Miquel,=20
> >>>>
> >>>> On 07.06.2023 10:58, Miquel Raynal wrote:
> >>>> =20
> >>>>> Hi Arseniy,
> >>>>>
> >>>>> AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:
> >>>>> =20
> >>>>>> Add description of 'nand-rb' property. Use "Fixes" because this pr=
operty
> >>>>>> must be supported since the beginning. For this controller 'nand-r=
b' is
> >>>>>> stored in the controller node (not in chip), because it has only s=
ingle
> >>>>>> r/b wire for all chips. =20
> >>>>>
> >>>>> Sorry if I mislead you in the first place, but you could definitely
> >>>>> have two chips and only one with RB wired. It needs to be defined in
> >>>>> the chips. =20
> >>>>
> >>>> Ok, so to clarify: is it ok, that in bindings this property will be =
placed in the
> >>>> chip, but in driver, i'm trying to read it from the controller node =
(thus  in
> >>>> dts file it will be also in controller node)? =20

The bindings and your driver internal representation are two different
things. Anyway, as mentioned above, wiring the RB line to one die and
not the other would be valid hardware design and would require the rb
property to be in the chip node. Please perform a per-chip property read
in the driver as well.

> >>>
> >>> No, because how would your DTS pass validation? I understand you did =
not
> >>> test the bindings, but this will improve, right? =20
> >>
> >> Ok, i'll follow DTS layout in the driver, "test the bindings" You mean=
 "make dt_binding_check"? =20
> >=20
> > Yes. They were sent without testing.
> >=20
> > But please also test your DTS with dtbs_check. =20
>=20
> Got it!
>=20
> Thanks, Arseniy
>=20
> >=20
> >=20
> > Best regards,
> > Krzysztof
> >  =20


Thanks,
Miqu=C3=A8l
