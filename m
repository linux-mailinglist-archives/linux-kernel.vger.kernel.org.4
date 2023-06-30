Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8457B743FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjF3QdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjF3Qch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:32:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA24681
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:32:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so18329435e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688142722; x=1690734722;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr5aNPnmIj4+do1i4OEVQYr9sSaiIia2H95Z8vclIKA=;
        b=YC62Xiq2beFNyTzUM0KwQ+R1zMCJUdqw5sheNfpuNAPyNKBFzXdHaCJ6t9LXZ6pgPp
         5xaxuBmllaqmvLe58I1CZFns/5eNTLpkoXZvZClEB9FEGO1XSNw6UfL8rXd7mJED7sfm
         zgLyfzvN2zIGVDfoaxEIgc2EGz7vUKtpH8IWvoDI2FIjRsRj7dbuJZpOL1ZsExNGfGo5
         PQThDYAqzn5yrqNzsygXfEr6dGBO8MoyEjLGv067Wl63cbLiUMesoqEuS+IygqjAWRNR
         u6P8aG5BaPcVlqf7poPw0u4iNSzY9bSQSoPGFtuR7lr8gyH4VQQG7Od4WatXqeWliWZp
         JnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688142722; x=1690734722;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr5aNPnmIj4+do1i4OEVQYr9sSaiIia2H95Z8vclIKA=;
        b=fhWVSKI6CbxWD4hYqp7obQ9jXApC0qcO0xT1hTK43Rv+ZazDgHtgmfl0RX6aB1ArLq
         oXC5T3okjY/kkmlHPOm6Hlfrfj1Hqbokol8Nh8MdC/0cnVA2asQvywP5Vm1yk+bVHOdO
         x74Gr6np8klygcq39DiFDynj24P1h1i3C0S27HE1HpHnuY3uLYUNYTzFU2ms2I6oN2lK
         FrflvOocE0ZVGfkdBBfRN4gEObh/LBb38GuRA97CQyYxFc1RGeT6LX4axbdBTTxUJgTR
         SYZqVydID1MMWNVGWxWRkE2Ax7cuqJijDXQOPCrcBNafQIPabEmrFsPcAboHD7YzF5w6
         pVoQ==
X-Gm-Message-State: AC+VfDwDHX1l2Go7AE3jMSyjpHUq0qK+jEp63LrMn/F3uSPGvRAWPhsf
        WIxYUEcGztwZ/hRu7KQr5+pXZQ==
X-Google-Smtp-Source: ACHHUZ689KxjgFZkvbAXDIM4DEHGdQNln8Kd+r4DSZSr8D6WQDrLFgyFflb30XwOa8hCBVU70F4MoA==
X-Received: by 2002:a05:600c:1c98:b0:3f9:b867:4bb with SMTP id k24-20020a05600c1c9800b003f9b86704bbmr7947161wms.2.1688142722350;
        Fri, 30 Jun 2023 09:32:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2? ([2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc446000000b003fba137857esm10828160wmi.14.2023.06.30.09.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:32:01 -0700 (PDT)
Message-ID: <18716904-87fa-bd72-b53f-9e71565b72f7@linaro.org>
Date:   Fri, 30 Jun 2023 18:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] arm64: dts: meson: add reset controller for Meson-C3
 SoC
Content-Language: en-US
To:     zelong dong <zelong.dong@amlogic.com>, narmstrong@baylibre.com,
        p.zabel@pengutronix.de, khilman@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        martin.blumenstingl@googlemail.com
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230630121059.28748-1-zelong.dong@amlogic.com>
 <20230630121059.28748-4-zelong.dong@amlogic.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230630121059.28748-4-zelong.dong@amlogic.com>
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

On 30/06/2023 14:10, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add the reset controller device of Meson-C3 SoC family
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index 60ad4f3eef9d..62684b7a684c 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -6,6 +6,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/reset/amlogic,meson-c3-reset.h>
>   
>   / {
>   	cpus {
> @@ -82,6 +83,12 @@ uart_b: serial@7a000 {
>   				clock-names = "xtal", "pclk", "baud";
>   			};
>   
> +			reset: reset-controller@0x2000 {

Please drop 0x, the node name should be: reset-controller@2000

Thanks,
Neil

> +				compatible = "amlogic,meson-c3-reset";
> +				reg = <0x0 0x2000 0x0 0x98>;
> +				#reset-cells = <1>;
> +			};
> +
>   		};
>   	};
>   };

