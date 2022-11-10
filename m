Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE4624883
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKJRnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKJRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:43:41 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD32D76D;
        Thu, 10 Nov 2022 09:43:38 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 59E57240007;
        Thu, 10 Nov 2022 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668102217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvDrMn2Uu/kHy2JQHhfB4c2SUZYxwuUXOR78mUDTGB0=;
        b=FteiV1EecPiLO/9aQedbolmycxbn9ZZLYDNbM+TZ+/Jq+YC1yWLGYpLt+mZUsFyTZGSYdo
        blXS/hgS0j1CKXUdFiFd3v9FnUdCwgMKrX4GxBuzok+QN8V/boNVhE6DIrx8JYnfTWHQRB
        lKQ34bS7Cu9GVIeqLBYJsQql1RAN3QLmCbhPu3izr0DqMA9I9C3FqHsF4zZv0mGgN3a7/k
        Y91cgpd6PRiLmow40vOvLAj6GYBVWa7vLCWFYjg/Pz87YdAIHTjthSb+TykLP5HZsv/kdB
        kHUJlkk0ZWjS/tG3eJAeIceg9J7GVshq3M0jWZhnQn7Qjs3cL7IoA+lQr3WPCA==
Date:   Thu, 10 Nov 2022 18:43:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: nvmem: add YAML schema for the ONIE
 tlv layout
Message-ID: <20221110184334.1cb531f6@xps-13>
In-Reply-To: <20221110140545.GA221642-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
        <20221104163833.1289857-7-miquel.raynal@bootlin.com>
        <20221110040055.GA3436769-robh@kernel.org>
        <20221110095034.7a80163a@xps-13>
        <20221110140545.GA221642-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Thu, 10 Nov 2022 08:05:45 -0600:

> On Thu, Nov 10, 2022 at 09:50:34AM +0100, Miquel Raynal wrote:
> > Hi Rob,
> >=20
> > robh@kernel.org wrote on Wed, 9 Nov 2022 22:00:55 -0600:
> >  =20
> > > On Fri, Nov 04, 2022 at 05:38:33PM +0100, Miquel Raynal wrote: =20
> > > > Add a schema for the ONIE tlv NVMEM layout that can be found on any=
 ONIE
> > > > compatible networking device.
> > > >=20
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
> > > >  .../nvmem/layouts/onie,tlv-layout.yaml        | 115 ++++++++++++++=
++++
> > > >  2 files changed, 116 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts=
/onie,tlv-layout.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-=
layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.=
yaml
> > > > index f64ea2fa362d..8512ee538c4c 100644
> > > > --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.=
yaml
> > > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.=
yaml
> > > > @@ -19,6 +19,7 @@ description: |
> > > > =20
> > > >  oneOf:
> > > >    - $ref: kontron,sl28-vpd.yaml
> > > > +  - $ref: onie,tlv-layout.yaml
> > > > =20
> > > >  properties:
> > > >    compatible: true
> > > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,t=
lv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-l=
ayout.yaml
> > > > new file mode 100644
> > > > index 000000000000..1d91277324ac
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layo=
ut.yaml
> > > > @@ -0,0 +1,115 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/nvmem/layouts/onie,tlv-layout.y=
aml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: NVMEM layout of the ONIE tlv table
> > > > +
> > > > +maintainers:
> > > > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > > > +
> > > > +description:
> > > > +  Modern networking hardware implementing the Open Compute Project=
 ONIE
> > > > +  infrastructure shall provide a non-volatile memory with a table =
whose the
> > > > +  content is well specified and gives many information about the m=
anufacturer
> > > > +  (name, country of manufacture, etc) as well as device caracteris=
tics (serial
> > > > +  number, hardware version, mac addresses, etc). The underlaying d=
evice type
> > > > +  (flash, EEPROM,...) is not specified. The exact location of each=
 value is also
> > > > +  dynamic and should be discovered at run time because it depends =
on the
> > > > +  parameters the manufacturer decided to embed.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: onie,tlv-layout
> > > > +
> > > > +  product-name: true   =20
> > >=20
> > > This is a node? If so, you need:
> > >=20
> > > type: object
> > > additionalProperties: false =20
> >=20
> > I thought referencing a schema under a property would be enough?
> >=20
> > Indeed in nvmem.yaml we create the property nvmem-layout and make it
> > reference nvmem-layout.yaml. Then, in nvmem-layout.yaml:
> >=20
> > 	 oneOf:
> > 	  - $ref: kontron,sl28-vpd.yaml
> > 	  - $ref: onie,tlv-layout.yaml
> >=20
> > we reference the different layouts that may apply (very much like what
> > you proposed to list the mtd partition parsers, if I got it right).
> >=20
> > Isn't it enough? =20
>=20
> No. It is enough to allow the property, but nothing defines what it must=
=20
> be (a node) and what the node contains in the case of empty nodes. Try=20
> adding 'product-name =3D "foo";' and it won't warn.

There was a misunderstanding on my side. I thought your comment was
about the nvmem-layout node. Actually you were commenting about all the
sub-nodes defining nvmem-cells inside, so I'm fully aligned with your
response.

However, if I understood it correctly, you basically said that:

	property:
	  $ref: foo.yaml

is not the same as:

	property:
	  type: object
	  $ref: foo.yaml

If that's the case, then should we consider dropping this patch (which
you agreed with in the first place)?

https://lore.kernel.org/linux-mtd/20221104164718.1290859-17-miquel.raynal@b=
ootlin.com/T/#u=20

Thanks,
Miqu=C3=A8l
