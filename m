Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E02E62E0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiKQQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiKQQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:02:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583FE4B9AB;
        Thu, 17 Nov 2022 08:02:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j15so4044753wrq.3;
        Thu, 17 Nov 2022 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/GUF4i0vFgTkWf2Mt9fp99ozQam8AhnbOj0pG+H04s=;
        b=JEJQRUtTU6aO1gfL4hnGyIAu28Nz+3sErCohP/a27SF2qNRKheEocfENENDqbYDYeW
         BadHM0NjaGngJIEtZQtiM8tn1LUUy82Ys137jAlcv01zuHwWCbLwHQ5z/oEcxFvhFV3C
         kZ5b1dE1QKEc/0TgQCjFxt0TCZSlcfGMDsyYSuT4Id+Cz9Gx9/tapIOPAtdX0YONgcR2
         /+6tH4fBHEmHvC9QvW0RHXYW6VZa65b/lZH1JO/74k+OL/InyD4qkEsj6VImJ3bn6KqB
         2I6vLlA/8Evu6VzpNb0fa5/Z2IVnE3RjaVPzPysTgHMcYbfc2FI4Rzuu1T3x+ObTTMTd
         TRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/GUF4i0vFgTkWf2Mt9fp99ozQam8AhnbOj0pG+H04s=;
        b=EsVPaol2nBWdvFDUpdKwEQ8TmM0R0gcvEmDko6pfqP6QmLFcMPsd/L3s5J+nns5v7k
         x8p35EF4r4RNXk/rQALUmcdN1hTUC4qeERaA0BoA4r8xdL/TNddGU2dPReWSnH+GFM8B
         r7Bem1Sc/aPj6vFnrLDV2B6zjpHUFVU0479xw1eWY+GJz4HGdjJ8p/zPkwbtumEWN8Yv
         EDfHb+2/0gUJqeEJe9z6D1BAoBIBipM7x+sjMoX9N/zG54Uecjm3BWWOuuPPq0nrI9/i
         X0k0QMeHpDKQ5Pw1UW3P70boVFxHgZ6l75yI7Pdr3dtzavzdA258FV5ZVjauyhhfN1tg
         pqew==
X-Gm-Message-State: ANoB5pn7P16ueLrWgB5osCMsR++ZKjtzNG4ZF6B259xMaVwsunK27bFt
        VScnvcPjXb7jlaZ5dA4EbSY=
X-Google-Smtp-Source: AA0mqf4ij58cUxvN+eDGc6Ok87DeWvysOzClnmI6KelXix/YI/GztmA81kXcaEnZiZ5xhp4tK91HZQ==
X-Received: by 2002:a05:6000:78d:b0:22e:3d63:80bc with SMTP id bu13-20020a056000078d00b0022e3d6380bcmr2013908wrb.30.1668700974648;
        Thu, 17 Nov 2022 08:02:54 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003cf5ec79bf9sm1985849wms.40.2022.11.17.08.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:02:53 -0800 (PST)
Message-ID: <3ab0a069-355c-b3a7-450b-22e58d5f1ea8@gmail.com>
Date:   Thu, 17 Nov 2022 17:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
 <20221005-mt6357-support-v5-7-8210d955dd3d@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 07/10] arm64: dts: mt6358: change node names
In-Reply-To: <20221005-mt6357-support-v5-7-8210d955dd3d@baylibre.com>
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
> - Change the node name from "mt6358" to "pmic" to be consistent
> with mediatek,pwrap.yaml documentation.
> 
> - Change the node name from "mt6358rtc" to "rtc" to be consistent
> with mediatek,mt6397-rtc.yaml documentation.
> 
> - Change the node name from "mt6358keys" to "keys" to be consistent
> with mediatek,pmic-keys.yaml documentation.
> 

I think the node names should be changed anyway. So I'd advise to update the 
commit message and I can take some right away.

Regards,
Matthias

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt6358.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> index 98f3b0e0c9f6..b605313bed99 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> @@ -5,7 +5,7 @@
>   #include <dt-bindings/input/input.h>
>   
>   &pwrap {
> -	pmic: mt6358 {
> +	pmic: pmic {
>   		compatible = "mediatek,mt6358";
>   		interrupt-controller;
>   		interrupt-parent = <&pio>;
> @@ -355,11 +355,11 @@ mt6358_vsim2_reg: ldo_vsim2 {
>   			};
>   		};
>   
> -		mt6358rtc: mt6358rtc {
> +		mt6358rtc: rtc {
>   			compatible = "mediatek,mt6358-rtc";
>   		};
>   
> -		mt6358keys: mt6358keys {
> +		mt6358keys: keys {
>   			compatible = "mediatek,mt6358-keys";
>   			power {
>   				linux,keycodes = <KEY_POWER>;
> 
