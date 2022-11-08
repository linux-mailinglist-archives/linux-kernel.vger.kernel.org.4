Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0108621BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiKHSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiKHSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:19:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503C66C9C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:18:20 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id be13so22364645lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhsyzOd+JiqoQLFaHc8UXEAL2nKXCxT80Po+9P/JnWs=;
        b=jLg3rx1c+WJF2MMSClc8UhrWlUyz6Cu8cHNu2CRIlGs8LzIqekez4d+V93lxC4zLmF
         G+R2TmgH5DTzj+TlJC1SJ5q9UEl66HIYNaU/WXpEPIkyZ+nQCRpAXSQZDIgBp8lyGZBg
         UKR15rwuyiIRG48Ht5jR4avw3/swKdKOkVaCQ1H6a7/q8jy7ofRv7kP71kDcISLn6RQw
         6jKmDUHLgmRlSK0nO0OWeP8jAcOyxqSGlBpDylRpcj1r2JvbA2oiO/d/h/Alh46oRz1V
         mUyroJTwGsPIlgc3dQU5FPIAVB+K8J98+7oSKsWo0phLaYGtD6ZIG6gA3vf5jO1vgXDo
         611g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhsyzOd+JiqoQLFaHc8UXEAL2nKXCxT80Po+9P/JnWs=;
        b=PEGsYInj3uygMUcLyaQesnGl1sypbcXSmQZmLAHZ3iFGpTuAIdE2JSduVCPSM4oMzV
         BPBoEbAJwvAr4/bfnp5Kou/yKQbTAlmXxF0QHwShRXDgPOc30pHZUmUCxO7Xnnf/0r3f
         Zq3LXQjf9CNGa1l/RdSf9wahT28AO+IyPa+93tuRFHO4xpKXyGRnkTnmEw3LBe6BBKfl
         LHtXSJ5vWnXU4ulZlhEF+5sPXcmGT+VC0hOpRD49oYZwnC7GFxK72xW489LIWiv5xf6O
         EJlHJQtL6f41yoCHAxjLCcmtQQELE9sBHJ01ZWYjlEQzqOrFG0hDcXLmxauFmyJnr/ZM
         0XwA==
X-Gm-Message-State: ANoB5plWYoFvtmiHQ+IplMnCZub2e8K8kAM7WYggR00+ZnKGqiEJzMeN
        /hyad42i92xK3R3pZD3Je3Ny1g==
X-Google-Smtp-Source: AA0mqf7a210R/c0Mt7ePIfbKQJ1ldqSmYIxYuSUvPwKCwf9s8vAPVy8PH18KaP3uUVF3zxtPVTWxyQ==
X-Received: by 2002:a19:911a:0:b0:4b4:106d:9666 with SMTP id t26-20020a19911a000000b004b4106d9666mr1402462lfd.471.1667931498512;
        Tue, 08 Nov 2022 10:18:18 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id o7-20020a05651205c700b00497a0ea92desm1881138lfo.135.2022.11.08.10.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:18:17 -0800 (PST)
Message-ID: <f70346da-228e-79d2-7284-6c64cda7eda0@linaro.org>
Date:   Tue, 8 Nov 2022 19:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, nm@ti.com,
        piyali_g@ti.com
References: <20221108073231.35008-1-b-kapoor@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108073231.35008-1-b-kapoor@ti.com>
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

On 08/11/2022 08:32, Bhavya Kapoor wrote:
> J721S2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
> for 8 channel ADCs for J721S2.
> 
> Enable ADCs present on J721S2 soc.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index b210cc07c539..de9cb40273be 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -429,3 +429,17 @@
>  &main_mcan17 {
>  	status = "disabled";
>  };
> +
> +&tscadc0 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&tscadc1 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 4d1bfabd1313..47a7a6b500c2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -299,4 +299,44 @@
>  			ti,cpts-periodic-outputs = <2>;
>  		};
>  	};
> +
> +	tscadc0: tscadc@40200000 {

Node names should be generic, so "adc"
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

