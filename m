Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593006219BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiKHQsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKHQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:48:51 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665B57B50
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:48:49 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id d3so21998847ljl.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1d8zM1Nk8TzoHcMhFh9hgmVPfiaP9d7SJOKHf4Sgw5U=;
        b=rQoPq/x5bDn6fzMrraOcEQR1STfeX+apF14pw1s4D7AeGlvFVI83vUXl0E5M4Dus1c
         VfTucuyBDcf8qVwOLKDgn8+7qV0pALj82vVRtppnjHXFCbILRuMKkmW4kIb25y/xrv/w
         HKagzTp/+eww6/F1zoJ5XKtIUDtWzzJ6TflIsRCb7EczjpLvWb9IBgTC6mu7qH6jUEwm
         X+PmxAUqWJLIy90RltXmvj1B0AnPNUkpIeGQwjM/FQRsGAtYcmmXMJzRl5HLdglQVLXb
         VDCkUfOz6KymP5e5p75PenWJMmdx0izaA0aN8tEOmNY8kvwEK89MthI1sbj/YaLub3gU
         LcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1d8zM1Nk8TzoHcMhFh9hgmVPfiaP9d7SJOKHf4Sgw5U=;
        b=2uN3oKiVyjsT5Z7KyOkEbvRa9GxjWKrZa4N/a8PVxcw+H96Zq6HpM03f6tYOSRSNX0
         JMnCqSrgE3h8Rfp4DQQ7P7qHr1OtJigZMngQ94U8+feHUlmchDEuJeyYVyf3Zl2OPqiS
         CdTHlI1wSNmhG9LhNwRWbbJbNXzfHYkznOovPY/plSJOSa4kUpURJ+qlSTgPU0grAzCJ
         JZXREupZ0OsKeL3C490DMj5+TAMYEmFa6fcWjcwwsvV6DSZPrEYH5yqZ/z7HS7OM3GFI
         tyiSron1AXDGIK059Zfptvf3rPPKnx+CHv0pl243fR3a2JkTzgAfi8kNT3qlcFixBsKJ
         KIqg==
X-Gm-Message-State: ACrzQf0BCGJtte6XRlpBNXGowZOi0Lf4HIvLJ8qpgeeMRDKpYfw979qF
        x99wBk6IMnvKRzzykgu/BjN1sA==
X-Google-Smtp-Source: AMsMyM5u/9SiHwFpF+uzGkWvQeS7YbWX5nP97SYIoeUaZGEPGJjeK8HJb6U4PCKJiuYxE+HDWNCIPA==
X-Received: by 2002:a2e:b94a:0:b0:277:91a:737 with SMTP id 10-20020a2eb94a000000b00277091a0737mr18538157ljs.25.1667926127850;
        Tue, 08 Nov 2022 08:48:47 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id cf29-20020a056512281d00b0049496855494sm1854737lfb.104.2022.11.08.08.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:48:47 -0800 (PST)
Message-ID: <6de8a161-b5fb-3360-fb01-636b47750ca0@linaro.org>
Date:   Tue, 8 Nov 2022 17:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq8074: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221108142357.67202-1-krzysztof.kozlowski@linaro.org>
 <20221108142357.67202-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221108142357.67202-2-krzysztof.kozlowski@linaro.org>
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



On 08/11/2022 15:23, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index d3d9e7eb5837..363ccc272cf1 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -317,35 +317,35 @@ tlmm: pinctrl@1000000 {
>   			interrupt-controller;
>   			#interrupt-cells = <0x2>;
>   
> -			serial_4_pins: serial4-pinmux {
> +			serial_4_pins: serial4-state {
>   				pins = "gpio23", "gpio24";
>   				function = "blsp4_uart1";
>   				drive-strength = <8>;
>   				bias-disable;
>   			};
>   
> -			i2c_0_pins: i2c-0-pinmux {
> +			i2c_0_pins: i2c-0-state {
>   				pins = "gpio42", "gpio43";
>   				function = "blsp1_i2c";
>   				drive-strength = <8>;
>   				bias-disable;
>   			};
>   
> -			spi_0_pins: spi-0-pins {
> +			spi_0_pins: spi-0-state {
>   				pins = "gpio38", "gpio39", "gpio40", "gpio41";
>   				function = "blsp0_spi";
>   				drive-strength = <8>;
>   				bias-disable;
>   			};
>   
> -			hsuart_pins: hsuart-pins {
> +			hsuart_pins: hsuart-state {
>   				pins = "gpio46", "gpio47", "gpio48", "gpio49";
>   				function = "blsp2_uart";
>   				drive-strength = <8>;
>   				bias-disable;
>   			};
>   
> -			qpic_pins: qpic-pins {
> +			qpic_pins: qpic-state {
>   				pins = "gpio1", "gpio3", "gpio4",
>   				       "gpio5", "gpio6", "gpio7",
>   				       "gpio8", "gpio10", "gpio11",
