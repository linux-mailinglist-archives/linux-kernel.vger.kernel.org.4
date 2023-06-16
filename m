Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9A732A24
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbjFPIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjFPIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:44:09 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81A2D79;
        Fri, 16 Jun 2023 01:44:05 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686905044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=124xCR73FJ7My9bUcYqnyZtkRBH/lUy5drQixPZ+QjI=;
        b=dCZABiwoUuGPAgpnhhcFhWhfm2UmADaqppObF3tQyWgbT2m7C6UrA8VZy5IN9GJ8/Ym67M
        b1eJaMQBaTKSUIMnFnAWpAmqH4t6WqZXsPidzUx5nBGwVATHF9TQWNZz5OgUGiTNkHa615
        MNo0ba7YmnaW/rhDYtTNse0K3k9ObZKY7ckjm7XpAW42rzreBR2SSsxpQiExTGtbDJbyOX
        Of+UP+5MYlP2Pp/DO8KEjC/0r+2ayKg4qLmpF4jsPlscRvOgyoZ7mnh/QGD7K6Yw9Gxb6R
        pnQb+At8OL6MkMe9/iwgzFUpSK5noRNyUbzH3K6pPBwJeqKu/ClNixEyI9FFxw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B13D1BF203;
        Fri, 16 Jun 2023 08:44:01 +0000 (UTC)
Date:   Fri, 16 Jun 2023 10:44:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v9 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20230616104401.5ca2b4de@xps-13>
In-Reply-To: <29a9f4a4-b205-d341-bc34-10829af2996a@linaro.org>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
        <20230615040447.3484564-4-chris.packham@alliedtelesis.co.nz>
        <f16e742f-e6f2-9761-e70d-e0e7cadcba4a@linaro.org>
        <1863cd53-9846-def2-ee5f-f4a51160ed8d@alliedtelesis.co.nz>
        <781c1db2-ecca-901a-4e11-7f7c68cf744d@linaro.org>
        <20230616102414.222dde21@xps-13>
        <29a9f4a4-b205-d341-bc34-10829af2996a@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Fri, 16 Jun 2023 10:38:38 +0200:

> On 16/06/2023 10:24, Miquel Raynal wrote:
> > Hi Krzysztof,
> >=20
> > krzysztof.kozlowski@linaro.org wrote on Fri, 16 Jun 2023 10:15:31 +0200:
> >  =20
> >> On 15/06/2023 23:06, Chris Packham wrote: =20
> >>>>   =20
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    oneOf:
> >>>>> +      - items:
> >>>>> +          - const: marvell,armada-8k-nand-controller
> >>>>> +          - const: marvell,armada370-nand-controller
> >>>>> +      - enum:
> >>>>> +          - marvell,armada-8k-nand-controller   =20
> >>>> This is wrong. 8k cannot be both: compatible and not compatible with
> >>>> 370. It's not someone's cat to be in both states at the same time...=
   =20
> >>>
> >>> The correct state (IMHO, Miquel correct me if I'm wrong) is `compatib=
le=20
> >>> =3D "marvell,armada-8k-nand-controller";`=C2=A0 as there are some 8K =
specific=20
> >>> requirements that aren't present on the 370 (specifically the=20
> >>> system-controller and the 2nd clock).    =20
> >>
> >> Presence of specific requirements does not invalidate compatibility. T=
wo
> >> devices are compatible if the 8k can bind and work with 370 compatible
> >> string, even if this means some lower performance or less features (e.=
g.
> >> subset of features). =20
> >=20
> > Quoting myself from 2019 (comment in the driver):
> > "Some SoCs like A7k/A8k need to enable manually the NAND controller,
> > gated clocks and reset bits to avoid being bootloader dependent."
> >=20
> > So can the 8k controller work using a 370 compatible : yes, if the
> > booloader enabled the NAND controller already, no otherwise. But in
> > practice it is the same controller.
> >=20
> > Given this information I don't know whether it makes sense to qualify
> > the 8k controller compatible with the 370 compatible or not. =20
>=20
> Indeed, a bit tricky decision. For me they could stay compatible,
> because apparently programming model is the same or similar.

Agreed, the programming model wrt the controller itself is the same. So
we will expect 8k controllers to be described with both 8k and 370
compatible strings then.

Thanks for your feedback.

Cheers,
Miqu=C3=A8l
