Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A16647165
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLHONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:13:32 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855E07E438
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:13:31 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c140so1754124ybf.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z5aJtLOuR7FuK5HbTy22FQpW8Dvr68E0rRJLO0HyBk=;
        b=oMLFT7CiEH/WZJjXGiQcL2YeIFMSySLFJwOHBXqBfUpYtZhi/y3/hjBquUv7hfXXtK
         RBd/4pWaU3C//J78g874Ftmevp3GEB9qEm/zre80CUs0NWyxnLfgX7oFYU2u4EUFXN7n
         hPyfOg8BnP04XPhmfgLacW8ue8nLW9y8dhWB2t4DLSeiNQbtNtMNQed65frPzWuOjmKV
         zVNdzEoD93UKR08k40tOWYhaRXvpnOqVQHUk36vPes1z8p3Xq7pWxsDt4Uu+CV/OyRay
         PiAECURGS5pUAr2MwHmjm9wqV5EVcChv7PFxFXu9qQuhQNPjLwCvtZejxE92epJWpwQA
         zVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Z5aJtLOuR7FuK5HbTy22FQpW8Dvr68E0rRJLO0HyBk=;
        b=K+azjQtICzS6KOMiLTGcXThe0WgAFoWHU7N1NqMf0ZrGQRB28Sn3X6onYP2i8AS4CL
         XN7eDDH810fS2/m5PEJuJ+XfRhFssdFoC1X0GgzrhAXspIl9CUb9oPfHmM23Kgi7NDxM
         FFBDZscy25leW0EKFcaZgSkr1qB+eaN2aupTk2cdPVp5DiGB482kCs9Yl+fjh/Jv3mkC
         4HyWN4CjZW57Sh3+aPriNFitFq2XTLksIrCmQgX4KO2UN1K3QipqJwUeIcJF3Ce1uUPa
         2WAezKqgjyxkmx+lamR6kSznn7IYFLlFP4zk5KkUS17/ugSI2Js69zzQL4fYo2sgmK6f
         H4ew==
X-Gm-Message-State: ANoB5pm36iTYzIHACTDl1f8en2Uxzens7x+akp9AveZCvuT6GxGyQ+QT
        DhbmaQocZIuQlB89L1KghjYp0ZeW6YJk9jAYCC9w3YCnKpG6IA==
X-Google-Smtp-Source: AA0mqf7BVGb/EIkFUaHqlMWOuRls39ddO5l5iNFgrXGZGIwAL1UtqvApnlXb3rvZfj2yAM/L4i77IP5/4pDvbZCoSqY=
X-Received: by 2002:a05:6902:114f:b0:701:161b:d3b1 with SMTP id
 p15-20020a056902114f00b00701161bd3b1mr17092268ybu.194.1670508810698; Thu, 08
 Dec 2022 06:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20221207062913.3154262-1-bhupesh.sharma@linaro.org>
 <CAA8EJpo30L=KYvrkbnWOrSXGVPk5++r77MTqVd12SZtaUqo-_w@mail.gmail.com> <CAH=2Ntw7EKxkrRwp7mqkBm0gGE7=jVruViPa7ZiG1aSA0ipMzQ@mail.gmail.com>
In-Reply-To: <CAH=2Ntw7EKxkrRwp7mqkBm0gGE7=jVruViPa7ZiG1aSA0ipMzQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 8 Dec 2022 17:13:20 +0300
Message-ID: <CAA8EJpqUT+Zy0uD+0NnUTbQWOM_+CAfXTU+ED=GwgcNe2MpVHQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix iommu sid values for PCIe nodes
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@linaro.org,
        andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 at 14:05, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> On Thu, 8 Dec 2022 at 16:14, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 7 Dec 2022 at 09:29, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> > >
> > > Fix the iommu sid values for the PCIe nodes present on
> > > Qualcomm SM8150 SoC dtsi (in sync the with downstream code).
> >
> > The commit message describes what you did, not why. Is there any
> > actual issue that you are trying to solve?
>
> Right, I will add that in v2. We have a customer facing some sid
> related IOMMU transactional errors on sm8150 based boards.
>
> > It makes me wonder because all modern Qualcomm platforms share more or
> > less the same setup.
>
> Please see sdm845.dtsi, which does the same as suggested via this
> patch for sm8150.

Should we also apply the same change to other platforms?

>
> Thanks,
> Bhupesh
>
> > > Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
> > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> >
> > No need to have regular maintainers in Cc tags. Please use regular
> > git-send-email arguments instead.
> >
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 32 ++++++++++++++++++++++++++--
> > >  1 file changed, 30 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > index d1b64280ab0b..e88d1617a1ab 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > @@ -1810,9 +1810,23 @@ pcie0: pci@1c00000 {
> > >                                       "slave_q2a",
> > >                                       "tbu";
> > >
> > > -                       iommus = <&apps_smmu 0x1d80 0x7f>;
> > > +                       iommus = <&apps_smmu 0x1d80 0xf>;
> > >                         iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
> > >                                     <0x100 &apps_smmu 0x1d81 0x1>;
> >
> > it looks like the patch was not even compile-tested.
> >
> > > +                                   <0x200 &apps_smmu 0x1d82 0x1>,
> > > +                                   <0x300 &apps_smmu 0x1d83 0x1>,
> > > +                                   <0x400 &apps_smmu 0x1d84 0x1>,
> > > +                                   <0x500 &apps_smmu 0x1d85 0x1>,
> > > +                                   <0x600 &apps_smmu 0x1d86 0x1>,
> > > +                                   <0x700 &apps_smmu 0x1d87 0x1>,
> > > +                                   <0x800 &apps_smmu 0x1d88 0x1>,
> > > +                                   <0x900 &apps_smmu 0x1d89 0x1>,
> > > +                                   <0xa00 &apps_smmu 0x1d8a 0x1>,
> > > +                                   <0xb00 &apps_smmu 0x1d8b 0x1>,
> > > +                                   <0xc00 &apps_smmu 0x1d8c 0x1>,
> > > +                                   <0xd00 &apps_smmu 0x1d8d 0x1>,
> > > +                                   <0xe00 &apps_smmu 0x1d8e 0x1>,
> > > +                                   <0xf00 &apps_smmu 0x1d8f 0x1>;
> > >
> > >                         resets = <&gcc GCC_PCIE_0_BCR>;
> > >                         reset-names = "pci";
> > > @@ -1909,9 +1923,23 @@ pcie1: pci@1c08000 {
> > >                         assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> > >                         assigned-clock-rates = <19200000>;
> > >
> > > -                       iommus = <&apps_smmu 0x1e00 0x7f>;
> > > +                       iommus = <&apps_smmu 0x1e00 0xf>;
> > >                         iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
> > >                                     <0x100 &apps_smmu 0x1e01 0x1>;
> > > +                                   <0x200 &apps_smmu 0x1e02 0x1>,
> > > +                                   <0x300 &apps_smmu 0x1e03 0x1>,
> > > +                                   <0x400 &apps_smmu 0x1e04 0x1>,
> > > +                                   <0x500 &apps_smmu 0x1e05 0x1>,
> > > +                                   <0x600 &apps_smmu 0x1e06 0x1>,
> > > +                                   <0x700 &apps_smmu 0x1e07 0x1>,
> > > +                                   <0x800 &apps_smmu 0x1e08 0x1>,
> > > +                                   <0x900 &apps_smmu 0x1e09 0x1>,
> > > +                                   <0xa00 &apps_smmu 0x1e0a 0x1>,
> > > +                                   <0xb00 &apps_smmu 0x1e0b 0x1>,
> > > +                                   <0xc00 &apps_smmu 0x1e0c 0x1>,
> > > +                                   <0xd00 &apps_smmu 0x1e0d 0x1>,
> > > +                                   <0xe00 &apps_smmu 0x1e0e 0x1>,
> > > +                                   <0xf00 &apps_smmu 0x1e0f 0x1>;
> > >
> > >                         resets = <&gcc GCC_PCIE_1_BCR>;
> > >                         reset-names = "pci";
> > > --
> > > 2.38.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
