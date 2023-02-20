Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1869CBF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBTNXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBTNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:22:32 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4661A646;
        Mon, 20 Feb 2023 05:22:30 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCRDP6007741;
        Mon, 20 Feb 2023 05:22:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=dhKelfLH8aJy1+bLl4u6+viGj8jNiDdLf7QWa3W/h7M=;
 b=QcBLBbnZ3QxONV9Cf5tKUiK/wiG9gG4UpzVbUJelFMGyGffaiErfbAZNVloTzw5YZpvN
 BXDxpTvtnZUT8l3Qnvayns4lEOehmxwdyAbMqsciEPniawfVe79rffDYXROAarQ/du7l
 7wunEGUEoW7aFIys7pUdyhYrUVErX1AsR6/ESEnUtsL7N6MRjof4hkGalMnJFT3xMESE
 Qo++nsPMuEefPbyaXOF5wN2dg+nYfvwuvb8OoQX2Zuw/K0slJtTdOjfdE1TJPCXB+Caa
 aPULn7p2Ixuo3HfFOeis/dK0DMVQQCKvJkYCEcCODycwMn1ClAUQayGINSMCEBIuN3ON rQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nty2yy8kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 05:22:17 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Feb
 2023 05:22:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 20 Feb 2023 05:22:14 -0800
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 795D93F7073;
        Mon, 20 Feb 2023 05:22:14 -0800 (PST)
Date:   Mon, 20 Feb 2023 05:22:14 -0800
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Message-ID: <20230220132214.GA24729@Dell2s-9>
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-5-pmalgujar@marvell.com>
 <d05161ed-eb30-2d4d-e9bc-4b40e8ae09e7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d05161ed-eb30-2d4d-e9bc-4b40e8ae09e7@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: tBUWEJSQod4CqVY50BpMJx56NXMKGx1i
X-Proofpoint-ORIG-GUID: tBUWEJSQod4CqVY50BpMJx56NXMKGx1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_11,2023-02-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for your review comments.

On Mon, Jan 23, 2023 at 08:42:54PM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2023 20:27, Piyush Malgujar wrote:
> > From: Jayanthi Annadurai <jannadurai@marvell.com>
> > 
> > Add support for SD6 controller support.
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
> > 
> > Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
> >  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 34 +++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..26ef2804aa9e17c583adaa906338ec7af8c4990b 100644
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
> > @@ -18,7 +18,9 @@ properties:
> >        - enum:
> >            - microchip,mpfs-sd4hc
> >            - socionext,uniphier-sd4hc
> > -      - const: cdns,sd4hc
> > +      - enum:
> > +          - cdns,sd4hc
> > +          - cdns,sd6hc
> >  
> >    reg:
> >      maxItems: 1
> > @@ -111,6 +113,34 @@ properties:
> >      minimum: 0
> >      maximum: 0x7f
> >  
> > +  cdns,iocell-input-delay:
> > +    description: Delay in ps across the input IO cells
> 
> Use proper unit suffix -ps, so ref wont' be needed.
> 
> This comment was also ignored.
> 
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,iocell-output-delay:
> > +    description: Delay in ps across the output IO cells
> 
> Ditto
> 
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,delay-element:
> > +    description: Delay element in ps used for calculating phy timings
> 
> Ditto
> 

Yes, will add -ps and remove the $ref.

> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  cdns,read-dqs-cmd-delay:
> > +    description: Command delay used in HS200 tuning
> 
> What are the units?
> 
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> 
> Drop quotes (everywhere)
> 
> > +
> > +  cdns,tune-val-start:
> > +    description: Staring value of data delay used in HS200 tuning
> 
> Same problem - missing units.
> 

These are integer values, will add in the description that these units are integer used
in tuning. Also, will remove the $ref.

> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> 
> 
> I don't get why the feedback has to be repeated. It's a bit a waste of
> time, isn't it?
> 
> Best regards,
> Krzysztof
> 

Please let me know if with above changes, it will be good and acceptable for V3.

Thanks,
Piyush

