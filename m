Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC226C80F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjCXPOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjCXPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:13:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BA13D59;
        Fri, 24 Mar 2023 08:13:23 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OD7YRd030570;
        Fri, 24 Mar 2023 08:13:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=m7eJZqfbGIP6ABsouoQLM79Zjnxq/OgPtKip3ry0izo=;
 b=YSis7Kw2a/yfq4F9YCGEZkudyuF7v0m9EoAHVTKF6U9wmN7aciLoOmmwAtNi7fKX5dhQ
 axIl2L3+l0d5LiBaoQh25H1KTbwV9j92Dpvx7l7qBaEjMG0efZhH11ze0+CLp9j+TnTu
 /cQKk+o8VH9bVk1HJFwELHrJMK62QWe8H+W6prCZQgsgGsNU/1I0ukPTpUdGT3kygOkk
 P71ellgmQQEccshvNH0Xh2Nlc2ByYrcTMY/2o03uyCpHNnhl4uUERRFRhcr2ddk6mZnh
 1EC+ugFxzZDyKz4hEpnLvZmrzN3dqYPE4DgaiZzyD17wLKLovxe0bgMxp7luRd5Ie/Ea yw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3pgxmfjw8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 08:13:12 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 08:13:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 24 Mar 2023 08:13:10 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 328BD3F7059;
        Fri, 24 Mar 2023 08:13:10 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:13:10 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Message-ID: <20230324151310.GB462@Dell2s-9>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-6-pmalgujar@marvell.com>
 <20230228154648.GA3298015-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230228154648.GA3298015-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: enzEamJ42N_bUD1QKajCJrXjvxsJ0_h7
X-Proofpoint-ORIG-GUID: enzEamJ42N_bUD1QKajCJrXjvxsJ0_h7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_09,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review comments.

On Tue, Feb 28, 2023 at 09:46:48AM -0600, Rob Herring wrote:
> On Mon, Feb 27, 2023 at 10:31:50AM -0800, Piyush Malgujar wrote:
> > From: Jayanthi Annadurai <jannadurai@marvell.com>
> > 
> > Add support for SD6 controller support.
> 
> On what h/w?
> 

This has been used and tested on Marvell CN10K series SOCs.

> > 
> > Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
> >  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 24 +++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..0dba17c4f17f82c8ae68e46225ed72418e8361ff 100644
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
> 
> Other than FPGA implementations IP vendor compatible strings are pretty 
> much useless. Define a compatible for your h/w.
> 

ok, will use Marvell specific string here. 

> >  
> >    reg:
> >      maxItems: 1
> > @@ -111,6 +113,24 @@ properties:
> >      minimum: 0
> >      maximum: 0x7f
> >  
> > +  cdns,iocell-input-delay-ps:
> > +    description: Delay in ps across the input IO cells
> > +
> > +  cdns,iocell-output-delay-ps:
> > +    description: Delay in ps across the output IO cells
> > +
> > +  cdns,delay-element-ps:
> > +    description: Delay element in ps used for calculating phy timings
> > +
> > +  cdns,read-dqs-cmd-delay-ps:
> > +    description: Command delay used in HS200 tuning
> > +
> > +  cdns,tune-val-start-ps:
> > +    description: Staring value of data delay used in HS200 tuning
> > +
> > +  cdns,tune-val-step-ps:
> > +    description: Incremental value of data delay used in HS200 tuning
> 
> Wouldn't any controller implementation need these possibly? IIRC, we 
> have some common properties for this. If not, survey what we do have and 
> come up with something common. Or you can imply all this from the h/w 
> specific compatible you are going to add.
> 

These parameters are for sd6 cadence controller, will add sd6 in the property
string so to imply it's specific to sd6hc.

> Rob

Thanks,
Piyush
