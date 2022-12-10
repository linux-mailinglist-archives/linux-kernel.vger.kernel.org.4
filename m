Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B743648FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLJQWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 11:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLJQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:22:22 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C0193F2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 08:22:00 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so11736226lfz.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xa+wgF2f+V8JgfQAupJPW6uYsxXB4NP4JKODbl1KcqE=;
        b=UHt1iU52cWqV3BAWi2M31hRUbBoSdtprzdHKUypxkiBjFMKxbSq9IiRqrhJs03Steo
         JrQUveWNUsk8SrBlSJf86PsiW2o9G02STZ5j5tTMALOTPjklJQ2ApAqDIPIm921N/59b
         lZvDEt9nvEYZYQzOC8zBo87MHwk0WzWGXBZkgvG23G1TLRfVhQaNU7WxYOZVBhAzJ9Ut
         2Mg+RZ4DZJsVluciDSLnYZlrwWnhCq4RLDEkYcOyMYHfMG/AH4oUNpKJPBlRWydGYEMr
         Y0NdDkg3vIDdJEdbBtU5NZtAgfcawxryqFnxxHvWtD3AlTKHOZ3WxR6vapMSSXGX/tSL
         K35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xa+wgF2f+V8JgfQAupJPW6uYsxXB4NP4JKODbl1KcqE=;
        b=RSyj3jRuDFKj74In5I0vGoxyOQcQ11jeykqiYbVgVK8jmWTgHcHNQVEGh2UhGY4n/e
         FnROynq0jB9doo/S79MRIzZmZ2zNbF73KlgFjZwJqXD7zmMF/nmG/cXa6vlOkarIT4dV
         8Bgvb7DVU3ysaL9I/PZgB4SUWF0Cl4KbrJoSYniBZnLrjnLqUqCtVhSWlgx1/EjhPSZe
         y/d2s1l1aeHcYC1Zyh2k8uwoeMsFeCe608ErARrm0rnRx9PAW/cUElgNkJkFhrImA+e6
         H4bvHPvO+399EfFKKjExNThYsVK+5xuFTtruFrT/yZgkSGjSq0l+acoXBVipWLxPtDpt
         QKPQ==
X-Gm-Message-State: ANoB5pkXU5VdhVFHIIo9+elzQTQUDUxQKUJ+3n+YYTMvg7r5ypRTdWs/
        Lox8TgURdYaeT2NwlEsiaNn7bXZiUTxIjsyZVdU9wQ==
X-Google-Smtp-Source: AA0mqf45e7e/ZiGpqcz90FYEYvqQ9RR7rpC8puKLEoNvnvF7lguelAa0o72DjwztPRv1/xDr9IEHXEixoR9K3zAR4lk=
X-Received: by 2002:a05:6512:a83:b0:4aa:f944:f7ec with SMTP id
 m3-20020a0565120a8300b004aaf944f7ecmr27167047lfu.467.1670689318339; Sat, 10
 Dec 2022 08:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20221207062913.3154262-1-bhupesh.sharma@linaro.org>
 <CAA8EJpo30L=KYvrkbnWOrSXGVPk5++r77MTqVd12SZtaUqo-_w@mail.gmail.com>
 <CAH=2Ntw7EKxkrRwp7mqkBm0gGE7=jVruViPa7ZiG1aSA0ipMzQ@mail.gmail.com> <CAA8EJpqUT+Zy0uD+0NnUTbQWOM_+CAfXTU+ED=GwgcNe2MpVHQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqUT+Zy0uD+0NnUTbQWOM_+CAfXTU+ED=GwgcNe2MpVHQ@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 10 Dec 2022 21:51:46 +0530
Message-ID: <CAH=2NtyQKBd3VQczfBzC5GU_y073wBdEH0gJBEfVm1ojsuWSag@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix iommu sid values for PCIe nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@linaro.org,
        andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 at 19:43, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 8 Dec 2022 at 14:05, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > On Thu, 8 Dec 2022 at 16:14, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Wed, 7 Dec 2022 at 09:29, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> > > >
> > > > Fix the iommu sid values for the PCIe nodes present on
> > > > Qualcomm SM8150 SoC dtsi (in sync the with downstream code).
> > >
> > > The commit message describes what you did, not why. Is there any
> > > actual issue that you are trying to solve?
> >
> > Right, I will add that in v2. We have a customer facing some sid
> > related IOMMU transactional errors on sm8150 based boards.
> >
> > > It makes me wonder because all modern Qualcomm platforms share more or
> > > less the same setup.
> >
> > Please see sdm845.dtsi, which does the same as suggested via this
> > patch for sm8150.
>
> Should we also apply the same change to other platforms?

That's a good question. But I have no test data points to say that
this should be valid for other platforms as well. Let me check with
the folks @ qcom who reported this, (i.e. whether they see this with
other qcom platforms as well), but let's not hold back this fix while
we wait for more data.

Thanks.

> > > > Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
> > > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > >
> > > No need to have regular maintainers in Cc tags. Please use regular
> > > git-send-email arguments instead.
> > >
> > > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 32 ++++++++++++++++++++++++++--
> > > >  1 file changed, 30 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > > index d1b64280ab0b..e88d1617a1ab 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > > @@ -1810,9 +1810,23 @@ pcie0: pci@1c00000 {
> > > >                                       "slave_q2a",
> > > >                                       "tbu";
> > > >
> > > > -                       iommus = <&apps_smmu 0x1d80 0x7f>;
> > > > +                       iommus = <&apps_smmu 0x1d80 0xf>;
> > > >                         iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
> > > >                                     <0x100 &apps_smmu 0x1d81 0x1>;
> > >
> > > it looks like the patch was not even compile-tested.
> > >
> > > > +                                   <0x200 &apps_smmu 0x1d82 0x1>,
> > > > +                                   <0x300 &apps_smmu 0x1d83 0x1>,
> > > > +                                   <0x400 &apps_smmu 0x1d84 0x1>,
> > > > +                                   <0x500 &apps_smmu 0x1d85 0x1>,
> > > > +                                   <0x600 &apps_smmu 0x1d86 0x1>,
> > > > +                                   <0x700 &apps_smmu 0x1d87 0x1>,
> > > > +                                   <0x800 &apps_smmu 0x1d88 0x1>,
> > > > +                                   <0x900 &apps_smmu 0x1d89 0x1>,
> > > > +                                   <0xa00 &apps_smmu 0x1d8a 0x1>,
> > > > +                                   <0xb00 &apps_smmu 0x1d8b 0x1>,
> > > > +                                   <0xc00 &apps_smmu 0x1d8c 0x1>,
> > > > +                                   <0xd00 &apps_smmu 0x1d8d 0x1>,
> > > > +                                   <0xe00 &apps_smmu 0x1d8e 0x1>,
> > > > +                                   <0xf00 &apps_smmu 0x1d8f 0x1>;
> > > >
> > > >                         resets = <&gcc GCC_PCIE_0_BCR>;
> > > >                         reset-names = "pci";
> > > > @@ -1909,9 +1923,23 @@ pcie1: pci@1c08000 {
> > > >                         assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> > > >                         assigned-clock-rates = <19200000>;
> > > >
> > > > -                       iommus = <&apps_smmu 0x1e00 0x7f>;
> > > > +                       iommus = <&apps_smmu 0x1e00 0xf>;
> > > >                         iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
> > > >                                     <0x100 &apps_smmu 0x1e01 0x1>;
> > > > +                                   <0x200 &apps_smmu 0x1e02 0x1>,
> > > > +                                   <0x300 &apps_smmu 0x1e03 0x1>,
> > > > +                                   <0x400 &apps_smmu 0x1e04 0x1>,
> > > > +                                   <0x500 &apps_smmu 0x1e05 0x1>,
> > > > +                                   <0x600 &apps_smmu 0x1e06 0x1>,
> > > > +                                   <0x700 &apps_smmu 0x1e07 0x1>,
> > > > +                                   <0x800 &apps_smmu 0x1e08 0x1>,
> > > > +                                   <0x900 &apps_smmu 0x1e09 0x1>,
> > > > +                                   <0xa00 &apps_smmu 0x1e0a 0x1>,
> > > > +                                   <0xb00 &apps_smmu 0x1e0b 0x1>,
> > > > +                                   <0xc00 &apps_smmu 0x1e0c 0x1>,
> > > > +                                   <0xd00 &apps_smmu 0x1e0d 0x1>,
> > > > +                                   <0xe00 &apps_smmu 0x1e0e 0x1>,
> > > > +                                   <0xf00 &apps_smmu 0x1e0f 0x1>;
> > > >
> > > >                         resets = <&gcc GCC_PCIE_1_BCR>;
> > > >                         reset-names = "pci";
> > > > --
> > > > 2.38.1
> > > >
> > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
>
>
> --
> With best wishes
> Dmitry
