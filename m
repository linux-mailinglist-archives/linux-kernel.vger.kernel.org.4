Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9F6B06CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCHMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCHMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:19:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB9C9CBC5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:19:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1147083wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678277993;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M0PT41N9/9aKEVWUCfnXqycSPIwscUdDNY/YmWQMOBc=;
        b=k4wPvfxf2rr+T0Dkk71MslV3OsYWjfXdYEyEikFNcloMvkxqleaMMX4PS1+8Jr17nx
         tjh3yjudHmxX5Lo4xVahN7eqitEFaADkyAFH/6v8k1f35HFlHeCjdxYpOZG/n4A+BR//
         F1UEKnuVtRQZ/j0ef38bQPqHZh6BtZX9ui/C5wB914i2/8yrmKl6J/P89j4644c9feZ+
         DE+HQkYpluF+tT2yQqAkFO6U8GNjtJn7gbqn21Gwat0zH8lZeJqBHP/fcMaWpjJ04qzH
         9IRRU6QMYfbX8NrthMk9iTS1DpFLQy8ug1deFEWXhD2KT665WxGDiLDG0wB3QMDkWGkF
         BGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678277993;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0PT41N9/9aKEVWUCfnXqycSPIwscUdDNY/YmWQMOBc=;
        b=iBXq+eQiJp1vCsG63vDIXUZMbaaaKh6ndZtdVchmecvTG/W2pMBNV1x7wS4rG/rLnk
         Ge1elI09q98JV0ZVmtIHWi5Xc0s6pCRIyEFOj/pffa/isgN51NJVFFv6nRYGulyQ4Pej
         ceXpsRgRqvKioTX8RJoWpgLkzWTH2EEFRp/Kfq2hOvLLRoiBAbbzYptgCGUa2WsdmXAm
         YJW1ExiARjnqowwPL7LduGSGnW1UdiEojbVAADK9+93lTHWrF8efnM6XEg6s4YgF6dxl
         xldZSY7SbRAlzvcwKtJc/FEgIeQrOmF2XFFlPLygLBZ6iTsNjyRevFUN0hXxZVHo+cf8
         SlnQ==
X-Gm-Message-State: AO0yUKUqYXAYk534usYW32Cu84gw36vIwgFbZzMq1PZWQyEidPjbXu5p
        9pEh3EfJ2mIrYBDCEh4N/fNDOw==
X-Google-Smtp-Source: AK7set/1ESdVmy/r7adhh0sf1VIdxSRaRJPt2FLSS8Mj6zEHB7dr0uJsp1xqOpWMYbJJuMVcjqBPyg==
X-Received: by 2002:a05:600c:3504:b0:3ea:e677:5017 with SMTP id h4-20020a05600c350400b003eae6775017mr16080220wmq.8.1678277992817;
        Wed, 08 Mar 2023 04:19:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b029:83b9:1fb8:7c34? ([2a01:e0a:982:cbb0:b029:83b9:1fb8:7c34])
        by smtp.gmail.com with ESMTPSA id j17-20020adff011000000b002c5a1bd527dsm14995123wro.96.2023.03.08.04.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:19:52 -0800 (PST)
Message-ID: <6af5bb93-650e-5ea3-ac14-4e37baf4a902@linaro.org>
Date:   Wed, 8 Mar 2023 13:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/3] arm64: dts: meson-g12-common: Use the G12A UART
 compatible string
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>
References: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
 <20230307222651.2106615-4-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230307222651.2106615-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 23:26, Martin Blumenstingl wrote:
> Switch meson-12-common.dtsi to use the Meson G12A specific UART
> compatible string. This enables the "divide XTAL by 2" divider which
> improves support for UART attached Bluetooth modules (for example
> RTL8822CS) running at a baud rate of 1500000. Without dividing XTAL
> (24MHz) by 2 a baud rate of 1500000 cannot be generated cleanly and the
> resulting jitter breaks communication with the module.
> 
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Greg, please don't take this through your tree. I included this patch
> to show the overall goal of this series. If Neil won't take this as
> part of another series then I'll send it separately.
> 
> Changes from v1 -> v2:
> - keep meson-gx-uart as fallback compatible string
> 
> Changes from v2 -> v3:
> - none
> 
> 
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 123a56f7f818..904bcd4d2acf 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -2046,7 +2046,8 @@ pwm_AO_cd: pwm@2000 {
>   			};
>   
>   			uart_AO: serial@3000 {
> -				compatible = "amlogic,meson-gx-uart",
> +				compatible = "amlogic,meson-g12a-uart",
> +					     "amlogic,meson-gx-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x3000 0x0 0x18>;
>   				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
> @@ -2056,7 +2057,8 @@ uart_AO: serial@3000 {
>   			};
>   
>   			uart_AO_B: serial@4000 {
> -				compatible = "amlogic,meson-gx-uart",
> +				compatible = "amlogic,meson-g12a-uart",
> +					     "amlogic,meson-gx-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x4000 0x0 0x18>;
>   				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
> @@ -2293,7 +2295,8 @@ clk_msr: clock-measure@18000 {
>   			};
>   
>   			uart_C: serial@22000 {
> -				compatible = "amlogic,meson-gx-uart";
> +				compatible = "amlogic,meson-g12a-uart",
> +					     "amlogic,meson-gx-uart";
>   				reg = <0x0 0x22000 0x0 0x18>;
>   				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
>   				clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
> @@ -2302,7 +2305,8 @@ uart_C: serial@22000 {
>   			};
>   
>   			uart_B: serial@23000 {
> -				compatible = "amlogic,meson-gx-uart";
> +				compatible = "amlogic,meson-g12a-uart",
> +					     "amlogic,meson-gx-uart";
>   				reg = <0x0 0x23000 0x0 0x18>;
>   				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
>   				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
> @@ -2311,7 +2315,8 @@ uart_B: serial@23000 {
>   			};
>   
>   			uart_A: serial@24000 {
> -				compatible = "amlogic,meson-gx-uart";
> +				compatible = "amlogic,meson-g12a-uart",
> +					     "amlogic,meson-gx-uart";
>   				reg = <0x0 0x24000 0x0 0x18>;
>   				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
>   				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
