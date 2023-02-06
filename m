Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C568C789
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBFUVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjBFUVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:21:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B43626CD4;
        Mon,  6 Feb 2023 12:21:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j25so8049258wrc.4;
        Mon, 06 Feb 2023 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ex4e1gAMfKgJufavu50b5FPTNtgN9MMTywAYUVv/rSo=;
        b=XPTSpZZrnTnEBrJw4RPKyn08rM4GwX0nBLt0S5ELlaniKrqUEXMWI1czxM8lXshVYC
         CA8fh3a9gyig1DezP7p8WACDq29+5cWJ1FYsg+7cuS4msR4DzceIc86hNf98AsinqnhP
         kWjPRJadddk+JOvcJgcd0YYGQDeu8QIw8RtNJF4OUZ36WhcUHWZ/mf1jw/yLXiESFcFq
         K5kOwBwVgNLAMPwWbztGYqDrdYOGyQWq828mCP1m625n7MdqOnBwd5TPMf0BN1SwggH4
         4ZXvr4MHB+KCVmSAN3kl+bOJ62eLkecyq4X7NfG6A7sJVzRFciXyTpxoc9bp9NjNmT/z
         YVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex4e1gAMfKgJufavu50b5FPTNtgN9MMTywAYUVv/rSo=;
        b=ntRXbZj3uUcqV4UbnXvEz/E9QFkiNpL35ECXe1eP1nD79ybvxUNvuMX35GWp6qvM12
         zIEePNay+D8Tt3KT6uwquPmb5iGgVWM8Ljikint19yYKZ3z9+LS8GG6PnIw+tNgF0lsi
         2g8sojhW01U4snXhvwqp2ZsTv+JQi2Of3LhvSVTVXWuSoV/NCXujhsv0dmTbo4hXraCR
         y4l4gDVkweYS0jv9uyiHPRe0Q5trqJR3hBWAUgUjBKXp7YF4JFHQ5Sq8lu3I/r60DJiK
         DLqkt8Ih1bf6h+GBZRNwt9fbOqshj7EwLAAimGwIw8aBE3tydtHzIDd1TJ7Cb4Y2J48G
         fZkw==
X-Gm-Message-State: AO0yUKUDVVNhBmrnKc19iMfwJCAj5L4RQLTdDClImFVwzjG7VtHac5Kp
        RtYJNYTXaHV79SokiGv4io2f5xHzPlo=
X-Google-Smtp-Source: AK7set8ldoPFjqGbTtujwy62UUH+LAzHrfMrth501Gur6mUru2ZVCWISA8okhMGgHRUBkyYWSasiXQ==
X-Received: by 2002:a5d:6a08:0:b0:2bf:de97:f3f8 with SMTP id m8-20020a5d6a08000000b002bfde97f3f8mr174292wru.28.1675714859909;
        Mon, 06 Feb 2023 12:20:59 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b002c3e9cce04csm3180724wrt.111.2023.02.06.12.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:20:59 -0800 (PST)
Message-ID: <8f04f2b5-320e-50d4-9517-6dac989f63b3@gmail.com>
Date:   Mon, 6 Feb 2023 21:20:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: mt7986: set Wifi Leds low-active for BPI-R3
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230205174833.107050-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230205174833.107050-1-linux@fw-web.de>
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



On 05/02/2023 18:48, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Leds for Wifi are low-active, so add property to devicetree.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> index 33bd6febc160..2b028141f1f7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> @@ -446,5 +446,9 @@ &wifi {
>   	pinctrl-names = "default", "dbdc";
>   	pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
>   	pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
> +
> +	led {
> +		led-active-low;
> +	};

The binding is missing this property also the driver implements it. Could you 
please update the bindind description properly?
Thanks
Matthias
