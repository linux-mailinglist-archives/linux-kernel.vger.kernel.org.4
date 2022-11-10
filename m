Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35365624875
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKJRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiKJRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:39:02 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED01C41C;
        Thu, 10 Nov 2022 09:38:59 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DCCEDFF803;
        Thu, 10 Nov 2022 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668101938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taYCXNFd+UiIpmW+eb3Zv5Y5gg+95S3hG+y0f/PVm30=;
        b=SeZZmHT+1ssN7wFu8Mkj9HXnbwJ7K5E/H6QeEtmceca6C/QeRVuYi4DZXxFk2cWek0d9m5
        ReKoUbroGhCYQwUZeTXZTHQqrxeyxQVgRgugqG+NtuBN35VLaRWjaOw53va2RNFi9K4tG8
        sggqYR9eWBQ+0eLtGYU2g6t82Dki7yxL/mBNcEDNE4ep87vTNglFqhHNFQ2ueAMiku0+yW
        THu5WDRMD88lW2OmfT4W3WP4hYcwKPblvfXk9q/Du36rpbt/Scn6vNmAZxMu6JmOHnTeY9
        NUVJXzpCIu5Cs6psieyMktxnxPehudcG/O0JAfUMmg0atJvmdq+BPMVniPb7+g==
Date:   Thu, 10 Nov 2022 18:38:55 +0100
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
Subject: Re: [PATCH v3 4/6] dt-bindings: nvmem: add YAML schema for the sl28
 vpd layout
Message-ID: <20221110183855.05ced2a0@xps-13>
In-Reply-To: <20221110134918.GB3436769-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-5-miquel.raynal@bootlin.com>
 <20221110134918.GB3436769-robh@kernel.org>
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

robh@kernel.org wrote on Thu, 10 Nov 2022 07:49:18 -0600:

> On Fri, Nov 04, 2022 at 05:38:31PM +0100, Miquel Raynal wrote:
> > From: Michael Walle <michael@walle.cc>
> >=20
> > Add a schema for the NVMEM layout on Kontron's sl28 boards.
> >=20
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../nvmem/layouts/kontron,sl28-vpd.yaml       | 60 +++++++++++++++++++
> >  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
> >  2 files changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kon=
tron,sl28-vpd.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl=
28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-=
vpd.yaml
> > new file mode 100644
> > index 000000000000..44088c8b4153
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.=
yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
> > +
> > +maintainers:
> > +  - Michael Walle <michael@walle.cc>
> > +
> > +description:
> > +  The vital product data (VPD) of the sl28 boards contains a serial
> > +  number and a base MAC address. The actual MAC addresses for the
> > +  on-board ethernet devices are derived from this base MAC address by
> > +  adding an offset.
> > +
> > +properties:
> > +  compatible:
> > +    const: kontron,sl28-vpd
> > +
> > +  serial-number:
> > +    type: object
> > +    description: The board's serial number
> > +
> > +  base-mac-address:
> > +    type: object
> > +    description:
> > +      Base MAC address for all on-module network interfaces. The first
> > +      argument of the phandle will be treated as an offset.
> > +
> > +    properties:
> > +      "#nvmem-cell-cells":
> > +        const: 1
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +      otp-1 {
> > +          compatible =3D "user-otp";
> > +
> > +          nvmem-layout {
> > +              compatible =3D "kontron,sl28-vpd";
> > +
> > +              serial_number: serial-number {
> > +              };
> > +
> > +              base_mac_address: base-mac-address {
> > +                  #nvmem-cell-cells =3D <1>;
> > +              };
> > +          };
> > +      };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layo=
ut.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > index ecc7c37cbc1f..f64ea2fa362d 100644
> > --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > @@ -17,6 +17,9 @@ description: |
> >    define and might require dynamic reading of the NVMEM device in orde=
r to
> >    perform their parsing. The nvmem-layout container is here to describ=
e these.
> > =20
> > +oneOf:
> > +  - $ref: kontron,sl28-vpd.yaml =20
>=20
> This is the other way around from how we normally structure things.=20
> Normally, the specific schema would reference the common/base schema.=20
> This works, though you will be applying the schema twice. Once here and=20
> then by matching on compatible string. Not a big deal as that happens=20
> fairly often, but a 'select: false' in kontron,sl28-vpd.yaml would=20
> prevent that. This way does more to enforce the overall structure of=20
> nodes.

Oh right, I knew about the "select: false" thing, but I forgot it in
the two layouts.

> The one downside I see with it this way is nvmem-layout can't ever have=20
> common properties defined without listing them in each layout schema.

Oh that's right, actually I solved it in the mtd dt-binding series with:

partitions.yaml:

	oneOf:
	  - $ref: <parser>.yaml

	generic-property:
	  $ref: something
	  min/max...: foo

<parser>.yaml:
	generic-property: true

But in this case, are the constraints provided by partitions.yaml on
"generic-property" actually still enforced?

Thanks,
Miqu=C3=A8l
