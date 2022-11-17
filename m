Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C462E077
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiKQP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiKQP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:56:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0A769EC;
        Thu, 17 Nov 2022 07:56:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o30so1704288wms.2;
        Thu, 17 Nov 2022 07:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jw7AXNLDquiKmb0cINuRMfIIFbIpSHUSTUYkwNek1L8=;
        b=EMUM9y0qHFTq+fyZfZPjr80/ZVBOVEtb/zBw5xodvQA4wG6FLabyEIo8El5oxnRoL9
         WTu5f+yqCYJajEvu4a94XN2XfeQN3HoNS1HY4b8X67zajEYV2cG0dySjS8Lz8nhRJhC3
         B2ZOB47D/YZuR4Z5fc5vUJbTNZRrGddtS1caO+4A07Yv0BaeBah1apqpbIRMWxYHGL24
         DA1fcNj44DcfL3eH4u0JfM++YqLwEiu9TPuNaHfETpnZGlLCR8EMKiqqtCcaZqIP/hEF
         OMKPmThfVFPXZ7s9ZPza5sJGl/XSZgyiBJjjNhBHHavxffgtIye+/zLC4nCvW6amGZqB
         68eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw7AXNLDquiKmb0cINuRMfIIFbIpSHUSTUYkwNek1L8=;
        b=VHZOOYOxzL5q1vjNLFt/ftN4S+Ihq1xRyB3PvjLi0yn2i1yiuuGFm3GfgGZjkOT1sL
         niBK68R6oqhpezcFHAsM+1kEr2Vow8RrrTl7sbLleAGH4YQjOxvylMEIp0eJrBqXJi9W
         l/txUETBPXjAlS1OFZO5iCxrzhRWaTv5jcdwPNpsmVBiFSN6O2EVQytnLtF/tv3VwOoI
         eVRC5BSzx2/G+4J9eA37+PKXOO3b0edKEDhWp5w9Jvf7vCPJ2xg9tv+7sZBpQVNPdBD4
         Z1zBLr5kNfx6CdnI0i0XIQTrnAuYWIRFhIJjZW21vlOvEaTQ1BY+Ed+ScRb0hjjNHhnC
         mEaw==
X-Gm-Message-State: ANoB5pmRVCerMpsaNtz97i83uKKLwsxUtD6FpGZArJPyWrYuVTPvs9wM
        q3OyRSt1/W8Xg7i/VpPfVNo=
X-Google-Smtp-Source: AA0mqf7PU6ZAl4D73Eqi1u337u3E+gX3npBMxRRcNin3zcfg82KMPzDIVP8aXn+bmx3EksJgOFP/Zw==
X-Received: by 2002:a7b:ca53:0:b0:3cf:74ef:3313 with SMTP id m19-20020a7bca53000000b003cf74ef3313mr2170849wml.41.1668700602684;
        Thu, 17 Nov 2022 07:56:42 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003cf4d99fd2asm1612146wmi.6.2022.11.17.07.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:56:41 -0800 (PST)
Message-ID: <10300d7f-30d5-7601-6f79-10c6799c89b3@gmail.com>
Date:   Thu, 17 Nov 2022 16:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 08/10] arm64: dts: mt8173: change node name
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-8-8210d955dd3d@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221005-mt6357-support-v5-8-8210d955dd3d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 13:33, Alexandre Mergnat wrote:
> - Change the node name from "mt6397" to "pmic" to be consistent
> with mediatek,pwrap.yaml documentation.
> 

Same here as in 7/10.

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index e21feb85d822..a8f5c48e1782 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -913,7 +913,7 @@ &pwm0 {
>   };
>   
>   &pwrap {
> -	pmic: mt6397 {
> +	pmic: pmic {
>   		compatible = "mediatek,mt6397";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index 0b5f154007be..755df5694234 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -300,7 +300,7 @@ &pwrap {
>   	/* Only MT8173 E1 needs USB power domain */
>   	power-domains = <&spm MT8173_POWER_DOMAIN_USB>;
>   
> -	pmic: mt6397 {
> +	pmic: pmic {
>   		compatible = "mediatek,mt6397";
>   		interrupt-parent = <&pio>;
>   		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> 
