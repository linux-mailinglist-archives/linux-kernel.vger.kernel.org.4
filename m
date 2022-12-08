Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA5646E15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLHLI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiLHLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:08:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE892A39
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:05:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b13so1504682lfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=56UZwWb97554Nv5zs14CPUZhHwIthfPCYLibiFwX6EI=;
        b=NLyv9aC5AOITkydXEHI6hvbohVyfAAoi8HK22bF5Ax5YjC4vTb+nH3wTjwRPzzmKFI
         3rSEyHM/ESp2/JC9hbz7piRSVIxDFrU9r5nwbs/6hKqZ2sBTyOIJoMZa3/qT+lMTlIUy
         UFL6wimzU07D0yCJVYsY3r5dC8hx5y3448xHNiw/N5b0ZRaZBDOOIsUYlQwVWxMMODb8
         PZ2jRjIZamYgv5mkaLlSlOFx9rSWWHPhykAmFH6p3j4Qr0F/V0KzhcPXR3z4cK/fECTn
         gpiA1+zW0K3iIb2oZKrQ3XIlgB5L8Vs3R8tT98LA1t0CLFe7dI05zY9210WmwkcdRmT/
         5zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56UZwWb97554Nv5zs14CPUZhHwIthfPCYLibiFwX6EI=;
        b=PdshfrWw9DDbyhAxsFG1xavqNCqOepCUa4DJIIkxTgT2NCpDT1a5E8jmrAmWWNZN4d
         DX3l0MxXDJ2Gky1FCgHAsKXao17c1QfdfNFsrq0uBEtqaqNw23O2idXC/UV9Q+Z0WW7Z
         5dSN+Z/c3grS20bROe0+DHwTbfI9UTViQwxOmCqKiKPHPULI2420yCWfro86c8laeJ/X
         G1/uAOd7hOwnO3fKrYn3cB4S043wc4ObfmWhgP0mEk+YFxe1R/8EsfgkQkus+oAq+x8D
         ZGEhlBxQrKnl6K4UzP2QtqHZBFleLpk7RpYiTyVoAzvWEv2tjADbqaT09GURtOWo/XEw
         t3ig==
X-Gm-Message-State: ANoB5pl3op1M2jcmYxdSI4qFsSSDSdUDrcihzf2ip2R2URfPCPGNEC2Q
        6mN18zCbt42DIRn/9FGASsiDHVx5e8jfqYp5bJMBGA==
X-Google-Smtp-Source: AA0mqf7WJRBHShtLR/6sZYSViQiLyM5jRxy7ThAqmzSVfkySCjQm3jFhbwJuviIHBEmdAl2/+ufnvxhC4ruTHHDwavw=
X-Received: by 2002:a05:6512:a83:b0:4aa:f944:f7ec with SMTP id
 m3-20020a0565120a8300b004aaf944f7ecmr26605425lfu.467.1670497501011; Thu, 08
 Dec 2022 03:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20221207062913.3154262-1-bhupesh.sharma@linaro.org> <CAA8EJpo30L=KYvrkbnWOrSXGVPk5++r77MTqVd12SZtaUqo-_w@mail.gmail.com>
In-Reply-To: <CAA8EJpo30L=KYvrkbnWOrSXGVPk5++r77MTqVd12SZtaUqo-_w@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 8 Dec 2022 16:34:49 +0530
Message-ID: <CAH=2Ntw7EKxkrRwp7mqkBm0gGE7=jVruViPa7ZiG1aSA0ipMzQ@mail.gmail.com>
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

On Thu, 8 Dec 2022 at 16:14, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 7 Dec 2022 at 09:29, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > Fix the iommu sid values for the PCIe nodes present on
> > Qualcomm SM8150 SoC dtsi (in sync the with downstream code).
>
> The commit message describes what you did, not why. Is there any
> actual issue that you are trying to solve?

Right, I will add that in v2. We have a customer facing some sid
related IOMMU transactional errors on sm8150 based boards.

> It makes me wonder because all modern Qualcomm platforms share more or
> less the same setup.

Please see sdm845.dtsi, which does the same as suggested via this
patch for sm8150.

Thanks,
Bhupesh

> > Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
>
> No need to have regular maintainers in Cc tags. Please use regular
> git-send-email arguments instead.
>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 32 ++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > index d1b64280ab0b..e88d1617a1ab 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -1810,9 +1810,23 @@ pcie0: pci@1c00000 {
> >                                       "slave_q2a",
> >                                       "tbu";
> >
> > -                       iommus = <&apps_smmu 0x1d80 0x7f>;
> > +                       iommus = <&apps_smmu 0x1d80 0xf>;
> >                         iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
> >                                     <0x100 &apps_smmu 0x1d81 0x1>;
>
> it looks like the patch was not even compile-tested.
>
> > +                                   <0x200 &apps_smmu 0x1d82 0x1>,
> > +                                   <0x300 &apps_smmu 0x1d83 0x1>,
> > +                                   <0x400 &apps_smmu 0x1d84 0x1>,
> > +                                   <0x500 &apps_smmu 0x1d85 0x1>,
> > +                                   <0x600 &apps_smmu 0x1d86 0x1>,
> > +                                   <0x700 &apps_smmu 0x1d87 0x1>,
> > +                                   <0x800 &apps_smmu 0x1d88 0x1>,
> > +                                   <0x900 &apps_smmu 0x1d89 0x1>,
> > +                                   <0xa00 &apps_smmu 0x1d8a 0x1>,
> > +                                   <0xb00 &apps_smmu 0x1d8b 0x1>,
> > +                                   <0xc00 &apps_smmu 0x1d8c 0x1>,
> > +                                   <0xd00 &apps_smmu 0x1d8d 0x1>,
> > +                                   <0xe00 &apps_smmu 0x1d8e 0x1>,
> > +                                   <0xf00 &apps_smmu 0x1d8f 0x1>;
> >
> >                         resets = <&gcc GCC_PCIE_0_BCR>;
> >                         reset-names = "pci";
> > @@ -1909,9 +1923,23 @@ pcie1: pci@1c08000 {
> >                         assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> >                         assigned-clock-rates = <19200000>;
> >
> > -                       iommus = <&apps_smmu 0x1e00 0x7f>;
> > +                       iommus = <&apps_smmu 0x1e00 0xf>;
> >                         iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
> >                                     <0x100 &apps_smmu 0x1e01 0x1>;
> > +                                   <0x200 &apps_smmu 0x1e02 0x1>,
> > +                                   <0x300 &apps_smmu 0x1e03 0x1>,
> > +                                   <0x400 &apps_smmu 0x1e04 0x1>,
> > +                                   <0x500 &apps_smmu 0x1e05 0x1>,
> > +                                   <0x600 &apps_smmu 0x1e06 0x1>,
> > +                                   <0x700 &apps_smmu 0x1e07 0x1>,
> > +                                   <0x800 &apps_smmu 0x1e08 0x1>,
> > +                                   <0x900 &apps_smmu 0x1e09 0x1>,
> > +                                   <0xa00 &apps_smmu 0x1e0a 0x1>,
> > +                                   <0xb00 &apps_smmu 0x1e0b 0x1>,
> > +                                   <0xc00 &apps_smmu 0x1e0c 0x1>,
> > +                                   <0xd00 &apps_smmu 0x1e0d 0x1>,
> > +                                   <0xe00 &apps_smmu 0x1e0e 0x1>,
> > +                                   <0xf00 &apps_smmu 0x1e0f 0x1>;
> >
> >                         resets = <&gcc GCC_PCIE_1_BCR>;
> >                         reset-names = "pci";
> > --
> > 2.38.1
> >
>
>
> --
> With best wishes
> Dmitry
