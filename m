Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9626A0DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjBWQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjBWQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:23:42 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB22D153;
        Thu, 23 Feb 2023 08:23:40 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BC8D18573B;
        Thu, 23 Feb 2023 17:23:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1677169418;
        bh=1PUzE0+zbdrJzsEspgWhplT9mz131Ery1oTB7F642MI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Azvh/tcvjgvN5bIIo+ysusWc22fXL0+3pHNK0k0GjuV2PJ0Yt+dLHqJ37QEOUHAPY
         vWiR9D+3B9DY1xfde56sZQp+GX9V/N06NjpCAnbDYNuDuvzKjfZFkyL5dH9j0UvX+R
         McAuYKfg2K9Sye15auGRD9TREB9Q783mv7s141xfbPsrzJ2g0t0HxdrM5IOJnarAeI
         H8y6UYNjprqLLTDzteq54V+Bcmdzo2caFYfhIC8zZvExDAJzwexV0Fdf5NmfJKasVa
         fGowF78SDNpWL7tqjGaNaKS1IAI0tHOvvt/+KglpLxYoBDGh3klIJBf8WPuVSWED3A
         KYcJjtu34RjpA==
Message-ID: <63cbfbaf-7405-eaec-9681-36fc3792e637@denx.de>
Date:   Thu, 23 Feb 2023 17:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add sound card
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, Jacky Bai <ping.bai@nxp.com>
References: <20230222182252.2ad6d82b@booty>
 <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
 <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
 <10394cf6-70f0-638a-15d3-5a14615dad44@denx.de>
 <20230222190246.ihknh2tgjb2w3qmf@pengutronix.de>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230222190246.ihknh2tgjb2w3qmf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 20:02, Marco Felsch wrote:

Hi,

[...]

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 8547391d9cbbf..3b38ec7bb47be 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -47,7 +47,6 @@ reg_audio_pwr: regulator-audio-pwr {
>   		regulator-max-microvolt = <3300000>;
>   		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
>   		enable-active-high;
> -		regulator-always-on;
>   	};
>   
>   	reg_can1_stby: regulator-can1-stby {
> @@ -94,21 +93,34 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>   		enable-active-high;
>   	};
>   
> -	sound-wm8960 {
> -		compatible = "fsl,imx-audio-wm8960";
> -		model = "wm8960-audio";
> -		audio-cpu = <&sai3>;
> -		audio-codec = <&codec>;
> -		audio-routing =
> +	sound-wm8524 {

Why WM8524 ? The MX8MP EVK I have here is populated with WM8960 chip and 
with single headphone jack, are you sure the below is correct ?

[...]
