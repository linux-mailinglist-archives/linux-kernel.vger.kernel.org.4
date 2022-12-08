Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA279646C4A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLHJzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLHJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:55:10 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FFD654E8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:55:08 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id x6so982447lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tvlnAL8F9eDttmg1+fY9hAFHlP4ZueorayQfollF64=;
        b=X67EBk0BvLFCF57EFgGmT9EHyQWozGOhaslVgdA8O+eNl5S2yMGEIjC9PW5PyFJHON
         EJwjy0PDm4THRYg9i+PN57H7dGmsi2dNp1o3uvcxqDyEWFErRiy6UJXUr/fmjO3INVpp
         iTCvYxg0R9CPlGhzqoBxz6lCMi1fQjrWyCKti73T8Zo2fb54LXqz8imtYnQtrysZ4RXd
         zWXnj56SPuqVdxM6nx4B39lP23fDGeR6LMCxJ6RItwA7YTrIEbBgm4bm6BxDS/pT4zn/
         gkl09ddmnG7iNSult5IO5C8ccc+nOsAhIIWUVj6ywaV2Zm2490D2hN0smtewMaecdi6P
         jZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4tvlnAL8F9eDttmg1+fY9hAFHlP4ZueorayQfollF64=;
        b=mOUEJ113NYlhjAi9pvuT523c5+ZYAg3VQ/5YG5hyzR7GHxlAXH2dRgIEZz3VEfJEsD
         5glSnev/xhUTbYWnJhnjFAtA4QTgxnQCcpEqYkikY7qk5OMmHAzThDXMMiVdBXzVbUvw
         +GKF/vybRN9ZHoUeyfAhksJZQ1jd53EfZrJyrFi9YfUh60UF5xSBwp3gqDmW6Kzet6wS
         CrMFWCBaQuuPGkm+QQKdO2IABJjrk17sJRENWtmprx3JxvKA4yQbKrBkZvaijRgQl4/2
         ipMjIg/DUHTQHpRPFk6/cLutECJyRrAF03rpublJ9buV5Xz/0FBDa9MPL2sdrLQBireE
         AQlg==
X-Gm-Message-State: ANoB5pnc+I5m7B1BOzKRqpTWyRdtOwEBAwIVA1SMNk2xHaHzSPUmhVjD
        SbBEoFq2sErMMyQrFZ5PPs/1eg==
X-Google-Smtp-Source: AA0mqf42uSff93t8l4RjdGOY5kdkI7wq941SVNz6wYLR7v8N13Ym8Y5EINoBy4yuD2PTmuNZnrXaBw==
X-Received: by 2002:a05:651c:54b:b0:276:d9a6:dc00 with SMTP id q11-20020a05651c054b00b00276d9a6dc00mr31085186ljp.379.1670493306642;
        Thu, 08 Dec 2022 01:55:06 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id m8-20020a2e9108000000b0026dffa29989sm1929668ljg.23.2022.12.08.01.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:55:06 -0800 (PST)
Message-ID: <6e584300-c025-e7d5-86f5-4e3c63fd7372@linaro.org>
Date:   Thu, 8 Dec 2022 10:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix iommu sid values for PCIe
 nodes
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org
References: <20221207062913.3154262-1-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221207062913.3154262-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2022 07:29, Bhupesh Sharma wrote:
> Fix the iommu sid values for the PCIe nodes present on
> Qualcomm SM8150 SoC dtsi (in sync the with downstream code).
> 
> Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8150.dtsi | 32 ++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index d1b64280ab0b..e88d1617a1ab 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1810,9 +1810,23 @@ pcie0: pci@1c00000 {
>   				      "slave_q2a",
>   				      "tbu";
>   
> -			iommus = <&apps_smmu 0x1d80 0x7f>;
> +			iommus = <&apps_smmu 0x1d80 0xf>;
>   			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
>   				    <0x100 &apps_smmu 0x1d81 0x1>;
Should be a "," here.


> +				    <0x200 &apps_smmu 0x1d82 0x1>,
> +				    <0x300 &apps_smmu 0x1d83 0x1>,
> +				    <0x400 &apps_smmu 0x1d84 0x1>,
> +				    <0x500 &apps_smmu 0x1d85 0x1>,
> +				    <0x600 &apps_smmu 0x1d86 0x1>,
> +				    <0x700 &apps_smmu 0x1d87 0x1>,
> +				    <0x800 &apps_smmu 0x1d88 0x1>,
> +				    <0x900 &apps_smmu 0x1d89 0x1>,
> +				    <0xa00 &apps_smmu 0x1d8a 0x1>,
> +				    <0xb00 &apps_smmu 0x1d8b 0x1>,
> +				    <0xc00 &apps_smmu 0x1d8c 0x1>,
> +				    <0xd00 &apps_smmu 0x1d8d 0x1>,
> +				    <0xe00 &apps_smmu 0x1d8e 0x1>,
> +				    <0xf00 &apps_smmu 0x1d8f 0x1>;
>   
>   			resets = <&gcc GCC_PCIE_0_BCR>;
>   			reset-names = "pci";
> @@ -1909,9 +1923,23 @@ pcie1: pci@1c08000 {
>   			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
>   			assigned-clock-rates = <19200000>;
>   
> -			iommus = <&apps_smmu 0x1e00 0x7f>;
> +			iommus = <&apps_smmu 0x1e00 0xf>;
>   			iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
>   				    <0x100 &apps_smmu 0x1e01 0x1>;
And here.

Konrad
> +				    <0x200 &apps_smmu 0x1e02 0x1>,
> +				    <0x300 &apps_smmu 0x1e03 0x1>,
> +				    <0x400 &apps_smmu 0x1e04 0x1>,
> +				    <0x500 &apps_smmu 0x1e05 0x1>,
> +				    <0x600 &apps_smmu 0x1e06 0x1>,
> +				    <0x700 &apps_smmu 0x1e07 0x1>,
> +				    <0x800 &apps_smmu 0x1e08 0x1>,
> +				    <0x900 &apps_smmu 0x1e09 0x1>,
> +				    <0xa00 &apps_smmu 0x1e0a 0x1>,
> +				    <0xb00 &apps_smmu 0x1e0b 0x1>,
> +				    <0xc00 &apps_smmu 0x1e0c 0x1>,
> +				    <0xd00 &apps_smmu 0x1e0d 0x1>,
> +				    <0xe00 &apps_smmu 0x1e0e 0x1>,
> +				    <0xf00 &apps_smmu 0x1e0f 0x1>;
>   
>   			resets = <&gcc GCC_PCIE_1_BCR>;
>   			reset-names = "pci";
