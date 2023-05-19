Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB64F70946C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjESKGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjESKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:05:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620EF102
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:05:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae408f4d1aso24469755ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684490758; x=1687082758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6PY6uvUf462T5HGV7ZU1zDBsJ0eattmDdV+/C5PCe8=;
        b=IVUEnwMqL5OREMR07mtKr8g8QRCpY4hGCDmnHnUVeqzZat7auN15wGndpqI2hOG8Ku
         UKZjPP6eJT1wyv3Uo1nbytT+te6IV7AFyo9YW6mYXzNNcZE3jSZUVkuf3vH+50X+bu+T
         iA5JSSUemXiJCUXn3x941Ud6NdyRngRfcSmSlH4vtI7Jw2zcZx+vB6sB4X2gfaz9yJq1
         01hqTR6/t5ME5bm456kENgG70IQUp/17RKiGyBmFnNCzpksENb4BpUtvNHnqrQduTmSp
         6VIrzSx8aCQTsxebHR7j8aZdoSNfokPc0nYPnjDfmghNRkgJccQTy3zo6PIMvQqm9rx6
         LYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490758; x=1687082758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6PY6uvUf462T5HGV7ZU1zDBsJ0eattmDdV+/C5PCe8=;
        b=U4AmCEs7vbY8sKZgRze4NUz3cBtABFGBvkp4SP4NyZFCji5930Fx9ZtjYoX38tMrCn
         QYIFAt71KCqHQDtxJxxvOP8yYaDuw3jMAbJ+NkfmOGwl+RXif+DmH+qZ5hMthezKGG37
         XwxdOJpaLjWZjTLI8X71XxxjUN0yB4RxNXtdnH5/wZjEsHct3mqB6wuMGyE9U42LAqrG
         d9rTB/MKaWl32u7JONToH/Dpy/8GTT7P46cfWsSrbyV7CFS5g+GJrOjUMxGg50htV0U2
         OqIQt6UakR0wmGEn5Z0O/l3lRfyuFuEKVzXFOhnN7n8I16sfdRy02nhM+LNoUDdII+o0
         a16A==
X-Gm-Message-State: AC+VfDz88qfTgeJGrvw9qFkNqidD82jBpjVn6ppKXryQt8vTd7gt7ZJ9
        z7SNhs0QSZ9lllqYRZbNQMry3A==
X-Google-Smtp-Source: ACHHUZ7lgCfZfb0FUOSKZivRwVF3xk9a4aNF0MSxuLrcXj9+fivBKJ+Knm9ROa3VzxvyXITlnYpSAg==
X-Received: by 2002:a17:902:e547:b0:1ac:712d:2032 with SMTP id n7-20020a170902e54700b001ac712d2032mr2401279plf.50.1684490757775;
        Fri, 19 May 2023 03:05:57 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001a800e03cf9sm3006682plg.256.2023.05.19.03.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 03:05:57 -0700 (PDT)
Message-ID: <7cf74a2b-21e3-4a0d-5791-d7d97e21cf30@linaro.org>
Date:   Fri, 19 May 2023 15:35:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/4] arm: dts: qcom: qdu1000: Add SDHCI node
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-3-quic_kbajaj@quicinc.com>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230519085122.15758-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

On 5/19/23 2:21 PM, Komal Bajaj wrote:
> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 60 +++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 734438113bba..6113def66a08 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -19,6 +19,10 @@
> 
>   	chosen: chosen { };
> 
> +	aliases {
> +		mmc0 = &sdhc_1; /*SDC1 eMMC slot*/

Please use the right comment formats /* text */
Also, just /* eMMC */ would be fine here.

> +	};
> +
>   	cpus {
>   		#address-cells = <2>;
>   		#size-cells = <0>;
> @@ -842,6 +846,62 @@
>   			#hwlock-cells = <1>;
>   		};
> 
> +		sdhc_1: mmc@8804000 {
> +			compatible = "qcom,qdu1000-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x08804000 0x0 0x1000>,
> +			      <0x0 0x08805000 0x0 0x1000>;
> +
> +			reg-names = "hc", "cqhci";
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC5_AHB_CLK>,
> +				 <&gcc GCC_SDCC5_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +
> +			/* Add dt entry for gcc hw reset */

Please drop the comment above - it's not needed.

> +			resets = <&gcc GCC_SDCC5_BCR>;
> +
> +			interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +			power-domains = <&rpmhpd QDU1000_CX>;
> +			operating-points-v2 = <&sdhc1_opp_table>;
> +
> +			iommus = <&apps_smmu 0x0080 0x0>;
> +			dma-coherent;
> +
> +			bus-width = <8>;
> +			non-removable;
> +			supports-cqe;
> +
> +			no-sd;
> +			no-sd;

Can we club the following 3 together:
non-removable;
no-sd;
no-sd;

And normally these is a part of board file (.dts), right?

Thanks,
Bhupesh

> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-hs400-1_8v;
> +			mmc-hs400-enhanced-strobe;
> +			cap-mmc-hw-reset;
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
> +					required-opps = <&rpmhpd_opp_min_svs>;
> +				};
> +			};
> +		};
> +
>   		pdc: interrupt-controller@b220000 {
>   			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>   			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
> --
> 2.17.1
> 
