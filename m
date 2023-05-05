Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E416F7D30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjEEGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjEEGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:45:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141A83C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:45:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f4b911570so210811066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269114; x=1685861114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1F8TUb0vE+6tu+UVmJ0AzgABHlR7ADfS8FFXBxRieA=;
        b=UK0H7SvI8XLENMldv8m6kP0ZOtVPN6jLEgL+NVDGS4xY4pOviX0TlMDLPiOJzKkVpY
         r1E21fJSLXmSn+BKOrwceUdmwgXLLt94CorxzRHPjMCeYoLJ92xjGs0xVwK0fdJaVWJV
         3VAcSGNDwKeIf8PmNSpfTvUz/UPhAQn3T56MoAHX0a91TdnGvGaJmHyD9UZ+77/R77/l
         Cs8r3YMdJDF3e8OZl8mGWJZkuocp3AuKu9y2XE0WEiLl+OkSEoJLKDvcjfOuFSoNtllk
         IgdJH/gJnymbzdllN9wY8zQ3SxQaRrivemzhUIHRcX53mtDJekOJkoA5K0BvRULz3cQG
         9z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269114; x=1685861114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1F8TUb0vE+6tu+UVmJ0AzgABHlR7ADfS8FFXBxRieA=;
        b=J6KFU9Lpw0Cy40FdI5SI6vrJosTiBPIXqrzCcBsdbblrbcc/CpaFBchK9nt/PTNebx
         +Ca1kAg5Iy1zI0oFCnGflApyUOhTPFl56CggXNQUaFpdkYgc28IuVIC3M1Bx90LPTKn8
         HCj8ZstNyHv4U5fs/eqzzjXWIRic5LNZoZ+vzJe7tVoOja3o4Q1pHJu6RFxs64O56DBN
         EVJ2JBn+SU+Ra7f0bkQ57wn394zXbQDQAYItPUwlbMRdhX0B7bG9ZP5HlagrKygQSKxT
         FhHgnASaXBxJf5x1rStZzID4KzZVVQPXFGPhk8sr6V2KNnfBzkLaRXdxRctJKQoQRxVJ
         jlRw==
X-Gm-Message-State: AC+VfDzWbw6jdCnF9TnCEUGuAofg4wWjjuTNw0iUOuJt97mvbWkTIeBR
        8639CjHEoMjYVsh5X7inex/01A==
X-Google-Smtp-Source: ACHHUZ7e7CM816XOA8JH1lGUFzOlkUl5vywj1RnY1LL4ilUqUe6wTzu5vYAUKtEeQGlRPbffNQbYGQ==
X-Received: by 2002:a17:906:db03:b0:965:4b43:11f1 with SMTP id xj3-20020a170906db0300b009654b4311f1mr230527ejb.3.1683269114140;
        Thu, 04 May 2023 23:45:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id bj6-20020a170906b04600b0096595cc0810sm549923ejb.72.2023.05.04.23.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 23:45:13 -0700 (PDT)
Message-ID: <76a8662d-25ce-cd8c-7851-d163f4b3496b@linaro.org>
Date:   Fri, 5 May 2023 08:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505-fxtec-pro1x-support-v1-1-1d9473b4d6e4@riseup.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505-fxtec-pro1x-support-v1-1-1d9473b4d6e4@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 22:33, Dang Huynh wrote:
> The F(x)tec Pro1X is a mobile phone released by FX Technologies Ltd
> in 2022.
> 
> The phone is exactly the same as the Pro1 released in 2019 with some
> changes:
> - MSM8998 -> SM6115
> - Camera button is no longer multistate
> - Only one 48MP back camera
> - A new keyboard layout picked by the community.
> 

Thank you for your patch. There is something to discuss/improve.

> + * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm6115.dtsi"
> +#include "pm6125.dtsi"
> +
> +/ {
> +	model = "F(x)tec Pro1 (QX1050)";
> +	compatible = "fxtec,pro1x", "qcom,sm6115";

Missing bindings (first patch in the series).

> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <417 0x10000>, <444 0x10000>;
> +	qcom,board-id = <34 0>;
> +
> +	aliases {
> +	};

Drop empty node.

> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1080 * 2160 * 4)>;
> +			width = <1080>;
> +			height = <2160>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> +
> +&tlmm {

Override/label entries should be ordered by name. tlmm is after pm6125.

> +	gpio-reserved-ranges = <0 4>, <14 4>;
> +};
> +
> +&pm6125_gpios {
> +	vol_up_n: vol-up-n-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&dispcc {
> +	/* HACK: disable until a panel driver is ready to retain simplefb */
> +	status = "disabled";
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	pm6125-regulators {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).


Best regards,
Krzysztof

