Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B467227B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjARQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjARQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:06:04 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A459756;
        Wed, 18 Jan 2023 08:02:48 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I8f4IA009052;
        Wed, 18 Jan 2023 08:02:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=4T0eCnCSn3ot26og/9AC5vrcmhPU97+jbxQrKlHXesQ=;
 b=lFiIIsOcz3AmX6SmtsE4lW6G3FHbl/wEatx5x/Jb15AQrdPUfU1889ukRsoNi0Z196Rs
 AmyCQ92nBG3LUhAuAu3kpVMkboPToEVd3tFjjQpdQMs86rVvf236BJIKQT/2rir6civQ
 ylRFkWEa+g2uqZrjybMuxRjC4u9ygNuN6j8L3Rr4jdJwKrZSSMwhXfPg6+6Pw6Fc0SCx
 kECaBgl+UY3NlwGDcZcGL+BTUwy3tV86inq7uBsOladCoASvdEie8ElQk2eRC33CULL4
 ui4POl2tOQAwHZgZ/so2W71twsC3hO/4cVM9ydbEg8tWnp3vteAe7lFSTDmqYfVyOrIh Lg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n3vstj4xv-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 08:02:27 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Jan
 2023 08:02:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 18 Jan 2023 08:02:18 -0800
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id AEE4A5B695F;
        Wed, 18 Jan 2023 08:02:16 -0800 (PST)
Date:   Wed, 18 Jan 2023 08:02:16 -0800
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>
Subject: Re: [PATCH 3/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Message-ID: <20230118160216.GA19078@Dell2s-9>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-4-pmalgujar@marvell.com>
 <5fc29d3c-e3da-3dc4-bce5-2158b81daa43@linaro.org>
 <20230106164812.GA14720@Dell2s-9>
 <f9d4c883-4b76-c95e-c6dc-a659b4410bf2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f9d4c883-4b76-c95e-c6dc-a659b4410bf2@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 6kslb20W85i3_AAAvtNMJwdG5rQ94t3s
X-Proofpoint-GUID: 6kslb20W85i3_AAAvtNMJwdG5rQ94t3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat, Jan 07, 2023 at 02:25:02PM +0100, Krzysztof Kozlowski wrote:
> On 06/01/2023 17:48, Piyush Malgujar wrote:
> > Hi Krzysztof,
> > 
> > Thank you the review comments.
> > 
> > On Mon, Dec 19, 2022 at 04:40:35PM +0100, Krzysztof Kozlowski wrote:
> >> On 19/12/2022 15:24, Piyush Malgujar wrote:
> >>> From: Jayanthi Annadurai <jannadurai@marvell.com>
> >>>
> >>
> >> Subject: use final prefix matching the file, so "cdns,sdhci:"
> >>
> >>> Add support for SD6 controller support
> >>
> >> Full stop.
> >>
> >>>
> >>> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> >>> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> >>> ---
> >>>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 +++++++++++++++++--
> >>>  1 file changed, 31 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> >>> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..2043e78ccd5f708a01e87fd96ec410418fcd539f 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> >>> @@ -4,7 +4,7 @@
> >>>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
> >>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>  
> >>> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> >>> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
> >>>  
> >>>  maintainers:
> >>>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> >>> @@ -19,6 +19,7 @@ properties:
> >>>            - microchip,mpfs-sd4hc
> >>>            - socionext,uniphier-sd4hc
> >>>        - const: cdns,sd4hc
> >>> +      - const: cdns,sd6hc
> >>
> >> Does not look like you tested the DTS against bindings. Please run `make
> >> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> >> for instructions).
> >>
> >> ... because it does not really make sense. Why do you require SD6HC as
> >> fallback? I think you meant enum.
> >>
> > 
> > Yes, that's correct. I will change it to enum.
> > 
> >>>  
> >>>    reg:
> >>>      maxItems: 1
> >>> @@ -111,6 +112,34 @@ properties:
> >>>      minimum: 0
> >>>      maximum: 0x7f
> >>>  
> >>> +  cdns,iocell_input_delay:
> >>
> >> No underscores. Use proper units in name suffix:
> >> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> >>
> >>
> >>> +    description: Delay in ps across the input IO cells
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>
> >> Ditto... and so on - all of the fields.
> >>
> >>> +
> >>> +  cdns,iocell_output_delay:
> >>> +    description: Delay in ps across the output IO cells
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>> +
> >>> +  cdns,delay_element:
> >>> +    description: Delay element in ps used for calculating phy timings
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>> +
> >>> +  cdns,read_dqs_cmd_delay:
> >>> +    description: Command delay used in HS200 tuning
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>> +
> >>> +  cdns,tune_val_start:
> >>> +    description: Staring value of data delay used in HS200 tuning
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>> +
> >>> +  cdns,tune_val_step:
> >>> +    description: Incremental value of data delay used in HS200 tuning
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>> +
> >>> +  cdns,max_tune_iter:
> >>> +    description: Maximum number of iterations to complete the HS200 tuning process
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>
> >> Why these three are properties of DT?
> >>
> > 
> > These tuning parameters are added here so to make them custom configurable for different
> > boards.
> 
> I understand why do you wanted to add them, but I am asking why these
> are suitable for DT? DT  describes hardware, so what is here specific to
> hardware which requires DT property?
> 
> 

We have different values based on emmc devices populated on different boards and these
tuning parameters are used to program phy registers accordingly.

> Best regards,
> Krzysztof

Thanks,
Piyush> 
