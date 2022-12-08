Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11928646E09
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLHLH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiLHLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:07:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC85B862
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:03:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b13so1497304lfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 03:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjd0LIY6puJkC/hEm5cZ8epGnqrESFVGEAPoWq9xwks=;
        b=fRuxAr2R4iNQXxwvnPQITfCge+kyhljMGA0ixWSVTtVgBNe9Qy0YLTEepKEo6eYF9g
         eVpY4UQSOBEAJR8J3ku5BoG8PAC/1rLsaCH2t8hmHSgiJlw4SO/Z57HM+uQXLC3wKDXY
         kmMc/JIvE/Aj7CNj/spmvV4IzToPJUByFCZeos0bCCEQoxzKszBBqwVgpWFCQwgmGbjZ
         xrL2Gjty0SbehLXhmCCIOvCFDL2P+EhHF1/yVLxrKXtwdhwhnAKWbo5YykvTrJuTPX37
         dWJK88/BLJIF2bqoXX42C1wgVlVwfIukf76uteQCe5R7vkUO9bbqC2oWLFI3xWg4px+r
         2AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tjd0LIY6puJkC/hEm5cZ8epGnqrESFVGEAPoWq9xwks=;
        b=KdH4A+VnllCSchl4ovlBbCdMVs9sSg5BZIYNsp1YTP3HoNjyjj8zJcKJsmTkLLmdR1
         1bi6GwHlIdmHJRqUhue/FVRKDJxHRK29bntxr5fNzXPauewYMYNhN2u2t5SR/NpnefeI
         25tkrqbWnGjk3IcrDWCQ0ZrCrPCWlmbtl5pluGaHgLljioDbX2a5hJpvsWw1UddDzRzP
         xibUq3UOtvardg9EYgbVLw0Uot53a0TVoU3V+iFMM0QifSc1Zs0drwDIs4CL9uPd421o
         G5FUE/WakK6uwdws7GznjL3XGI+VRJu3rbuAaIJk9rU6pb90yhiNfEaJGsse2ZC+9Ppy
         eG5g==
X-Gm-Message-State: ANoB5pmoFHIRfSxdPqoAFV650hHEmswFW9YisByWPu2DA9i12m7qiFDh
        B6kwir+z1/Dv87HsStB/880xExlINU1W704qYo3Isw==
X-Google-Smtp-Source: AA0mqf5yCcGR+QHydFM+8Av0rAtyAulUGwYPMIwtToG7k6S8BITRXN5ROpMdezMHsmJyCTyIYThY8CQ675THjC3UrGA=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr29610383lfa.122.1670497386664; Thu, 08
 Dec 2022 03:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20221207062913.3154262-1-bhupesh.sharma@linaro.org> <6e584300-c025-e7d5-86f5-4e3c63fd7372@linaro.org>
In-Reply-To: <6e584300-c025-e7d5-86f5-4e3c63fd7372@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 8 Dec 2022 16:32:54 +0530
Message-ID: <CAH=2Ntw5RaMk5ym_nayyZ_eMZ2vB5VG6oXROOe0XwH5TtM3yKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix iommu sid values for PCIe nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 at 15:25, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 07/12/2022 07:29, Bhupesh Sharma wrote:
> > Fix the iommu sid values for the PCIe nodes present on
> > Qualcomm SM8150 SoC dtsi (in sync the with downstream code).
> >
> > Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8150.dtsi | 32 ++++++++++++++++++++++++++--
> >   1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > index d1b64280ab0b..e88d1617a1ab 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -1810,9 +1810,23 @@ pcie0: pci@1c00000 {
> >                                     "slave_q2a",
> >                                     "tbu";
> >
> > -                     iommus = <&apps_smmu 0x1d80 0x7f>;
> > +                     iommus = <&apps_smmu 0x1d80 0xf>;
> >                       iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
> >                                   <0x100 &apps_smmu 0x1d81 0x1>;
> Should be a "," here.
>
>
> > +                                 <0x200 &apps_smmu 0x1d82 0x1>,
> > +                                 <0x300 &apps_smmu 0x1d83 0x1>,
> > +                                 <0x400 &apps_smmu 0x1d84 0x1>,
> > +                                 <0x500 &apps_smmu 0x1d85 0x1>,
> > +                                 <0x600 &apps_smmu 0x1d86 0x1>,
> > +                                 <0x700 &apps_smmu 0x1d87 0x1>,
> > +                                 <0x800 &apps_smmu 0x1d88 0x1>,
> > +                                 <0x900 &apps_smmu 0x1d89 0x1>,
> > +                                 <0xa00 &apps_smmu 0x1d8a 0x1>,
> > +                                 <0xb00 &apps_smmu 0x1d8b 0x1>,
> > +                                 <0xc00 &apps_smmu 0x1d8c 0x1>,
> > +                                 <0xd00 &apps_smmu 0x1d8d 0x1>,
> > +                                 <0xe00 &apps_smmu 0x1d8e 0x1>,
> > +                                 <0xf00 &apps_smmu 0x1d8f 0x1>;
> >
> >                       resets = <&gcc GCC_PCIE_0_BCR>;
> >                       reset-names = "pci";
> > @@ -1909,9 +1923,23 @@ pcie1: pci@1c08000 {
> >                       assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> >                       assigned-clock-rates = <19200000>;
> >
> > -                     iommus = <&apps_smmu 0x1e00 0x7f>;
> > +                     iommus = <&apps_smmu 0x1e00 0xf>;
> >                       iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
> >                                   <0x100 &apps_smmu 0x1e01 0x1>;
> And here.

Oops. Thanks for noticing this.
I will send a v2, Konrad.

Thanks,
Bhupesh

> Konrad
> > +                                 <0x200 &apps_smmu 0x1e02 0x1>,
> > +                                 <0x300 &apps_smmu 0x1e03 0x1>,
> > +                                 <0x400 &apps_smmu 0x1e04 0x1>,
> > +                                 <0x500 &apps_smmu 0x1e05 0x1>,
> > +                                 <0x600 &apps_smmu 0x1e06 0x1>,
> > +                                 <0x700 &apps_smmu 0x1e07 0x1>,
> > +                                 <0x800 &apps_smmu 0x1e08 0x1>,
> > +                                 <0x900 &apps_smmu 0x1e09 0x1>,
> > +                                 <0xa00 &apps_smmu 0x1e0a 0x1>,
> > +                                 <0xb00 &apps_smmu 0x1e0b 0x1>,
> > +                                 <0xc00 &apps_smmu 0x1e0c 0x1>,
> > +                                 <0xd00 &apps_smmu 0x1e0d 0x1>,
> > +                                 <0xe00 &apps_smmu 0x1e0e 0x1>,
> > +                                 <0xf00 &apps_smmu 0x1e0f 0x1>;
> >
> >                       resets = <&gcc GCC_PCIE_1_BCR>;
> >                       reset-names = "pci";
