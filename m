Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD86111E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJ1Mu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJ1Mu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:50:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B49C17D281;
        Fri, 28 Oct 2022 05:50:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7025CE0002;
        Fri, 28 Oct 2022 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666961452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKhsQ0skPx79THQDV65x19RAWdNtmUgJxMQOVbrGvzY=;
        b=HkpSlQsFsyQylWoifevprpzR3l/KdpO8IdZ03j57tzhY5upzvUZyd6oD9gJE+ZMb3TB26S
        HOADRMzhzDcn0PNtdHZPXcazIAZs0zGEhp7zFO2whVCYFlLn7RLOorsZ07jw0+vSVMyZVQ
        jG3mJ8BSB76RmEbo+Lb4IBGQEI4Khn0MVOfYH/sMrhtlQDKTtELdizStOH6Y5Ko/GbsSDN
        C2k7sotPaFxPo+LPBk30iKC6r82ZV2dEw9ZWdr19DF//Mr2AaxXsgEppI6MiptmZ86jzAU
        6LnfIrYsPzeH+KRFiIwhHn4QKZOpYToVu6w7ztRfymtB33FYXnPLRu0vYPoalA==
Date:   Fri, 28 Oct 2022 14:50:49 +0200
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
Message-ID: <20221028145049.76db792f@xps-13>
In-Reply-To: <a98f00bd-013a-a1ce-0054-bbceeaefcefa@linaro.org>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
        <20221026134545.7146-2-vadym.kochan@plvision.eu>
        <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
        <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <10581088-e4ff-76db-3c9b-42a7a9c118ee@linaro.org>
        <20221027151825.166a9255@xps-13>
        <e937b059-4168-3bd4-b294-cbfff0519d1f@linaro.org>
        <20221027155025.7c04774a@xps-13>
        <683dffbc-744f-80cd-2262-b6deb4200ccc@linaro.org>
        <20221028094740.3c11f52b@xps-13>
        <a98f00bd-013a-a1ce-0054-bbceeaefcefa@linaro.org>
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

krzysztof.kozlowski@linaro.org wrote on Fri, 28 Oct 2022 07:31:39 -0400:

> On 28/10/2022 03:47, Miquel Raynal wrote:
> > Hi Krzysztof,
> >=20
> > krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 10:51:29 -0400:
> >  =20
> >> On 27/10/2022 09:50, Miquel Raynal wrote: =20
> >>> Hi Krzysztof,
> >>>
> >>> krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 09:24:24 -04=
00:
> >>>    =20
> >>>> On 27/10/2022 09:18, Miquel Raynal wrote:   =20
> >>>>> Hi Vadym,
> >>>>>      =20
> >>>>>>>>> +patternProperties:
> >>>>>>>>> +  "^nand@[0-3]$":
> >>>>>>>>> +    type: object
> >>>>>>>>> +    properties:
> >>>>>>>>> +      reg:
> >>>>>>>>> +        minimum: 0
> >>>>>>>>> +        maximum: 3
> >>>>>>>>> +
> >>>>>>>>> +      nand-rb:
> >>>>>>>>> +        minimum: 0
> >>>>>>>>> +        maximum: 1
> >>>>>>>>> +
> >>>>>>>>> +      nand-ecc-strength:
> >>>>>>>>> +        enum: [1, 4, 8]
> >>>>>>>>> +
> >>>>>>>>> +      nand-on-flash-bbt: true
> >>>>>>>>> +
> >>>>>>>>> +      nand-ecc-mode: true
> >>>>>>>>> +
> >>>>>>>>> +      nand-ecc-algo:
> >>>>>>>>> +        description: |
> >>>>>>>>> +          This property is essentially useful when not using h=
ardware ECC.
> >>>>>>>>> +          Howerver, it may be added when using hardware ECC fo=
r clarification
> >>>>>>>>> +          but will be ignored by the driver because ECC mode i=
s chosen depending
> >>>>>>>>> +          on the page size and the strength required by the NA=
ND chip.
> >>>>>>>>> +          This value may be overwritten with nand-ecc-strength=
 property.
> >>>>>>>>> +
> >>>>>>>>> +      nand-ecc-step-size:
> >>>>>>>>> +        description: |
> >>>>>>>>> +          Marvell's NAND flash controller does use fixed stren=
gth
> >>>>>>>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual s=
tep size
> >>>>>>>>> +          will shrink or grow in order to fit the required str=
ength.
> >>>>>>>>> +          Step sizes are not completely random for all and fol=
low certain
> >>>>>>>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
> >>>>>>>>> +
> >>>>>>>>> +      label:
> >>>>>>>>> +        $ref: /schemas/types.yaml#/definitions/string
> >>>>>>>>> +
> >>>>>>>>> +      partitions:
> >>>>>>>>> +        type: object       =20
> >>>>>>>>
> >>>>>>>> That's not what I asked for. Like four times I asked you to add =
here
> >>>>>>>> unevaluatedProperties: false and I never said that ref to partit=
ion.yaml
> >>>>>>>> should be removed and you... instead remove that ref.
> >>>>>>>>
> >>>>>>>> You need to define here children and specify their ref.
> >>>>>>>>
> >>>>>>>> You must use unevaluatedProperties: false here. So this is fifth=
 time I
> >>>>>>>> am writing this feedback.
> >>>>>>>>
> >>>>>>>>       =20
> >>>>>>>
> >>>>>>> It is a bit confusing that it is needed to define "partitions" an=
d "label" rules particulary
> >>>>>>> in this nand controller instead of some common place like nand-ch=
ip.yaml, these properties
> >>>>>>> are common also for the other nand controllers.       =20
> >>>>>>
> >>>>>> No one speaks about label, I never commented about label, I think.=
..
> >>>>>>
> >>>>>> If you think the property is really generic and every NAND control=
ler
> >>>>>> bindings implement it, then feel free to include them there, in a
> >>>>>> separate patch. It sounds sensible, but I did not check other bind=
ings.     =20
> >>>>>
> >>>>> FYI, label is already defined in mtd/mtd.yaml.     =20
> >>>>
> >>>> Which is not included here and in nand-controller.yaml   =20
> >>>
> >>> Maybe nand-chip.yaml should?   =20
> >>
> >> mtd.yaml looks a bit more than that - also allows nvmem nodes. Maybe
> >> let's just add label to nand-chip? =20
> >=20
> > I don't get the reason behind this proposal, mtd.yaml really is
> > kind of a definition of generic properties any mtd device might
> > have, so duplicating label (or whatever else inside) does not seem
> > legitimate to me. The jedec,spi-nor.yaml file already references it for
> > instance. =20
>=20
> spi-nor is not a NAND chip... By including mtd.yaml in nand-chip you
> also allow the NVMEM properties which are not applicable.

MTD is an NVMEM provider, any MTD device (including NANDs) can use
these properties IMHO. It's not reserved to spi-nor (even though it is
more common, I conceed).

> >>>>> Partitions do not need to be defined in your binding, just don't put
> >>>>> any in your example and you'll be fine. These partitions are either
> >>>>> static and may be described in the DT (see
> >>>>> mtd/partition/partition.yaml) or there is some dynamic discovery
> >>>>> involved and a proper parser shall be referenced (parsers have their
> >>>>> own binding).     =20
> >>>>
> >>>> I don't think this is correct. Basically you allow any node to be un=
der
> >>>> partitions as there is no schema validating them (without compatible=
s).   =20
> >>>
> >>> Sorry if that was unclear, what I meant is: partitions should not be
> >>> defined in the bindings for Marvell NAND controller because they shou=
ld
> >>> be defined somewhere else already.   =20
> >>
> >> Ah, right. Then it seems reasonable.
> >> =20
> >>>
> >>> NAND controller subnodes should define the storage devices (the
> >>> flashes themselves) connected to the controller. "nand-chip.yaml"
> >>> describes generic properties for these. Additional subnodes are allow=
ed
> >>> and expected to be partitions (this is not enforced anywhere I think),
> >>> they should use one of the existing compatibles to define the parser.
> >>> The most common parser is named fixed-partitions and has its own
> >>> compatible. Every parser references partitions.yaml.
> >>>
> >>> There are a few controller bindings however which reference
> >>> partition.yaml anyway, probably to make the examples validation work,
> >>> I'm not sure it should be done like that though:
> >>> https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree=
/bindings/mtd/ti,gpmc-nand.yaml
> >>> https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree=
/bindings/mtd/ti,gpmc-onenand.yaml   =20
> >>
> >>
> >> Yes, so the nand-chip implementation (like Marvell NAND) could referen=
ce
> >> the parser and we would be done. If it doesn't, then we must have
> >> generic partitions in the nand-chip. =20
> >=20
> > In this case, I am not aware of any parser that would be relevant.
> >=20
> > In the generic case, should we really reference a parser in particular?
> > If yes then maybe we should make a yaml file that just gathers all the
> > parsers and include it within mtd.yaml (and have it referenced in
> > nand-chip.yaml). What do you think?
> >  =20
>=20
> Not all MTD devices have partitions so putting this into mtd.yaml does
> not look correct. Adding it into nand-chip seems fine.

Not all MTD devices have partitions but all of them can have
partitions. It's not a required subnode, but it is definitely common to
all mtd devices. I would then consider mtd.yaml a _very_ generic place
where we put anything that is not specific to the underlying storage
technology.

Anything that is specific to NAND goes into nand-chip.yaml or
nand-controller.yaml, anything specific to SPI-NOR goes into
jedec,spi-nor.yaml.

nand-chip.yaml and jedec,spi-nor.yaml should reference mtd.yaml.

mtd.yaml could probably reference some kind of "partition.yaml" to
define subnodes with partition parsers. I don't yet know exactly how to
make everything coherent but I liked the idea of having a file
referencing all the documented parsers, so that they could all apply if
necessary. I did not understand if you were in favor or opposed to this
idea? If opposed, how could we make all the partition parsers
schemas (and only them) to be validated as MTD devices subnodes?

Thanks a lot for all your feedback,
Miqu=C3=A8l
