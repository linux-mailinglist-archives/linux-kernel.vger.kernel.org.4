Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743D26CC0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjC1Nbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjC1Nbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:31:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422E3C16A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:30:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o20so9641908ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680010252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gg3lYt3KoE0McrcY8uu+tDhI/9yJmtbZP7QMSYflkEI=;
        b=neLigaJNs85v4HvccLAiYFw9i2EX7oanTtSYEnArUPiRtPWURytpUJEi/KgC0H/29s
         tIoxohaT5snQhHDmAD8EtUklkhTviBuCe0snughWBEZsdPchExAlvrK1StVKMdRu09tr
         weg0tMgGCSkqpoM0vose++I/9f21NiP+8VqeE0LmDfcO2gTC7+xlYJfp0J2U3XYwZSAU
         ZTcWY4+8dTpsr745bggmocREbA3MuGw1cgPVNEYRowkxbmv/whS4hHZEb2DrbZuUwOoL
         +j/w8YMVyTRRlbA0zajHsKA+HAn1S+1diuAWGT4MEoWVfsl97dY1E+tGp6rOySMlMMnj
         P/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg3lYt3KoE0McrcY8uu+tDhI/9yJmtbZP7QMSYflkEI=;
        b=nmfO1NU93X6qbTGpvjbQa/fb9DoDR2jfEid4rFLgidyd5Dav//byE6tiwTDZpCjJEK
         eahFnjKx0nKaCj4vsev6iCE9rMpaHX1WMgC7Sj4RsBshU33Sh6jXmHL6VaZByjZq4TKM
         1MzKFI44Z4ThKmQ7mcwEc29CD1GYMURpOq8b/HYgVex/bOYE021ifmNk1fvT+SSvHMXP
         coG19spIvpeey7nvMst4uUFxSVy6ma8GTKfVuJtFQKaDNp5x7zZ7h90W2fuiJylxHX5o
         +U8uzEmV3KDRPUWl+3A+spOGAV46nlExcxGzt/Foew4dxsKV28RVuox/mvkRLpEhlzdd
         /7Iw==
X-Gm-Message-State: AAQBX9cJCrBD0Ao1/fu0ru+vXI6xii9xArZtZuw4kMtEBvS1XnUeFnHV
        4JLLmCZ4f6xItpR8RrqSVHu9aQ==
X-Google-Smtp-Source: AKy350bUJTEzd90IIRG/iiSwghCm704Zg/Yznz/Kyq7j/pOc02N3i7IEZ3Dd9uMd3shE/X2VacQCew==
X-Received: by 2002:a2e:9e83:0:b0:293:52f5:2957 with SMTP id f3-20020a2e9e83000000b0029352f52957mr5142979ljk.5.1680010252658;
        Tue, 28 Mar 2023 06:30:52 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id c1-20020a2e6801000000b002a421ac8629sm1678069lja.49.2023.03.28.06.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:30:52 -0700 (PDT)
Message-ID: <ddeb8021-2247-4ec0-4861-56a9f8d617f7@linaro.org>
Date:   Tue, 28 Mar 2023 15:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 5/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
 <1679036039-27157-6-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1679036039-27157-6-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.03.2023 07:53, Rohit Agarwal wrote:
> Enable PCIe Endpoint controller on the SDX65 MTP board based
> on Qualcomm SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index 70720e6..afe970a 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -245,6 +245,17 @@
>  	status = "okay";
>  };
>  
> +&pcie_ep {
> +	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
> +			&pcie_ep_wake_default>;
This seems misaligned, the &s should be one below another

But other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +	pinctrl-names = "default";
> +
> +	reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> +
>  &pcie_phy {
>  	vdda-phy-supply = <&vreg_l1b_1p2>;
>  	vdda-pll-supply = <&vreg_l4b_0p88>;
> @@ -277,6 +288,29 @@
>  	status = "okay";
>  };
>  
> +&tlmm {
> +	pcie_ep_clkreq_default: pcie-ep-clkreq-default-state {
> +		pins = "gpio56";
> +		function = "pcie_clkreq";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	pcie_ep_perst_default: pcie-ep-perst-default-state {
> +		pins = "gpio57";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	pcie_ep_wake_default: pcie-ep-wake-default-state {
> +		pins = "gpio53";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
>  &usb {
>  	status = "okay";
>  };
