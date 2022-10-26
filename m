Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0E60EB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiJZV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiJZV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:57:40 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2099.outbound.protection.outlook.com [40.107.247.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEF1B5FC7;
        Wed, 26 Oct 2022 14:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMGVF1s+IvznZfzBx2xbSKg6bCg8vauNnCswFmkUj+VDDeOqCxnmwjY1bjPOmXeWsr470gl8jJha7wqjYVTdTuvrcVJ4RiXA80tdkTnn4sY/HYOtP0loJaJdpdUdNd9R3jXZOlMhw2Mr8sFW37FAjIDfKixm+ytiQt23Dktu9ESl0GaDJoQNY5ODf2L02bvWf30G4IL0z3t32gPxy/aNhnjHsmM0xM/nIgM5DqYf1q5Fi49akhWBNPW53iwDKmA1+BnqjF5/lTYJzjMBYjIt793aOY/2RIO4aGQ/y1sx1JyIxXf8YaA1sEjnRwgPtvXcuMlSA/vEBQg+q718AIKOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVTpKpJ5aSQsXLfuLBcGt2L9XOl29rRIsDL0OJJST5k=;
 b=QMP4qV7u4OxYgxZ5JxOJksmiZ30bsravVkq8OIiXUPiYxGa3iz6vp8NYvvgItyUJeX2El75OYitISb6VheBWy52at9QJcM1e1Fzfx8kY1eQrVSWDbZi79miRggtSFbQQWhDQrHoKZGB+W6+thkGhaDfgDn3EeZ3uR/5OVXzVhkRRw5tYz7oEn8fveXsxF240i5FqXYw2xnEZWlEH0IqmM3iFxEOUJXiaJXlzWgSlc+5blySrAbjchB/0hQ8mE3QjbX8lUoOjlzNpxD9ZLGZfDXuPEiaXNJgrfbm4wwZZQDl7mcHG9Xi6mdWQi7dF98zGndVCti0kodhoTbItDIIgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVTpKpJ5aSQsXLfuLBcGt2L9XOl29rRIsDL0OJJST5k=;
 b=dTaeQz5DUpivklaHZPp0iMMui6Y0hKq8WN/WyuXvmgsGRvnyIjXPYuMVQ7K5kqse2FDg9c+ZtYEIvOxfmx2wp34HHBVg18oKd/2rd0+ZKlG3eJiywVEwrswe6n3D1lSMQJf0CC5Led+4ZJkwJka5ITmWSPIH2engLYn/XHHBWCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1828.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:34c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 21:57:31 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 21:57:30 +0000
Date:   Thu, 27 Oct 2022 00:57:28 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
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
In-Reply-To: <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
        <20221026134545.7146-2-vadym.kochan@plvision.eu>
        <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DU0P190MB1828:EE_
X-MS-Office365-Filtering-Correlation-Id: 272f621a-0678-4fa1-da36-08dab79d1452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mATtxBbCeTOvjkuaw7eqaAAUHXm6n6uB9O5A1AOwRpQ0zaRfGwoyd2AK14/WNjUDzWZnbyvD7gSVFV5X2s7pET1ckYp44GhMRgfBNZ/VgcLakBwofseshfnl2zhCtqSRx0NCQQlzxe+pX8pLZZjO5KaS1zS3L1kV57MPEurQQCm4i7Vh5f3LtdtSj5FkqhrqzjigjVZyty3OozfqZFv+w1XGEkPY6q8kcMoK7O63lEgJ0kBXEJz6jIUex34uZnnbcfwhiCbOAMBbNqxKp2g9Ooq3nvFwbhvZP0ZZCrLy3H1pwWW1oXqTLH6fuVdWBYbWFD+6Y8O10BURbe7vtnsqcpGKdDYl+KPHehc3uZ9BFoOIwrT2rEZQYAIe05t+NQ1aTxwM8FdUX2+q+AlIpxalJSYS/iRLFqXBRyEaM5yWEu2WInuA8ZOuV52WpGkxjbu92FNUBJ7v8t3yv0hmUIbQK+9PHruKhlyeFGdDClrsvP5lnD01lVmLvubgUTAi2zfCX+AZiLZA421iUahuua4pl8blUcOIW0tbzPtiEIG5xW3sstdIT+FN5KpnFjRxKbXmvAIDdCjWUh3cGYbobF5qG7CegDKGAqs38ivB8dvfV/QIEtJdjPlJB1aF7ucgu1sbi7PqnyhI0OGViqFkqapq7QfFyXnquxm1wdd1GApBtNKOd4B4/BQNZL3ZAhKS6ngzDK9hmoLA2Y5+0lPh2Kag3cDqK4u8ZKwHLa4692zllIyPmwSxJQGjODbCwzl4biXCmwT282or6SUg0OzyXilI4ai5VJXN5twHUW61yFdzRbb210onPsxYOB+Nqp9wJBf/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(34036004)(376002)(39830400003)(366004)(346002)(396003)(451199015)(8936002)(5660300002)(186003)(41320700001)(7696005)(66946007)(4326008)(54906003)(66556008)(2906002)(86362001)(66476007)(316002)(52536014)(44832011)(33656002)(7416002)(110136005)(8676002)(41300700001)(966005)(508600001)(38350700002)(921005)(26005)(38100700002)(9686003)(53546011)(6506007)(83380400001)(55016003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ho5QAJoomSQziz+8aYpU+fOrxBh/Lsc8xxW8/ev0Qsi8STnb5yQ9r1+TUtaa?=
 =?us-ascii?Q?ZvWJrxT3Mm0qK026G7NbL08VIapErWsQBzXgQsiU8N5J+T6CuyToeJodX31W?=
 =?us-ascii?Q?Rnyo1qi1kurw82CCA1Kpn2eNVpEiUWB0sP69uS3tg9O+bdNj48rc+eNpR77A?=
 =?us-ascii?Q?SVrWybL8vQuiAQuKPAeUAXNCTZVCp79N99k9654RThmiwQvVLB1iOO8tnWQ8?=
 =?us-ascii?Q?W1qJRkA7zKJJrDhTpqbTQoDP5kXRvnzjIsnMb7hF3IxONXaegYUTljNhwMap?=
 =?us-ascii?Q?sBplDpQJhivIyasnd09AuugculidpRMvUoGXbzHqr7F55Cp0Bdf9ztmsvACx?=
 =?us-ascii?Q?DFXOsehS7yJGWZw0ZEamSNVx8rP1cSwJxzGZSpkv876mCpOeXYn0wOE94y8V?=
 =?us-ascii?Q?7UC+Ijx3VTqU36/Za4iB4zaHRaP/VKT+gnf9TW0fiogU/YYbHUuHmsUr/+Yw?=
 =?us-ascii?Q?7JJDIgjIrpk37hIBjju8z4UZLtgzJP3iFp9123vT5C7dasMyfunaSTUFAwHt?=
 =?us-ascii?Q?8RMA3YfdPtLAgh4CBkSgHIulL+xv+gPIRUoR0r3+kkDeqS0tpBwp5Ebdx7xx?=
 =?us-ascii?Q?K9ypGn9/yAWzrS9b5CMHdZrn+EDw+lEffQOuSH9ct489jeXw64vxX/z9y25C?=
 =?us-ascii?Q?hRWYUtr4Tojyfvd1tAt1aD7ArlCFRWb/EEt0gfSSselXBhUFa3XDyooE+QOR?=
 =?us-ascii?Q?hb67RxulEInY+AroU3st8QOrm4XYBxhEccAmhpbA9XAesoqeS+uBCfz5tcyQ?=
 =?us-ascii?Q?T/8QfUP1bUGTFLWxoT1wjTLNeTomehB2O4pe07bD1wUZ/CkK9K8veTPXqAcF?=
 =?us-ascii?Q?pzT6nc1DcVw/KvVUN6EoNGO8aYGwNd1AflSdcHc6UmrJLADGXknM97eg8xcy?=
 =?us-ascii?Q?b6EVN3Y65IcVznZnnUDK48E6CuLKD1SDDG/7HATdUchbhaE/9QJk/jdqaEYH?=
 =?us-ascii?Q?ThTDMlY/kiOGD4kqRlAtN6XnQS81P/SjyMlIRJHKwEZUP3Q9RaSIgJPxJVj4?=
 =?us-ascii?Q?Tw/H8zWtelaeiOqQiMVN5B/aiZl1WnfRV9ScJGTc8Q5/YAm8IuQODiKf+DVy?=
 =?us-ascii?Q?IZ3y4mxMd5tmnxRNytcROWrobYxLMj82jHvmy6I9AJgwCAiisrfqEOG5GNQQ?=
 =?us-ascii?Q?eULp5XDdLQgQhTUMJYIZ+xp2GyMBdI8Zah9Bi8JstMmF8xxYvomqT0cvm0aw?=
 =?us-ascii?Q?D/6J1EQwpCXpRhC+yUETLz2lsF1+heoH+p9ntlZvpDnLHju7nQsYNtnlQnbM?=
 =?us-ascii?Q?DwUwJgll9Rf9+cEF7fCcu1axXecwvhXNmyq+ytv6239kiV2HFbjMkQtoap+m?=
 =?us-ascii?Q?gsE1qn/QfV+QmEs9TUphNRqV29PDmrrz3qZwBH9F0yvU9UJtNypuAYgEOUA2?=
 =?us-ascii?Q?G6UsKXxjwG1HLugwVtvJ6vT2eWCFba6bXPAitgDVJaEbAJiwzjjO1XzSzmA/?=
 =?us-ascii?Q?3Y1Lz+ysAua7wvqccBbUInGfpmvPz8rrvkXEeZteRkHJfgnfM8eppzwEqDH/?=
 =?us-ascii?Q?Zc/ibvAEl8i6ILFtzYB5Mm3UEdUSe48W7MchtSK4+M1cg4NEP3MtQldVv7U8?=
 =?us-ascii?Q?mLQEt7zyxyMMTfO/Zyf4lAjQtOWFRYILeI65VdDg/6mYxisfEDx9JmqVxvyu?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 272f621a-0678-4fa1-da36-08dab79d1452
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 21:57:30.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO5LhbK7HCSkaKGmVRY95BeZZERSzH7s3T4K2Cdt6/AhXx3RlBYqllFlZVGa4sySxmGrZtcCVM5up3uTiakhJ72vcDrkx48oj5SpDy2sT6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1828
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

On Wed, 26 Oct 2022 10:03:51 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 26/10/2022 09:45, Vadym Kochan wrote:
> > Switch the DT binding to a YAML schema to enable the DT validation.
> > 
> > Dropped deprecated compatibles and properties described in txt file.
> > 
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> > 
> > v5:
> >    1) Get back "label" and "partitions" properties but without
> >       ref to the "partition.yaml" which was wrongly used.
> > 
> >    2) Add "additionalProperties: false" for nand@ because all possible
> >       properties are described.
> > 
> > v4:
> >    1) Remove "label" and "partitions" properties
> > 
> >    2) Use 2 clocks for A7K/8K platform which is a requirement
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
> > 
> >   8) Drop quites from yaml refs.
> > 
> >   9) Use 4-space indentation for the example section
> > 
> > v2:
> >   1) Fixed warning by yamllint with incorrect indentation for compatible list
> > 
> >  .../bindings/mtd/marvell,nand-controller.yaml | 195 ++++++++++++++++++
> >  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
> >  MAINTAINERS                                   |   1 -
> >  3 files changed, 195 insertions(+), 127 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > new file mode 100644
> > index 000000000000..544e98ed12bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > @@ -0,0 +1,195 @@
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
> > +          - const: marvell,armada370-nand-controller
> > +      - enum:
> > +          - marvell,armada370-nand-controller
> > +          - marvell,pxa3xx-nand-controller
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> 
> What happened to maxItems here? This is wrong. You keep changing random
> things, again. V3 was correct.
> 

It is not random, I tried to enforce to use 2 clocks for A7k/8K case.

> 
> > +    description:
> > +      Shall reference the NAND controller clocks, the second one is
> > +      is only needed for the Armada 7K/8K SoCs
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +      - const: reg
> > +
> > +  dmas:
> > +    maxItems: 1
> > +
> > +  dma-names:
> > +    items:
> > +      - const: rxtx
> > +
> > +  marvell,system-controller:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Syscon node that handles NAND controller related registers
> > +
> > +patternProperties:
> > +  "^nand@[0-3]$":
> > +    type: object
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 3
> > +
> > +      nand-rb:
> > +        minimum: 0
> > +        maximum: 1
> > +
> > +      nand-ecc-strength:
> > +        enum: [1, 4, 8]
> > +
> > +      nand-on-flash-bbt: true
> > +
> > +      nand-ecc-mode: true
> > +
> > +      nand-ecc-algo:
> > +        description: |
> > +          This property is essentially useful when not using hardware ECC.
> > +          Howerver, it may be added when using hardware ECC for clarification
> > +          but will be ignored by the driver because ECC mode is chosen depending
> > +          on the page size and the strength required by the NAND chip.
> > +          This value may be overwritten with nand-ecc-strength property.
> > +
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
> 
> That's not what I asked for. Like four times I asked you to add here
> unevaluatedProperties: false and I never said that ref to partition.yaml
> should be removed and you... instead remove that ref.
> 
> You need to define here children and specify their ref.
> 
> You must use unevaluatedProperties: false here. So this is fifth time I
> am writing this feedback.
> 
> 

It is a bit confusing that it is needed to define "partitions" and "label" rules particulary
in this nand controller instead of some common place like nand-chip.yaml, these properties
are common also for the other nand controllers.

> 
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
> > +    additionalProperties: false
> > +
> > +    required:
> > +      - reg
> > +      - nand-rb
> > +
> > +unevaluatedProperties: false
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
> > +          maxItems: 2
> 
> This does not make sense now...
> 
> Best regards,
> Krzysztof
> 

Thank you,

