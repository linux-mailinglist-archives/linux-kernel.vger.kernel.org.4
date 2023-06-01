Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC371949C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjFAHou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFAHmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:42:37 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0053010CA;
        Thu,  1 Jun 2023 00:40:15 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685605214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCdgs2ZY0Qmc8wOXyCbJFq17brRZ1eICKOVPf7KfY74=;
        b=GhliR3CFcGqyKvO9Be0KLUU18LziFPSA3gWRYzfkfkxTtoRGNRQQ9KiITjQUd9LNCvf/bN
        dLWtSU271I3ei3B9VjvDY4DngI2pg+yMFY7sBSksuAP5kr/HRolrc8Cp1j47Qv+JgKqEg0
        M57yjvo2UM4Mu6prfeHwEoAmy9+Geg9mfpXrlmf2CRxqS88Ejxe7szZFnJzYWGhwKdyyWn
        dQBAVgHBaosZQrQenv/x+9h58ExbFku8HfMjN3l7cX4sdwAOeQc19VLjXlWeYaej0O01pj
        NrbkRjziy6ZjKCPkwFgtiY5aWt/j9GjtXWU0kQoolKCVQp/HPw8UfTKVLh8J3g==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61260C0004;
        Thu,  1 Jun 2023 07:40:10 +0000 (UTC)
Date:   Thu, 1 Jun 2023 09:40:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v7 3/4] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20230601094009.1eca5dbb@xps-13>
In-Reply-To: <40bb4ad8-2bec-4eae-d0c8-c9aa31e03f32@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
        <20230530235456.1009082-4-chris.packham@alliedtelesis.co.nz>
        <40bb4ad8-2bec-4eae-d0c8-c9aa31e03f32@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Wed, 31 May 2023 22:43:46
+0000:

> Hi Miquel,
>=20
> On 31/05/23 11:54, Chris Packham wrote:
> > From: Vadym Kochan <vadym.kochan@plvision.eu>
> >
> > Switch the DT binding to a YAML schema to enable the DT validation.
> >
> > Dropped deprecated compatibles and properties described in txt file.
> >
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > --- =20
> <snip>
> > diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-control=
ler.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.ya=
ml
> > new file mode 100644
> > index 000000000000..7cd4a2e99343
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > @@ -0,0 +1,221 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell NAND Flash Controller (NFC)
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: marvell,armada-8k-nand-controller
> > +          - const: marvell,armada370-nand-controller =20
>=20
> On this specific point. Was your intention to allow just the=20
> "marvell,armada-8k-nand-controller" compatible?
>=20
> I made it a list as the existing usage is `compatible =3D=20
> "marvell,armada-8k-nand-controller",=20
> "marvell,armada370-nand-controller";` but an earlier comment you made=20
> suggested that your intention was to allow just the 8k compatible on=20
> it's own.

To be honest I don't recall. Sometimes it's best to consider a version
of a controller to be a superset of another, in this case both
compatibles are welcome. I suggest you keep the description as it is.

> Looking at the driver it doesn't do any is_compatible() checks=20
> so I don't think it cares (currently).
>=20
> > +      - enum:
> > +          - marvell,armada370-nand-controller
> > +          - marvell,pxa3xx-nand-controller
> > +          - marvell,armada-8k-nand
> > +          - marvell,armada370-nand
> > +          - marvell,pxa3xx-nand
> >  =20


Thanks,
Miqu=C3=A8l
