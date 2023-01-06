Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF697660514
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjAFQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjAFQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:49:33 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF967A3BA;
        Fri,  6 Jan 2023 08:48:29 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306GlDbE031052;
        Fri, 6 Jan 2023 08:48:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=iFGa7sCejpLjxBrJt2qUGf4PBail2P7nsKTUm1JWp34=;
 b=fn4GDrET5PqE+4Y/hdYUZjURYrE0SpSl52bTiU7/uuUGOiRDaU2WvxfHFM1RcIIfdNLR
 r5a4wfa0T5FWbt2aENuVjbA9I31CNYeR5URHKyO7uNAOqUu9Gy5mJ6rdaiLHOrp5w8dD
 O8hL2yhAWLOvSRCSU90C9p0apY97G6opzKwjIldziFL9Yv6jsCEkl3jyBWzQM78SW6Qd
 EVzBXdkb95/vT7xTU/7kdbXpF98MhAamPzMbTcLO7N1r2/6RifrGlQcLinZdxUwRFYno
 9CkYT1O54cv4CO1tLeQt2AKxPCRxApjCuIDasB10ObHuKpM2lXf8IEn+vxkXcGzazxb3 Fw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3mxemv9wgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 08:48:15 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 6 Jan
 2023 08:48:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 6 Jan 2023 08:48:13 -0800
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id EB3033F7072;
        Fri,  6 Jan 2023 08:48:12 -0800 (PST)
Date:   Fri, 6 Jan 2023 08:48:12 -0800
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>
Subject: Re: [PATCH 3/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Message-ID: <20230106164812.GA14720@Dell2s-9>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-4-pmalgujar@marvell.com>
 <5fc29d3c-e3da-3dc4-bce5-2158b81daa43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5fc29d3c-e3da-3dc4-bce5-2158b81daa43@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: HTm2pA0fiwcfzVWCF3EuzxN6iv6MJ-dV
X-Proofpoint-ORIG-GUID: HTm2pA0fiwcfzVWCF3EuzxN6iv6MJ-dV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_10,2023-01-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you the review comments.

On Mon, Dec 19, 2022 at 04:40:35PM +0100, Krzysztof Kozlowski wrote:
> On 19/12/2022 15:24, Piyush Malgujar wrote:
> > From: Jayanthi Annadurai <jannadurai@marvell.com>
> > 
> 
> Subject: use final prefix matching the file, so "cdns,sdhci:"
> 
> > Add support for SD6 controller support
> 
> Full stop.
> 
> > 
> > Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
> >  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 +++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..2043e78ccd5f708a01e87fd96ec410418fcd539f 100644
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -4,7 +4,7 @@
> >  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> > +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
> >  
> >  maintainers:
> >    - Masahiro Yamada <yamada.masahiro@socionext.com>
> > @@ -19,6 +19,7 @@ properties:
> >            - microchip,mpfs-sd4hc
> >            - socionext,uniphier-sd4hc
> >        - const: cdns,sd4hc
> > +      - const: cdns,sd6hc
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
> 
> ... because it does not really make sense. Why do you require SD6HC as
> fallback? I think you meant enum.
> 

Yes, that's correct. I will change it to enum.

> >  
> >    reg:
> >      maxItems: 1
> > @@ -111,6 +112,34 @@ properties:
> >      minimum: 0
> >      maximum: 0x7f
> >  
> > +  cdns,iocell_input_delay:
> 
> No underscores. Use proper units in name suffix:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> 
> > +    description: Delay in ps across the input IO cells
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> 
> Ditto... and so on - all of the fields.
> 
> > +
> > +  cdns,iocell_output_delay:
> > +    description: Delay in ps across the output IO cells
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,delay_element:
> > +    description: Delay element in ps used for calculating phy timings
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,read_dqs_cmd_delay:
> > +    description: Command delay used in HS200 tuning
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,tune_val_start:
> > +    description: Staring value of data delay used in HS200 tuning
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,tune_val_step:
> > +    description: Incremental value of data delay used in HS200 tuning
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,max_tune_iter:
> > +    description: Maximum number of iterations to complete the HS200 tuning process
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> 
> Why these three are properties of DT?
> 

These tuning parameters are added here so to make them custom configurable for different
boards.

> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -122,7 +151,7 @@ unevaluatedProperties: false
> >  examples:
> >    - |
> >      emmc: mmc@5a000000 {
> > -        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> > +        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc", "cdns,sd6hc";
> 
> This is confusing. I don't understand it. It requires much more
> explanation in your commit msg.
> 
> >          reg = <0x5a000000 0x400>;
> >          interrupts = <0 78 4>;
> >          clocks = <&clk 4>;
> 
> Best regards,
> Krzysztof
> 

Rest of the comments will be taken care in V2.

Thanks,
Piyush
