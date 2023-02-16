Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2062699A67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBPQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:43:53 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E954CC99;
        Thu, 16 Feb 2023 08:43:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676565816; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SX2i5Tos38Fgwi7WtqJ+Djt6Hh/XIDXXlqs4vzzhRHYCrSEzYERiDrjAyM12u1gGn/
    BEMVwVfVId0ucms5nEGYKzMZ7v1qzZAwUTG8tIM9yC+dJT477lgwesC0j7BQdwY7OV/T
    3BA1jYaU25ILVmhdP+0/s1a6xC6ut3xG6GShqqLZuTn2l2iQq5vvmj+LpSSK2T6XJP29
    E4a+9Jah+cR8ahtWXCL9+QsLfyki4HBdxToYx9HEaVt5BHMQe2Bn8php4NTKsfPhbsgQ
    VQmvYNBLUzlBoayL8pEYTC3kd1kujYW+vMueUs2qjSlwInEyPfvQuGgdcks24VL6Uisz
    ERWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676565816;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KMpn1IroileXPCsxjh9VYqExYDjc8Zq6GFm4REmK/QM=;
    b=ShCcQC/IJNKfhorlbLJfPnTV9LgEtOOfIdsQK6n86HHOZZ5y/S0QpFAQGiIGMtX8QU
    pWpYDAqydCStB8/QTcRCWB9bYjZH44HB+idoL9nZp3GihsW50BXinA4rOeCuEX6/li3j
    /lWZOATPZn0zGi+bEIi0DrJrNPU1a70eLDVf1+mVoEuB/EJ4yaO1zgDhSJJ1ea/EiEAT
    CVYbUNOLcQtWUzPnSaW3aJTl4xbbgC55QVU7SReU4wBuhRYY98jsPyTL6myTsV7qqUuW
    dH2IngqC8WExj9CAdybWyOYweuB675Mj4ENh2AuxzZa/RZEVVWxVuLbnrrv1hOsxZ0L3
    JukA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676565816;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KMpn1IroileXPCsxjh9VYqExYDjc8Zq6GFm4REmK/QM=;
    b=dATuccg1g273KSxWYcYfBAAP2/GC3yDsUKac+O7ad1YstcfcoG3Q3n5lbHo9xYYGxw
    dplgtY7MjSswWRJF6pUg6CQTOeJnm3f5F5nzA/3dMlPSrKVV77GBv5vP3P0OMvwbyggA
    uYd9bV7K4ZXf981x3/N2DZhhOWD6ue5ipySCgVxBqM/NoUqbE1kS5rwo+AnXaUWRlVkn
    SjyLjySx5dvuNX7SiGiJU+d2XV9VpfLq4GfZVOBaeLsHVutPCIIf/lg/ZgtaoxW2rA1j
    5+Bvgbi8Ha4ne34lRs4p8+X63o29OxP8OqdKsyZgpeATDJ08v6mNAg5erK8qpj6WqD6p
    6FBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfq2U="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1GGhahTJ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 16 Feb 2023 17:43:36 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC 2/2] WIP: dt-bindings: omap: Convert omap.txt to yaml
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <814cd5f3-b46d-13f3-1d05-f26a29914c9b@ti.com>
Date:   Thu, 16 Feb 2023 17:43:35 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F8C8151-73E4-49A2-B49A-F190AF2F3BFA@goldelico.com>
References: <20230216153339.19987-1-afd@ti.com>
 <20230216153339.19987-3-afd@ti.com>
 <B4B86F81-3483-400B-8D14-AC92940D2B57@goldelico.com>
 <814cd5f3-b46d-13f3-1d05-f26a29914c9b@ti.com>
To:     Andrew Davis <afd@ti.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> Am 16.02.2023 um 17:19 schrieb Andrew Davis <afd@ti.com>:
>=20
> On 2/16/23 10:08 AM, H. Nikolaus Schaller wrote:
>> Hi,
>>> Am 16.02.2023 um 16:33 schrieb Andrew Davis <afd@ti.com>:
>>>=20
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>> .../devicetree/bindings/arm/omap/omap.yaml    | 174 =
++++++++++++++++++
>>> 1 file changed, 174 insertions(+)
>>> create mode 100644 =
Documentation/devicetree/bindings/arm/omap/omap.yaml
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.yaml =
b/Documentation/devicetree/bindings/arm/omap/omap.yaml
>>> new file mode 100644
>>> index 0000000000000..cf07a7a7df279
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.yaml
>>> @@ -0,0 +1,174 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/omap/omap.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments OMAP SoC architecture device tree bindings
>>> +
>>> +maintainers:
>>> +  - Tony Lindgren <tony@atomide.com>
>>> +
>>> +description: |
>>> +  Platforms based on Texas Instruments OMAP SoC architecture.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    oneOf:
>>> +
>>> +      - description: TI OMAP2420 SoC based platforms
>>> +        items:
>>> +          - enum:
>>> +              - ti,omap2420-h4 # TI OMAP2420 H4 board
>>> +              - nokia,n800 # Nokia N800
>>> +              - nokia,n810 # Nokia N810
>>> +              - nokia,n810-wimax # Nokia N810 WiMax
>>> +          - const: ti,omap2420
>>> +          - const: ti,omap2
>>> +
>>> +      - description: TI OMAP2430 SoC based platforms
>>> +        items:
>>> +          - enum:
>>> +              - ti,omap2430-sdp # TI OMAP2430 SDP
>>> +          - const: ti,omap2430
>>> +          - const: ti,omap2
>>> +
>>> +      - description: TI OMAP3430 SoC based platforms
>>> +        items:
>>> +          - enum:
>>> +              - logicpd,dm3730-som-lv-devkit # LogicPD Zoom =
OMAP35xx SOM-LV Development Kit
>>> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom =
OMAP35xx Torpedo Development Kit
>>> +              - ti,omap3430-sdp # TI OMAP3430 SDP
>>> +              - ti,omap3-beagle # TI OMAP3 BeagleBoard
>>> +              - compulab,omap3-cm-t3530 # CompuLab CM-T3530
>>> +              - timll,omap3-devkit8000 # TimLL OMAP3 Devkit8000
>>> +              - ti,omap3-evm # TI OMAP35XX EVM (TMDSEVM3530)
>>> +              - ti,omap3-ldp # TI OMAP3430 LDP (Zoom1 Labrador)
>>> +              - nokia,omap3-n900 # Nokia N900
>>> +          - const: ti,omap3430
>>> +          - const: ti,omap3
>>> +
>>> +      - description: TI OMAP3630 SoC based platforms
>>> +        items:
>>> +          - enum:
>>> +              - logicpd,dm3730-som-lv-devkit # LogicPD Zoom DM3730 =
SOM-LV Development Kit
>>> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 =
Torpedo + Wireless Development Kit
>>> +              - ti,omap3-beagle-xm # TI OMAP3 BeagleBoard xM
>>> +              - compulab,omap3-cm-t3730 # CompuLab CM-T3730
>>> +              - amazon,omap3-echo # Amazon Echo (first generation)
>>> +              - ti,omap3-evm-37xx # TI OMAP37XX EVM (TMDSEVM3730)
>>> +              - ti,omap3-gta04 # OMAP3 GTA04
>> precisely the GTA04 was not a TI product, but from Golden Delicious =
Computers.
>> It got this compatible because it originally shared a lot of device =
tree with the ti,omap3-beagle-xm.
>> Well, we could add a vendor prefix ("goldelico") and update the =
device trees to "goldelico,gta04".
>> Generally, there is also the OpenPandora with both OMAP3 variants =
(3430 and 3630):
>> compatible =3D "openpandora,omap3-pandora-600mhz", "ti,omap3430", =
"ti,omap3";
>> compatible =3D "openpandora,omap3-pandora-1ghz", "ti,omap3630", =
"ti,omap36xx", "ti,omap3";
>> But it is also missing a vendor prefix. Should I send a patch for =
both topics?
>> Before the scheme is merged or afterwards?
>=20
> I'd suggest we get as many fixes into the actual DT files before the =
schemas
> are solidified. Doing it after would mean changes in two places vs =
one.

Ok, I'll prepare and send a patch set asap.

BR and thanks,
Nikolaus


