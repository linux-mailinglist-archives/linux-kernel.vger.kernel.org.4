Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE41719589
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjFAI1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjFAI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:27:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360099F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:27:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so560523e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685608047; x=1688200047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqwFSbxwJ8AdUEIxg01urYLJMhjViKDMFaxG2jdI9Fo=;
        b=gKRw5trt3vM867kwwx8JF+3TlBcWvOLUtM7Z5+1NEngoLE74sdYg4FesKEop0YngBh
         5Q6jfQbnHel08CqCRwfjuUAZ/8c4MV8VDM8w5tfv5hoxeybKHYjt1y4+gR8op4LlNIdT
         NnW9BUptRHsRNQgteKZz5PkUSzP6WSeKk/vWsE1B0kLNDwK7jRKIjbGw7iSObyM3AeOI
         C9yuJQSyTSNEq5/e7bNSxbHv+jUbNjlbMylL1XWv9ODkjVbIrUGSBIqCy8a1UYyPEAFW
         y3Ute9VrFPoKWWygo89E5s7wkqHXaK4YLpGWfepRviHHj8KM8P2/Rc5u3NQG/GvDtvBp
         UQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608047; x=1688200047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqwFSbxwJ8AdUEIxg01urYLJMhjViKDMFaxG2jdI9Fo=;
        b=LJBHIWvKNdHnLTUpOWJjk+9VtjzXhCiQoPjmZzN9BKqfaenR68/e0mK1QpogZyaryR
         /wX40ncMLz3Siz/bhmQHZxhe29vUUCAUHllhbBmSwtkgXEjgNJM4WNaf/SImpJ/7l+jN
         K8kkvvKVxTDwn2UcWN73nX4Ws1XTZhJ+pYt7NPi3KBxIAWlSEa0ZXP2xAJYc3boCPW58
         7D6B32L+iHnqJsfw+zlAAK1jUYkJ/Py2wv+1Xu2HlP8OI5SSj8rgDDCFg5oMhbm0Sv9X
         Xj8sOG8EhFov8+l7N7ZnDnFd6acRHmmFVgec+LTvYfOZq2dcWn09oTzd0LLmW4a3PO0y
         k/Nw==
X-Gm-Message-State: AC+VfDz5GCk754tMf7oX6s6GkFyQ4DrsGxEVZGmycYJ80Tq4D6k4azPf
        /3sNJPHXqN97PLmYsFi/M9kyEA==
X-Google-Smtp-Source: ACHHUZ5Jhjxm/4GIwys6Rax0J6ZGiPTimXCYhsHDuqXpQJaWukWj1UYj6jk3IWoSawj0pXfPWzykGA==
X-Received: by 2002:a05:6512:21b:b0:4f3:b9bb:1453 with SMTP id a27-20020a056512021b00b004f3b9bb1453mr835253lfo.45.1685608047380;
        Thu, 01 Jun 2023 01:27:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id p24-20020ac246d8000000b004ec84d24818sm1004005lfo.282.2023.06.01.01.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:27:26 -0700 (PDT)
Message-ID: <5bb80be4-4ad5-63c5-b34e-5ecfade7b494@linaro.org>
Date:   Thu, 1 Jun 2023 10:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qdu1000: Add SDHCI node
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
 <20230601065805.18079-3-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601065805.18079-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 08:58, Komal Bajaj wrote:
> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 734438113bba..6df07334f1d3 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -842,6 +842,53 @@
>  			#hwlock-cells = <1>;
>  		};
> 
> +		sdhc: mmc@8804000 {
> +			compatible = "qcom,qdu1000-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x08804000 0x0 0x1000>,
> +			      <0x0 0x08805000 0x0 0x1000>;
> +			reg-names = "hc", "cqhci";
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC5_AHB_CLK>,
> +				 <&gcc GCC_SDCC5_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "xo";
> +
> +			resets = <&gcc GCC_SDCC5_BCR>;
> +
> +			interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +			power-domains = <&rpmhpd QDU1000_CX>;
> +			operating-points-v2 = <&sdhc1_opp_table>;
> +
> +			iommus = <&apps_smmu 0x80 0x0>;
> +			dma-coherent;
> +
> +			bus-width = <8>;
> +
> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			status = "disabled";
> +
> +			sdhc1_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-384000000 {
> +					opp-hz = /bits/ 64 <384000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <6528000 1652800>;
> +					opp-avg-kBps = <400000 0>;
> +				};
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>  			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
> --
> 2.17.1
> 
