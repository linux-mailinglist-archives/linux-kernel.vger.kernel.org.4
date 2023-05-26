Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1218712E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjEZUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243750AbjEZUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:51:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479CE54
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:50:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4eed764a10cso1254565e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685134239; x=1687726239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p86bLQNbobDigp0k3P3tmO5QVRnjnFz7+fIP1sFxECg=;
        b=X0C2YM6zfUM1cor3ejxX0WrV5fJ/BeHuc73ilzWM5ze/g+4YqqvhHYfzSnKuizJ9/B
         yChH2grov0wxgM9NcpLjefbhZbnnpsKA4gdlcjxkbCeWRYfR3bfX3KGpbXyizLW0xWE/
         iq8QdC5eOUZKbwX58EePd1/egoua3thuV4KrNGDLX35VUvd/dtqN7syDy8pDKRC5/kGh
         Ne/Ki5i9CMR0QJ6Pd8HQJ+YTqNfrvM84WLJACfaWqVqLjj9mRBdH1wpoMPBb6Jl3SwiW
         ZsfM8fTjqLynNADYaLE05tMPGkvlWqCVg1+oOD2jw7Y6gEy2j/r0QOoEZKgiPLg2TSVO
         O1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134239; x=1687726239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p86bLQNbobDigp0k3P3tmO5QVRnjnFz7+fIP1sFxECg=;
        b=EL+e/FIlZgg+85HlOPU/zyOm/Uogxy50m1KUHqSCwoaasg++kDLj8aF0YvVKnkMDzn
         8e7VHLxQ+gb5J8roZYRTMDfK6a9P6RxXbF/DagEtz9VqogTpCSrpS0WeYYQh2tapIBf9
         mBDqeSQtvz39OIoxX1twV+vclrVlN5UVHhLn62/BCKCqM4mwOyNFK3gS7T/d3/xKdsm9
         p2qe8p4Ju2MyCG5PyDh5buipoXgM+rPNyiwCTC+SIWQsA9SfcA1YXYbxX9ZxEwWpU2PZ
         EnL52ON9oOUxdFhk33t2UuXZ8T9SQ+FbpRfkbR3Fx1NrtpcPkc9y6/VGA3vu3frWYOJL
         yX0A==
X-Gm-Message-State: AC+VfDyccIC4XrGxVsrEXPXJQ8CgT/1phVkRvGi24GdNJrM1MYSZkj65
        +5c1Gkkfw2stulDiSqlhqare0w==
X-Google-Smtp-Source: ACHHUZ48hIn+EMWhdHTr8iY1OzvhRt3OSLaAaGUEpHkGvWfieZ5elIptZwAVcQSo3wBqIVfOfBu+rA==
X-Received: by 2002:ac2:4a76:0:b0:4f4:dfd4:33e4 with SMTP id q22-20020ac24a76000000b004f4dfd433e4mr822684lfp.51.1685134239533;
        Fri, 26 May 2023 13:50:39 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25312000000b004f37bd02a89sm773168lfh.287.2023.05.26.13.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:50:39 -0700 (PDT)
Message-ID: <5e5c41e3-e659-67fb-34b8-8fe3713b36d9@linaro.org>
Date:   Fri, 26 May 2023 22:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 11/11] arm64: dts: qcom: sm8450: add crypto nodes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-12-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526192210.3146896-12-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 21:22, Bhupesh Sharma wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Add crypto engine (CE) and CE BAM related nodes and definitions
> for the SM8450 SoC.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> [Bhupesh: Corrected the compatible list]
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 7f193802a7c4..1642daea9624 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -4173,6 +4173,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
>  			};
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0 0x01dc4000 0 0x28000>;
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			iommus = <&apps_smmu 0x584 0x11>,
> +				 <&apps_smmu 0x588 0x0>,
> +				 <&apps_smmu 0x598 0x5>,
Does mapping 0x598 with and without the SMR mask make sense?

(this is a genuine question, I have no idea but would be leaning
on the side of no)

Konrad
> +				 <&apps_smmu 0x59a 0x0>,
> +				 <&apps_smmu 0x59f 0x0>;
> +		};
> +
> +		crypto: crypto@1de0000 {
> +			compatible = "qcom,sm8450-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0 0x01dfa000 0 0x6000>;
> +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x584 0x11>,
> +				 <&apps_smmu 0x588 0x0>,
> +				 <&apps_smmu 0x598 0x5>,
> +				 <&apps_smmu 0x59a 0x0>,
> +				 <&apps_smmu 0x59f 0x0>;
> +			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "memory";
> +		};
> +
>  		sdhc_2: mmc@8804000 {
>  			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0 0x08804000 0 0x1000>;
