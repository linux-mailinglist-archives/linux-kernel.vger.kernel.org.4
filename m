Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB417042AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEPBLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:11:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FE659CB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:11:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso15449875e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684199465; x=1686791465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKmG1QiKCqrXxBXEc9OganUA2qNFdNKRSrBQxLkvPfw=;
        b=CciJ8FalkHTd8ww4CuZKCRmQPCIXzNjv6zkaSoWMutqst1QdbpMfwCg7CwocPVzTp5
         r+sJugMPs928D6yJ4IZXA87KWwnl7D730gv8xZoRCvsOKwPzUhyosr1RE73nNN88n1Ve
         p4+FmDfAUPbkH0+gtK4Lfk0ZQ0E95pVvl51dQL9NzxVooTcaSH7wI1CYQp/LMv6FXQF2
         I0vLi5tkaqo5nS35VflOFFjw/9tka79iw+mkHJ4+LAopSeubYoeKmnkXF8lPyGsmv+Rd
         kEfeOnpKGp4xne+7YjjzIkfljRalkE+3JM6uGGyLjCdeOwwmAK0ZVpHYmg8MeHQL89ZZ
         c7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684199465; x=1686791465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKmG1QiKCqrXxBXEc9OganUA2qNFdNKRSrBQxLkvPfw=;
        b=MOtKl1SOJPKjAzMNMr8HyrUPY50EznHBsegBOm4BhzxuILYnOqMCIXD56NItMNm/nD
         waB7b5K4b5yPYdyBHQR0Z6vjW6hzUJ7YoB5WQubJw2a45IhxWsyHxkGo/sdFqDZgcSjD
         8be5XQpwDafq0cNdXHuzXNWKfaqHDsonEVVGqIn1MxsSi4yJOlpkhL9KRjg3FFdydt93
         Hg6kTbadaz393oUXnv06U4y0gfj2RitBP9U1oG39fZBZGlcR07NC4XBmN/w0HSSWuqwm
         vMvYDXeOf8lRiGA0YWVLKgCLsADzqPzqwRNyCv7RWcYAhdFbr0hlALDrJn/0SyUj2Ozo
         B/EQ==
X-Gm-Message-State: AC+VfDwILVPrkNvwMQdvmkyIafwO9fgdljgKaZwtBGJzwy3J9sXuv/o3
        UoKGwfmHR92eS/JJTZVYds3cJhXm0d7aFl/mCSU=
X-Google-Smtp-Source: ACHHUZ5QIJuTN1N6dvCLxwnOKW3RQkxO7D5pFgbIQmT3N3dSvLgqjefQQByQ41smL5HB6Y4EDgXTIg==
X-Received: by 2002:a05:6512:78:b0:4f1:4862:9369 with SMTP id i24-20020a056512007800b004f148629369mr5942579lfo.4.1684199465075;
        Mon, 15 May 2023 18:11:05 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id d10-20020ac241ca000000b004f24e797c55sm2788336lfi.25.2023.05.15.18.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:11:04 -0700 (PDT)
Message-ID: <2991a4fe-2103-aa99-7750-6e017c51ab15@linaro.org>
Date:   Tue, 16 May 2023 03:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-longcheer-l8910: Add front
 flash LED
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
References: <20230514-x5_front_flash-v1-1-3979c8498efa@apitzsch.eu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230514-x5_front_flash-v1-1-3979c8498efa@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.05.2023 21:58, André Apitzsch wrote:
> l8910 uses OCP8110 flash LED driver. Add it to the device tree.
> 
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> index b79e80913af9..81cebac117f1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> @@ -20,6 +20,21 @@ chosen {
>  		stdout-path = "serial0";
>  	};
>  
> +	flash-led-controller {
> +		compatible = "ocs,ocp8110";
> +		enable-gpios = <&msmgpio 49 GPIO_ACTIVE_HIGH>;
> +		flash-gpios = <&msmgpio 119 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&camera_front_flash_default>;
property-n
property-names

please!
> +
> +		flash_led: led {
> +			function = LED_FUNCTION_FLASH;
> +			color = <LED_COLOR_ID_WHITE>;
> +			flash-max-timeout-us = <250000>;
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> @@ -246,6 +261,14 @@ button_backlight_default: button-backlight-default-state {
>  		bias-disable;
>  	};
>  
> +	camera_front_flash_default: camera-front-flash-default-state {
> +		pins = "gpio49", "gpio119";
> +		function = "gpio";
> +
Unnecessary newline

LGTM otherwise!

Konrad
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> 
> ---
> base-commit: 533c54547153d46c0bf99ac0e396bed71f760c03
> change-id: 20230514-x5_front_flash-c189e22b32fd
> 
> Best regards,
