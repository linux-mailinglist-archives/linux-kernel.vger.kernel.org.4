Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777246ABCE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCFKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCFKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:32:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BA244BE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:32:09 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m6so12059343lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678098727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZTV+4Gmwp9zOCF5DZ06H8JPUmoVNQM9yDBfTH3SiIY=;
        b=s8Ddyl/wtVcnfUe2AbuxysW9nFMskqqveAQfu0HULr5YmBsfMK79p6WXzrmGg9yjIn
         RTYVglLSOqI1AelhWiLd3/l1DvZGZTWh6MYUjOSeDfjJMv60Vz6Yeea2AEMBgS7v7xMO
         i4YpNRujDgBRT/4DQ6AlhmiaQzG3eyTKab1O/vGJGqBdQN7T84Nho1o4isEx5VA4brFE
         200fVKMW5Ebdg0maLIqPkC6InfkVqnmYebhvJtrx0tT7O/o7VImLabwpFIJZ83IoeOgA
         SVbs+izLsgxQwLIx3FTZLGmL93N4qfDi29e1fbL29lVCVxyvpAOJfG8lNn6bXMEhVMi2
         +8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZTV+4Gmwp9zOCF5DZ06H8JPUmoVNQM9yDBfTH3SiIY=;
        b=ol58AvRI4Od6FfcSYZ0Jm5AKb3XygoYyYJ5SkrHfeRh0dQ4ngJgeSuBuECNIE0M77n
         Yk92af/xhURei3VoKAOH6d7S9qFR/UxGFcTAQ8HNTgf6s98JQ9psujcQrgcEtUJDcQ5Z
         vjtzx0qyuxWQQ+tFOj7xMZPVRIRxY2y5OOfPRyFzTcrK3SFPUJHPYQNyUs2vumIYyT++
         J6aWDt4pnG7JXdNJlsNsR2HsJYxGpuKaPLnSILRZvCcI+aW/Iup6MJWLRVXwyIhCdCT4
         RGeN89CIrfFELBcWj0bJ3l/Dk7DaEol8KB9Wm9uehpYRBNCEN7+gu5NdVCk7/azUjTaH
         +Wfg==
X-Gm-Message-State: AO0yUKU5bT//qVQcaq1CK9TFKhBG0VekioW7MJ6F5bKCNF3kBtm4Vqgt
        32f4po5DV7I9vZB8QkAkCBR+yvHfB4aCXXd0j6I=
X-Google-Smtp-Source: AK7set/QsD+accgDtrwErpouZPCmD4mAzYUsXsFT/IpdOeKpjtAkgHDudvtna865/TvgT//zoJ8T4g==
X-Received: by 2002:a19:760f:0:b0:4d5:c996:2940 with SMTP id c15-20020a19760f000000b004d5c9962940mr2806820lff.61.1678098727263;
        Mon, 06 Mar 2023 02:32:07 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id n14-20020a19550e000000b004db1b99055dsm1598067lfe.229.2023.03.06.02.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:32:06 -0800 (PST)
Message-ID: <a24841f4-ad59-24dd-0110-814995d95655@linaro.org>
Date:   Mon, 6 Mar 2023 11:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/6] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678080302-29691-7-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1678080302-29691-7-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.03.2023 06:25, Rohit Agarwal wrote:
> Enable PCIe Endpoint controller on the SDX65 MTP board based
> on Qualcomm SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 46 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index 86bb853..952de105 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -252,6 +252,14 @@
>  	vdda-pll-supply = <&vreg_l4b_0p88>;
>  };
>  
> +&pcie_ep {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
> +			&pcie_ep_wake_default>;
status last

pinctrl-n goes before pinctrl-names
> +};
> +
>  &qpic_bam {
>  	status = "okay";
>  };
> @@ -276,6 +284,44 @@
>  	memory-region = <&mpss_adsp_mem>;
>  };
>  
> ++&tlmm {
> +	pcie_ep_clkreq_default: pcie_ep_clkreq_default {
No underscores in node names, pinctrl children node names
must end in -state. Please check your patches against
"make dtbs_check"
> +		mux {
> +			pins = "gpio56";
> +			function = "pcie_clkreq";
> +		};
> +		config {
> +			pins = "gpio56";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
mux {} / config {} is unnecessary. You can simply do:

{
    pins = "gpio56";
    function = "pcie_clkreq";
    drive-strength = <2>;
    bias-disable;
};

Konrad
> +	};
> +
> +	pcie_ep_perst_default: pcie_ep_perst_default {
> +		mux {
> +			pins = "gpio57";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio57";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	pcie_ep_wake_default: pcie_ep_wake_default {
> +		mux {
> +			pins = "gpio53";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio53";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +};
> +
>  &usb {
>  	status = "okay";
>  };
