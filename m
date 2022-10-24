Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4B60BC62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJXVmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJXVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:41:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20710.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::710])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68C169102;
        Mon, 24 Oct 2022 12:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNO7kuAuTr73O3I38OJEy3BX63yxmGWJt/6q5U2acplv7iQhkxOgIjaagMg2JP5EeqoBt0dVwbJ032MJRWbVdtqYq8IiGqvqsCI6Uj2UkBMtyG9P1KzLZZvF7ro6Qp9dv0mYrSyWCWZRw/LaYEglokHGh2aZGACU1UstYoE6U/fCH6pvq/HjeNk3QKbBl/s53IWdodGBei9d8QetP81Je00qhRX+VQSYndbPvCs2ca/4LAj4xvArrOZzHstFviEXV/BBuwPl9mRsFX0Y1HFyVElq0Mgv6RPmKAspPdBNWTabp34ZA/W97jWZF6xgSXH5b5VjOz+yFFp1pF3Q2faNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01HtayiXVIPLrgRMdJ2YaZlOiyAYH7R7InsDUxd4ujM=;
 b=BMOkirGtJQCjKU830FswQbgPeDvPI385QNUkGci860HM6cCEutF5T2H9RrSW4pyLkTlLS4nZ0XVo7FKdp7KGACPuGfSzufvfXAgpwJxpmYGxABUSH1VXXC5Cpky9i2sproI97HUgOI8FSQZNu2/OnmUrVxkYU63Pnyws2UQcs7V1uh6uFhVmBaeSlkdqnQ6dmfyqeMXv8CB45TxkIgi9RNZHX7Dc1OE6d5mr8h5GFuh5aT/D/tGfBObXqFScV2NSmkKu1y8mrRzOkYe7I+UDFY/uX2fR3klGVGu4j8wwdT9F7k8FAJBZ45tNblU4m2TE9RSIGceH060YDu7IXeoWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01HtayiXVIPLrgRMdJ2YaZlOiyAYH7R7InsDUxd4ujM=;
 b=wW0iQ/Bhfo8HbEZmrhGUdjqff8LI+5U3tVPLjei1Ok6PT9mjbwBdssH8l28erpHiskBPBHzGXcVArY9WxUzBsOIL/jkhs9dtzNeMiC5KUM93+01dIVj2FGjM6JcQl2UW5AXwtSCGCnIRPTu9pw/Pq7EsYSX3MOKF69VEvbxaWz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1742.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 24 Oct
 2022 19:48:56 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 19:48:56 +0000
Date:   Mon, 24 Oct 2022 22:48:54 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
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
Cc:     Elad Nachman <enachman@marvell.com>
In-Reply-To: <a46c6a18-903d-2120-4876-509ce8ad19d5@linaro.org>
References: <20221021194552.683-1-vadym.kochan@plvision.eu>
        <20221021194552.683-2-vadym.kochan@plvision.eu>
        <a46c6a18-903d-2120-4876-509ce8ad19d5@linaro.org>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB03170416FB2C521103B8EE1A952E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PAXP190MB1742:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbdf6dd-0349-402f-6a97-08dab5f8c93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEJHvnxeXLgZkJNS6lYEE5O7IKLQBf9GciQtDRznUVcIpCVNx9zqVjcEg962RkoYnARo7kJO/eKFdeQlKpWshvombPfhrYFY0GsBQS85Q/9LnIY9Rpu1z7XnAAhASLLHLBOBx1n04hSxbrLbME/ObwzmJtvDFOOGAjhh+LfXAKSCjkk44FxT9DJoxh+xsRqK985uFDvtkqM0nG3BdWLJi6/fpiIvYlw473pE8NDTsES08T+/BX3HJ2fm2ZzcquyzIGJVGuWNjY+dIlg4l1Js5DU/zt8ylXcwM4NmH/8sP01hkS3eGzawbkpYnCqvUolpa19ebi+6BDsanpyIb/82YSws++6FhLb3TzVssHRw0ng4M6AmebSj4J/c3lE11jVo5Yn/lGZNty921PnGMfZ3KxHZatMbad9FAhCD7iv3g1yyJttgDIEbRutehRBqwt8WC1ik7mQfW46ACq8iKDeslQvAF6QnQ5Oip1R+nxOnBCHYjsjZC0CuwdPuh6+lLpQ3+7ByPmaLAIv/NsTE9ZDfZTfaFR80L0P4LFiwcsUxo+z4v2mkvBm4q3/741pJFNQgyFFfrVkSD8xC0rrlbQxdjlE2FW5HKWFgdwVkr0526ANLZBWdnad0tGYn/EpyA9swQkvM/SutdxvmV8eojanhWNU7eMZLDMvDbYeJaBsb1Xambke389QV/a59N8zZitLBCsPXRebkmYm8d6TknNdLxfuaZmViKbCSYgwsMcG/R/x6E6ot+5Ga1MxqPZ2lchvZXtAEEgKV829vdKIBjEngTeBo2qHN7YauEwjY+mLurvW2Cb9ylILNFjmQEiBXJyf3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(34036004)(39840400004)(376002)(366004)(136003)(346002)(451199015)(7416002)(921005)(5660300002)(38100700002)(38350700002)(4326008)(66946007)(316002)(86362001)(110136005)(8676002)(66556008)(44832011)(66476007)(8936002)(83380400001)(186003)(53546011)(41300700001)(52536014)(966005)(52116002)(2906002)(6506007)(26005)(508600001)(7696005)(9686003)(41320700001)(33656002)(55016003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dmT+9NQfrtUvY0a9mxf+EL6TwanhErYoROaO2eagnSkQax6HrDB9+ZWKZo4?=
 =?us-ascii?Q?wsqQPNWPB4Ni8yUm0/9IiXg2exW5UhsMoVC+Sd0q4zWq/LtaZhF47q69+66a?=
 =?us-ascii?Q?K46NIHIw7XLC7ZpPH2TIf6kmfBfTmdugSkgEmmb54XL6zFRIpUncWrWCu8KW?=
 =?us-ascii?Q?62mOdpX4jReSQczY8glPjL/ahfLhZM1wRi1PX2eBRiUJRFnzpJjV8PXZvmtX?=
 =?us-ascii?Q?2/IHABWWk4Gv8YwURMITEIOxwkFWKuNrQ8l3KOwizXnUcoKOoIAb6b7UCPcm?=
 =?us-ascii?Q?3/Fb3Sn0GgkGhW+nq5ongvV6akC0dtht3E/bSfYd5G1dsYJWEqPiJaMrLhd1?=
 =?us-ascii?Q?XthFyRsGuXFmx3WzZxXbOBASaiH2mpx+MQSPHqTpfsPDIcda0pPtgD25XQmd?=
 =?us-ascii?Q?W3aBfdpyCn64+1yulu6vRcxNPcKrUqw4Z/Zxh2c4jzbdzA7VubMqsyd+8wsH?=
 =?us-ascii?Q?z93qAdwUkm/8EQqKrLuTx4uVQ5YyD67ReSAmqRPcG/7oK3p2ZWdCoQ8ymP6P?=
 =?us-ascii?Q?5sRpClKUFq+h4ka7Z2brSB8xPGlM2crewEfZ5wgWf6YYuA8+rg+VJxzXaD5T?=
 =?us-ascii?Q?0JVtTaVi6njU2+efnR81MmOAF2SolC6bh86CIZqyFi5WIISyoekqK0uW5dWK?=
 =?us-ascii?Q?5pxY4g14VS1yFVTXrJCAZyfPpW9hu7++SiX2SpiTWSA3frYjnTUDaplI6AXb?=
 =?us-ascii?Q?81K4EFTKM1BnFF9Nkk4LBvUvhMYbrtktsmuUrn6z8KL6vjnzIkJJHbvQRPIw?=
 =?us-ascii?Q?+AxD5WFWh8/v4JFlT30atWmFJVt3Smn+6T+C9QR9HdQ7Wof/CWM8pGgyrZsQ?=
 =?us-ascii?Q?cN5HTZJlMCoK9LIvFfMeSDvbga6P/5rmCuhmTsbME7IkqsgccY4WNKkBgxfz?=
 =?us-ascii?Q?yzU977jfMtrub+BCm//M8VsUhP5/O+LDBBOh+ihC8+5+ulxngJa5AidT44w6?=
 =?us-ascii?Q?MP9XgaylnmXlVkeF7bRczfLXU7+yV4qtiu4hLn471QBOQolonPVOEzaockQ2?=
 =?us-ascii?Q?IVmNMwUdUrJdgTB+DG3yYVQRAtWSxCIBHG9o9sZbrt9Wvl/c/pVSVsVIhPis?=
 =?us-ascii?Q?ghHJ7+vctayrHTSBAGjqHYRagQ4ph5uOR5tjcuHXAAA1rwNrnMwvYu3wB2Eo?=
 =?us-ascii?Q?dIX1H1czHbVHVwc388qxpJDXLPRreB/pjII+jh1YA+rZQAVt+wa0fGJd0wrm?=
 =?us-ascii?Q?00saECUbKURt9ZlSQvTYtCSS4rSJNXgCIlm5eood+kgymMdOm282ac+V842O?=
 =?us-ascii?Q?9YpdPZYEXxyW3PH145O4yewxhfq5DIF6FyofCeNJua7AZ6VeLqi6S5/0lAd2?=
 =?us-ascii?Q?BR9bQCR01o38pjm6jmU9E3kdlbRvhdPRzVZKlJ7uS5C1RwPS0M1nYKHKpZuX?=
 =?us-ascii?Q?J6UUj70j+nuoC7lMRgP3R9n9P0VFM53M+LzNcUetz2WValiXOWXIlrzHeKn+?=
 =?us-ascii?Q?UqYGNgRvFHRTJvUfuIIhjhRXnr1JbZBss37S+cBaIUdgZh9Oy/tWKdKXYdoj?=
 =?us-ascii?Q?dv96fMKVzn77SapiXTmaydch98wzI9Sbx5JdocPewXKsWrzeAO3WgUGUNT4L?=
 =?us-ascii?Q?muIuNl1wxOEBgGCOoi+E+S/XKEQoBjwPkVmEdhQQS07BQ5oB4FhFXQll9tdL?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbdf6dd-0349-402f-6a97-08dab5f8c93f
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:48:56.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhw8Wid4TF8/e6GRBDyrUVGwh4322j+G20V8eLGzAqRBq0sEwXewwJ1tgwlvcDSTxkRTj55A6XZI5XUKywwBuwGY5Ac7Su1qqQzWl+MeLVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1742
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat, 22 Oct 2022 12:18:49 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 21/10/2022 15:45, Vadym Kochan wrote:
> > Switch the DT binding to a YAML schema to enable the DT validation.
> > 
> > Dropped deprecated compatibles and properties described in txt file.
> > 
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> >  .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
> >  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
> >  2 files changed, 199 insertions(+), 126 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > new file mode 100644
> > index 000000000000..535b7f8903c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > @@ -0,0 +1,199 @@
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
> 
> This should be someone responsible for hardware, not subsystem
> maintainer. Unless by coincidence Miquel matches both. :)
> 
> > +
> > +properties:
> > +
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - const: marvell,armada-8k-nand-controller
> > +        - const: marvell,armada370-nand-controller
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).

Yes, on v1 I did not use yamllint, but installed after Rob pointed
on some lint warnings.

> 
> > +      - const: marvell,armada370-nand-controller
> > +      - const: marvell,pxa3xx-nand-controller
> 
> These two are just enum.
> 

OK.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> 
> Drop, comes with nand-controller.yaml
> 

OK.

> > +
> > +  "#size-cells":
> > +    const: 0
> 
> Ditto
> 

OK.

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> 
> No need for |
> 
> > +     Shall reference the NAND controller clocks, the second one is
> > +     is only needed for the Armada 7K/8K SoCs
> 
> You need allOf:if:then restricting it further per variant.
> 

OK, added.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +      - const: reg
> > +    description: |
> > +      Mandatory if there is a second clock, in this case there
> > +      should be one clock named "core" and another one named "reg"
> 
> The message is confusing. What is mandatory if there is a second clock?
> Plus, the binding requires two clocks.
> 
> Drop entire description.
> 
> minItems: 1
> 

OK, droped (I used from the txt version).
Added minItems.

> 
> > +
> > +  dmas:
> > +    maxItems: 1
> > +    description: rxtx DMA channel
> 
> Drop description.
> 

OK.

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
> > +
> 
> Drop blank line.
> 

OK.

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
> > +        const: 512
> 
> Why this is const?
> 

Removed const.

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
> > +        $ref: "/schemas/mtd/partitions/partition.yaml"
> 
> Drop quotes
> 

OK.

>         unevalautedProperties: false
> 
> and then you will see errors, because you referenced schema for one
> partition.
> 

Hm, I did not see errors with partitions with- or without "unevaluatedProperties".

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
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> 
> Drop these two - required by nand-controller.

OK.

> 
> > +  - interrupts
> > +  - clocks
> > +
> > +allOf:
> > +  - $ref: "nand-controller.yaml#"
> 
> Drop quotes.
> 

OK.

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
> > +    else:
> > +      properties:
> > +        marvell,system-controller: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    nand_controller: nand-controller@d0000 {
> > +            compatible = "marvell,armada370-nand-controller";
> > +            reg = <0xd0000 0x54>;
> 
> Use 4 spaces for example indentation.
> 

OK.

> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +            clocks = <&coredivclk 0>;
> > +
> 
> Best regards,
> Krzysztof
> 

Thanks for the comments.
