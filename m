Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342736B073E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCHMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCHMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:36:18 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5CC0805
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:36:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b13so16418726ljf.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678278959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZpdSgX43Mq+ODhE1K9G2P1+evJkHGWtMYj5Dwnw8gQ=;
        b=Xk9Znw5jGSeoR8gwxLs/3zhqRHZDsXJShUIn6dsURMqAjamt5YfH29TGvztqyaqBUn
         RNZVtYP0DuiSEyQmEe7IPB6Rrz6FVkpsdktzza6SJopw55ku7ttNJW9Y/sdgILhdNKE6
         95NK0Bp2m+dYw4g81pY/9xbRmL+63nwHOIXUL8n4BlQfcqzBP+tvt5FaA5bVMutWUHNs
         WqU/01Bqhr/fr3jc7agJp4rI9+aFKMfG0dwSmHYtBG0es39jJcsWOyGqKNCzqefL4vzP
         Wjp6hQ0Tbo4CcxUwcxUE25UmjVtHVSEKvAZznh3sZRdRkv8sqA/KVzyJ5XyL9qr9q/7m
         QRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678278959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZpdSgX43Mq+ODhE1K9G2P1+evJkHGWtMYj5Dwnw8gQ=;
        b=OOCDxnGUWm8UOkzg7BudQZP1Gouent3FRE801tk5RwBJ4wz8aemoi91cY9A/lm5mLW
         epl7seyPZIurtNynJo1mN73Z8f0gWM4CfwwpHVO4hIHF9VCUFrzA1f2/gRWTJwQ5ZQ5O
         DsnKmYH8zpv3wpCTKoxOLZOxsxROSeJDZKlJbSrl8tbR7P57xrWDrmHun7Dd4vOKlZoy
         u12VH/6qNUu32yBuc2Ph++Z6tlTt84ThTpSDn9GdGuDQ058IEVerniiOHJLXsnzTtCzX
         1pIiaoxCdYG7hly3O+BudN13s1LRwBie6o7sf5qfbwCoic8cTbpBNtBwTp7Cu9twpyxT
         g+SQ==
X-Gm-Message-State: AO0yUKWti3iMgt+4ELFppNiU8GKXyDA9VufPVppVpclewRxJmf8qpZVH
        1MmKg3x1yJtmsHVLqHfrebsPIA==
X-Google-Smtp-Source: AK7set8QN8XuVSRs0alwNTJXovC9xlgO2NzhZ6xDlt7EvrZzUVP4mtJTHN6zGdIPQ1iYb6w2mIAROA==
X-Received: by 2002:a2e:b8d2:0:b0:290:6a6f:48d1 with SMTP id s18-20020a2eb8d2000000b002906a6f48d1mr5679650ljp.43.1678278959655;
        Wed, 08 Mar 2023 04:35:59 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i19-20020a056512007300b004db508326c0sm2341220lfo.90.2023.03.08.04.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:35:59 -0800 (PST)
Message-ID: <a1ae9cb4-1fde-67f9-360f-67c2771a54e4@linaro.org>
Date:   Wed, 8 Mar 2023 13:35:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/6] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678277993-18836-4-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1678277993-18836-4-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 13:19, Rohit Agarwal wrote:
> Add devicetree support for PCIe PHY used in SDX65 platform. This PHY is
> used by the PCIe EP controller.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 192f9f9..df9d428 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -293,6 +293,39 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_phy: phy@1c06000 {
> +			compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy";
> +			reg = <0x01c06000 0x2000>;

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
No child nodes, please drop this hunk.


Konrad
> +			clocks = <&gcc GCC_PCIE_AUX_PHY_CLK_SRC>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
> +				 <&gcc GCC_PCIE_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "rchng",
> +				      "pipe";
> +
> +			resets = <&gcc GCC_PCIE_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_GDSC>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x01f40000 0x40000>;
