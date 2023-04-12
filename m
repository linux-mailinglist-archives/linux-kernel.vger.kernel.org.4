Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8212A6DF5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjDLMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjDLMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:45:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC369ECE;
        Wed, 12 Apr 2023 05:44:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so4148615wmq.5;
        Wed, 12 Apr 2023 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303479; x=1683895479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9NXku2pSRV2wSCRtuxBqdlKYT3KNs95Y1/l9wS3vzw=;
        b=OyUCjn9d2mWZw6/j9UH76T6MvVfV73nrX7flAEHmexvlXuDR1A3kUxIjr+44xDCrDR
         k//7Zw99Qqcchw/qWW0ytKHFb8rCDg0FSSOQiwNs2dwvTwNVjp8nk0Cu2NfAfjmw9Zc8
         5uzci64ZRXvrjB0zjvaimqizCRF1+OKTRXwW/zN3C0pT8ZwRwRaQ6Xx/6f+OROOMWKG6
         cMyn8GGHWv15mf6E752bYcMrKPUww+r3RV4+3atyPQuSPI9VETbjjn0N4Uxt2Pn/UyoH
         ccqI2akgk2fhK3+m1y6MYcSTCHHj84THPSfcHDOGBvGTZqhWb9Y2KoXB3FK5Oj3oqwwm
         pI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303479; x=1683895479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9NXku2pSRV2wSCRtuxBqdlKYT3KNs95Y1/l9wS3vzw=;
        b=OahRvyRn0/I3SYRErsOeFsLRH5OeEPe9B0luLKAQShphuH88thb3kCEXcfURsF7SG+
         0ejg40vtlEQbk1IchsBKgS9SxHQl8xLb1mZMJ9lMNFoi8pwl/OUBbknIwi4ODW/sDHst
         DyNFBRoaV5TLOUKG/e9ITG8tz8Xg9cpu9TckwAcZOFengKmC0v7bQuqFchRAI26spY+j
         dL+POSnCwUx8SvESIaidap8W4b7dy8NKoAGF0xp0A+5YBVZ+868oUWYJndKAisTMCYHx
         onHS3t/ZAlMgHqtwFCTjXnN8uCYLrp26C7ojSNSOm88+0wRGo2LVT4SuuJNFTqNPFuGW
         CIRA==
X-Gm-Message-State: AAQBX9eU7wfn0pmLO7BU7XXG7wXg+XQ5ATXfMOCkIIQ0qGDMYcFmvjqF
        ilHwgjj/iJL+K6ZmoCiBQpE=
X-Google-Smtp-Source: AKy350Z9J6ofOu5x2SAuA+Yid54vROa2O2IpNFieU9+eQdR2LmXWIs2SlT696xFupy+hn+OrZ4Z+vg==
X-Received: by 2002:a1c:f20b:0:b0:3ed:418a:ec06 with SMTP id s11-20020a1cf20b000000b003ed418aec06mr11959758wmc.28.1681303479096;
        Wed, 12 Apr 2023 05:44:39 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f0824e8c92sm2294201wmc.7.2023.04.12.05.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:44:38 -0700 (PDT)
Message-ID: <d892f4d4-f311-4795-ded4-6b735739dd94@gmail.com>
Date:   Wed, 12 Apr 2023 14:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 26/27] arm64: dts: mediatek: mt6795-xperia-m5: Add Bosch
 BMA255 Accelerometer
Content-Language: en-US
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
 <20230412112739.160376-27-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-27-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add the BMA255 Accelerometer on I2C3 and its pin definitions.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   .../boot/dts/mediatek/mt6795-sony-xperia-m5.dts   | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> index 155a573eac4c..0b0519f6b2f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -68,6 +68,13 @@ &i2c1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c1_pins>;
>   	status = "okay";
> +
> +	accelerometer@10 {
> +		compatible = "bosch,bma255";
> +		reg = <0x10>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&accel_pins>;
> +	};
>   };
>   
>   &i2c2 {
> @@ -247,6 +254,14 @@ pins-irq {
>   		};
>   	};
>   
> +	accel_pins: accelerometer-pins {
> +		pins-irq {
> +			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>;
> +			bias-pull-up;
> +			input-enable;
> +		};
> +	};
> +
>   	i2c0_pins: i2c0-pins {
>   		pins-bus {
>   			pinmux = <PINMUX_GPIO45__FUNC_SDA0>,
