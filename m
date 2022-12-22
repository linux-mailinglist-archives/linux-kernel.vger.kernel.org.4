Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB08653E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiLVKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiLVKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:10:21 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2AF1E3C7;
        Thu, 22 Dec 2022 02:10:15 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 64C5E200F3;
        Thu, 22 Dec 2022 11:10:13 +0100 (CET)
Date:   Thu, 22 Dec 2022 11:10:12 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: arm-smmu: Document smmu-500 binding
 for SM6125
Message-ID: <20221222101012.ptrrugxj3ksiyitn@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221216215819.1164973-1-marijn.suijten@somainline.org>
 <20221216215819.1164973-2-marijn.suijten@somainline.org>
 <306709f8-7d45-9b76-f95b-1b3088d37a78@linaro.org>
 <6d263321-782d-9d9c-4fdf-8bcf5b280779@linaro.org>
 <20221219192839.6oqialqqw5xw5fxa@SoMainline.org>
 <b4186ec6-a3f2-4dfb-a83e-25cf6d460a39@linaro.org>
 <20221222082353.lhdw7h3pdqyyvsxy@SoMainline.org>
 <a251f29d-58b7-5ccb-2661-a397e41fba80@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a251f29d-58b7-5ccb-2661-a397e41fba80@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-22 10:29:40, Krzysztof Kozlowski wrote:
> On 22/12/2022 09:23, Marijn Suijten wrote:
> > On 2022-12-20 10:52:49, Krzysztof Kozlowski wrote:
> >> On 19/12/2022 20:28, Marijn Suijten wrote:
> >>> On 2022-12-19 10:09:03, Krzysztof Kozlowski wrote:
> >>>> On 19/12/2022 10:07, Krzysztof Kozlowski wrote:
> >>>>> On 16/12/2022 22:58, Marijn Suijten wrote:
> >>>>>> From: Martin Botka <martin.botka@somainline.org>
> >>>>>>
> >>>>>> Document smmu-500 compatibility with the SM6125 SoC.
> >>>>>>
> >>>>>
> >>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>
> >>>> Wait, not entirely... no constraints for clocks and regs?
> >>>
> >>> Quite odd that there is no warning for my DT patch as it clearly
> >>> requires at least one clock...
> > 
> > Again, any idea why there's no warning for this DT mismatching minItems:
> > 1 for clocks, clock-names and power-domains?
> 
> I don't know what do you have in DT and what is mismatched. Why there
> should be a warning?

There is:

  clock-names:
    minItems: 1
    maxItems: 7

  clocks:
    minItems: 1
    maxItems: 7

But I did not provide _any_ (see patch 2 of this series).  Shouldn't
that trigger a warning?

> >>> Irrespective of that downstream doesn't define any (nor power domains).
> >>> How should we proceed?
> >>
> >> Binding now has constraints for clocks so at least that should be added
> >> to your variant.
> > 
> > And that should be:
> > 
> >     clock-names: false
> >     clocks: false
> >     power-domains: false
> > 
> > Because this board does declare have any, at least not when going off of
> > downstream DT?
> 
> I'll add it for existing platforms, so you can rebase on top.

Thanks, will do!

- Marijn
