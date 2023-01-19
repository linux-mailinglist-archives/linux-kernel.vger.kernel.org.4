Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83669674C33
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjATF0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjATF0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:26:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF0F7D679;
        Thu, 19 Jan 2023 21:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAD98B826A2;
        Thu, 19 Jan 2023 17:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD721C433EF;
        Thu, 19 Jan 2023 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674149368;
        bh=XjA6FNxjMQiOnXZJOx1apsS33nTEFUkoVAm3T3M6M8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vI7EuC1HYKUg35FJz+wmpXIUQjvqRm71FrejBhtsRO4XtT9ItQR86PhdAESkgM2rl
         7s6IlQzP0XSW7IlxDFPBCZ3z3IsEUxb1WdmYcsnLETy9SdoiX2/nmQhgWGjCOOyabB
         zqGZhMNFrw6TlZ6001HKwUFH4L//OAwWGr8fjwVabhzlAHxlu/eajf3mElNal1fM6M
         SaMmXAd6HflnYdMEot9iGdLyuPeT5RXI6rL0QVXgZdWADTtiEk1BMgHzLEC2/FzJ0h
         R9wXeygOsbBT3A+vniK0UL9rpejY4/y6juSijYU//RhqSTZ2On16QdOoQGkn03Qmu6
         R9u9NciOXNBZg==
Date:   Thu, 19 Jan 2023 17:29:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     iommu@lists.linux.dev, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: iommu: qcom: Add Qualcomm MSM8953
 compatible
Message-ID: <20230119172921.GA20092@willie-the-truck>
References: <20221105142016.93406-1-luca@z3ntu.xyz>
 <20221114134458.GD30263@willie-the-truck>
 <4793103.31r3eYUQgx@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4793103.31r3eYUQgx@g550jk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 10:34:35PM +0100, Luca Weiss wrote:
> On Montag, 14. November 2022 14:44:59 CET Will Deacon wrote:
> > On Sat, Nov 05, 2022 at 03:20:17PM +0100, Luca Weiss wrote:
> > > Document the compatible used for IOMMU on the msm8953 SoC.
> > > 
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > ---
> > > Changes in v5:
> > > * Change subject so it hopefully gets noticed by iommu maintainers
> > > 
> > >   (thanks Krzysztof, maybe this helps..)
> > >  
> > >  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > > b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt index
> > > 059139abce35..e6cecfd360eb 100644
> > > --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > > +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > > @@ -10,6 +10,7 @@ to non-secure vs secure interrupt line.
> > > 
> > >  - compatible       : Should be one of:
> > >                          "qcom,msm8916-iommu"
> > > 
> > > +                        "qcom,msm8953-iommu"
> > > 
> > >                       Followed by "qcom,msm-iommu-v1".
> > 
> > I'd expect the MSM maintainers (i.e Andy and Bjorn) to pick this up.
> 
> Bjorn, could you pick this up for v6.3 please?

Since this seems to be stagnating here, I'll pick it up into the smmu
queue along with the other pending bindings patches I have.

Will
