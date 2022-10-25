Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3B60C0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiJYBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiJYBOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:14:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60114.outbound.protection.outlook.com [40.107.6.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5CC491C4;
        Mon, 24 Oct 2022 17:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkshdRpZYjJ2M8Cl+3TB3vS/TFy2otQUTsYjo5iQPq8rL9CHajgteIpHahOl78OOqnKooZitJyrlr//VZN5DBG20vW6sZ6EuU4n9J8uDQ8Coeh/OQsUcfNTsX4AwNQoWwWYZCPqxK7fjRA7XU8dK7e4p5yOS29bOXimcmgfPDPea4TZrjzKjprBw6tsSTYGQe5zzUYmJmmZy4CHHDZgdnGFJZYKw3n7ISW5uAh/0YcxrqsKFFY6XzMwr3sty+OhzD361zHx8Rlpe3ujJPm3I4kmA3dlEDOPZbYcAr3vEeEDi8r1pu2FBfhK/gL9iksh0J1GxhwrLZkV3Z4X9JCMcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IOTa1ei1QS0V2/+xi/yXGVv97VIou+W2yjeELCkTws=;
 b=O1vjQ5En3t9QMRZsn8lnLhsZ5H24FHh99F6d3+MdjF6ibeJmgqkGtHcOZxQ4hR/pmc+Nutr5JydVlADrUNXSbV6OPdcrNKWlwbttFwJUiEP1V+tNS8TPm1GwP9i1gHNXq8o28yGoBCIxbSal0YXpF21GiDfgcMi54JLhcH+g/zzi+O+AupZptSxJOWwaBmn0vK6c1VLg4B1TSTnBQDNk80ciAEuFbdUUcKFX7nx/BGBV8OpUH2TcUkWNvdmzBLs3/VJg9YGcUuNbMuPya5HAmsLNoJhq6zDY+ez2gfORius1Dgr/rAapcFToQ2Iq1tOnT4rlEXuQgDfC7G6uZU9lfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IOTa1ei1QS0V2/+xi/yXGVv97VIou+W2yjeELCkTws=;
 b=lMwUEmIA9K4u7aGxZz0ioLEhBbtAjMAheF72j5e22X3IIWvYHWYGNDJsaMNYXlU5GfD9z+GCEZdIShwkj9QqRujAsmvGKhF87Jc5HvSW4iawD04tWpe8XnKkIWdLmivLZUxeZDd8rdB6uq2SKsnaQ0kmrxG9SWWcLE7Y/TF5xcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1765.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:276::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 00:29:25 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 00:29:25 +0000
Date:   Tue, 25 Oct 2022 03:29:24 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <ae7c86fd-5bc9-4cdb-857c-e686225f5966@linaro.org>
References: <20221024210153.28852-1-vadym.kochan@plvision.eu>
        <20221024210153.28852-2-vadym.kochan@plvision.eu>
        <ae7c86fd-5bc9-4cdb-857c-e686225f5966@linaro.org>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB03170C4FC92ED25F78EF57FC95319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PAXP190MB1765:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dec9b5-77d0-4581-fc2a-08dab61ff827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rc1dwM7q35ymkeJv1bcYslzzVrd9m27xiViRbYgXjZwKVQDTYsKaByF+Oyr05lFPREQhUTxNA29QAIX93cTGLOH6HZt7kVk7BVz5Qd7ImDCUdc7PuwEeJ691mUao2RgIsk3tke+9JcjDRyH9C8ZKi1+wR+5LxEaOiFx6bWc/Qo1b8Tei5dUpClVuhvTO1u1Eq6yfTRlmaT9fe8qR8iIUDO+bng5RxVp9FfdhMkc4eavzsYA/PORXcoZasICYppitkS+Kyu/Dc7aa0WccwdDMPx/3ldmiFplZiW2uLKnr6837i/3rgikChxp9j2VoJ+NVDTUSbXsfkcw51IrltH8m+ySTKjo0oYTlCniK05oufH4L3GFttSybuU0fP2SvWYe6nxvyC5Ct6lJ2EActkmAZaH0fdVp9mjWmiMgOfTR24JwMqcImFlBkskMlqRRl8yFr30V54N7IcOPwNdCj0d6Q6vtA92ymT8xS7Ra4Gl0w1gTbsRrJ3CWcXL5sm8l8h3GJcD1XrDESlx+bDfII/bH1Ht8s5n3rG0+3mHcni2Q319GD22QMeovT/HN/6sJkhlNZ6yWqXWcY5GcY62U1bIiWnlYMS5rqIJES7Ti3ibsVZ/ArScZ+2WpuAHthnlFv1E6xtNsHFFFKYxZlTkisD6f/gAq1OUhsAJJFGZgQOteNb0d04aUQPBD6ZeyF8C93P0cn8KY6D7He6knapXCt/GpaGe1rH08yuQ1embWIOnOPSSIpvHUxggtJvjQBbfwLmTE9EtrKiIDMAQh/KpiV3z15igQ0MWTpIEUabx7sHZJw0EW0TBN694NkjyDuPJoMu7sBIisATfelR59lAilvuD22iKaNYk6xBkGQ6CTulhY0K5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39840400004)(376002)(366004)(396003)(346002)(34036004)(451199015)(41300700001)(6506007)(110136005)(7696005)(52116002)(53546011)(38350700002)(38100700002)(52536014)(7416002)(5660300002)(54906003)(8936002)(316002)(55016003)(921005)(8676002)(508600001)(966005)(44832011)(4326008)(66476007)(66946007)(86362001)(66556008)(33656002)(41320700001)(83380400001)(9686003)(26005)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJN0LVYnhpbBtAmqW+eALDOkUX0QvEVq7E++cmyKKfIWXuPtWdtYAPZ4TDV1?=
 =?us-ascii?Q?IobpFOeW5R/FxmjTCWzoue3PhBfMU7bthV4AE4W+CLPZiNnkhIkEVnPsavPy?=
 =?us-ascii?Q?8YRnNEFx1IHZjJQgTgDf68EmhU+6nxHWZpAeS1LR1Lb9o2JBddVp0yJC8Unz?=
 =?us-ascii?Q?c1punLIFXsMfF6fdbqWCSbDAvocMsZevox4P6MKPiKgux4Wmf1bFOAVXz4QK?=
 =?us-ascii?Q?9GWblt96V4f7h1JNJkp2yJKiGXjbpdR1b9i2VJ1llkk2AMNNHKTpw80ds0c/?=
 =?us-ascii?Q?0ZRuppdPfMv53A0m0KmvSTU3RmnN3gErlv4BBQRNSHcwzs8zA0FW2D9i0BD0?=
 =?us-ascii?Q?5UEHkinLRFbfz54ObH0LmZR8x9R0j64dEmS1qVKscHyNRMN/CtOLr3FU2g32?=
 =?us-ascii?Q?tDumxXEKa1PE31n0Bhmw9VzYboWKhFpE+QKMb4vG2NSK45jr3uSIaW/sF3q8?=
 =?us-ascii?Q?zuhqLrDssXT5svy76UpJ/AjwC8TwR+Oo8VspcPzfjIMOwyu5ScwYPBpjFDfU?=
 =?us-ascii?Q?p6/+JY626Bho5NL+1MGMobueY8W0F/Abcz7cmDoD6E9pJbvnsdCqBOvVVdfz?=
 =?us-ascii?Q?XthXFQEQhCHcXFWpvlvl5iaXsC9Sh6Mnnh0xvmZv9xv/IxrCXUp4lhOAUJFr?=
 =?us-ascii?Q?QnJRInVda3O1g8V7bU7NernpptfpPUYyhZ3+/zgqLCfoPFxHRLipNjAG63rx?=
 =?us-ascii?Q?4J7M8RGpZ3KZZ0KbHcYbG3mbRdYuE9t85Re6R/0bZHgUSvAWuHqygVmKF7Kl?=
 =?us-ascii?Q?cda1/lBJxSdcJiWF/L5g79HePzQu77w8MugMA9X3Cmxy1DYyazxvtwr1ib6F?=
 =?us-ascii?Q?FUhtuLyPcv9SEKfy6qt+ujHFKIKyJcX0OgTv4MG3C74lAZ08f4ANzMCRQWI1?=
 =?us-ascii?Q?0DMw+ihlPqBWoOx6w+XRVVUTnjtiYZ9hiULCVF9+A/9nM708WqskmQ33Oe/M?=
 =?us-ascii?Q?iJThOpy8L0QGtQUsgTSkjss063c7No44QynKmcdGPR8aP1R343aEvcQwUyqJ?=
 =?us-ascii?Q?/NoHRLBhU15jDJnS9itEgThBN8fe2HkkQWo7JQSYxNezVDzKRDcQivOocmb+?=
 =?us-ascii?Q?mdqe9b1P+N+tFg2iDUC0ypNVIfqOZikcSJpPI9J9EJcCf2pV/8anTgbFfmYu?=
 =?us-ascii?Q?riuJIuB+enKpP2TJdlxcMhp+5x80Y8BRP77bT+tHIrnBqJCBS/V+ApgNHn3z?=
 =?us-ascii?Q?4llObNehH3eGucNOtB6/Aws26mS2RfaVkBECKH/ylChiCyir3b/rwdTW4uYL?=
 =?us-ascii?Q?bPg+rKlwxUtEczPYKfv7cyEafbPos3b01ejU+NFDOlSwDOAgq7aF13tH+cVS?=
 =?us-ascii?Q?hcPLfUkpIHXHwwRBMzzHXsUrYzSf4XQ0dvCK/6Cywvz6N7yyPk8nYkazne4t?=
 =?us-ascii?Q?AadklAFKwxgSRhKTjLjHPgrJggNC+zFVxzE9WpCNMs/EBdHyxubvIqTohjiJ?=
 =?us-ascii?Q?xWOXCnLyYyPYr22OPL/SYJunPvpoWUt+C2FIo5YajlpkyiMhljMAoGju6PwC?=
 =?us-ascii?Q?MITi80TfjcGC0zgEXzeUbH5zhSWcpBstCFwAc47JMChUYLMnXQSGspeXxuwL?=
 =?us-ascii?Q?P8Fg0rHdILHWzufAGTSu1M8gFpRb9IU2W+xyKigLkUcoNTg4Y6jnkv7WgWl2?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dec9b5-77d0-4581-fc2a-08dab61ff827
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:29:25.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnV4+L2gZzkCRH4SvZu6I8/pzl3N5I0BJwZIJ90pP1RFZWoNNYASX328SIfb9LQaotPcY1tThg2MFXC4zmmsM5Rux7UPNYOVCnNMvM2/Hsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 24 Oct 2022 17:31:48 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 24/10/2022 17:01, Vadym Kochan wrote:
> > Switch the DT binding to a YAML schema to enable the DT validation.
> > 
> > Dropped deprecated compatibles and properties described in txt file.
> > 
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> > 
> > v3:
> >   1) Remove txt version from the MAINTAINERS list
> > 
> >   2) Use enum for some of compatible strings
> > 
> >   3) Drop:
> >         #address-cells
> >         #size-cells:
> > 
> >      as they are inherited from the nand-controller.yaml
> > 
> >   4) Add restriction to use 2 clocks for A8K SoC
> > 
> >   5) Dropped description for clock-names and extend it with 
> >      minItems: 1
> > 
> >   6) Drop description for "dmas"
> > 
> >   7) Use "unevalautedProperties: false"
> 
> Hmm... In one place it makes sense. In "nand@" not really.
> 
> > 
> >   8) Drop quites from yaml refs.
> > 
> >   9) Use 4-space indentation for the example section
> > 
> > v2:
> >   1) Fixed warning by yamllint with incorrect indentation for compatible list
> > 
> >  .../bindings/mtd/marvell,nand-controller.yaml | 189 ++++++++++++++++++
> >  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ------------
> >  MAINTAINERS                                   |   1 -
> >  3 files changed, 189 insertions(+), 127 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > new file mode 100644
> > index 000000000000..cb20f14d4aea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > @@ -0,0 +1,189 @@
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
> > +

[...]

> > +      nand-ecc-step-size:
> > +        description: |
> > +          Marvell's NAND flash controller does use fixed strength
> > +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
> > +          will shrink or grow in order to fit the required strength.
> > +          Step sizes are not completely random for all and follow certain
> > +          patterns described in AN-379, "Marvell SoC NFC ECC".
> > +
> > +      label:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +
> > +      partitions:
> > +        type: object
> > +        $ref: /schemas/mtd/partitions/partition.yaml
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Thank you.
> 

I see that I have to drop "label" and "partitions" properties.

> > +
> > +      marvell,nand-keep-config:
> > +        description: |
> > +          Orders the driver not to take the timings from the core and
> > +          leaving them completely untouched. Bootloader timings will then
> > +          be used.
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +
> > +      marvell,nand-enable-arbiter:
> > +        description: |
> > +          To enable the arbiter, all boards blindly used it,
> > +          this bit was set by the bootloader for many boards and even if
> > +          it is marked reserved in several datasheets, it might be needed to set
> > +          it (otherwise it is harmless) so whether or not this property is set,
> > +          the bit is selected by the driver.
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        deprecated: true
> > +
> > +    unevaluatedProperties: false
> 
> This looks wrong. I do not see referencing schema here and I did not ask
> to change it.

Yes, I will drop it.

> 
> > +
> > +    required:
> > +      - reg
> > +      - nand-rb
> > +
> > +unevaluatedProperties: false
> 
> This one is ok.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +allOf:
> > +  - $ref: nand-controller.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: marvell,pxa3xx-nand-controller
> > +    then:
> > +      required:
> > +        - dmas
> > +        - dma-names
> > +    else:
> > +      properties:
> > +        dmas: false
> > +        dma-names: false
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: marvell,armada-8k-nand-controller
> > +    then:
> > +      required:
> > +        - marvell,system-controller
> > +      properties:
> > +        clocks:
> > +          minItems: 2
> 
> Also for clock-names "minItems: 2"
> 
> > +    else:
> > +      properties:
> > +        marvell,system-controller: false
> 
>     clocks:
>       maxItems: 1
> 

OK, so it goes under the "else".

> and the same for clock-names... unless these variants also have two clocks?
> 
> 
> Best regards,
> Krzysztof
> 

Thank you,
Vadym
