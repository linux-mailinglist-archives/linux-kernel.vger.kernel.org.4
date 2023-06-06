Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F75723F71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjFFK2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbjFFK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:28:20 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B0DE67;
        Tue,  6 Jun 2023 03:28:18 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686047297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbOwpIPwd7ecKKCdWUaXxk1gMTlweGrlfTRorHHoufY=;
        b=m24Uwt3PtvDcGDw8hY4xSFXyyh9gm3u4OIwNTmSu/dQoeVeBZ1MnVppSZrBMqIu/M6yDvi
        U0fjurhQl/AJJaHAvrsolInpAAiTznZ+r3yK2X+qGbjRmvpFovpbZHWvAcbwuV1u8qA+ET
        BMlT3V3eMQUQBTpUFvPQZ/AVVi8wxLW+ivwAcGF/hnJWZAubBn1C6lrBjyQlsmFatjC2WX
        I+PRH3eDvRdV+/YwbBujtndbU44UxDW4Xwq9facrRSbE99ZmyobpLNuEA0Z+GhTg4w93LJ
        C8+yL84A+unRUTSzDoqitydxRaCWKtoJLReE5CBZZ3TV/QP9RPCgn1abnTsYpQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CD9140003;
        Tue,  6 Jun 2023 10:28:13 +0000 (UTC)
Date:   Tue, 6 Jun 2023 12:28:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20230606122812.411b223a@xps-13>
In-Reply-To: <845924ba-d9bf-d0ec-e1f2-f721366f43c0@linaro.org>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
        <20230531234923.2307013-4-chris.packham@alliedtelesis.co.nz>
        <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
        <785368df-1881-e62e-6172-d902cee814a8@alliedtelesis.co.nz>
        <eaf9d7cf-c9f5-a5d5-67af-c43761c3c6cf@linaro.org>
        <4ea0b16e-0cec-00db-c598-e0364a7edef8@alliedtelesis.co.nz>
        <9fc57052-5049-ed50-ca95-cfd1d0420dd9@alliedtelesis.co.nz>
        <20230606094855.1ab005eb@xps-13>
        <845924ba-d9bf-d0ec-e1f2-f721366f43c0@linaro.org>
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

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Tue, 6 Jun 2023 10:44:34 +0200:

> On 06/06/2023 09:48, Miquel Raynal wrote:
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it (other=
wise it is harmless).
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.=
yaml#/definitions/flag
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deprecated: true
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 additionalProperties: false   =20
> >>>>>> unevaluatedProperties: false   =20
> >>>>> It was hiding by '"^nand@[0-3]$":'. Should I move it here?   =20
> >>>> You cannot have both additionalProps and unevaluatedProps at the same
> >>>> time, so we do not talk about same thing or this was never working? =
  =20
> >>>
> >>> Hmm, I'm a little confused then. At various times I've been told to=20
> >>> put 'additionalProperties: false' or 'unevaluatedProperties: false'=20
> >>> (although never at the same time). I'm not sure when to use one or th=
e=20
> >>> other.
> >>>
> >>> From what I've been able to glean 'additionalProperties: true'=20
> >>> indicates that the node is expected to have child nodes defined in a=
=20
> >>> different schema so I would have thought 'additionalProperties: false=
'=20
> >>> would be appropriate for a schema covering a leaf node.=20
> >>> 'unevaluatedProperties: false' seems to enable stricter checking whic=
h=20
> >>> makes sense when all the properties are described in the schema.   =20
> >>
> >> So I think this might be the problem. If I look at qcom,nandc.yaml or=
=20
> >> ingenic,nand.yaml which both have a partitions property in their=20
> >> example. Neither have 'unevaluatedProperties: false' on the nand@...=20
> >> subnode. If I add it sure enough I start getting complaints about the=
=20
> >> 'partitions' node being unexpected. =20
> >=20
> > Sorry if that was unclear, I think the whole logic around the yaml
> > files is to progressively constrain the descriptions, schema after
> > schema. IOW, in the marvell binding you should set
> > unevaluatedProperties: false for the NAND controller. What is inside
> > (NAND chips, partition container, partition parsers, "mtd" properties,
> > etc) will be handled by other files. Of course you can constrain a bit
> > what can/cannot be used inside these subnodes, but I think you don't
> > need to set unevaluatedProperties in these subnodes (the NAND chip in
> > this case, or even the partitions) because you already reference
> > nand-controller.yaml which references nand-chip.yaml, mtd.yaml,
> > partitions.yaml, etc. *they* will make the generic checks and hopefully
> > apply stricter checks, when deemed relevant. =20
>=20
> No, neither nand-controller.yaml nor nand-chip.yaml limit the properties
> in this context, so each device schema must have unevaluatedProperties:
> false, for which I asked few emails ago.

The controller description shall be guarded by unevaluatedProperties:
false, we agree. Do you mean the nand chip description in each nand
controller binding should also include it at its own level? Because
that is not what we enforced so far IIRC. I am totally fine doing so
starting from now on if this is a new requirement (which makes sense).

If yes, then it means we would need to list *all* the nand
chip properties in each schema, which clearly involves a lot of
duplication as you would need to define all types of partitions,
partition parsers, generic properties, etc in order for the examples to
pass all the checks. Only the properties like pinctrl-* would not need
to be listed I guess.

As Chris was having issues comparing his work with the ingenic and qcom
yaml files, I gave your input a try and hopefully "fixed" these
bindings. I'll Cc Chris on the submission so that he has an example of
working -but maybe not fully valid, let's see- binding to take as
example.

Thanks,
Miqu=C3=A8l
