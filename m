Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D664F1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiLPTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiLPTaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:30:20 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C92F646
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:30:18 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8E7923F432;
        Fri, 16 Dec 2022 20:30:16 +0100 (CET)
Date:   Fri, 16 Dec 2022 20:30:15 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Will Deacon <will@kernel.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: iommu: arm-smmu: Add binding for
 sm6125
Message-ID: <20221216193015.3uzmt3cxrlmbxvcf@SoMainline.org>
References: <20210612094606.89576-1-martin.botka@somainline.org>
 <20221114125616.GC30263@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114125616.GC30263@willie-the-truck>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-14 12:56:18, Will Deacon wrote:
> On Sat, Jun 12, 2021 at 11:46:04AM +0200, Martin Botka wrote:
> > This patch adds binding for sm6125 SoC
> > 
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > ---
> > Changes in V2:
> > Add commit description
> > Changes in V3:
> > None
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > index 9d27aa5111d4..26d7ca86e519 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > @@ -37,6 +37,7 @@ properties:
> >                - qcom,sc7280-smmu-500
> >                - qcom,sc8180x-smmu-500
> >                - qcom,sdm845-smmu-500
> > +              - qcom,sm6125-smmu-500
> >                - qcom,sm8150-smmu-500
> >                - qcom,sm8250-smmu-500
> >                - qcom,sm8350-smmu-500
> 
> Neither this patch nor the subsequent driver patch apply. Please can you
> send a v4 based on v6.1-rc1?

It looks like this v3 is from June 2021, while a resend (without v4) was
later sent as:

https://lore.kernel.org/all/20221001185715.495477-1-martin.botka@somainline.org/

I'll skip that and send a v4 of the entire sm6125 iommu, adhering to the
latest compatible conventions.

- Marijn
