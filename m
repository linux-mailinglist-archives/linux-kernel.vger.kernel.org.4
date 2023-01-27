Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519E267EAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjA0QXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjA0QXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:23:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F283248
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:23:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d14so5430993wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OFZ/BTQfLUI4AMEOvHlW0oDJVdmzbciPT1PhvmheSG0=;
        b=Xijd+vNgyTj7S9rsA6yloLjWak7DQEZFGDKEiucPfNb0lKVu1UOC8FarbM8rq7Sp1H
         aIYWoVjWfDmhzIZqWFkHuc2jUBEXbBr9B8+Dlsdf1hENmYvdo5h3AJmz/r27Iu/aLrMc
         CZ5cDNSEiKVRainkE+lLmXjLvucyi1FzR91rmOtY0vDV5JMV67rYTHJoWRlpKwq6IFXH
         xlzlRMgD4Wypwux38lHdNS6BR0wrQ/pjATJrqLCSFHGA9nE5R2zRlZyn+T7XSxCDNruq
         RYgF7+KF+YCyBkKVthnqoiizKTOev/UJf7Pr82LImqGPGKqpjr/NDzooqPUvh/p6GN1O
         ys/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFZ/BTQfLUI4AMEOvHlW0oDJVdmzbciPT1PhvmheSG0=;
        b=NESax6tUby6A0qB+eR/WdSeR80u3JPGperVr4kl+BVa4K/YPYjWvLGuBPFMBQ1i7tg
         HSQN2yhidcy/crXhz9dkdmctIbREYFsC7le06NROzpiTtnEaVRTQcynyquOPIwnjmGA1
         Ma4mHoxBK/x2OG1BFGnRWcc5MfFxPFvS64c0os6wH+ulODpLl5pZZe2J2ys07/GLHbKA
         ZcuE9P0+jWdAz/3sU5iaJQtd6y/fYthArPykGIEfP1rvk/T5Bhd4fgPyBbqS8OMxP1Ie
         Vjp6Eh3XVqXSxaDpokWCwBmQSemioZjoVTCcaAKmnoAq9z2dBQFmpoy9lwlIDKmsFMKh
         3jnA==
X-Gm-Message-State: AFqh2krFGxqTiUHW1pKH7w8rqS3tMMGaJK/ERKpsq0wuPhZKn/S1Z4ar
        rzN/EQJBviW9/rwD2ZNLizRlnA==
X-Google-Smtp-Source: AMrXdXsICGx9XFP2osGdhhQ2tv0Rnw7eemSj1jTTYkvE8MHdg+ouYA9RBSEukdfnlM1B1j1yOMEHwg==
X-Received: by 2002:adf:e0c5:0:b0:2bc:8074:b702 with SMTP id m5-20020adfe0c5000000b002bc8074b702mr36680743wri.19.1674836625714;
        Fri, 27 Jan 2023 08:23:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6? ([2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002bfb1de74absm4466462wrj.114.2023.01.27.08.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:23:45 -0800 (PST)
Message-ID: <24c7e160-762d-61f9-1745-4d91a29ff0d6@linaro.org>
Date:   Fri, 27 Jan 2023 17:23:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/5] arm64: dts: meson: bananapi-m5: switch VDDIO_C pin
 to OPEN_DRAIN
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
 <20230127142221.3718184-2-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230127142221.3718184-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 15:22, Christian Hewitt wrote:
> For proper warm (re)boot from SD card the BPI-M5 board requires TFLASH_VDD_EN
> and VDDIO_C pins to be switched to high impedance mode. This can be achieved
> using OPEN_DRAIN instead of ACTIVE_HIGH to leave the GPIO pins in input mode
> and retain high state (pin has the pull-up).
> 
> This change is inspired by meson-sm1-odroid.dtsi where OPEN_DRAIN has been
> used to resolve similar problems with the Odroid C4 board (TF_IO in the C4
> dts is the equivalent regulator).
> 
> Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> index 028220ed45ad..3c1267a7ffef 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> @@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
>   		regulator-min-microvolt = <1800000>;
>   		regulator-max-microvolt = <3300000>;
>   
> -		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
>   		enable-active-high;
>   		regulator-always-on;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
