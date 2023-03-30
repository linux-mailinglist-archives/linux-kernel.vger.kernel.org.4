Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DA6D0CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjC3RXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjC3RW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:22:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E2E05A;
        Thu, 30 Mar 2023 10:22:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l27so19866530wrb.2;
        Thu, 30 Mar 2023 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPJs63vkmES77vLWP6h36VSVcoJgnvHBO16dXz7aLLA=;
        b=HXRk0gSjc7UzTeVlVScMI/bFzbgMX6Yx0jQ7+4jjV6DbiTYXpmzqrCfaC6n/XV5O1s
         GTmmS93u4AXEG/2sSwLT0vXUqxiJ8DO6xBkmyY3kWOQgjtA1yZr/x0LSK9l0j01p0U5U
         CWV95X1Lbaur4n4ym0ubz4jziweW0xxdp+Xg9jblSMmG9Pu70RpkNGFWxGr1pYMJu55J
         FC5/CEsyB7kDishxKTQILkUpwj24mwr/qxifNx+6eZcTxEjXTXokLd71O7ffNfjP1z2Y
         Wy2VW9ADXsVVW/lCjhTPZ2gvKUUhp+ErKtO0jvW+Hj0JLgkUzyiqpyilqKwOYXA0+tzK
         IlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPJs63vkmES77vLWP6h36VSVcoJgnvHBO16dXz7aLLA=;
        b=5awsRaPBltqL1GMGhQLZHB3W5SRcLb8MLhRSWVYUgmdDbfsHgQNvSq4KpBFKrP1RjJ
         j4sKybb0S+LMl5vNrdKf+Z5wQtotff+tuGI/OGm3KOLHf7sJbwfDBH5ifTNuytp/GgXH
         mSobbOTYOk5JG8Ucg5ByJ4ppaL1LV0xAGzbSMXwnjSENQZQD/VKW3VQcgNwsKlvRVKCx
         cedOh4jR9duu5wzEw+hAthHn/rcQwFa4i4UuYyD6qyBb9LeJop7awQ9IISj0jPPwxO3Q
         ZwV17K2CC0wOyWv3IQSvapm4lASRpBrHHWM9OE5dl4yWHggVUqrGFyXcWflChMQ24pHF
         0uHA==
X-Gm-Message-State: AAQBX9cZKBXPpv6SAH8BO2bacOeERfl+BXTRLXxRBY4Y8hWbA7dDquz8
        xiAevmkbZfEYavrhWuQ3pVw=
X-Google-Smtp-Source: AKy350beiItDOkhHiEWsPQhED+hZbp9xWyCi7X3rVDzlAVAglOScC+nn76KoyGNSMhG9Vj0f6PhHGA==
X-Received: by 2002:a5d:66ca:0:b0:2d3:bde8:9ff with SMTP id k10-20020a5d66ca000000b002d3bde809ffmr20716784wrw.34.1680196970778;
        Thu, 30 Mar 2023 10:22:50 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm33258678wru.40.2023.03.30.10.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:22:49 -0700 (PDT)
Message-ID: <5e929f59-7565-25c1-51af-ccb346a06036@gmail.com>
Date:   Thu, 30 Mar 2023 19:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 06/17] arm64: dts: mediatek: add pwrap support to
 mt8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-6-0003e80e0095@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230203-evk-board-support-v3-6-0003e80e0095@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 10:54, Alexandre Mergnat wrote:
> In order to use the PMIC, the pwrap support should be added
> to allow communication between the SoC and the PMIC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Applied, thanks.

> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index e018df6844f6..687011353f69 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -186,6 +186,18 @@ apmixedsys: syscon@1000c000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		pwrap: pwrap@1000d000 {
> +			compatible = "mediatek,mt8365-pwrap";
> +			reg = <0 0x1000d000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_IFR_PWRAP_SPI>,
> +				 <&infracfg CLK_IFR_PMIC_AP>,
> +				 <&infracfg CLK_IFR_PWRAP_SYS>,
> +				 <&infracfg CLK_IFR_PWRAP_TMR>;
> +			clock-names = "spi", "wrap", "sys", "tmr";
> +		};
> +
>   		keypad: keypad@10010000 {
>   			compatible = "mediatek,mt6779-keypad";
>   			reg = <0 0x10010000 0 0x1000>;
> 
