Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3B62BB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiKPLSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiKPLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:17:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7954B9A1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:06:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x102so10774651ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5/N5LyBz+qKhDlrBFv0875oFJ3hH7vg4dj8YnmHYuQ=;
        b=Eyfm9LAdzTXXfnF6NWjr2swz7ns/Z8SRnftpfOEIxvLoP0I9W9wyyFnmnfwLWs7AXm
         fAJXTUrZtCjSnKOcZOnUmzXBY87gJCeHa+Wvsenaqp5Q60Ax19XilMT5wTQjIxhtlqqZ
         f9y92MEqv5lpj+WYn060367m/SWJQtdsHes1sJ5W+4OZdV229sCU6ewX1offjuS2TtUW
         P3kzENfg1e82Xu/qdcs13EYP0Q9I3O0Ix9Qm0fax4nlZnJc04yDhOWZkgITDULlPftsi
         +LmPiQuc0STm46TMEZUMms/gifCU4utcnmriKnFUwrLn7Yq7R+axjEUMCJrb5OeI464D
         Fnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R5/N5LyBz+qKhDlrBFv0875oFJ3hH7vg4dj8YnmHYuQ=;
        b=1VR7g2yFe6fPYGQdI2a/360kMFoCKwy0zkCcou702rMe2S6gP+v3bKR320kust5AdX
         ykhm2MzjOtQMmEGTH6E3c32oKA7Ot2aWjj1v35PsL2NlnBpjGz4MEs4OKdBST7nqNZqt
         CEhw5+YmuV6Jj/B6aPY1BG+ECCw1HhUL9yeKafhq6B4WeVROyYGbwkVZmL0cQpNfjGKg
         cHxg6LocJUN7AbtjoEO3+ZJtH0+OHSeJcU2zyqS4VJ+ruYrVoorOkBLzFwnj5QHiS+lX
         J9u8TkB+tRMExn9qSwLayOBDcYOUdrtgv0EcYJqat0ls7QBOwg7EeUDo2dLWn6l41hmc
         Yovw==
X-Gm-Message-State: ANoB5pkHM3o0sZsEAedN51AymvD7XUNwgqzEpDG1t4OxVC7OKRf9jBos
        /TWCjD29XXG/ph8vsXidQSI9UW69c5NheAv3
X-Google-Smtp-Source: AA0mqf5OU9UWZUGRklx8nSQJtDU+t/03DGd/iu2VDa9tHl5/YLHJbGegy00xmMg3GF3EtpP/6uzM5w==
X-Received: by 2002:aa7:d691:0:b0:468:74:9668 with SMTP id d17-20020aa7d691000000b0046800749668mr9311523edr.394.1668596786354;
        Wed, 16 Nov 2022 03:06:26 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b0077f20a722dfsm6620030ejb.165.2022.11.16.03.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:06:25 -0800 (PST)
Message-ID: <4d5daa59-37c8-6664-fb6e-6d0d58245664@linaro.org>
Date:   Wed, 16 Nov 2022 12:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-4-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116103146.2556846-4-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 16/11/2022 11:31, Abel Vesa wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Add nodes for pm8010 in separate dtsi file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/pm8010.dtsi | 84 ++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8010.dtsi b/arch/arm64/boot/dts/qcom/pm8010.dtsi
> new file mode 100644
> index 000000000000..0ea641e12209
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8010.dtsi
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +	thermal-zones {
> +		pm8010-m-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8010_m_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		pm8010-n-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8010_n_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +
> +&spmi_bus {
> +	pm8010_m: pmic@c {
> +		compatible = "qcom,pm8010", "qcom,spmi-pmic";
> +		reg = <0xc SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8010_m_temp_alarm: temp-alarm@2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0xc 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +	};
> +
> +	pm8010_n: pmic@d {
> +		compatible = "qcom,pm8010", "qcom,spmi-pmic";
> +		reg = <0xd SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8010_n_temp_alarm: temp-alarm@2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0xd 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +	};
> +};
