Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7435F736491
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFTHbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTHbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:31:17 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945FE4D;
        Tue, 20 Jun 2023 00:30:56 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 379B75EDBD;
        Tue, 20 Jun 2023 10:30:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pUbQt2qDVKo0-eL4OdmlW;
        Tue, 20 Jun 2023 10:30:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1687246253;
        bh=3rtRPYT14HBdyVacf+D4l8FmRddXv2uGiiB1drmivrY=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=n1eSasTp6ajRtQvhnqv+1Y30fetreVfCGaUbhe/ONKZruw5nR7lYLfj65my4PUj+5
         IZvD+PJ7iQ3899jqYpUbdsJXAhi09TfZfIIxC6b/ByuAPe1cnvC7d1I0PTvZag9iIB
         Bsyp5Bq6nr4OPZW4a54OFVGbAum1HQMsQTITJu9I=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <e6c68580df0bb8441bf5beabfa978bfe15e0a39d.camel@maquefel.me>
Subject: Re: [PATCH v1 29/43] dt-bindings: rtc: Add ST M48T86
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Jun 2023 10:30:54 +0300
In-Reply-To: <a2b286a5-32c1-213d-49df-129f2d94d771@linaro.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601054549.10843-11-nikita.shubin@maquefel.me>
         <a2b286a5-32c1-213d-49df-129f2d94d771@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof!

On Thu, 2023-06-01 at 10:18 +0200, Krzysztof Kozlowski wrote:
> On 01/06/2023 07:45, Nikita Shubin wrote:
> > Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >=20
> > Notes:
> > =C2=A0=C2=A0=C2=A0 v0 -> v1:
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 - s/dallas/st/
> > =C2=A0=C2=A0=C2=A0 - description for regs
> > =C2=A0=C2=A0=C2=A0 - s/additionalProperties/unevaluatedProperties/
> > =C2=A0=C2=A0=C2=A0 - add ref rtc.yaml
> > =C2=A0=C2=A0=C2=A0 - changed compatible to st,m48t86
> > =C2=A0=C2=A0=C2=A0 - dropped label in example
> > =C2=A0=C2=A0=C2=A0 - replaced Alessandro Alessandro to Alexandre Bellon=
i
> >=20
> > =C2=A0.../bindings/rtc/st,m48t86-rtc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 38
> > +++++++++++++++++++
> > =C2=A01 file changed, 38 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/st,m48t86-
> > rtc.yaml b/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml
> > new file mode 100644
> > index 000000000000..eb8e6451d7c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml
>=20
> Filename based on compatible, so drop "rtc".
>=20
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/st,m48t86-rtc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ST M48T86 / Dallas DS12887 RTC wirh SRAM
>=20
> typo: with
>=20
> > +
> > +maintainers:
> > +=C2=A0 - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - st,m48t86
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: index register
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: data register
> > +
> > +allOf:
> > +=C2=A0 - $ref: rtc.yaml
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
>=20
> required goes after properties:
>=20
> Keep the same order in all your patches.
>=20
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 rtc@10800000 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "st,m48t86";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x10800000 0x1>, <0x11700000 0=
x1>;
>=20
> One byte long? Not a word?

They are indeed one byte long:

https://elixir.bootlin.com/linux/v6.4-rc7/source/drivers/rtc/rtc-m48t86.c#L=
46

>=20
> > +=C2=A0=C2=A0=C2=A0 };
> > +
> > +...
>=20
> Best regards,
> Krzysztof
>=20

