Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31762BB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiKPLVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiKPLVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:21:20 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF2C40450
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:09:15 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n21so2458962ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q56U9tO+bEviYqgOpEu8IESBaXGjd6XtmCO3RbZByhw=;
        b=djFXN70bt59I60cgRaSA5NvbLVxYeEIER7jqVtipWv778Fop/JoWgZF5bOJ1QnjkYO
         8neGIu78wWwpl50/b7y2p+yyoaf/9Ab1ae3gB1Idgftyh6/1XsJhW78ZEpOf9b5KH59e
         2/XlQr7+/t6Mw5pi3g/2Ma7bRxDLG//ARYnZdIXmUUSwWU5ZKyzVutDwAn4rwfiArZkX
         dDUoM2akhcnYETQfGTXDLXysZFaSMs/QGrnlgQ8VAVeZuBphL0tziYKXHzB4rw3vlvZC
         ozoJmkxFEfA3WDNDaUMeHGpJ1FgGCkK9ucteDy4kPnq7zyPoqzm0foNWZtCqcGJXxKXs
         oD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q56U9tO+bEviYqgOpEu8IESBaXGjd6XtmCO3RbZByhw=;
        b=o5o+Hj6hQeLpwXlnJP9rEcLShIqnUPMjmauWEsYVynIiTto4J2cbGpqy880kSlAqs0
         cG4DHCvK+v7vRx9WwYsZWku3oR143hUrsrfYNSFlw5tT/K6n9fOL5IEegb6effmji403
         6uYGdhotjCS94skCeFFImO+cBE2faWqW4ukVwhSeWFcqjwymqDyDCPuXuzl9sd4BnoVF
         X/iBLi0KTDQxbDXXbRH/JjP4qquWwUGTO84MnbeYoy8bfK8UJipUAxsiOTTSLES6VrvB
         TBhP0Y9NRfJlsOqJWguX5vzV9vIJD5Jvfch6PQf63HFwXeuNTzSxHpo4JfEmuYNgTe4Y
         Dtzg==
X-Gm-Message-State: ANoB5pkBXkMLSOIP62g+57Mq1EHp909ZgyRYI+go9qVERrGHLX9TwSxS
        fkHhjosVrTYxt1kgxSA9kJBTkg==
X-Google-Smtp-Source: AA0mqf6fcwHzgOUNhm4JAYtCgCMJSV/ojZPf78wcs4L7DgOLE5ZNr+YeKVo4XPoNG6Y8vY8EWK08VA==
X-Received: by 2002:a17:907:77c4:b0:78d:2af:a818 with SMTP id kz4-20020a17090777c400b0078d02afa818mr16848616ejc.675.1668596954427;
        Wed, 16 Nov 2022 03:09:14 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id de30-20020a1709069bde00b0073d796a1043sm6673058ejc.123.2022.11.16.03.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:09:14 -0800 (PST)
Message-ID: <4e186edd-03d4-fd88-0987-b75cc94f96bb@linaro.org>
Date:   Wed, 16 Nov 2022 12:09:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 08/10] arm64: dts: qcom: Add PMK8550 pmic dtsi
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
 <20221116103146.2556846-9-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116103146.2556846-9-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> Add nodes for PMK8550 in separate dtsi file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> --- >   arch/arm64/boot/dts/qcom/pmk8550.dtsi | 54 +++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/pmk8550.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
> new file mode 100644
> index 000000000000..1f707202f5da
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmk8550: pmic@0 {
> +		compatible = "qcom,pm8550", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmk8550_pon: pon@1300 {
> +			compatible = "qcom,pm8998-pon";
Don't you need to specify the PBS register too for this PMIC?

Other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

> +			reg = <0x1300>;
> +
> +			pon_pwrkey: pwrkey {
> +				compatible = "qcom,pmk8350-pwrkey";
> +				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_POWER>;
> +				status = "disabled";
> +			};
> +
> +			pon_resin: resin {
> +				compatible = "qcom,pmk8350-resin";
> +				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		pmk8550_rtc: rtc@6100 {
> +			compatible = "qcom,pmk8350-rtc";
> +			reg = <0x6100>, <0x6200>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		pmk8550_gpios: gpio@8800 {
> +			compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
> +			reg = <0xb800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmk8550_gpios 0 0 6>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
