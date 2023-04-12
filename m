Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441A6DF605
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDLMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDLMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:45:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA759000;
        Wed, 12 Apr 2023 05:44:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e7so681748wrc.12;
        Wed, 12 Apr 2023 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303489; x=1683895489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSYib968TlNgbrZtfYcfjByTNtcgxfB28BPrF3X4daM=;
        b=MY99ceA8wW7QbNZeJ/UhL0jrqb2PDV0XkIO8PiE1B8pXUXYSBVMcBHlchVBx3ZlKSI
         Trcl3JgQqyu1U7HJ74gMZWDscs3HoXaHyMQ735SDo9Fn5itRQ8EvLCVif5RzSRLu5zQ2
         O/6M7+H/ztv7xPbiwep43pFqwS3TIdB4EEzdGvVvqiLYbT6MXYWNQnITM8CmTbtX/okK
         Apf2oxWNTsasGFbHib6t1eqVM72eAnh0mbZ7vd68+8/MGhhAeJdPTebocQUPaTZOuYVu
         fEb4EO7BCR4mny4FfkJKgcvkUyaRXqDHu0Kcc33XmjHrkPBTPJCA9MC4hEmmkp3RJydb
         gBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303489; x=1683895489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSYib968TlNgbrZtfYcfjByTNtcgxfB28BPrF3X4daM=;
        b=Ov3CaWSwd9/Tx9xUmFy5i1EBAtX99ptMT6VOdtDsusUv2n9bsBvKgLNe3u/2t6NrjV
         XHGQboyNniwaOqfCTHuBTLVhFBInb9MMTgdUYHYNIuC2WgBEL1t7+UW/3BeXx/8Czmfz
         XQJeAMG20BD/UIGsVIaSc061/as/rgnyM99jNLz5CPNYjS+RY8d6NzJ5uEHXW9efd3/U
         V97Of5AqIpM3ZqWF41Kn4p+l5HjfOaWXEvVGj3dKrg0mye4ZnambMtuahnZBS1FLwinK
         c7D9cp31T2UYxii04ThDRm0XLfny5Q9I6O5UhDA2urRUkOjcvBPBz69FYNuR3cbAsbHe
         0MUg==
X-Gm-Message-State: AAQBX9d4wKUwraB1iL2Qc0yKXtnxVVoq/s9SIYwE7rVZLXzV/Dq5the7
        CVFn0qgX09miLXLZB08Daeg=
X-Google-Smtp-Source: AKy350bqiWDrholWxeMJXdmA/F5ClDwfMvEqM4y0TIzuUBHgXU6/D61FCV64IYa31nkjoJetKcYdxQ==
X-Received: by 2002:adf:dc07:0:b0:2e2:730a:c7de with SMTP id t7-20020adfdc07000000b002e2730ac7demr10112945wri.24.1681303488999;
        Wed, 12 Apr 2023 05:44:48 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b002c71b4d476asm17054089wrt.106.2023.04.12.05.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:44:48 -0700 (PDT)
Message-ID: <17cd35c1-aaa2-26d1-e372-06774e78514f@gmail.com>
Date:   Wed, 12 Apr 2023 14:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 27/27] arm64: dts: mediatek: mt6795-xperia-m5: Add Bosch
 BMM050 Magnetometer
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
 <20230412112739.160376-28-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-28-angelogioacchino.delregno@collabora.com>
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
> This smartphone features a Bosch BMM050 Magnetometer on I2C3: enable
> it with the BMM150 binding, as that driver supports BMM050 as well.
> For this sensor, there is no interrupt pin;
> readings were validated in sysfs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied :)

> ---
>   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> index 0b0519f6b2f1..b5746e6d0b15 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -75,6 +75,11 @@ accelerometer@10 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&accel_pins>;
>   	};
> +
> +	magnetometer@12 {
> +		compatible = "bosch,bmm150";
> +		reg = <0x12>;
> +	};
>   };
>   
>   &i2c2 {
