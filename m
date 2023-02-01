Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD56864DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBAK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBAK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:57:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B329CDD7;
        Wed,  1 Feb 2023 02:56:58 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2349439wmb.0;
        Wed, 01 Feb 2023 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LinfPfwdc69r+5MS9+W8GWtbQTG5CSXHZBHVy7HHbcc=;
        b=d9PgESiUcaaRDq+WJ3qIgUQfDcb66ZTE97cDw7SP6ZgJ3dD3SeK72xuDAnSYhmTgnq
         /wpB10A26l+EJ3cf+WDXXjHtkOZQX+0iGr4nLsuWOH6fZ3ADULkg0w6ayIs+izB5KSi3
         BilQgqt1RChReSbl/E+QB82h9uyKf+ipLBKu2aLDxw1DHdtsRaKE6d9prSeFiURA7Sds
         UpTOPVYZicbDAuMSU2Ajfb77KnWRDP3xSOClB6BFn7p2uYWGHRq8sf2qLel5NtGxWeRV
         1Vpiht2CFIr3Y0u6shqlmXHt0q7gl47P+Hfu4euynXC9rExcBXgf1ooc3cr52Ta87HJ0
         3F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LinfPfwdc69r+5MS9+W8GWtbQTG5CSXHZBHVy7HHbcc=;
        b=Lf1e+6fkJqNq3N9CAsdqCxlMZCaipoFDPZWl71OuZHXg7VfOwKyMGT2tCuZeK5bDSY
         K3dzEJdPnrOQijw1K/VjoKhT0g1L2BbEEN+HOS7P5NE8LhDm8FP006f7GWoRlajLMr96
         Kn/ciWepXJXEolG8OJ2BhsiEFMD3w847L8aQCCX7nlTB+yYFg/RgCG976/RTxw1pr/+B
         68aRAzpsqcrXsHnDxHbXID3Kr1rh9wFOFS8A90akfjyaNtfTBXPmmENnilPcJMR9PPle
         BPLCX809f5cwHt5wJ6Li92TiBH0KG9VI4g6G8qfGgJar2vi2c22TklDtTzICJ0XWPIX0
         jbZg==
X-Gm-Message-State: AO0yUKV4Kh2czdgisTcYl0LIjCfYKLGHZiMVydW62v2Jmt1jebebJkuH
        My3dc3asRpWk0sE35rzYpss=
X-Google-Smtp-Source: AK7set/YIe/I+C+MEjw/u4XskuAdX7Srwo/ASJLfYgnYv2wbXKrk75N0foIaGyXaEO3k+QVkOVLCEQ==
X-Received: by 2002:a05:600c:601b:b0:3dc:557f:6129 with SMTP id az27-20020a05600c601b00b003dc557f6129mr1566953wmb.2.1675249016755;
        Wed, 01 Feb 2023 02:56:56 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003dc1d668866sm1357736wme.10.2023.02.01.02.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:56:56 -0800 (PST)
Message-ID: <f5e283bf-2cd2-779e-eb2d-ef36f4780153@gmail.com>
Date:   Wed, 1 Feb 2023 11:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/2] arm64: dts: mediatek: mt7622: Add missing
 pwm-cells to pwm node
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, john@phrozen.org, sean.wang@mediatek.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
 <20221128112028.58021-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221128112028.58021-2-angelogioacchino.delregno@collabora.com>
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



On 28/11/2022 12:20, AngeloGioacchino Del Regno wrote:
> Specify #pwm-cells on pwm@11006000 to make it actually usable.
> 
> Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 146e18b5b1f4..f321c6d0fd7c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -435,6 +435,7 @@ uart3: serial@11005000 {
>   	pwm: pwm@11006000 {
>   		compatible = "mediatek,mt7622-pwm";
>   		reg = <0 0x11006000 0 0x1000>;
> +		#pwm-cells = <2>;
>   		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&topckgen CLK_TOP_PWM_SEL>,
>   			 <&pericfg CLK_PERI_PWM_PD>,
