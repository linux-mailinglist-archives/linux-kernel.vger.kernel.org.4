Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE39704C18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjEPLPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjEPLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:14:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F786E9E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:13:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so21629845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235584; x=1686827584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XLBZYDOlju9+mAa1IeI6xdw8ojmUnCJJZY2yhbQHc8=;
        b=im25hgLtoQevbBKEIbJaGnRpqPZiE8VGfYJ1LVySDj+T8OchmdOjoVCWynDrHYNmk/
         +rHUe/ocWIR+caY2pWxF090qTbUrqE92IGfrPqWOtduVKDyULQoLagVP9SygHovJpVQw
         a5V+jI49MkzwDfkHpt+iA2rwHnc71HRJYwzFo7qbEamx2P/0g7HznyRj1+sTI3AEH9zo
         S32uLT1Ujv4ASYPOMDn15niWjuWJLp5HDDQli9Cmkb6btqt31eq/vMWkYzy+sQdTEO9X
         vbHKO28hNU7ahyBVb5GUew0Fu71ShPHaRA9/TbUrlqOd6Otu2Tu1GlQBahEb2WBdJulj
         Kflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235584; x=1686827584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XLBZYDOlju9+mAa1IeI6xdw8ojmUnCJJZY2yhbQHc8=;
        b=EU1ZOtQBGDJ/6iQdSUQJhi5rf7qZzeII/56LEcMm63F9kYoqe/Ug/1a4F7bWkQjw3P
         sZltmhzt0lP6nuh9L68QjkOrmoaal61dhCfXnDkiS4pPdGGSgw7cx9JmgaU53RlPj7g7
         FrZfZAOzQ91YZUVS4TQ0EwvPBr0gPmN1oreVWuxJxyexku5CaLZLQy0Y8803ub0cK4Bw
         h3HLk0X0D21Ub2UIF6RgjzDRiPL/9rpiEhRCC3Re9mEGlgIKNOXR9QwgGPG9Uign97+Q
         2r1AuGdJruFj3VHsKSCiwbfoXWPV8gZGSOD+9nQ4ykdLbS9NcsE8V3tJJQGmL2UBQ0bP
         JrGQ==
X-Gm-Message-State: AC+VfDx2WIcbfBGZg6YgiT+AZraZ60IladFWrGqMZbYLXXrfKPWyXvcA
        w3S5VjXD5a7UYDRdNHVScRKVJQ==
X-Google-Smtp-Source: ACHHUZ5ijRtVbd+5lLEB6Hao8XoYKXtIjM/5Ro3eesJunbAxyGf9wXb6cAjfOrobWxk/5EGg2suNrg==
X-Received: by 2002:a05:600c:2294:b0:3f4:2a69:409 with SMTP id 20-20020a05600c229400b003f42a690409mr16923922wmf.11.1684235583839;
        Tue, 16 May 2023 04:13:03 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q4-20020a7bce84000000b003f420667807sm1983577wmj.11.2023.05.16.04.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:13:03 -0700 (PDT)
Message-ID: <eae6b1e9-6a21-7409-7ed3-a80d13bf0312@monstr.eu>
Date:   Tue, 16 May 2023 13:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ARM: zynq: dts: Add SCL & SDA GPIO entries for recovery
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Chirag Parekh <chiragp@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <5eb73d1150648e782795e35c30fccb983b3e0db7.1683035557.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <5eb73d1150648e782795e35c30fccb983b3e0db7.1683035557.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:52, Michal Simek wrote:
> From: Chirag Parekh <chiragp@xilinx.com>
> 
> Wire i2c pinmuxing gpio recovery for zc702.
> 
> Signed-off-by: Chirag Parekh <chiragp@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/boot/dts/zynq-zc702.dts | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index d23201ba8cd7..6efdbca9d3ef 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -5,6 +5,7 @@
>    */
>   /dts-v1/;
>   #include "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	model = "Xilinx ZC702 board";
> @@ -106,8 +107,11 @@ &gpio0 {
>   &i2c0 {
>   	status = "okay";
>   	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c0_default>;
> +	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +	scl-gpios = <&gpio0 50 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio0 51 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	i2c-mux@74 {
>   		compatible = "nxp,pca9548";
> @@ -298,6 +302,19 @@ conf {
>   		};
>   	};
>   
> +	pinctrl_i2c0_gpio: i2c0-gpio {
> +		mux {
> +			groups = "gpio0_50_grp", "gpio0_51_grp";
> +			function = "gpio0";
> +		};
> +
> +		conf {
> +			groups = "gpio0_50_grp", "gpio0_51_grp";
> +			slew-rate = <0>;
> +			io-standard = <1>;
> +		};
> +	};
> +
>   	pinctrl_sdhci0_default: sdhci0-default {
>   		mux {
>   			groups = "sdio0_2_grp";

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
