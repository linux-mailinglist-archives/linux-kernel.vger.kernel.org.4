Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39F7618B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKCWUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiKCWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:20:49 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D77220D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:20:42 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w4so2183186qts.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLQxMqZeSjx3t7d42CWl5RcAbFY//1FJaI4cAmerqIM=;
        b=Y5gxiSNoc0mcvBtK7drkUAI9qNJu8OFLvo7mVi2WzZfGnfvhED0EqpqNAOcccvCY1m
         JENlL6Q3HqYbgyk4QmHDfzGe1jeXmBQ23NWZBxWgyxNVZxfGbyR2dNMybBBaviwKo6lP
         VGl/CaMn6HlzQNvKUJciwHthNg0V/f3bUhy6OrkZxNQn5o6pu1uDBpxH6jyXKr1AKgVa
         oEHqALA+YY5NcJBSFSpTKWjYLAskJOSP2WXL7JYBlDXGWqb2yfL6AtgylOSVmJjFHeU/
         MtKaGx2C2VMEkytnLPuXLZFsnGN1wzOonBU+n0/NEhW4QarjWnF6MQXNdf5OeJpnH97B
         0Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLQxMqZeSjx3t7d42CWl5RcAbFY//1FJaI4cAmerqIM=;
        b=mthyWC8D03E1XoL90uyd/C41Zaf5/3PX0n/noVUe7tKU0qCEW4CFbvE7ROPmooMwDY
         Sh2rYloJteSPAOsmUYqpfL8Il8bPHop7fBCfz5bDDanOzft9mjLpwFLnv0sY0UjGQCE1
         yrKHE1Fz4Y/gAD8mENuc7ZNEiXpIv9JWXsBzH2ZE14eda8DqhfeHhMej/3ezYJqWY6Uw
         02dY+8eHq/Je4Bj7D0Lh/9COy16oC7ZV2cUp7MyDupXdRzbfPT2SwA/b9ZOr4uVzNDa+
         Ci+eKICP0PNGYeg7I7OeSYi1/529r+zoMIYy8Uy/wizU8gVCAZzwcAMMwTTI9kBoaGRl
         6wSw==
X-Gm-Message-State: ACrzQf2rYXb1UKiTRNUQ21gIfVLiZ8HqfpD8hwL9jXKNl/3VbCl1D5Vf
        b3veIx9RAsH5L5rFOexqe+qltA==
X-Google-Smtp-Source: AMsMyM4kjXr8XPqH1mcvbytz7yHrxD33ODexAHSYNycgk1HoKAatWrQRdoUJ8cJnr+OczKAfBF3Bsg==
X-Received: by 2002:a05:622a:1d0:b0:39c:fc19:b580 with SMTP id t16-20020a05622a01d000b0039cfc19b580mr27435489qtw.238.1667514041955;
        Thu, 03 Nov 2022 15:20:41 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id p20-20020a05620a15f400b006b953a7929csm1529020qkm.73.2022.11.03.15.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 15:20:41 -0700 (PDT)
Message-ID: <780253cd-960f-ee29-247f-22b9c899c035@linaro.org>
Date:   Thu, 3 Nov 2022 18:20:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 1/2] arm64: dts: qcom: msm8916-alcatel-idol347: add
 GPIO torch LED
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221029145557.106920-1-vincent.knecht@mailoo.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221029145557.106920-1-vincent.knecht@mailoo.org>
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

On 29/10/2022 10:55, Vincent Knecht wrote:
> Add support for torch LED on GPIO 32.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index 3dc9619fde6e..3a0a593899ae 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -5,6 +5,7 @@
>  #include "msm8916-pm8916.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	model = "Alcatel OneTouch Idol 3 (4.7)";
> @@ -34,6 +35,19 @@ button-volume-up {
>  		};
>  	};
>  
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_leds_default>;
> +
> +		led-0 {
> +			gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "torch";
> +			function = LED_FUNCTION_TORCH;
> +		};
> +	};
> +
>  	usb_id: usb-id {
>  		compatible = "linux,extcon-usb-gpio";
>  		id-gpio = <&msmgpio 69 GPIO_ACTIVE_HIGH>;
> @@ -276,6 +290,14 @@ gpio_keys_default: gpio-keys-default {
>  		bias-pull-up;
>  	};
>  
> +	gpio_leds_default: gpio-leds-default {

Node name: gpio-leds-default-state

Best regards,
Krzysztof

