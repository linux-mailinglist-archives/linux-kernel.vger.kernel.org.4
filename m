Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0296FC0A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjEIHol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEIHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:44:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1956F83D2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:44:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f315712406so196373585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683618275; x=1686210275;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/tIWIjCU0WB4+s+0CLXZp3rE/hrVxQbRrR7hGm/i1t8=;
        b=FS045pxekPIy3zvybkfVPHe6eMBCAkuvJgWnUdb31Avcc4yyadf8jCoDTyTn3dQp7X
         nJeSCyxtCn23b8AEbg8AUd9eRaIq/xYZcwQAk2hEWCjBTHvAeajabpDyQNklwEMZ58DU
         Kz4J2Htyn4dGPyzXyy70is1VHwsrsSzx8ia/px/eMY4UWpcUu9piuWERmxYqNasXIL08
         N85eWBxxiQxVr0JUNGHr2szdrhhx7g8JzYJjvO4oMM9gngmxNqPElviZpictdF6A+3EF
         4wMQzw2SyPMwAPsmI78QFBgadv2JzPwaFe0uk/mPPCK7LBGv3biIhaXQmUyVRtPRVu2Y
         96eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683618275; x=1686210275;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tIWIjCU0WB4+s+0CLXZp3rE/hrVxQbRrR7hGm/i1t8=;
        b=FW81GUoUsI0AKbJS2CNTBW+6Wf+GAG5nx0DUe2mO8GaGNxcNFwcH4sL9DqL3+h6RIn
         zmLonUYpv9/cfXrd1pIBft7okIhuLIFYFVvfm/H845EUHNyE9oMoP97c+p7qRz3BiOhf
         9C9gBrSaQ1ADpVnI01VEIwDRfZ55tCWpcgUNyWyf//B8SurET/tPY8b6rVtkh/Gyni6F
         KUiwC4I4CCYsH14tkeN0L2/bJ0HFqgLiMls0rdIc28dklaX56uHWmQKsrzchkXobrZAL
         qqI6xs4zWU7Hl2xfY2QSofmLKOwdjTmbqzuE3MyhRzdB8ULntwq+zBq0CwUZVERfSKjG
         HG3g==
X-Gm-Message-State: AC+VfDwQ3lJpTqD2iB4kiqncc+LbsjgZyMBz0NNa8UiqnLN5p7onozmI
        GTUp6I7RgkpBHjTPMU/qvijPzg==
X-Google-Smtp-Source: ACHHUZ5azk0AtvIKQkzwUK42XJg0J/YOW/KQyQjpBHJ5Rilppz/v+9dWNUtHMmojYs5nx4Y5u/mbwQ==
X-Received: by 2002:adf:e483:0:b0:2ff:801b:dec6 with SMTP id i3-20020adfe483000000b002ff801bdec6mr8605708wrm.20.1683618275426;
        Tue, 09 May 2023 00:44:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79ab:8da0:d16d:9990? ([2a01:e0a:982:cbb0:79ab:8da0:d16d:9990])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d4e8f000000b0030629536e64sm13492065wru.30.2023.05.09.00.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 00:44:35 -0700 (PDT)
Message-ID: <acc5eb75-c6ed-98c7-6d69-f8b0f024c744@linaro.org>
Date:   Tue, 9 May 2023 09:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/5] arm64: dts: meson: a1: support USB controller in
 OTG mode
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com
Cc:     yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
References: <20230426102922.19705-1-ddrokosov@sberdevices.ru>
 <20230426102922.19705-6-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230426102922.19705-6-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/04/2023 12:29, Dmitry Rokosov wrote:
> Amlogic A1 SoC family has USB2.0 controller based on dwc2 and dwc3
> heads. It supports otg/host/peripheral modes.
> 
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 59 +++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index ae7d39cff07a..5588ee602161 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -8,6 +8,8 @@
>   #include <dt-bindings/gpio/meson-a1-gpio.h>
>   #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
>   #include <dt-bindings/clock/amlogic,a1-clkc.h>
> +#include <dt-bindings/power/meson-a1-power.h>
> +#include <dt-bindings/reset/amlogic,meson-a1-reset.h>
>   
>   / {
>   	compatible = "amlogic,a1";
> @@ -169,6 +171,17 @@ gpio_intc: interrupt-controller@0440 {
>   				amlogic,channel-interrupts =
>   					<49 50 51 52 53 54 55 56>;
>   			};
> +
> +			usb2_phy1: phy@4000 {
> +				compatible = "amlogic,a1-usb2-phy";
> +				clocks = <&clkc CLKID_USB_PHY_IN>;
> +				clock-names = "xtal";
> +				reg = <0x0 0x4000 0x0 0x60>;
> +				resets = <&reset RESET_USBPHY>;
> +				reset-names = "phy";
> +				#phy-cells = <0>;
> +				power-domains = <&pwrc PWRC_USB_ID>;
> +			};
>   		};
>   
>   		gic: interrupt-controller@ff901000 {
> @@ -192,6 +205,52 @@ spifc: spi@fd000400 {
>   			#size-cells = <0>;
>   			status = "disabled";
>   		};
> +
> +		usb: usb@fe004400 {
> +			status = "disabled";
> +			compatible = "amlogic,meson-a1-usb-ctrl";
> +			reg = <0x0 0xfe004400 0x0 0xa0>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&clkc CLKID_USB_CTRL>,
> +				 <&clkc CLKID_USB_BUS>,
> +				 <&clkc CLKID_USB_CTRL_IN>;
> +			clock-names = "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
> +			resets = <&reset RESET_USBCTRL>;
> +			reset-name = "usb_ctrl";
> +
> +			dr_mode = "otg";
> +
> +			phys = <&usb2_phy1>;
> +			phy-names = "usb2-phy1";
> +
> +			dwc2: usb@ff500000 {
> +				compatible = "amlogic,meson-a1-usb", "snps,dwc2";
> +				reg = <0x0 0xff500000 0x0 0x40000>;
> +				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +				phys = <&usb2_phy1>;
> +				phy-names = "usb2-phy";
> +				clocks = <&clkc CLKID_USB_PHY>;
> +				clock-names = "otg";
> +				dr_mode = "peripheral";
> +				g-rx-fifo-size = <192>;
> +				g-np-tx-fifo-size = <128>;
> +				g-tx-fifo-size = <128 128 16 16 16>;
> +			};
> +
> +			dwc3: usb@ff400000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0xff400000 0x0 0x100000>;
> +				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				dr_mode = "host";
> +				snps,dis_u2_susphy_quirk;
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,parkmode-disable-ss-quirk;
> +			};
> +		};
>   	};
>   
>   	timer {

This patcj is fine, but depends on clock bindings & dt, so now Vinod took the PHY
patch, please resend this wiyhout patches 1 & 5, then resend the DT patch later when
the clock bindings is merged.

Thanks,
Neil
