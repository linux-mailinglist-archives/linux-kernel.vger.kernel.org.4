Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3FA6BA3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCNX6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCNX56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:57:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552D5AB53
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:57:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bp27so11904428lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678838273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aN4RFzxPl53NEPH6mcAZ76PnFwWs2sCpg6jdulGDfz4=;
        b=p1kdN9n8iQ66a3wqyEKOARChYxLd6XFWH2SzWccJluze2vB/0Ng8lfv78xIyfylnIZ
         iKrjwojzdeICtwuyIivQkme62hqmnZWd8MXSTz9xPv0zom/WDvuUcYmc66W5S/XsRWEs
         FDQtG67SYZxUcslXIMGn9OW0ga+QJV/i+kbzsM92edJxw0zpRxJ7pWlnEEgAvGRGPjhJ
         R47yn8w/UexDHdWDfnEcx4rRmFlMewF6w19+VljVv03JnR2ORT3z5TD2uk2qUzbJE04r
         NsZ0v6KiouFi6soYloc+yZ3om7hc5Jfb+hxGPuP5slR84IFoB7P0lzhvZNM23OaPO4Rr
         rZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678838273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aN4RFzxPl53NEPH6mcAZ76PnFwWs2sCpg6jdulGDfz4=;
        b=qJ3c1f3zV+ia8gPrLMrJGqA6i5B3QUhWcWn212AxEJnYTrWzaDDa0T2TVIN3QYqbRD
         xaUmAUbwBqVECT/ZgVPE8t7r+fMAsFtoU/KpdON1Hck8yK9fTDSIEAm+mTSIBE08vwte
         mENEAmkAGgvw+UooKEwWaeHUHxv78Ifx2lw8mArCGLFo2EMI7iIHd4L/46Z7VXpDpAAX
         QX2LZIp0E/ipQihbfUUnYR2SJGfY6P7oYDRT1LQw2O3udT524mikjf+HYsJ5sos3BXkP
         /p3czmGtC7QYDGWSDx2xo5WhaWM+SY7dvIkbW9wydvNBn9JdIUp6n3xlRmifgDxzGNto
         BEbA==
X-Gm-Message-State: AO0yUKVCX4WXbg43+KkIyNsSsqioKgurD8DnYn7c62ivFN9Ex0CLLBSf
        6PpW28KDb9mkImY6tRkFgfEY4Q==
X-Google-Smtp-Source: AK7set+puZ2tGimAgVlxw/q4UwXqtRXPDbxxa0kHDBZ0r/f0xE9gPf1dE+rK3zKk05T0XDNH8EwL8w==
X-Received: by 2002:a05:6512:408:b0:4dc:65c0:c74e with SMTP id u8-20020a056512040800b004dc65c0c74emr1385832lfk.29.1678838273627;
        Tue, 14 Mar 2023 16:57:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id t16-20020ac24c10000000b004d4d7fb0e07sm585254lfq.216.2023.03.14.16.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 16:57:53 -0700 (PDT)
Message-ID: <adb3a64f-2542-6123-4306-3ed6eac928dc@linaro.org>
Date:   Wed, 15 Mar 2023 00:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 12/15] arm64: dts: qcom: sm6375: Introduce MPM support
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
 <20230303-topic-sm6375_features0_dts-v1-12-8c8d94fba6f0@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-12-8c8d94fba6f0@linaro.org>
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



On 3.03.2023 22:58, Konrad Dybcio wrote:
> Add a node for MPM and wire it up on consumers that use it. This also
> fixes a very bad and sad assumption I made when initially porting this
> SoC that the downstream MPM-TLMM mappings were 1-1. That apparently
> changed some time ago, so with this patch the MPM consumers will actually
> be hooked up to the correct interrupt lines.
> 
> Fixes: 59d34ca97f91 ("arm64: dts: qcom: Add initial device tree for SM6375")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
As agreed with Krzysztof offline, this one is a no-go.
Awaiting resolution on RPM MSG RAM bindings.

Konrad
>  arch/arm64/boot/dts/qcom/sm6375.dtsi | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index 94bb373f8d97..ecb654357288 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -315,6 +315,7 @@ CPU_PD7: power-domain-cpu7 {
>  
>  		CLUSTER_PD: power-domain-cpu-cluster0 {
>  			#power-domain-cells = <0>;
> +			power-domains = <&wakegic>;
>  			domain-idle-states = <&CLUSTER_SLEEP_0>;
>  		};
>  	};
> @@ -633,7 +634,7 @@ tlmm: pinctrl@500000 {
>  			reg = <0 0x00500000 0 0x800000>;
>  			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-ranges = <&tlmm 0 0 157>;
> -			/* TODO: Hook up MPM as wakeup-parent when it's there */
> +			wakeup-parent = <&wakegic>;
>  			interrupt-controller;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> @@ -755,7 +756,7 @@ spmi_bus: spmi@1c40000 {
>  			      <0 0x01c0a000 0 0x26000>;
>  			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>  			interrupt-names = "periph_irq";
> -			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts-extended = <&wakegic 86 IRQ_TYPE_LEVEL_HIGH>;
>  			qcom,ee = <0>;
>  			qcom,channel = <0>;
>  			#address-cells = <2>;
> @@ -791,6 +792,25 @@ rpm_msg_ram: sram@45f0000 {
>  			reg = <0 0x045f0000 0 0x7000>;
>  		};
>  
> +		wakegic: interrupt-controller@45f01b8 {
> +			compatible = "qcom,mpm";
> +			reg = <0 0x045f01b8 0 0x1000>;
> +			interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_SMP2P>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			#power-domain-cells = <0>;
> +			interrupt-parent = <&intc>;
> +			qcom,mpm-pin-count = <96>;
> +			qcom,mpm-pin-map = <5 296>,  /* Soundwire wake_irq */
> +					   <12 422>, /* DWC3 ss_phy_irq */
> +					   <86 183>, /* MPM wake, SPMI */
> +					   <89 314>, /* TSENS0 0C */
> +					   <90 315>, /* TSENS1 0C */
> +					   <93 164>, /* DWC3 dm_hs_phy_irq */
> +					   <94 165>; /* DWC3 dp_hs_phy_irq */
> +		};
> +
>  		sram@4690000 {
>  			compatible = "qcom,rpm-stats";
>  			reg = <0 0x04690000 0 0x400>;
> @@ -1185,10 +1205,10 @@ usb_1: usb@4ef8800 {
>  					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>  			assigned-clock-rates = <19200000>, <133333333>;
>  
> -			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts-extended = <&intc GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&wakegic 12 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&wakegic 93 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&wakegic 94 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hs_phy_irq",
>  					  "ss_phy_irq",
>  					  "dm_hs_phy_irq",
> 
