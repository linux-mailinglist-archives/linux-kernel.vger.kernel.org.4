Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83E699986
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBPQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBPQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:11:47 -0500
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 08:11:45 PST
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C5D4CCAC;
        Thu, 16 Feb 2023 08:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676563716; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UExMufGNAbdxg4Rau5cfUBui/sNMTv0xRaa7hTV0a2YUDWVqPCwEmzpmwpz2mQX9q0
    FqwMUeYoog3PjWb2DqXBqiGrlLuEa8K2uMReFIHlfx1Wr4aw4BmMqtfKQU4MaYgWHrmM
    W1n+ovBHzqAC/uDrkb9hMiAr/i5AdVWQTj+kJTmFTtCExUeFZ7h7EZTwUPqaZWwVZtDD
    1Z8RE8zARpt1Lrqvr5WCbu+DJyMHCIJbtUUocfbREQ6yONMz+qagT7Etyia7W4LoCAgp
    fH60qwW0uUVASryrAiWIs+pmMNANkRaR9BtpEzaeoVi82gUsqCUPAtn1gB9XGXQFBXO4
    c8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676563716;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ehg8EOSq35GC79Mm4B9aUGELRulukppK1jG4qgT2b/Y=;
    b=Re53vaEKbGUeZBSJl1nghSyuFtNzLlvdgtB7pNNkiPwF1vR5zo7gX7KOo5RM796GOC
    MYAoKeI9tYM2Ufeod/CSglbjk2XsLY/TeAgC3EbLu3+qga7WZdRzW4J+tCJz7//lqbB6
    jhAh6ANlqWm/Iyp4cZmnbQ+CCBEmEVipWXII1INz3C+iFfF7RzoOoyeRWhjHVLGn6O2P
    FT9u67X7kd7zvPFdtOQsfwyLaLqBg1cM+YR2pMRU0my7MTyQrYqBG+0MPded4lKBmqsk
    +yGMHuLbm+B+08PZH5FcNaDTgB2vjeD7yQlQeILAZoTQZ2YRAhN+8+HTSq49ey+9pqmD
    NRZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676563716;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ehg8EOSq35GC79Mm4B9aUGELRulukppK1jG4qgT2b/Y=;
    b=tTJ2JgVWAx64AZte3cmkAqFTHyv/rdT3pCTMHiZTwLq0NVBLmEB4NzM5bjwBwNAwyi
    pihBEK/h9qOUJW4PgL/pb+bQAdYIEWGfs854JYGocRV+jyFXFIc4myFjTHVwZ5N+9t3q
    ZnSE8mcMeKsQPluLax4eIbRxaKo/aTrHc+WPPf/n0Gg4NOkZdwhPGLFAxKWWDMb0cBLx
    r/gmKqsI1Hz5efJX1oW7BcBdkoobhIB5HhyZMCN8qjNzuuZjF0iJM5JXMCWdRr5H4t54
    4yqZSyzXwAdrs2B/Bq3lnMiaNoBrBPtGKfdGOkV7vCT9SiK/OMHr/PAL0XrbMKaUI5Tp
    F2wQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfq2U="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1GG8ZhLU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 16 Feb 2023 17:08:35 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC 2/2] WIP: dt-bindings: omap: Convert omap.txt to yaml
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230216153339.19987-3-afd@ti.com>
Date:   Thu, 16 Feb 2023 17:08:34 +0100
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
Message-Id: <B4B86F81-3483-400B-8D14-AC92940D2B57@goldelico.com>
References: <20230216153339.19987-1-afd@ti.com>
 <20230216153339.19987-3-afd@ti.com>
To:     Andrew Davis <afd@ti.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 16.02.2023 um 16:33 schrieb Andrew Davis <afd@ti.com>:
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> .../devicetree/bindings/arm/omap/omap.yaml    | 174 ++++++++++++++++++
> 1 file changed, 174 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/arm/omap/omap.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.yaml =
b/Documentation/devicetree/bindings/arm/omap/omap.yaml
> new file mode 100644
> index 0000000000000..cf07a7a7df279
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.yaml
> @@ -0,0 +1,174 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/omap/omap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP SoC architecture device tree bindings
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +description: |
> +  Platforms based on Texas Instruments OMAP SoC architecture.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +
> +      - description: TI OMAP2420 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,omap2420-h4 # TI OMAP2420 H4 board
> +              - nokia,n800 # Nokia N800
> +              - nokia,n810 # Nokia N810
> +              - nokia,n810-wimax # Nokia N810 WiMax
> +          - const: ti,omap2420
> +          - const: ti,omap2
> +
> +      - description: TI OMAP2430 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,omap2430-sdp # TI OMAP2430 SDP
> +          - const: ti,omap2430
> +          - const: ti,omap2
> +
> +      - description: TI OMAP3430 SoC based platforms
> +        items:
> +          - enum:
> +              - logicpd,dm3730-som-lv-devkit # LogicPD Zoom OMAP35xx =
SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom OMAP35xx =
Torpedo Development Kit
> +              - ti,omap3430-sdp # TI OMAP3430 SDP
> +              - ti,omap3-beagle # TI OMAP3 BeagleBoard
> +              - compulab,omap3-cm-t3530 # CompuLab CM-T3530
> +              - timll,omap3-devkit8000 # TimLL OMAP3 Devkit8000
> +              - ti,omap3-evm # TI OMAP35XX EVM (TMDSEVM3530)
> +              - ti,omap3-ldp # TI OMAP3430 LDP (Zoom1 Labrador)
> +              - nokia,omap3-n900 # Nokia N900
> +          - const: ti,omap3430
> +          - const: ti,omap3
> +
> +      - description: TI OMAP3630 SoC based platforms
> +        items:
> +          - enum:
> +              - logicpd,dm3730-som-lv-devkit # LogicPD Zoom DM3730 =
SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 =
Torpedo + Wireless Development Kit
> +              - ti,omap3-beagle-xm # TI OMAP3 BeagleBoard xM
> +              - compulab,omap3-cm-t3730 # CompuLab CM-T3730
> +              - amazon,omap3-echo # Amazon Echo (first generation)
> +              - ti,omap3-evm-37xx # TI OMAP37XX EVM (TMDSEVM3730)
> +              - ti,omap3-gta04 # OMAP3 GTA04

precisely the GTA04 was not a TI product, but from Golden Delicious =
Computers.
It got this compatible because it originally shared a lot of device tree =
with the ti,omap3-beagle-xm.
Well, we could add a vendor prefix ("goldelico") and update the device =
trees to "goldelico,gta04".

Generally, there is also the OpenPandora with both OMAP3 variants (3430 =
and 3630):

compatible =3D "openpandora,omap3-pandora-600mhz", "ti,omap3430", =
"ti,omap3";
compatible =3D "openpandora,omap3-pandora-1ghz", "ti,omap3630", =
"ti,omap36xx", "ti,omap3";

But it is also missing a vendor prefix. Should I send a patch for both =
topics?
Before the scheme is merged or afterwards?

> +              - nokia,omap3-n9 # Nokia N9
> +              - nokia,omap3-n950 # Nokia N950
> +              - lg,omap3-sniper # LG Optimus Black
> +              - ti,omap3-zoom3 # TI Zoom3
> +          - const: ti,omap3630
> +          - const: ti,omap3
> +
> +      - description: TI AM35 SoC based platforms
> +        items:
> +          - enum:
> +              - teejet,mt_ventoux # TeeJet Mt.Ventoux
> +              - ti,am3517-craneboard # TI AM3517 CraneBoard =
(TMDSEVM3517)
> +              - ti,am3517-evm # TI AM3517 EVM (AM3517/05 TMDSEVM3517)
> +              - compulab,omap3-sbc-t3517 # CompuLab SBC-T3517 with =
CM-T3517
> +          - const: ti,am3517
> +          - const: ti,omap3
> +
> +      - description: TI OMAP4430 SoC based platforms
> +        items:
> +          - enum:
> +              - motorola,droid4 # Motorola Droid 4 XT894
> +              - motorola,droid-bionic # Motorola Droid Bionic XT875
> +              - amazon,omap4-kc1 # Amazon Kindle Fire (first =
generation)
> +              - ti,omap4-panda # TI OMAP4 PandaBoard
> +              - ti,omap4-sdp # TI OMAP4 SDP board
> +          - const: ti,omap4430
> +          - const: ti,omap4
> +
> +      - description: TI OMAP4460 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,omap4-panda-es # TI OMAP4 PandaBoard-ES
> +          - const: ti,omap4460
> +          - const: ti,omap4
> +
> +      - description: TI OMAP543 SoC based platforms

s/TI OMAP543 SoC/TI OMAP5 SoC/

> +        items:
> +          - enum:
> +              - compulab,omap5-cm-t54 # CompuLab CM-T54
> +              - isee,omap5-igep0050 # IGEPv5
> +              - ti,omap5-uevm # TI OMAP5 uEVM board
> +          - const: ti,omap5
> +
> +      - description: TI AM33 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,am335x-bone # TI AM335x BeagleBone
> +              - compulab,cm-t335 # CompuLab CM-T335
> +              - ti,am335x-evm # TI AM335x EVM
> +              - ti,am335x-evmsk # TI AM335x EVM-SK
> +              - bosch,am335x-guardian # Bosch AM335x Guardian
> +              - ti,am3359-icev2 # TI AM3359 ICE-V2
> +              - novatech,am335x-lxm # NovaTech OrionLXm
> +              - moxa,uc-2101 # Moxa UC-2101
> +              - moxa,uc-8100-me-t # Moxa UC-8100-ME-T
> +              - gumstix,am335x-pepper # Gumstix Pepper
> +              - tcl,am335x-sl50 # Toby Churchill SL50 Series
> +          - pattern: '^ti,am33(5[1246789]|xx)$' # ti,am33xx is legacy =
please use full SoC name
> +
> +      - description: TI AM43 SoC based platforms
> +        items:
> +          - enum:
> +              - compulab,am437x-cm-t43 # CompuLab CM-T43
> +              - ti,am437x-gp-evm # TI AM437x GP EVM
> +              - ti,am437x-idk-evm # TI AM437x Industrial Development =
Kit
> +              - ti,am437x-sk-evm # TI AM437x SK EVM
> +          - pattern: '^ti,am4372[26789]$'
> +          - const: ti,am43
> +
> +      - description: TI AM57 SoC based platforms
> +        items:
> +          - enum:
> +              - beagle,am5729-beagleboneai # BeagleBoard.org =
BeagleBone AI
> +              - compulab,cl-som-am57x # CompuLab CL-SOM-AM57x
> +              - ti,am5718-idk # TI AM5718 IDK
> +              - ti,am5728-idk # TI AM5728 IDK
> +              - ti,am5748-idk # TI AM5748 IDK
> +          - pattern: '^ti,am57[0124][689]$'
> +          - const: ti,am57
> +
> +      - description: TI DRA7 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,dra718-evm # TI DRA718 EVM
> +              - ti,dra722-evm # TI DRA722 EVM
> +              - ti,dra742-evm # TI DRA742 EVM
> +              - ti,dra762-evm # TI DRA762 EVM
> +          - pattern: '^ti,dra7[12456][024568p]$'
> +          - const: ti,dra7
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    / {
> +        model =3D "TI OMAP2430 SDP (Software Development Board)";
> +        compatible =3D "ti,omap2430-sdp", "ti,omap2430", "ti,omap2";
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +    };
> +
> +  - |
> +    / {
> +        model =3D "TI DRA762 EVM";
> +        compatible =3D "ti,dra762-evm", "ti,dra762", "ti,dra7";
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +    };
> +
> +...
> --=20
> 2.39.1
>=20

BR,
Nikolaus

