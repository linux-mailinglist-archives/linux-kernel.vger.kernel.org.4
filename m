Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F76946DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBMNXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBMNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:23:18 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232576EBA;
        Mon, 13 Feb 2023 05:23:17 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 946FD26F77F; Mon, 13 Feb 2023 14:23:15 +0100 (CET)
Date:   Mon, 13 Feb 2023 14:23:15 +0100
From:   Janne Grunau <j@jannau.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 07/17] dt-bindings: iommu: apple,sart: Add
 apple,t8112-sart compatible string
Message-ID: <20230213132315.GC17933@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-7-cb5442d1c229@jannau.net>
 <6e18ab3a-512e-ffe2-1c88-9b57bd1d3960@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e18ab3a-512e-ffe2-1c88-9b57bd1d3960@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 12:13:55 +0100, Krzysztof Kozlowski wrote:
> On 12/02/2023 16:41, Janne Grunau wrote:
> > "apple,t8112-sart" as found on the Apple M2 SoC appears to be SART3 as
> > well. To allow for later discovered incompatibilities use
> > '"apple,t8112-sart", "apple,t6000-sart"' as compatible string.
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > 
> > ---
> > This trivial dt-bindings update should be merged through the asahi-soc
> > tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> > series.
> 
> Same comment as in other cases.

dropped from all commits and cover letter.

> > ---
> >  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> > index 1524fa3094ef..07d2d68a87df 100644
> > --- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> > @@ -28,9 +28,14 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - apple,t6000-sart
> > -      - apple,t8103-sart
> > +    oneOf:
> > +      - items:
> > +          - const: apple,t8112-sart
> > +          - const: apple,t6000-sart
> > +      - items:
> 
> Drop items.

done

> > +          enum:
> > +            - apple,t6000-sart
> > +            - apple,t8103-sart
> >  
> >    reg:
> >      maxItems: 1
> > 

thanks

