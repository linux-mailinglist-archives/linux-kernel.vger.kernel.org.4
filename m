Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE046BA09F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCNUXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjCNUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:23:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69002B636
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:23:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m4so8601521lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678825379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEIZdHCfx9cGTkFeh+07JO8Lboce4xL6m1cAEzuyo8Y=;
        b=MUPw5BTjDVecsRP8Di8yTaAnTfTLv8FxJ+CiOf8Hbjf7DjiazMBhjZq5CBlEPDM0hj
         r8ur9FBBAk/ZcYq67N9/TXZnTwK1RuZpnavDfbOHwBW1c+UiENb7cyZ7EjhbS1updTDc
         PaB/PZh8d22DMOGx54mUy/PW/XQsrpHXQGmHw48/m+44kL6k+K8Tf7ADaWk+7KA+KfwH
         3DgEd2JNy3JzP8cjc44LJRizpUZ/QG1ZsADY4BBKYnlfyf0J5wUTOQkVUepgFNKwb81W
         3wXpHLmkykVPP0Q3TaMOBXr3N16CPJ28s+C7ePoSacZIqilIN/R9Hj9DDg/ilzn8b52O
         Mn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEIZdHCfx9cGTkFeh+07JO8Lboce4xL6m1cAEzuyo8Y=;
        b=2mVN0XhZ8wOahZuwYmyh2KgBs6uUF7snekFFJACHyGHliYeU8wJX3JxswMXsEzfmDd
         +nrJJKj5hcTh/LtUB/r5XvbO7BPbLWksrrXaW8TgE2IedmQsSgL19etFNeRqiW/BY+wx
         vgyIMz+W3dBCAhkE/SiEOdy3C7RWlfrbtTkA1RbVlHoVTY0akMfnsTm76XHBRGrQhSKb
         TSraC/bZ9kUcXnDg5JTNc6h2/sdzKA/M5w5nqnAqcMtdGKf24mdg6X2VER0N4MwL5Anb
         X3qOH1U3M3mfR7mo8vJp6nuRXLxtIKA3QNVCwGYKVEWc/41kyeMYQkmyuBYPF5S4wCvL
         0EFA==
X-Gm-Message-State: AO0yUKVZt4bWZUe9Y0afJt5s04oXHtbXatgZzT4jLoIqiZ5znAkFXbXO
        JJzQpJxzfABy37Pwwpi8IG8PCA==
X-Google-Smtp-Source: AK7set9WxjZkM7fy+9fuq+4jIrZn7/mXAYs1U7lLky5CA0SAQxgruGmIhqElPLk5vT0UoB9o6BlXNw==
X-Received: by 2002:a05:6512:489:b0:4d8:62e5:4f64 with SMTP id v9-20020a056512048900b004d862e54f64mr1202962lfq.17.1678825378895;
        Tue, 14 Mar 2023 13:22:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i14-20020ac25d2e000000b004d8584970b8sm523570lfb.226.2023.03.14.13.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 13:22:58 -0700 (PDT)
Message-ID: <08dff56d-227a-a791-549c-15ac0f1ac08b@linaro.org>
Date:   Tue, 14 Mar 2023 21:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/14] arm64: dts: qcom: sa8775p: add support for the
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
References: <20230314183043.619997-1-brgl@bgdev.pl>
 <20230314183043.619997-6-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314183043.619997-6-brgl@bgdev.pl>
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



On 14.03.2023 19:30, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new .dtsi file for sa8775p PMICs and add the four PMICs interfaced
> to the SoC via SPMI.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> new file mode 100644
> index 000000000000..77e2515a7ab9
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
> +	pmk8775_0: pmic@0 {
pmk8775..

> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
..or pmm8654au?

Konrad
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	pmk8775_1: pmic@2 {
> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	pmk8775_2: pmic@4 {
> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	pmk8775_3: pmic@6 {
> +		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> +		reg = <0x6 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
