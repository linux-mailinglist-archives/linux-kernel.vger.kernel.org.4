Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5426A2A48
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBYOWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 09:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 09:22:06 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B75193D5;
        Sat, 25 Feb 2023 06:22:04 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f16so1912788ljq.10;
        Sat, 25 Feb 2023 06:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6yuzfd4cfp7Wsvy7k4YO2yj3vuOSi9NJ8184ii/QaI=;
        b=jKeELB5zxaByVRQ7zIEZKejXHBlGSr33O4qU1N4sXVlemwwFzuoG95k6UalgDoXwxI
         VjWyjfpJz338gOP6PncGnM7/RmfruyykMzTqu2+HU/PZMGOkFfISLG2sl4GwGUrJ+/Ye
         QglXHbIzKYP2SqNdKg3vaRIzbxK1RIYKEwIfMBI4tNYFB9AUzc67xnmrU/UDJiHI5EVZ
         i1XPC8DU9dzq+JZ1I/4gJvpnzw/iEQlICVQWrkyiXt+x0gU+fmuODf2zjuCoQtx26y8Y
         OFvQFyRirMsfFJCaT7Q1EnoSU8Ex9M8Mr2UFyRRyxuDaiUtqMlU457ydh9lzTSjL8nAS
         GeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6yuzfd4cfp7Wsvy7k4YO2yj3vuOSi9NJ8184ii/QaI=;
        b=mGJjlV+fpQryfi4kBxeOTldX/Dikzby+X+Q3jVZkymQ9Ix79lmo45lNrHgl/aTL9BR
         84POL7kSXj4SE2Htfo/JEBAZEhfQnM91joiubZ9auoabueT3OkEqR4SF0PKQjxDrtX0V
         Mu1XReXrIQAEKyprLiix449em+2gh/9SnlI34zNU0C75Fe/SyS3iWkBvPWU3FdTu/lbQ
         TAJoIWTPaCeQFG8JZ+p3No1oMsVeMPavdWhl2oyYltlq9zh/lSDnicLuK7gCjSe46vAp
         DuQ9cZxx3gX/ZTi23368XEc/2IGWx1Wr9z4SrJoC6LamvUffMOEJ6sDEX78ibHeatUg2
         MC8w==
X-Gm-Message-State: AO0yUKVw8xqOpaQbplA2ilDXrHDYJFBYuAkANrx0Ockld9yj5LXbPMWs
        3UklpTBhrEYw7VumT3WUrF4=
X-Google-Smtp-Source: AK7set8mcFf4FIjIFyxlQvO1ZfJzK9NiS+iW+wCQMwBiGg8NB9oEVbadDs58iRjc/bQtENEpo6xFEw==
X-Received: by 2002:a2e:9a8a:0:b0:295:a3a6:95b with SMTP id p10-20020a2e9a8a000000b00295a3a6095bmr2207012lji.0.1677334922705;
        Sat, 25 Feb 2023 06:22:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id f25-20020a05651c03d900b00295a5aa9d05sm180069ljp.120.2023.02.25.06.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 06:22:02 -0800 (PST)
Message-ID: <52813148-fef6-aac3-09ff-65aac8426528@gmail.com>
Date:   Sat, 25 Feb 2023 16:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Alistair Francis <alistair@alistair23.me>, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     arnd@arndb.de, alistair23@gmail.com, kernel@pengutronix.de,
        jernej.skrabec@gmail.com, linux@armlinux.org.uk, festevam@gmail.com
References: <20230225113712.340612-1-alistair@alistair23.me>
 <20230225113712.340612-4-alistair@alistair23.me>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx7d-remarkable2: Enable the
 rohm,bd71815
In-Reply-To: <20230225113712.340612-4-alistair@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On 2/25/23 13:37, Alistair Francis wrote:
> Add support for the rohm,bd71815 power controller controller for the
> reMarkable 2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>   arch/arm/boot/dts/imx7d-remarkable2.dts | 158 ++++++++++++++++++++++++
>   1 file changed, 158 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 288fc8611117..9ecb733545cc 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -91,6 +91,10 @@ wifi_pwrseq: wifi_pwrseq {
>   	};
>   };
>   
> +&cpu0 {
> +	cpu-supply = <&buck1_reg>;
> +};
> +
>   &clks {
>   	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
>   			  <&clks IMX7D_CLKO2_ROOT_DIV>;
> @@ -118,6 +122,147 @@ wacom_digitizer: digitizer@9 {
>   	};
>   };
>   
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	bd71815: pmic@4b {
> +		compatible = "rohm,bd71815";
> +		reg = <0x4b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_bd71815>;
> +		interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-controller;
> +		clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
> +		clock-output-names = "bd71815-32k-out";
> +		#clock-cells = <0>;
> +		#gpio-cells = <1>;
> +
> +		regulators {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			buck1_reg: regulator@0 {
> +				reg = <0>;
> +				regulator-compatible = "buck1";

I'm sure you have learned to regard my comments with certain care ;) (I 
think it was you for whom I gave an advice - which resulted a board to 
be bricked :| So, please treat my comment as if I did not know what I am 
talking about).

Anyways, I believe the "regulator-compatible" is deprecated and should 
no longer be used to match the node with the regulator? Instead, the 
regulator node name itself should be used for the matching.

ref. 
https://elixir.bootlin.com/linux/latest/source/drivers/regulator/of_regulator.c#L380

I don't think the regulator-compatible can even be found from the 
regulator.yaml binding list...

With this remark - (and what ever it is worth):
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

