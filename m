Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004AE73B53C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFWK2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjFWK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:27:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965EFE6D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:27:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-311367a3e12so563094f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687516074; x=1690108074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=susFV57im5tSf3WGR3zOStFyG2/oJd0dt6Ch9Sc5R/Q=;
        b=CQ26+r7KjbMFIgFsXrZx03f5Ypz1JJ10KyMGQBCHYHCEHCPdHnSVif7EgPDUedT7JQ
         yZDsqUQgH/CoPO+aq2wggZXdnqjBLdwYujJWjdQ042c8arIcP2JLN5AiR8HxhrHxG887
         Sq/3F6oHNMe8XGCPg6Lmpj/x64rWHKoI8TuTe66EA0kzSDkbRilJa8NDZTetBWQ6nOmH
         lqJSTJ9W/bJJAju8/QsBopiubfaA6ZWWZyfXTFsOlFJcVtAHlNvUGNLXqunQ4oZFkhWA
         8bJvzMlZw5ThOQccm8phIt0IkxOg1RG/mut3d2GaU5jfi4vlz+MM77ELcYRRiBu6l4gh
         kimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687516074; x=1690108074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=susFV57im5tSf3WGR3zOStFyG2/oJd0dt6Ch9Sc5R/Q=;
        b=IxSxsEwj+0thQGL5Sy8puJJuV5+TLZhbaGWgw9MoCvnEr9wuT2AmmEjSlS1v+puTO1
         Y00y05l107rUufAk63pcVbN0ikTLI003BVsFYFKdyZxhIaD8Lti158itGJiLruBTYBrh
         2DGB7HERwwF6w1MWAbML6hug3kQc1T9hA49HM7ql4K7EZZIC7xFW1A5iL7CxFpS0ajcy
         ehq0gLqPuQ9rYRlytRu19W3qKgS/fBPuAAWD9SrJA7ugtgoAirzYX6+B+rJkVGHi7Hxt
         2H9YKMXHiD4jNQM2LhEGbH4poye6xn96uMVsSOCkg44qCWCq9YEA1EVqd3iEQPrgjksI
         u/4Q==
X-Gm-Message-State: AC+VfDxyfdOpQMaETneikBsvhoguv8yIruLsn2olRmQV6zZJxZMTT+ET
        XzhMSC6nxhe1VAHN6TEZhOhBPg==
X-Google-Smtp-Source: ACHHUZ6zbSDzHqUUOp6uJk47EIyk+W/ESkxUmRwqpu4U8tTf86ZaJNkr4kooSftOtxD+8aLz2UNHlw==
X-Received: by 2002:adf:dcc3:0:b0:309:54b6:33b0 with SMTP id x3-20020adfdcc3000000b0030954b633b0mr19128922wrm.44.1687516074065;
        Fri, 23 Jun 2023 03:27:54 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b00307c8d6b4a0sm9180899wro.26.2023.06.23.03.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:27:53 -0700 (PDT)
Message-ID: <5fbba4e8-a8d9-0e99-e112-31b5781c1648@linaro.org>
Date:   Fri, 23 Jun 2023 11:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial
 dts
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
 <20230623100237.5299-1-linmengbo0689@protonmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230623100237.5299-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 11:02, Lin, Meng-Bo wrote:
> This dts adds support for Samsung Galaxy A7 smartphone released in 2015.
> 
> Add a device tree for A7 with initial support for:
> 
> - GPIO keys
> - Hall Sensor
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART (on USB connector via the SM5502 MUIC)
> - WCNSS (WiFi/BT)
> - Regulators
> - Touch key
> - Accelerometer/Magnetometer
> - Fuelgauge
> - NFC
> - Vibrator
> - Touchscreen
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/msm8939-samsung-a7.dts      | 495 ++++++++++++++++++
>   2 files changed, 496 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 337abc4ceb17..23fd31d4bf5a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
> new file mode 100644
> index 000000000000..66e56ac59998
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
> @@ -0,0 +1,495 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8939-pm8916.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "Samsung Galaxy A7 (2015)";
> +	compatible = "samsung,a7", "qcom,msm8939";
> +	chassis-type = "handset";

Will the downstream bootloader accept this dts without

         // This is used by the bootloader to find the correct DTB
         qcom,msm-id = <239 0>;
         qcom,board-id = <0xEF08FF1 1>;

?

https://github.com/msm8916-mainline/lk2nd/blob/master/dts/msm8916/msm8939-samsung-r01.dts#L10

---
bod
