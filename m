Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2D6C1E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCTRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjCTReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:34:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A811EAA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:30:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id br6so15866835lfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679333394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUkNBgKIji4KAUdHCIafclaMQCxbZPhuIVJLpVn+vig=;
        b=yrLuUSqbfIZGSyMdBx3MLW3OQTK0ca8lCZTKNJ1hTZ05LmZvXPHnKCOShTaFn5W8n0
         72aFXKLIyMw6VwFzQ/V5s6e1HZZ5Mw8gEICshJp5D9UPLYyk04+onkQFfzJ+pCBt1DMz
         WQBiZaDjTwy0YtJMWRalNwGiSaAl0zE6WPX3grq9zWFIOBQKOQTuqZoeAEBbp4d22StD
         w+JrUYDRrNXSpiOQhcnmpPZZ2duQ7YnPqkBEx19Cin4NROyGR2QwL6wBxhHYDZ4i/W9h
         vPeyqdgdvF2ZyIWot3mlGq5radbnSPfnl9xaVP3feUX1aTxgiyI2A4vDPbXZRtbNlwlZ
         xRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUkNBgKIji4KAUdHCIafclaMQCxbZPhuIVJLpVn+vig=;
        b=66NPIIoJ+JX7Jiv+FzktWosUMS6LqrpRNWHM7/Q29dOegfkSOO7FxGsZGd8rG+W4oH
         AlXOueYFZpfEZoZ+nS6Ay0lmfTT2EgoVXNjfBxtAhtYih68XrE1Qa8i7FYU9xf+8n+Wb
         02fyJmcrc7cDrWCfOPnpgbHA7KCV4zCROgTkPNdopfe84T0RvdZpWRBko2qfu/28g+gd
         RmHW2nRy99lLdWzd4rpX69VpWIV5xNLUKS0qr9M1Mi/bwQVI8ZBDc+iUgjBNnHpZU9sT
         BnWEKbAG/nYTdT0ldTz5dODLHxpIenXR3tHokLO1qjsJqmo7Wv4CK/qgcuJ9AXCgn6Km
         AqwQ==
X-Gm-Message-State: AO0yUKUXdPxXO9rHQF7IBVOWsvas9+T3nNjVPYjgLbWHEPOjaxNYHdmq
        gPn20N8FEFMvIQArljFE5f4QBg==
X-Google-Smtp-Source: AK7set8dKKH+mPfIt1IcdGKkuSF2keuJQ2NJBN/ix8vlOp8lnKk6tcfMm/wyHe833I7z7+A4aT86pQ==
X-Received: by 2002:a05:6512:24c:b0:4e8:3d24:de6f with SMTP id b12-20020a056512024c00b004e83d24de6fmr222286lfo.14.1679333394654;
        Mon, 20 Mar 2023 10:29:54 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id b26-20020a056512025a00b0048a9e899693sm1786995lfo.16.2023.03.20.10.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:29:54 -0700 (PDT)
Message-ID: <e6dcfa3b-9814-fc57-cb03-87e89c9eaff4@linaro.org>
Date:   Mon, 20 Mar 2023 18:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 07/15] arm64: dts: qcom: sa8775p: add support for the
 on-board PMICs
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230320154841.327908-1-brgl@bgdev.pl>
 <20230320154841.327908-8-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-8-brgl@bgdev.pl>
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



On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new .dtsi file for sa8775p PMICs and add the four PMICs interfaced
> to the SoC via SPMI.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> new file mode 100644
> index 000000000000..afe220b374c2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmm8654au_0: pmic@0 {
> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	pmm8654au_1: pmic@2 {
> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	pmm8654au_2: pmic@4 {
> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	pmm8654au_3: pmic@6 {
> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> +		reg = <0x6 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
