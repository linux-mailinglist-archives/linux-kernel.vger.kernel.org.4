Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A009A60F9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiJ0Nuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiJ0Nuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:50:40 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A7F7AC11;
        Thu, 27 Oct 2022 06:50:30 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DB8920009;
        Thu, 27 Oct 2022 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666878629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UG3WwlOVChAnpFDe0xeg3U7NggvKxaTr383RmAux4Y=;
        b=U84VQ7GLpcOkquHAJlNEadSl8VjGxoB0v5YyKNQUvWLwbwTOB/5Su2wXJDhXL654Zc4QH4
        afJzb2R8U5dPRLH235p9dMt00CR0RovkE42TemSA8FoDPn4psoYSGAVmZgk5uNrWYrCTJO
        Rm9q5Dvk70SE3aInhLeI7VV5IjWPRzqkqRVbet88bsz2mIAuIKY42JvmXQtWrzB1wQp2Uj
        rOcnbFVUzgPoLg/4sChvPLTKgd+JBhunoGl8/Jro8NldDUyIdQ2GqzfwTYX63jsywnmOt6
        5Z6vVIUkRpP891tqAZPQqakC9IxkayES/nt4zYpdFtqomYB8O0mgL6E9/S1nmA==
Date:   Thu, 27 Oct 2022 15:50:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20221027155025.7c04774a@xps-13>
In-Reply-To: <e937b059-4168-3bd4-b294-cbfff0519d1f@linaro.org>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
        <20221026134545.7146-2-vadym.kochan@plvision.eu>
        <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
        <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <10581088-e4ff-76db-3c9b-42a7a9c118ee@linaro.org>
        <20221027151825.166a9255@xps-13>
        <e937b059-4168-3bd4-b294-cbfff0519d1f@linaro.org>
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

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 09:24:24 -0400:

> On 27/10/2022 09:18, Miquel Raynal wrote:
> > Hi Vadym,
> >  =20
> >>>>> +patternProperties:
> >>>>> +  "^nand@[0-3]$":
> >>>>> +    type: object
> >>>>> +    properties:
> >>>>> +      reg:
> >>>>> +        minimum: 0
> >>>>> +        maximum: 3
> >>>>> +
> >>>>> +      nand-rb:
> >>>>> +        minimum: 0
> >>>>> +        maximum: 1
> >>>>> +
> >>>>> +      nand-ecc-strength:
> >>>>> +        enum: [1, 4, 8]
> >>>>> +
> >>>>> +      nand-on-flash-bbt: true
> >>>>> +
> >>>>> +      nand-ecc-mode: true
> >>>>> +
> >>>>> +      nand-ecc-algo:
> >>>>> +        description: |
> >>>>> +          This property is essentially useful when not using hardw=
are ECC.
> >>>>> +          Howerver, it may be added when using hardware ECC for cl=
arification
> >>>>> +          but will be ignored by the driver because ECC mode is ch=
osen depending
> >>>>> +          on the page size and the strength required by the NAND c=
hip.
> >>>>> +          This value may be overwritten with nand-ecc-strength pro=
perty.
> >>>>> +
> >>>>> +      nand-ecc-step-size:
> >>>>> +        description: |
> >>>>> +          Marvell's NAND flash controller does use fixed strength
> >>>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step =
size
> >>>>> +          will shrink or grow in order to fit the required strengt=
h.
> >>>>> +          Step sizes are not completely random for all and follow =
certain
> >>>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
> >>>>> +
> >>>>> +      label:
> >>>>> +        $ref: /schemas/types.yaml#/definitions/string
> >>>>> +
> >>>>> +      partitions:
> >>>>> +        type: object   =20
> >>>>
> >>>> That's not what I asked for. Like four times I asked you to add here
> >>>> unevaluatedProperties: false and I never said that ref to partition.=
yaml
> >>>> should be removed and you... instead remove that ref.
> >>>>
> >>>> You need to define here children and specify their ref.
> >>>>
> >>>> You must use unevaluatedProperties: false here. So this is fifth tim=
e I
> >>>> am writing this feedback.
> >>>>
> >>>>   =20
> >>>
> >>> It is a bit confusing that it is needed to define "partitions" and "l=
abel" rules particulary
> >>> in this nand controller instead of some common place like nand-chip.y=
aml, these properties
> >>> are common also for the other nand controllers.   =20
> >>
> >> No one speaks about label, I never commented about label, I think...
> >>
> >> If you think the property is really generic and every NAND controller
> >> bindings implement it, then feel free to include them there, in a
> >> separate patch. It sounds sensible, but I did not check other bindings=
. =20
> >=20
> > FYI, label is already defined in mtd/mtd.yaml. =20
>=20
> Which is not included here and in nand-controller.yaml

Maybe nand-chip.yaml should?

> > Partitions do not need to be defined in your binding, just don't put
> > any in your example and you'll be fine. These partitions are either
> > static and may be described in the DT (see
> > mtd/partition/partition.yaml) or there is some dynamic discovery
> > involved and a proper parser shall be referenced (parsers have their
> > own binding). =20
>=20
> I don't think this is correct. Basically you allow any node to be under
> partitions as there is no schema validating them (without compatibles).

Sorry if that was unclear, what I meant is: partitions should not be
defined in the bindings for Marvell NAND controller because they should
be defined somewhere else already.

NAND controller subnodes should define the storage devices (the
flashes themselves) connected to the controller. "nand-chip.yaml"
describes generic properties for these. Additional subnodes are allowed
and expected to be partitions (this is not enforced anywhere I think),
they should use one of the existing compatibles to define the parser.
The most common parser is named fixed-partitions and has its own
compatible. Every parser references partitions.yaml.

There are a few controller bindings however which reference
partition.yaml anyway, probably to make the examples validation work,
I'm not sure it should be done like that though:
https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/bindi=
ngs/mtd/ti,gpmc-nand.yaml
https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/bindi=
ngs/mtd/ti,gpmc-onenand.yaml

Thanks,
Miqu=C3=A8l
