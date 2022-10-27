Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFA60FBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiJ0PWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiJ0PWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:22:02 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D01A07D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:21:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 8so1164667qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heHpdcI45GOXk8T2s9CmWTp8F02GlWHnis60xMjPMlk=;
        b=B6pZGgr5Vb424y2UPAUjVdVDpiMLvwsdFM7+CrEvb00N8q5EF4R+w+SLQqq3RNL6i+
         dda795nURfokgHWmscaDh5bQt4n9BlfhVrZzIYNPeioZZHxuzgfH8PG6lQI3JnyaYeVB
         y7ivL2118dYWNSYp5QnrE0AOSUIf3wS+P0FVjvPRiPeKZuOkCUzCjofP95A9pub7EOLN
         sd7GGCbmolDJz/pHT5OppzbZgJyehQ5d28wzutZ8lruxuXNvO00M38WUfmzCFJtgPhff
         LcrWGzIrV4w8Wabdumi2jfgRLFHfY6yJ9Le30/NdiZlrBjD+bsoolEvzzHReqyqhGUM+
         ld0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heHpdcI45GOXk8T2s9CmWTp8F02GlWHnis60xMjPMlk=;
        b=x1fs44uZnqRRKezsJOXVSWxHLz0l13wBaPP/6s4h8Ipn0q2CP3jdZ9LkW2tI8Dqcig
         nkbpaChSyCprcTz/kWlRtAf6TMWdbI2DkrW2b5ZQ4uEfHAcQPzc1S351JQWMisjnJ6k3
         eqh5JzBLVeaPn4BnFb8OmAjH6A39a/bMhkMsMmDNYwJccGOzfL+ur92qIf+qg1S3mtbj
         OUmmIZS2sFr6poLlNo3JWPxtSgtI8jWo97nwuh00nXfe08KCQrYrbOipOHUb+g2r/RHn
         ZoCzXY7QJLzd/MwSS9dq4RRBVJoofHbTic2TNfurvjTg7sf8TF2J7Ypw6w+pN0HSTrfp
         5TCQ==
X-Gm-Message-State: ACrzQf0QULa1HW3qAVLAVouLz1+ka3aO92UMLAJb/XXjoXA6R04s4P7/
        RGLzesz1OToQ4kWtbw4QxOpX99HeEBxXcw==
X-Google-Smtp-Source: AMsMyM5A7BjcafrMIY/pw2z0YoMSHNSpNA/KPFxJ/5qUjU7y0AS8z0jOn6JQnM46RXu18BQEf5iKvA==
X-Received: by 2002:a05:622a:19a2:b0:39c:ba6d:5d6d with SMTP id u34-20020a05622a19a200b0039cba6d5d6dmr41370322qtc.358.1666884100567;
        Thu, 27 Oct 2022 08:21:40 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y27-20020a37f61b000000b006cf19068261sm1094226qkj.116.2022.10.27.08.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:21:39 -0700 (PDT)
Message-ID: <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
Date:   Thu, 27 Oct 2022 11:21:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-4-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026200429.162212-4-quic_molvera@quicinc.com>
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

On 26/10/2022 16:04, Melody Olvera wrote:
> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
> to boot to shell with console on these SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1406 +++++++++++++++++++++++++

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>  2 files changed, 1433 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> new file mode 100644
> index 000000000000..76474106e931
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -0,0 +1,1406 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */

(...)

> +
> +	soc: soc@0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0 0 0 0 0x10 0>;
> +		dma-ranges = <0 0 0 0 0x10 0>;
> +		compatible = "simple-bus";
> +
> +		gcc: clock-controller@80000 {
> +			compatible = "qcom,gcc-qdu1000", "syscon";
> +			reg = <0x0 0x80000 0x0 0x1f4200>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
> +			clock-names = "bi_tcxo", "sleep_clk";
> +		};
> +
> +		gpi_dma0: dma-controller@900000  {
> +			compatible = "qcom,sm6350-gpi-dma";

You should add here a specific compatible as well. Same in other places.
All places. I had impression we talked about this few times, so I don't
know what is missing on your side.

This must be:
"qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma"

> +			#dma-cells = <3>;
> +			reg = <0x0 0x900000 0x0 0x60000>;
> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <12>;
> +			dma-channel-mask = <0x3f>;
> +			iommus = <&apps_smmu 0xf6 0x0>;
> +		};
> +

(...)


> +
> +		tlmm: pinctrl@f000000 {
> +			compatible = "qcom,qdu1000-tlmm";
> +			reg = <0x0 0xf000000 0x0 0x1000000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 151>;
> +			wakeup-parent = <&pdc>;
> +
> +			qup_uart0_default: qup-uart0-default-state {
> +				pins = "gpio6", "gpio7", "gpio8", "gpio9";
> +				function = "qup00";
> +			};
> +
> +			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
> +				pins = "gpio10", "gpio11";
> +				function = "qup01";
> +				drive-strength = <2>;

Can we have some generic agreement where to put drive-strengths and bias?

See also:
https://lore.kernel.org/linux-devicetree/20221026200357.391635-2-krzysztof.kozlowski@linaro.org/

https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/

> +				bias-pull-up;
> +			};

(...)

> +		};
> +
> +		cpufreq_hw: cpufreq@17d90000 {
> +			compatible = "qcom,sm8250-cpufreq-epss", "qcom,cpufreq-epss";

This is not sm8250...

> +			reg = <0x0 0x17d90000 0x0 0x1000>, <0x0 0x17d91000 0x0 0x1000>;
> +			reg-names = "freq-domain0", "freq-domain1";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> +			clock-names = "xo", "alternate";
> +			#freq-domain-cells = <1>;
> +		};
> +
> +		gem_noc: interconnect@19100000 {
> +			reg = <0x0 0x19100000 0x0 0xB8080>;
> +			compatible = "qcom,qdu1000-gem-noc";
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +	};

Best regards,
Krzysztof

