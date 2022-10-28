Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21556610B83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJ1Hrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJ1Hrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:47:46 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112A6FA28;
        Fri, 28 Oct 2022 00:47:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 74201E0010;
        Fri, 28 Oct 2022 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666943263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLXC0cwAmDt5KBT+Al/vAYlHjySoviECJr9RtYbcKzg=;
        b=SoaPKg4+LmzLGFBGG+w/Xg5NUehylrSZvbjXNLIgzaqTWTPzApxQ0TsUvLwCMkvE3FjyZ3
        D+LIaLMmYDinzQP5DLMHDyScbeWkQBDLv7DGsHduIeNoXv/w2SuZBR85jJv2oggff23rLq
        qPWR8lnjB6n/famZwwZCK4tIqBH2t9A74noW+HNz6YctDgC8jwOgM/XE/67+je7bTXKs1t
        p7oOkz9+SdXKCDxXjMJ5hQ1MZMXjjzNlnvVdRCahcp/hrxDGdzedV2/XJp1/Y+uWCC3YBi
        5UhRLlIPkMKGJVx/mBTYc+cfO5sSZ/TmVCi7bSo2uZw7LnDesnUlXHwow6D8IQ==
Date:   Fri, 28 Oct 2022 09:47:40 +0200
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
Message-ID: <20221028094740.3c11f52b@xps-13>
In-Reply-To: <683dffbc-744f-80cd-2262-b6deb4200ccc@linaro.org>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
        <20221026134545.7146-2-vadym.kochan@plvision.eu>
        <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
        <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <10581088-e4ff-76db-3c9b-42a7a9c118ee@linaro.org>
        <20221027151825.166a9255@xps-13>
        <e937b059-4168-3bd4-b294-cbfff0519d1f@linaro.org>
        <20221027155025.7c04774a@xps-13>
        <683dffbc-744f-80cd-2262-b6deb4200ccc@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 10:51:29 -0400:

> On 27/10/2022 09:50, Miquel Raynal wrote:
> > Hi Krzysztof,
> >=20
> > krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 09:24:24 -0400:
> >  =20
> >> On 27/10/2022 09:18, Miquel Raynal wrote: =20
> >>> Hi Vadym,
> >>>    =20
> >>>>>>> +patternProperties:
> >>>>>>> +  "^nand@[0-3]$":
> >>>>>>> +    type: object
> >>>>>>> +    properties:
> >>>>>>> +      reg:
> >>>>>>> +        minimum: 0
> >>>>>>> +        maximum: 3
> >>>>>>> +
> >>>>>>> +      nand-rb:
> >>>>>>> +        minimum: 0
> >>>>>>> +        maximum: 1
> >>>>>>> +
> >>>>>>> +      nand-ecc-strength:
> >>>>>>> +        enum: [1, 4, 8]
> >>>>>>> +
> >>>>>>> +      nand-on-flash-bbt: true
> >>>>>>> +
> >>>>>>> +      nand-ecc-mode: true
> >>>>>>> +
> >>>>>>> +      nand-ecc-algo:
> >>>>>>> +        description: |
> >>>>>>> +          This property is essentially useful when not using har=
dware ECC.
> >>>>>>> +          Howerver, it may be added when using hardware ECC for =
clarification
> >>>>>>> +          but will be ignored by the driver because ECC mode is =
chosen depending
> >>>>>>> +          on the page size and the strength required by the NAND=
 chip.
> >>>>>>> +          This value may be overwritten with nand-ecc-strength p=
roperty.
> >>>>>>> +
> >>>>>>> +      nand-ecc-step-size:
> >>>>>>> +        description: |
> >>>>>>> +          Marvell's NAND flash controller does use fixed strength
> >>>>>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual ste=
p size
> >>>>>>> +          will shrink or grow in order to fit the required stren=
gth.
> >>>>>>> +          Step sizes are not completely random for all and follo=
w certain
> >>>>>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
> >>>>>>> +
> >>>>>>> +      label:
> >>>>>>> +        $ref: /schemas/types.yaml#/definitions/string
> >>>>>>> +
> >>>>>>> +      partitions:
> >>>>>>> +        type: object     =20
> >>>>>>
> >>>>>> That's not what I asked for. Like four times I asked you to add he=
re
> >>>>>> unevaluatedProperties: false and I never said that ref to partitio=
n.yaml
> >>>>>> should be removed and you... instead remove that ref.
> >>>>>>
> >>>>>> You need to define here children and specify their ref.
> >>>>>>
> >>>>>> You must use unevaluatedProperties: false here. So this is fifth t=
ime I
> >>>>>> am writing this feedback.
> >>>>>>
> >>>>>>     =20
> >>>>>
> >>>>> It is a bit confusing that it is needed to define "partitions" and =
"label" rules particulary
> >>>>> in this nand controller instead of some common place like nand-chip=
.yaml, these properties
> >>>>> are common also for the other nand controllers.     =20
> >>>>
> >>>> No one speaks about label, I never commented about label, I think...
> >>>>
> >>>> If you think the property is really generic and every NAND controller
> >>>> bindings implement it, then feel free to include them there, in a
> >>>> separate patch. It sounds sensible, but I did not check other bindin=
gs.   =20
> >>>
> >>> FYI, label is already defined in mtd/mtd.yaml.   =20
> >>
> >> Which is not included here and in nand-controller.yaml =20
> >=20
> > Maybe nand-chip.yaml should? =20
>=20
> mtd.yaml looks a bit more than that - also allows nvmem nodes. Maybe
> let's just add label to nand-chip?

I don't get the reason behind this proposal, mtd.yaml really is
kind of a definition of generic properties any mtd device might
have, so duplicating label (or whatever else inside) does not seem
legitimate to me. The jedec,spi-nor.yaml file already references it for
instance.

> >>> Partitions do not need to be defined in your binding, just don't put
> >>> any in your example and you'll be fine. These partitions are either
> >>> static and may be described in the DT (see
> >>> mtd/partition/partition.yaml) or there is some dynamic discovery
> >>> involved and a proper parser shall be referenced (parsers have their
> >>> own binding).   =20
> >>
> >> I don't think this is correct. Basically you allow any node to be under
> >> partitions as there is no schema validating them (without compatibles)=
. =20
> >=20
> > Sorry if that was unclear, what I meant is: partitions should not be
> > defined in the bindings for Marvell NAND controller because they should
> > be defined somewhere else already. =20
>=20
> Ah, right. Then it seems reasonable.
>=20
> >=20
> > NAND controller subnodes should define the storage devices (the
> > flashes themselves) connected to the controller. "nand-chip.yaml"
> > describes generic properties for these. Additional subnodes are allowed
> > and expected to be partitions (this is not enforced anywhere I think),
> > they should use one of the existing compatibles to define the parser.
> > The most common parser is named fixed-partitions and has its own
> > compatible. Every parser references partitions.yaml.
> >=20
> > There are a few controller bindings however which reference
> > partition.yaml anyway, probably to make the examples validation work,
> > I'm not sure it should be done like that though:
> > https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/b=
indings/mtd/ti,gpmc-nand.yaml
> > https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/b=
indings/mtd/ti,gpmc-onenand.yaml =20
>=20
>=20
> Yes, so the nand-chip implementation (like Marvell NAND) could reference
> the parser and we would be done. If it doesn't, then we must have
> generic partitions in the nand-chip.

In this case, I am not aware of any parser that would be relevant.

In the generic case, should we really reference a parser in particular?
If yes then maybe we should make a yaml file that just gathers all the
parsers and include it within mtd.yaml (and have it referenced in
nand-chip.yaml). What do you think?

Thanks,
Miqu=C3=A8l
