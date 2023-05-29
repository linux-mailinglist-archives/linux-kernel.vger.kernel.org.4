Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E2714B68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjE2OCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE2OB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:01:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FC12A;
        Mon, 29 May 2023 07:01:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30ad458f085so2175933f8f.0;
        Mon, 29 May 2023 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368884; x=1687960884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkVD5uNKLXho+93j6yXeIdGEkFo+SItch2wdaTfZzF4=;
        b=C8jexQLFK7fIrq5hMh29fnNYYCZQHc49p8HRIM5JHUgM4KuH+lyrtzwU8rn9/yeadB
         9JYXQjgZaX99pzBa2fVTzAVeIpk/wElSxYrTMu0+oeNaJfSGwg7nQMDKnLQniSb8VPF0
         6t/CiNN2IWiqXzQCJa+3H68BSoEJouPRp1dhpEKNspKTwlplGQo1X/klW76s4LqmacVb
         ncWvJ75VEhzilUyIYh8n8ZqMbIwZspLoKhKA6qyqhEOi46eYZOISn/3/JSkzs25PaiAV
         gADmrHGgPmE5JnbpiGvfddF7CVbs9fw+d/cON2F3bR3gb7wgYa1sr3ulwtht+Va+VjOs
         A9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368884; x=1687960884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkVD5uNKLXho+93j6yXeIdGEkFo+SItch2wdaTfZzF4=;
        b=AGATU3s/H9zXCKg0qeLN+SbSXbSVvege86XuhYSZ7/I84gEL2xDoJQVc60ZGnbu2cG
         cp9gvOI324yYO93BcK2Lic+sTHYUPdeW+zHoKwCEjCF6teCQpx7wg3MlLePJZ2IlZb6+
         ZktM+3/MQBghYMjjwqT+Ehr7S8qFzCLM4s/PUHM7jvvzC6SAS2nzu6knWhIi8SMSMZ00
         8f/UxQ30yrVg0mB7yALzk7HSAcY0ZYv05WQ6QOVtuAgg43Vrs2Aq0GlWk6IMjbg9Y4tS
         oyasXfnIJzTBzFEb32LnnIi3MeZk3xEzLDevurMM4bCfdxsGYvemSgz9MGM+Wm0xW4AN
         sBaA==
X-Gm-Message-State: AC+VfDzeL6DRZwxqAdh604UnMcJVGmqtGJfu6/plv4cwBuFIw1iAmqMq
        yg0UCbNIDEy2w/a+N2WxDdE=
X-Google-Smtp-Source: ACHHUZ61i21IzzVJYxeHp9DzEw7W00OUTsqZ1efYzky4ahkIIyaYvbeNiPCUyPUefgpCOGfRZCmSBw==
X-Received: by 2002:a5d:4592:0:b0:2ef:d0de:e8a4 with SMTP id p18-20020a5d4592000000b002efd0dee8a4mr6317453wrq.25.1685368884120;
        Mon, 29 May 2023 07:01:24 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b0030af1d87342sm92246wrp.6.2023.05.29.07.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:01:23 -0700 (PDT)
Message-ID: <674cecd6-931a-9949-8a81-aa5dd1960b84@gmail.com>
Date:   Mon, 29 May 2023 16:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 25/27] arm64: dts: mediatek: mt6795-xperia-m5: Add eMMC,
 MicroSD slot, SDIO
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-26-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-26-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Configure and enable the MMC0/1/2 controllers, used for the eMMC chip,
> MicroSD card slot and SDIO (WiFi) respectively.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 91 +++++++++++++++++++
>   1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> index debe0f2553d9..155a573eac4c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -17,6 +17,7 @@ / {
>   	aliases {
>   		mmc0 = &mmc0;
>   		mmc1 = &mmc1;
> +		mmc2 = &mmc2;
>   		serial0 = &uart0;
>   		serial1 = &uart1;
>   	};
> @@ -121,7 +122,97 @@ proximity@48 {
>   	};
>   };
>   
> +&mmc0 {
> +	/* eMMC controller */
> +	mediatek,latch-ck = <0x14>; /* hs400 */
> +	mediatek,hs200-cmd-int-delay = <1>;
> +	mediatek,hs400-cmd-int-delay = <1>;
> +	mediatek,hs400-ds-dly3 = <0x1a>;
> +	non-removable;
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	vmmc-supply = <&mt6331_vemc33_reg>;
> +	vqmmc-supply = <&mt6331_vio18_reg>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	/* MicroSD card slot */
> +	vmmc-supply = <&mt6331_vmc_reg>;
> +	vqmmc-supply = <&mt6331_vmch_reg>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	/* SDIO WiFi on MMC2 */
> +	vmmc-supply = <&mt6331_vmc_reg>;
> +	vqmmc-supply = <&mt6331_vmch_reg>;
> +	status = "okay";
> +};
> +
>   &pio {
> +	mmc0_pins_default: emmc-sdr-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO154__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO155__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO156__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO157__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO158__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO159__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO160__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO161__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO162__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO163__FUNC_MSDC0_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO165__FUNC_MSDC0_RSTB>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
> +
> +	mmc0_pins_uhs: emmc-uhs-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO154__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO155__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO156__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO157__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO158__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO159__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO160__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO161__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO162__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO163__FUNC_MSDC0_CLK>;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO165__FUNC_MSDC0_RSTB>;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-ds {
> +			pinmux = <PINMUX_GPIO164__FUNC_MSDC0_DSL>;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
> +
>   	nfc_pins: nfc-pins {
>   		pins-irq {
>   			pinmux = <PINMUX_GPIO3__FUNC_GPIO3>;
