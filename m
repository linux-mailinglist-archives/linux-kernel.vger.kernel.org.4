Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E09F7189A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjEaSwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEaSwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:52:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B310F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:52:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso134386a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685559134; x=1688151134;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8mhm7idTTwdobO8VYFJI/rBh8GvseokeCrJFHScjyQ=;
        b=bqXJHM08t5TZHMjSxtosb6YTa615kIAiva0EtLAFyfpHwW+dw877RZ/o1DtXhy0OML
         Arf70ALlnliZ4KLorEm8/YurfJxPfzCQjmUtLBj/Wapcendah8Z2vrl5hR+amjFBFnN/
         MVo79+h72WbT2kXD77itbNsWrlVUZ3BO/mMjLA8Ue6aNxE7KWie9XCtYI+iJqcTYkU7e
         BkFXbUaXVHTShsbCM0OupE+O9neLA6hg/NXWi0wCH/742cIvAhly9fseb/7BFp5wJeAO
         LfEhT1Aj8Ur0/+nHAAymQw2ILzkNWxBBMsXtb8s4HQROheOkW+FMxHP7X0jqzfQ0m7hA
         qTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685559134; x=1688151134;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8mhm7idTTwdobO8VYFJI/rBh8GvseokeCrJFHScjyQ=;
        b=SwzzJb3SfauPw/noxFT6YR5pfT7XIks5yeHaOXIT3vUdqD219sZduk6uKckqwnduvr
         OS49G853GOgWn9sY4MI7uBkwTJDrxf3u+ryufkS9+ZU/brz5cWccUigJEp+z+r2g1KCp
         juKp3Wd2bhWBcPUBGzmksHJsp0V8xAOir5WluGMMQofD/75HUeBVBC0DRhN2dBKA7zWJ
         jy807ooUZoj7nIxkp5YxbEfYyTA8AROFmRT6deF13Rerf9dORalpd2iNrcsiuSOrTiq/
         rTYPZohAY45qZ9K6GHi22tEh9X+eMUQPE0mZJEvCm7FndZRhZzaqCvQUXU55GCBLa4IE
         iumw==
X-Gm-Message-State: AC+VfDz40r8WTVc4AlijIqL6U4AZn8x8AqkYsmR04BU1I+1UAZRogOqz
        FnybSKcNZbrdWdOJWqkvBA9XEg==
X-Google-Smtp-Source: ACHHUZ6eOrx4dIjp3wqkvG5513eaco+Qx5vesKTAid5KKQIWpiLWUF0vG/B6UCte/witxxniYeSIkw==
X-Received: by 2002:a05:6402:1219:b0:510:db93:f034 with SMTP id c25-20020a056402121900b00510db93f034mr4219474edw.36.1685559134197;
        Wed, 31 May 2023 11:52:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id d23-20020a50fe97000000b0051458c4ae68sm6138807edt.77.2023.05.31.11.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:52:13 -0700 (PDT)
Message-ID: <a9b0202b-dd1f-3844-ac0a-7dc318d7c3fb@linaro.org>
Date:   Wed, 31 May 2023 20:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq5332: add support for the RDP474
 variant
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230531135048.19164-1-quic_kathirav@quicinc.com>
 <20230531135048.19164-5-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531135048.19164-5-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 15:50, Kathiravan T wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 474 based on IPQ5332 family of SoC. This patch carries
> the support for Console UART, eMMC, I2C and GPIO based buttons.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts | 112 ++++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4f9e81253e18..0f8c763a9bd9 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp474.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
> new file mode 100644
> index 000000000000..085729a0fdf1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * IPQ5332 RDP474 board device tree source
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "ipq5332.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.9";
> +	compatible = "qcom,ipq5332-ap-mi01.9", "qcom,ipq5332";
> +
> +	aliases {
> +		serial0 = &blsp1_uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	gpio_keys {

Same problems as with most of recent patches. No underscores in node names.

Best regards,
Krzysztof

