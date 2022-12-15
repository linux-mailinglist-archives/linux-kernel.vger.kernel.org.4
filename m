Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E864DBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLOM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLOM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:56:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9E12741
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:56:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p36so15495617lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWtDU+FOgPNes2AlOVTZNdVXxSnxfWwUp6uqGiT5yLk=;
        b=a93FC4EvnIKh+4fO2248sZeWiGd1mAxMjVJC0Kid3UoiGFyU2YaM1t7Nge6ZTSxec5
         QffUnDHzU5nmMkob0VZBxwqi9FGmaRsuyVGRwV5sFZjP16yujH+qjJ67W5PDOOcTvCUd
         WTXD0zn/pH+NtS8u916aKwtwyqw6u9qplbFzcYgjzrTAnzmUoJzL7oJ29iZ5OsX59hna
         S9OubT/38jsZWzRijn0Y0Y+eVwQod/+1+1O5NaOzLFJeoCNQndfBf+LSOn3Ni3bHDPpC
         ChgY8NT99+WslG7229H7AoWQpTUUophOkJgzSzlgCZuRX6n+cnFBbdnYBCdQHn2bE5rG
         mNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWtDU+FOgPNes2AlOVTZNdVXxSnxfWwUp6uqGiT5yLk=;
        b=CqWIDh742DxTZipUXUISz5K4MmMJWGo/KkV+am7K7g5h/RjDem0s1trtz5Sw4p3tKF
         37s/rc0lWe4SW+drxiBIJfXuJ+T2UyVl+Py0NGlBMmRg92gqYpK6QxvgkWjEO03RFQfo
         g2CThPfOeOQ65P5SSMkl8RQUWqnecbom5SMiwFGGKOwBnCwxIqc1UfZBNA8TfAHNkDSo
         T2DhguW3KdsTBfFSH070ODuTUVGAGytSeqDGo2UcN/Bo3sCjF6XRXbWDwAVsMBoB3cp7
         44S65wml53GTxmUX5uurBqLWmu93C8mL/wS+mhN0/wwa8N10wjDuAFfJ9FI8rYMyEZIw
         mLiw==
X-Gm-Message-State: ANoB5pmZ1XTU4xgTMG0U210QhdxE8dzKE0yRMJ6Hj+QYkmbHvK0SYwyf
        AD5LZ2YCXIC9o+lb/HiSy35cPw==
X-Google-Smtp-Source: AA0mqf7BdqZB3hRbhCPQO2qyL+r7AXWNH+DxXPE2BadtF+lSBVJblhs6jYIle4LE9YLUR+slOy5sEA==
X-Received: by 2002:ac2:4c33:0:b0:4b5:26f3:2247 with SMTP id u19-20020ac24c33000000b004b526f32247mr6835866lfq.69.1671108980771;
        Thu, 15 Dec 2022 04:56:20 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id u23-20020a196a17000000b004994c190581sm1154417lfu.123.2022.12.15.04.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:56:19 -0800 (PST)
Message-ID: <90437b6d-0543-80c5-ea27-238e3aafc6ea@linaro.org>
Date:   Thu, 15 Dec 2022 13:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sc8280xp: add rng device tree
 node
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
References: <20221214171145.2913557-1-bmasney@redhat.com>
 <20221214171145.2913557-8-bmasney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214171145.2913557-8-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.2022 18:11, Brian Masney wrote:
> Add the necessary device tree node for qcom,prng-ee so we can use the
> hardware random number generator. This functionality was tested on a
> SA8540p automotive development board using kcapi-rng from libkcapi.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
Nodes with MMIO addresses should be sorted address-wise, so
this one should come between qup1 and pcie4.

Konrad
> This is a new patch that's introduced in v2.
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 4591d411f5fb..67765975361b 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2811,6 +2811,13 @@ tlmm: pinctrl@f100000 {
>  			gpio-ranges = <&tlmm 0 0 230>;
>  		};
>  
> +		rng: rng@10d3000 {
> +			compatible = "qcom,prng-ee";
> +			reg = <0 0x010d3000 0 0x1000>;
> +			clocks = <&rpmhcc RPMH_HWKM_CLK>;
> +			clock-names = "core";
> +		};
> +
>  		apps_smmu: iommu@15000000 {
>  			compatible = "qcom,sc8280xp-smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x100000>;
