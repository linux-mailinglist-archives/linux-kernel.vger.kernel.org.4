Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A707646D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLHKva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiLHKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:50:56 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69A92A2A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:44:50 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g4so1139870ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/MTdVOdPppbnP+rAbbGOQVo9VYExTtbyUU8WhFMBao=;
        b=dKQcu9paovdf2bhpUoNTbPxWctG0sBdnpfgj9Zxey5YU95Kxv6xtQJQ32GAcorA81Z
         ISmVRE1NMYRGUwKia522St6d/A7xVe7KIcg6AjNlH0k+SaxhmXnHP4eRl1ligh41MAdh
         tJUHyGJC6Xd0ocRJKcDj0+P/1aRCSg9nH4k7GkSYve3dhL2vufDb5Ef/QwgsLUbRNTPe
         pv1LrvFSoaXV6B0SvMdm4MfMA9G9gK9k5Dnvk9ITkPTXZ63gKrzB7BtKsRMCheaqrWNz
         or6IJNdz9lWPj/su1IivJzddDAIZA1u9uEiV2CAFFrGxpmLDFqYe34A5COuKwQhPI09N
         BUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/MTdVOdPppbnP+rAbbGOQVo9VYExTtbyUU8WhFMBao=;
        b=oT2b8OMbRkWhJRgjdfACQFRiQCPDVhaLeeRiHg2XU2HKV2xAoLKeBAv0CD9dvcXjfY
         L/WUVaK29nR8QQKKb0DJKHkJ58XnABe3tSmRyuFePcRNuoRqfrXJxtXb8A6pu6kzR1Li
         o6hHriDAbe/ZAovgbua5iz26aFEzy4HvYwtltlTz1zxarj4YTOvXJd5oPgrbMVXeWnj7
         i8rOyEHnAyEr3HM+4SOe/Qrd0YYspVAyek0fkRT9jOMAfGN3Pa8TYf4kRPZZAmDEuKg0
         JR5IxKPjRJphwIqYLOi5XzkcfHZQPbSW8+eKN83BrcQknSpq6rdG4DiNgAsPJFh8D4hH
         fOlA==
X-Gm-Message-State: ANoB5pnrilGKxXZF92YHMIiqNLomxBwqojIje4rm941kYD2lpt+aJ6BY
        zde5lVDcfWI2ZJI4bd1+t4sNjL37R7sS9t7pq1lX0faX70rWpw==
X-Google-Smtp-Source: AA0mqf6ZED3KxFDcqPX3ROcO3vw5KziX61l3uQ3EwpxmLialIpiHeBGuyYF/yfqB8Ju0OjrkkjXrcbnArZgC89IOlus=
X-Received: by 2002:a25:8c9:0:b0:6f8:9c91:4503 with SMTP id
 192-20020a2508c9000000b006f89c914503mr39303257ybi.15.1670496289814; Thu, 08
 Dec 2022 02:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20221207062913.3154262-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20221207062913.3154262-1-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 8 Dec 2022 13:44:39 +0300
Message-ID: <CAA8EJpo30L=KYvrkbnWOrSXGVPk5++r77MTqVd12SZtaUqo-_w@mail.gmail.com>
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

On Wed, 7 Dec 2022 at 09:29, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Fix the iommu sid values for the PCIe nodes present on
> Qualcomm SM8150 SoC dtsi (in sync the with downstream code).

The commit message describes what you did, not why. Is there any
actual issue that you are trying to solve?
It makes me wonder because all modern Qualcomm platforms share more or
less the same setup.

>
> Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>

No need to have regular maintainers in Cc tags. Please use regular
git-send-email arguments instead.

> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 32 ++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index d1b64280ab0b..e88d1617a1ab 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1810,9 +1810,23 @@ pcie0: pci@1c00000 {
>                                       "slave_q2a",
>                                       "tbu";
>
> -                       iommus = <&apps_smmu 0x1d80 0x7f>;
> +                       iommus = <&apps_smmu 0x1d80 0xf>;
>                         iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
>                                     <0x100 &apps_smmu 0x1d81 0x1>;

it looks like the patch was not even compile-tested.

> +                                   <0x200 &apps_smmu 0x1d82 0x1>,
> +                                   <0x300 &apps_smmu 0x1d83 0x1>,
> +                                   <0x400 &apps_smmu 0x1d84 0x1>,
> +                                   <0x500 &apps_smmu 0x1d85 0x1>,
> +                                   <0x600 &apps_smmu 0x1d86 0x1>,
> +                                   <0x700 &apps_smmu 0x1d87 0x1>,
> +                                   <0x800 &apps_smmu 0x1d88 0x1>,
> +                                   <0x900 &apps_smmu 0x1d89 0x1>,
> +                                   <0xa00 &apps_smmu 0x1d8a 0x1>,
> +                                   <0xb00 &apps_smmu 0x1d8b 0x1>,
> +                                   <0xc00 &apps_smmu 0x1d8c 0x1>,
> +                                   <0xd00 &apps_smmu 0x1d8d 0x1>,
> +                                   <0xe00 &apps_smmu 0x1d8e 0x1>,
> +                                   <0xf00 &apps_smmu 0x1d8f 0x1>;
>
>                         resets = <&gcc GCC_PCIE_0_BCR>;
>                         reset-names = "pci";
> @@ -1909,9 +1923,23 @@ pcie1: pci@1c08000 {
>                         assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
>                         assigned-clock-rates = <19200000>;
>
> -                       iommus = <&apps_smmu 0x1e00 0x7f>;
> +                       iommus = <&apps_smmu 0x1e00 0xf>;
>                         iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
>                                     <0x100 &apps_smmu 0x1e01 0x1>;
> +                                   <0x200 &apps_smmu 0x1e02 0x1>,
> +                                   <0x300 &apps_smmu 0x1e03 0x1>,
> +                                   <0x400 &apps_smmu 0x1e04 0x1>,
> +                                   <0x500 &apps_smmu 0x1e05 0x1>,
> +                                   <0x600 &apps_smmu 0x1e06 0x1>,
> +                                   <0x700 &apps_smmu 0x1e07 0x1>,
> +                                   <0x800 &apps_smmu 0x1e08 0x1>,
> +                                   <0x900 &apps_smmu 0x1e09 0x1>,
> +                                   <0xa00 &apps_smmu 0x1e0a 0x1>,
> +                                   <0xb00 &apps_smmu 0x1e0b 0x1>,
> +                                   <0xc00 &apps_smmu 0x1e0c 0x1>,
> +                                   <0xd00 &apps_smmu 0x1e0d 0x1>,
> +                                   <0xe00 &apps_smmu 0x1e0e 0x1>,
> +                                   <0xf00 &apps_smmu 0x1e0f 0x1>;
>
>                         resets = <&gcc GCC_PCIE_1_BCR>;
>                         reset-names = "pci";
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
