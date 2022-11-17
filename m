Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6362DBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiKQMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiKQMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:51:45 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386D56EF8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:51:41 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x21so2534719ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivOtpXTOVxqAUn1+lH6HKSHAv64mRXc3v+PCvhSh3nM=;
        b=jCOO/9/1ZgQUAToy/jlfSV/3OEUGI6uZiLwvNVaOGz8jE8IZ3zHrQ/QCxv1m/P5efU
         RhxqS6Y4LwUGVy7G22ZyeVaWp9U8qSQnkI4CLp5EEhgn+p3Jmws70lg5gsIffMsnOyjO
         gVTlx5toTuKOg2R56XWkdR6UiMlzYMCAqcsxKvg1ofH4BaHRr1cftJOnAFK5kUrYFGEx
         Rt2dw+EiKDdA3R6KWrsNF5fwdOU6FR/qDxUSIo+/cHHfv+/TU7Q+h8VJgi7qwu8k0Yrq
         aAJeUZSndB3/8SSaUh8eo8QLvVD1NBYjqu3/JgYpCVUel99eObeBMpDy3Fsskfrqj80b
         uxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivOtpXTOVxqAUn1+lH6HKSHAv64mRXc3v+PCvhSh3nM=;
        b=dcP2v6sKm1vUSLEtCR+qqv+9eNJi0RAH/OJzBJMnCpqgpeuegfWwwuIeNvBMlmx9F2
         GeuKCNbTtF2HQ73XUWQdRoIB7BXC62QF/koxjigStJ51Z3Fl9GE6SjHAvMXVDcyot+NO
         Rl2NJ72zCoBW+D+gm782IJMERy8gztFxGgEA+i+nwn2tDHYFoxw7ssxgZ7nh0g4kkgju
         uYNVy4mrPwCZQLKGr6bLl1hSQRS7GaAySxIpgfw7BgwZpU/caynk/KmQL7roBwrXlrYH
         vt0tkjuGPSpPCj70v+GIyKaROwneQmdXvZ6GuO2K0fmUgjzFtj3WnV03VQWVs5i+JEBz
         UqFg==
X-Gm-Message-State: ANoB5pmnOYR1GVNTdnUot9yx5vCmQSYEa6W0QyZbbLWp9bpgbTwDhIax
        Gl1GL+t2vRrQ8F3xTykg062Rdw==
X-Google-Smtp-Source: AA0mqf5txKZD1DtAJuOvDYd5A5Lz3o/9OuyIeJ6s9Hg+26PK3VHEPiIPbuMHEN2xQuGxdqE38Tq0Tw==
X-Received: by 2002:a05:651c:150c:b0:277:c7c:c573 with SMTP id e12-20020a05651c150c00b002770c7cc573mr956141ljf.316.1668689499998;
        Thu, 17 Nov 2022 04:51:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b004b4b69af17dsm133528lfr.214.2022.11.17.04.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 04:51:39 -0800 (PST)
Message-ID: <76560659-7c90-3846-c250-24bfb072ec0e@linaro.org>
Date:   Thu, 17 Nov 2022 13:51:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-4-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116103146.2556846-4-abel.vesa@linaro.org>
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

On 16/11/2022 11:31, Abel Vesa wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Add nodes for pm8010 in separate dtsi file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8010.dtsi | 84 ++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8010.dtsi b/arch/arm64/boot/dts/qcom/pm8010.dtsi
> new file mode 100644
> index 000000000000..0ea641e12209
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8010.dtsi
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: BSD-3-Clause

Any reason why this is licensed BSD-3 clause? It's not a recommended
license (2 clause is). Same for other patches.

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

Just one blank line.


Best regards,
Krzysztof

