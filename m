Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D36D586B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjDDGGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjDDGGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:06:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B01FEF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:06:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so126078174edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680588394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEKSJHqtUY3iTrghpmkFQRQ+nNVQQ5R95rmcE96rgEA=;
        b=ZR0ADA7rJ0HKv6m1qCdnai7+qXGTAD+oYXE8DEFJwq0yUNu3fOnNrCxmG5WA2dcL7P
         oWT2OcAdLjG4Kf+427tNKA+Gh46EHuLXmNGR9GX6h1HeALfsaJE1JiBvXwHVlMJASIiD
         qY7sO473GIJQnbZLR03yjMwahA3E6BwqLaCyBvkVYAyf1bOvxI1Bw0t/d/3Y6kWcMPZ8
         nlbyyPhYQ1PY8N4BuIp4QhTD9JDlnDEPlt24f83buQ14+kAcr1XAIfqwOOl0BNfYTlpA
         yMUSOb6MZ01r4kYLSVeDb4qquWyA2kA60nVzPXCkxDqREOvjJE2Y5+fsWAz44efie/lU
         X+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680588394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEKSJHqtUY3iTrghpmkFQRQ+nNVQQ5R95rmcE96rgEA=;
        b=Ozz1AeDci5rv8WIcApsozbBn9wFbfrWOSFjJrCB7GmzAyrDJMC+v+Lax72TXNXQKdm
         4BcoKEhDuc5Vig/hnuuxMvvNC49nvBNT8A6S8AVT2eKqMSIcS7Bu+kJTzrZpFqYpfA3G
         GbvQ0xyho1vPoi2GqoTAeLYCK5h//rWQrZqJYnIFw/5UQnABimj2BMgH7kOqZCv5VBkJ
         7Y0n3slXf89n3iwNynvCrd7awrDqEiJkE/+in6JVreZS2G7BOdCkDjk4iD/ByofTFj7K
         fvPEmubvtancQgRxEx9bBu0+Eez4Kni3hNif1+rQUPc3RFoyGaNXmEkUMABvj0Twa4Zm
         S/Rw==
X-Gm-Message-State: AAQBX9eFW0rNiVqJ6Bk+DFeLTf1/KrDiPCOQaO3ohsTGnYQdBhYUtwtp
        LEdKo8ps0K2u3LqofwthjD2FkQ==
X-Google-Smtp-Source: AKy350bE05C+aEd2NTBCMVnCtFXvWeQkCm5DZfV4X/6CexXFfWKuI5BcupDvAZp0GFRtqhh5MY2dNQ==
X-Received: by 2002:a17:906:3448:b0:92d:44ca:1137 with SMTP id d8-20020a170906344800b0092d44ca1137mr1443971ejb.43.1680588394650;
        Mon, 03 Apr 2023 23:06:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008f767c69421sm5482106ejc.44.2023.04.03.23.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 23:06:34 -0700 (PDT)
Message-ID: <e1c2605c-6976-4d3e-25c8-e71145eea518@linaro.org>
Date:   Tue, 4 Apr 2023 08:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/9] arm64: dts: qcom: Add initial QCM2290, PM2250 & RB1
 device trees
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
 <20230403-topic-rb1_qcm-v1-3-ca849b62ba07@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403-topic-rb1_qcm-v1-3-ca849b62ba07@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 19:36, Konrad Dybcio wrote:
> Add initial device trees for the QCM2290 SoC, QC Robotics RB1 board, as
> well as the bundled PM2250 PMIC.
> 
> On the SoC part, CA53 compatibles were used, as Qualcomm claims that's
> what has been implemented, despite the cores reporting a Qualcomm Kryo
> MIDR_EL1[PART_NUM].
> 
> To get a successful boot on RB1, run:
> 
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb >\
> .Image.gz-dtb
> 
> mkbootimg \
>         --kernel .Image.gz-dtb \
>         --ramdisk some_initrd \
>         --output rb1-boot.img \
>         --pagesize 4096 \
>         --base 0x8000 \
>         --cmdline 'some cmdline'
> 
> fastboot boot rb1-boot.img
> 
> There's no dtbo or other craziness to worry about.
> For the best dev experience, you can erase boot and use fastboot boot
> everytime, so that the bootloader doesn't mess with you.
> 
> If you have a SoM revision 3 or older (there should be a sticker on it
> with text like -r00, where r is the revision), you will need to apply
> this additional diff:
> 
>         aliases {
> -               serial0 = &uart0;
> +               serial0 = &uart4;
> 
> /* UART connected to the Micro-USB port via a FTDI chip */
> -&uart0 {
> +&uart4 {
> 
> That should however only concern preproduction boards.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/pm2250.dtsi     |  63 +++
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi    | 848 +++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 107 ++++
>  4 files changed, 1019 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1a29403400b7..6fc8d6664f0c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -70,6 +70,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/pm2250.dtsi b/arch/arm64/boot/dts/qcom/pm2250.dtsi
> new file mode 100644
> index 000000000000..c5344d6e47c4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm2250.dtsi
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

Odd license. Unless you based it on 2.0+, please use standard dual-license.

> +/*
> + * Copyright (c) 2023, Linaro Ltd
> + */
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmic@0 {
> +		compatible = "qcom,pm2250", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pon@800 {
> +			compatible = "qcom,pm8916-pon";
> +			reg = <0x800>;
> +
> +			pm2250_pwrkey: pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts-extended = <&spmi_bus 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_POWER>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +			};
> +
> +			pm2250_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts-extended = <&spmi_bus 0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				status = "disabled";
> +			};
> +		};
> +
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts-extended = <&spmi_bus 0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pm2250_gpios: gpio@c000 {
> +			compatible = "qcom,pm2250-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pm2250_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmic@1 {
> +		compatible = "qcom,pm2250", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> \ No newline at end of file

Patch error to fix.

> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> new file mode 100644
> index 000000000000..27d4742cdb19
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -0,0 +1,848 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

Same concern. Also in DTS.

Best regards,
Krzysztof

