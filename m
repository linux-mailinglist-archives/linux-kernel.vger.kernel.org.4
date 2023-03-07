Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37576AE529
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCGPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCGPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:44:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF0739BB0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:44:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u9so54116521edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678203865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pELUsp6yWcX3CCqh+SbGeeFg/b7go8wzOCVsRgt5zwM=;
        b=ydLI2+dorOlsuYhWP2zsWARMk6lgEr41/nPZDVCjE8vfPGA7ZkynpTY1Iw1FtkB1t6
         DPPA35j2Pc8pGeizv6b4jONr6Dy19NNHIjoQ7CgBFeNiPmsbaTkmGxXUmv1gOFXXz4Q7
         iRd3DumPvXQSIZ8oUQivbR6U2rV41hsY6P7zIW7AxOJAHuBHczFsbT5j5cwQDJ74gvcl
         /oAnKfr3gA/Z3lBnpH7HqAcLIUB/JqhLoD9ESkTpvbprFydsWEeVzWenGHBHj683+snp
         4k16GdWLVMj2RtV1mLoauY0t06h8Um6OWYPC5JGmdkaExGWZdIbzwfLX45I15pN7KxMh
         uPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pELUsp6yWcX3CCqh+SbGeeFg/b7go8wzOCVsRgt5zwM=;
        b=htGUkXR5aCMP5qqSXs8wXc5g0NFa6//EOWRQlt8Gd0lirSctwMNXP8a4XlF+8htImM
         TaDMKgPyjnDlHVcLZqNzK43VT9PL21YaLcxMqJBnsOUosG6W1ltqh1IeoOnWkQbIsCoB
         gVgfymeR8RPPYsYih4e9T8yQ+0+IwJhcgGIs7NZ0jk3hU2c0/IFo+QCoD5jcBYti9zIi
         cjE5MBK4zVnUrau1RMxXdS1YivNzXiNpJfTfzO7qBkcSwZPPqs9PD/Xi+HFyfl8UJMsJ
         5kYGdwyjqIOsVwip6c6TU7a/mkK+PzLaY3ON0kToJevlIx9ZniXg8IqLD5GD4npZziD4
         YLnw==
X-Gm-Message-State: AO0yUKVdfVWlpZfn7/LBiAvlQD9w17RHKQU7n/y5iyRfOln6nEt7LZVF
        VukgtncNyNZL/LlQ93j5y7dWlA==
X-Google-Smtp-Source: AK7set8/P7VfJR9EkoyuPlWLt539pgRHouLThdqqpFF177TUeWAJVJV+TPJqqOuWra8yPAxD5Ao1Dg==
X-Received: by 2002:a17:907:7242:b0:8df:8381:52f7 with SMTP id ds2-20020a170907724200b008df838152f7mr20172769ejc.17.1678203865457;
        Tue, 07 Mar 2023 07:44:25 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id hy3-20020a1709068a6300b008e57b5e0ce9sm6261800ejc.108.2023.03.07.07.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:44:25 -0800 (PST)
Message-ID: <c89d2b2b-fea1-c255-582d-60a783e2f555@linaro.org>
Date:   Tue, 7 Mar 2023 16:44:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/11] arm64: dtsi: qcom: ipq9574: Add nodes to bring up
 multipd
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-12-git-send-email-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678164097-13247-12-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
> Enable nodes required for multipd remoteproc bring up.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 145 ++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
> 


>  	soc: soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -829,6 +858,122 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>  			msi-parent = <&v2m0>;
>  			status = "disabled";
>  		};
> +
> +		q6v5_wcss: remoteproc@cd00000 {

Be sure you put it in correct place - ordered by unit address.

> +			compatible = "qcom,ipq9574-q6-mpd";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;

Why do you need them?

> +			reg = <0x0cd00000 0x4040>;

reg is always a second property.

> +			interrupts-extended = <&intc GIC_SPI 325 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcss_smp2p_in 0 0>,
> +					      <&wcss_smp2p_in 1 0>,
> +					      <&wcss_smp2p_in 2 0>,
> +					      <&wcss_smp2p_in 3 0>;
> +			interrupt-names = "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack";
> +
> +			clocks = <&gcc GCC_ANOC_WCSS_AXI_M_CLK>,
> +				 <&gcc GCC_WCSS_AHB_S_CLK>,
> +				 <&gcc GCC_WCSS_ECAHB_CLK>,
> +				 <&gcc GCC_WCSS_ACMT_CLK>,
> +				 <&gcc GCC_WCSS_AXI_M_CLK>,
> +				 <&gcc GCC_Q6_AXIM_CLK>,
> +				 <&gcc GCC_Q6_AXIM2_CLK>,
> +				 <&gcc GCC_Q6_AHB_CLK>,
> +				 <&gcc GCC_Q6_AHB_S_CLK>,
> +				 <&gcc GCC_Q6SS_BOOT_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_APB_BDG_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_ATB_BDG_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_NTS_BDG_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_APB_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_ATB_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_DAPBUS_CLK>,
> +				 <&gcc GCC_WCSS_DBG_IFC_NTS_CLK>,
> +				 <&gcc GCC_Q6_TSCTR_1TO2_CLK>,
> +				 <&gcc GCC_Q6SS_ATBM_CLK>,
> +				 <&gcc GCC_Q6SS_PCLKDBG_CLK>,
> +				 <&gcc GCC_Q6SS_TRIG_CLK>,
> +				 <&gcc GCC_MEM_NOC_Q6_AXI_CLK>,
> +				 <&gcc GCC_WCSS_Q6_TBU_CLK>,
> +				 <&gcc GCC_SYS_NOC_WCSS_AHB_CLK>;
> +
> +			clock-names = "anoc_wcss_axi_m",
> +				      "wcss_ahb_s",
> +				      "wcss_ecahb",
> +				      "wcss_acmt",
> +				      "wcss_axi_m",
> +				      "q6_axim",
> +				      "q6_axim2",
> +				      "q6_ahb",
> +				      "q6_ahb_s",
> +				      "q6ss_boot",
> +				      "dbg-apb-bdg",
> +				      "dbg-atb-bdg",
> +				      "dbg-dapbus-bdg",
> +				      "dbg-nts-bdg",
> +				      "dbg-apb",
> +				      "dbg-atb",
> +				      "dbg-dapbus",
> +				      "dbg-nts",
> +				      "q6_tsctr_1to2_clk",
> +				      "q6ss_atbm_clk",
> +				      "q6ss_pclkdbg_clk",
> +				      "q6ss_trig_clk",
> +				      "mem_noc_q6_axi",
> +				      "wcss_q6_tbu",
> +				      "sys_noc_wcss_ahb";
> +
> +			assigned-clocks = <&gcc GCC_ANOC_WCSS_AXI_M_CLK>,
> +				 <&gcc GCC_WCSS_AHB_S_CLK>,
> +				 <&gcc GCC_WCSS_ECAHB_CLK>,
> +				 <&gcc GCC_WCSS_ACMT_CLK>,
> +				 <&gcc GCC_WCSS_AXI_M_CLK>,
> +				 <&gcc GCC_Q6_AXIM_CLK>,
> +				 <&gcc GCC_Q6_AXIM2_CLK>,
> +				 <&gcc GCC_Q6_AHB_CLK>,
> +				 <&gcc GCC_Q6_AHB_S_CLK>,
> +				 <&gcc GCC_Q6SS_BOOT_CLK>,
> +				 <&gcc GCC_MEM_NOC_Q6_AXI_CLK>,
> +				 <&gcc GCC_WCSS_Q6_TBU_CLK>,
> +				 <&gcc GCC_SYS_NOC_WCSS_AHB_CLK>;
> +
> +			assigned-clock-rates = <266666667>,
> +						<133333333>,
> +						<133333333>,
> +						<133333333>,
> +						<266666667>,
> +						<533000000>,
> +						<342857143>,
> +						<133333333>,
> +						<133333333>,
> +						<342857143>,
> +						<533000000>,
> +						<533000000>,
> +						<133333333>;
> +
> +			qcom,smem-states = <&wcss_smp2p_out 0>,
> +					   <&wcss_smp2p_out 1>;
> +			qcom,smem-state-names = "shutdown",
> +						"stop";
> +
> +			memory-region = <&q6_region>;
> +
> +			glink-edge {
> +				interrupts = <GIC_SPI 321 IRQ_TYPE_EDGE_RISING>;
> +				label = "rtr";
> +				qcom,remote-pid = <1>;
> +				mboxes = <&apcs_glb 8>;
> +			};
> +
> +			q6_wcss_pd1: remoteproc_pd1 {
> +				compatible = "qcom,ipq9574-wcss-ahb-mpd";

Why do you need empty node? Usually there is no benefit and these should
be just part of parent.

> +			};
> +		};
>  	};
>  
>  	rpm-glink {

Best regards,
Krzysztof

