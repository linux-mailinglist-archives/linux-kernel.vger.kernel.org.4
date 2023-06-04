Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE272188D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjFDQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjFDQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:24:48 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A38B3;
        Sun,  4 Jun 2023 09:24:47 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2a06:0:640:53c4:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 3F87E5E8D2;
        Sun,  4 Jun 2023 19:24:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id iOUqx9kDcSw0-8qWdlqKb;
        Sun, 04 Jun 2023 19:24:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685895884;
        bh=+1ttS7pErZll0H0q/8Tb8XEtJl7bmBgeGkj1iSaH4eU=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=kMEgW+pB3bU6FxlMumd+nRHDMIqB9uhwGiK4+nrpHI1uErZmL4aBjIz1snJ+3seju
         0KDjJAyiID4XmRv5awaMBgJw6khQc/w5rTDhO5utxAMx5a9tP5oajQkxbkZnHOqIi0
         z6pn9S7vzoLsMJsrYYvZNpgXvtbV4+DyJuYAW9Ek=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <3df4489939a5285f1e9d923d43bf0e656750a74d.camel@maquefel.me>
Subject: Re: [PATCH v1 25/43] dt-bindings: ata: Add Cirrus EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 04 Jun 2023 22:24:45 +0300
In-Reply-To: <fe8bfbfc-0ce5-d4ea-a2a8-8608fe4e2f97@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601054549.10843-7-nikita.shubin@maquefel.me>
         <fe8bfbfc-0ce5-d4ea-a2a8-8608fe4e2f97@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Damien!

On Fri, 2023-06-02 at 08:57 +0900, Damien Le Moal wrote:
> On 6/1/23 14:45, Nikita Shubin wrote:
> > Add YAML bindings for ep93xx SoC PATA.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >=20
> > Notes:
> > =C2=A0=C2=A0=C2=A0 v0 -> v1:
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 - renamed file to ep9312-pata
>=20
> Looks OK to me but given that this is both for the cirrus,ep9315-pata
> and
> cirrus,ep9312-pata, wouldn't it be better to name the file
> cirrus,ep931x-pata.yaml ?

I was advised against using wildcards by Arnd and Krzysztof.

See=C2=A0
https://lore.kernel.org/all/c981e048-8925-deba-6916-9199844976b9@linaro.org=
/

As i understood we should have at least one fallback, in out case it's
"cirrus,ep9312-pata" and one for each SoC variant that supports it.

All other comments acknowledged and agreed.

I will also change=20

```
>> +	if (!drv_data)
>> +		return -ENXIO;
```

To ENOMEM, as a part of dt conversion patch in v2.


>=20
>=20
> > =C2=A0=C2=A0=C2=A0 - changed email to dlemoal@kernel.org
> > =C2=A0=C2=A0=C2=A0 - dropped label
> > =C2=A0=C2=A0=C2=A0 - fixed ident
> >=20
> > =C2=A0.../bindings/ata/cirrus,ep9312-pata.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 44
> > +++++++++++++++++++
> > =C2=A01 file changed, 44 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep9312-
> > pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep9312-
> > pata.yaml
> > new file mode 100644
> > index 000000000000..3489be55a6fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/cirrus,ep9312-pata.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic EP9312 PATA controller
> > +
> > +maintainers:
> > +=C2=A0 - Damien Le Moal <dlemoal@kernel.org>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: cirrus,ep9312-pata
>=20
> I am not a DT specialist, but isn't this line superfluous since it is
> listed in
> the items ?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: cirrus=
,ep9315-pata
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: cirrus=
,ep9312-pata
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 ide@800a0000 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "cirrus,ep9312-pata";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x800a0000 0x38>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&vic1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <8>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&ide_default_pins>;
> > +=C2=A0=C2=A0=C2=A0 };
> > +
> > +...
>=20

