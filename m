Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558C6E5FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDRL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDRL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:29:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0954146B8;
        Tue, 18 Apr 2023 04:29:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c9so33429162ejz.1;
        Tue, 18 Apr 2023 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681817393; x=1684409393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUjxC0HW0q5I55Ax2kRGx20p8+lDHCxMQJGu0kJowSw=;
        b=U0iCP8nOAVApaPEkGMtGpgndS6lVxObOT5lefbgS6i07iCjKPsAtfi0yrtsLTFav7C
         dsYcDXIDHBHjLSwxkRnVns9jMC5mSyElI7ZZu8JIHF/v+r8F75GjSb/+BrBZC+ogAwgT
         +jNu5mJgctRSYIY3mL0mxn8TGFh6qQ9Tm8hnXSGaYyUpD2epJt+wqrqM2j7fFbnwe/dm
         PUkk3qgKtanqohQqh5BevHHP1jbw952C5P8+sTQruVtoSbQhITjeivDEXVs2fnYA+FZX
         6PUuJQfNVssCi+Nb99qx+S4Gt95d9RG5gp/MZNRRuzQLjZFAWMerIZfHXA4P1Fe3Higa
         a17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681817393; x=1684409393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUjxC0HW0q5I55Ax2kRGx20p8+lDHCxMQJGu0kJowSw=;
        b=FwppERspLD+BdyoDkyY86lkUCSejiqxGNxTomA6qmZNTpvECXJoLvcjRElX8qe8/Iu
         rc6u2bojaOIj8OSieLj7YuRcSHUIYqn31O9kK4LYqppr72uaefRx6ChzlunATZM/8IJ9
         h/Anex1ak+kn8vNNEpHrcgsWWOcE1xY3s9Tt1U6Sks4fHqrBE5710Pq2ftN86FGfhM5e
         WxmGWcHEPp0s/BhP82HxymKaf+C2QZc2UjGWznBAVmIyyoBvBcC1iTv9jqyiT1E6kdbp
         Ru6rBns2gtV5s+gehoC0gTC8zCCn4+2H5IU3UXRjzoJslOlfXDMk31UkZwsX10jNA3Pq
         tHkQ==
X-Gm-Message-State: AAQBX9cY8n0fQCS8mpIZ1t0f88maUf9rN7SNY/VWf27B6onjbXmxZWbH
        bpWXjWuOMgHXwl1WhqGeEbI=
X-Google-Smtp-Source: AKy350Z5PYIUr+24jeO+tsguwPxv00arJ5cPOm61+xLOM5UFxuNli8FAI+NRKMphOLz9QZFDv9jT/A==
X-Received: by 2002:a17:906:f107:b0:895:58be:957 with SMTP id gv7-20020a170906f10700b0089558be0957mr10433828ejb.2.1681817393267;
        Tue, 18 Apr 2023 04:29:53 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090603c100b00882f9130eafsm7799572eja.26.2023.04.18.04.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:29:52 -0700 (PDT)
Message-ID: <a8a9e82b-996e-2b0d-4e3b-9ceda0ab81e4@gmail.com>
Date:   Tue, 18 Apr 2023 13:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add rk3588 timer
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230418095344.274025-1-cristian.ciocaltea@collabora.com>
 <20230418095344.274025-4-cristian.ciocaltea@collabora.com>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230418095344.274025-4-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 11:53, Cristian Ciocaltea wrote:
> Add DT node for Rockchip RK3588/RK3588S SoC timer.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 657c019d27fa..acd89a55374a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1400,6 +1400,14 @@ i2c5: i2c@fead0000 {
>  		status = "disabled";
>  	};
>  

> +	rktimer: timer@feae0000 {

There are multiple timers.
Use a label in line with the TRM.
Maybe change your label to "timer0" in that trend?

> +		compatible = "rockchip,rk3588-timer", "rockchip,rk3288-timer";
> +		reg = <0x0 0xfeae0000 0x0 0x20>;

> +		clocks = <&cru PCLK_BUSTIMER0>, <&cru CLK_BUSTIMER0>;
> +		clock-names = "pclk", "timer";
> +		interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;

Heiko's sort rules:

compatible
reg
interrupts
[alphabetical]
status [if needed]

> +	};
> +
>  	wdt: watchdog@feaf0000 {
>  		compatible = "rockchip,rk3588-wdt", "snps,dw-wdt";
>  		reg = <0x0 0xfeaf0000 0x0 0x100>;
