Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE66C80A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjCXPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjCXPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:02:30 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D41A67B;
        Fri, 24 Mar 2023 08:02:29 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O6YNpg018286;
        Fri, 24 Mar 2023 08:02:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=KsuiKi0/2VWPXAHDgeXROi/C4iGh0eo1W7TTdfdWANw=;
 b=E2ilRJZUvqrOxMsA9WLLkNbHNHt5hcSu5J03zfU7jmUuLhehfm0VOfZB/iWJ43Xztgeu
 4DelJtNLmV4h3ziokmKiAdt3PXpGZShray/YEymlbh4FsK8rG9cxiBWHe/jMr3OrR4w7
 /hwkxFkeu39jKWIrdGpcsqFMsOTsJZZ0TsVBUKGkDNk+0gDfG/hmFLhN1TEtr6k74Q0n
 xPhyfLoEbdC6BsmAUd3Lv2to2KPAABWGa65IFxsRnRFeemGk0RYAWyNy6dpfHWCHDy/m
 8X5CgGmcV2oUKbZTfz26sKamuQdRb1PaCLAtXIMbp/2P5mJYinWknKpzYSK8GY+GSngm HA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ph6q3smbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 08:02:21 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 08:02:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 24 Mar 2023 08:02:19 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id CCE483F7067;
        Fri, 24 Mar 2023 08:02:19 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:02:19 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Message-ID: <20230324150219.GA462@Dell2s-9>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-6-pmalgujar@marvell.com>
 <90b332b7-ba62-d9b5-2d94-5d2e70fad4af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90b332b7-ba62-d9b5-2d94-5d2e70fad4af@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 0gdXSSbut2TIb_yfuWOQP7iJSSYS0grh
X-Proofpoint-ORIG-GUID: 0gdXSSbut2TIb_yfuWOQP7iJSSYS0grh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the review comments.

On Tue, Feb 28, 2023 at 11:53:51AM +0100, Krzysztof Kozlowski wrote:
> On 27/02/2023 19:31, Piyush Malgujar wrote:
> > From: Jayanthi Annadurai <jannadurai@marvell.com>
> > 
> > Add support for SD6 controller support.
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
> I see here rather random set of changes in each version of this patch.
> This does not really make sense. You are saying that existing (!!!)
> mpfs-sd4hc is compatible with sd6hc. I think you wanted oneOf here, but
> not sure. Can you explain what is your intention? Your commit msg is
> just one line saying the same as subject, so not really helpful.
> 
> 
> Best regards,
> Krzysztof
>

Yes thank you, it should be oneOf as sd6hc is exclusive. I will correct it in the
next version.

Best Regards,
Piyush
