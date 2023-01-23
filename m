Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4826776CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAWIwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjAWIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:52:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583D1E5E8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:52:35 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so7975026wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr7vqvJVlpxRui+FUTfQy19pwuzQyDWhmumOiFPc8HU=;
        b=qNh+xE+SKgb/0+aKHDKMwJKLe0v70rfrsroEg6aJ6Wh/HJq+xIRcmt67mxWq/f78GJ
         60yfbe6sd3TwEZzvll039+oQJXQfvgxNehZajtXkxOOqE2HIsMp8yZXKRXrgMZZUPQwP
         GPHKGr8N5CodfZwiJiy6KLHXF10gJ3ZRowZDe0QPj4wqwmwkCG3gN1WITOsdmwNQu1FW
         22lNMT3635c6DxsDHOmC1Df5oMWO7YpvkofaY+zT9Bg8nSEzMcuc2truGIBby3BNA2GN
         WByd87iq9Lk6yuhX77fIi24IxQqJxOJIP+6zAJNN+v//AEO06m0PdangexrnhH0Ghgpy
         tefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr7vqvJVlpxRui+FUTfQy19pwuzQyDWhmumOiFPc8HU=;
        b=BqWgll8VFKg0NH7Krq6VQtuc7sCVYNCMp1de+dX9YPp1gB+Ww3YnsYrt/78N0zmJQc
         WyOpiRlh3Xp7TO+yOPb6cJBjToO3GY9tog8iXfb0zixfVhekKftWSgeufaqDC5U/ovcf
         sntUgRLFdOR8gZsT+OllAGO937I21nBEMfYwcoKJLfn5uH3GVxDzb9Xu1ECksnJ+Nx6q
         f+S1CrHEQoL1pC5nVIgkLGL2GOqvcsG7cnUuVytt0hYCvsDUz4Ack+DZ2P4xYOA3mjKv
         88umW/lgD+cs4iai7nDLUilGJiudhPZ95vxhOmJ2akxfW+XcsBSpD5j8MYzJ1Zit2Aiy
         Ifxw==
X-Gm-Message-State: AFqh2kqJuAhICfe1obrtsjgqdpbIyFfzkRmjv8Y/g1M/zDnYg2/oorQ7
        2kAcrDQRQkaR/daiLhTLL2hn4Q==
X-Google-Smtp-Source: AMrXdXsuae/e8VvvaHB4ifPigkBADdadOBuacj2j0C3Qi498flwkbacYg4v6ep4izvFrr8mLm/GwVA==
X-Received: by 2002:a05:600c:3b1e:b0:3cf:497c:c4f5 with SMTP id m30-20020a05600c3b1e00b003cf497cc4f5mr23381074wms.13.1674463954095;
        Mon, 23 Jan 2023 00:52:34 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id n9-20020adf8b09000000b00241d21d4652sm3875418wra.21.2023.01.23.00.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:52:33 -0800 (PST)
Message-ID: <42bbccf4-0ebe-ddfd-69c4-9cf26dce3ccb@linaro.org>
Date:   Mon, 23 Jan 2023 09:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] arm64: dts: meson: remove WiFi/BT nodes from Khadas
 VIM1
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123065504.2669769-1-christianshewitt@gmail.com>
 <20230123065504.2669769-4-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230123065504.2669769-4-christianshewitt@gmail.com>
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

On 23/01/2023 07:55, Christian Hewitt wrote:
> The Broadcom WiFi/BT SDIO nodes are now inherited from the P212 common dtsi
> so we can remove them from the VIM1 board dts.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts    | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> index bee51e29015b..2f88f78de5b7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> @@ -220,21 +220,6 @@ &pwm_ef {
>   
>   &sd_emmc_a {
>   	max-frequency = <100000000>;
> -
> -	brcmf: wifi@1 {
> -		reg = <1>;
> -		compatible = "brcm,bcm4329-fmac";
> -	};
> -};
> -
> -&uart_A {
> -	bluetooth {
> -		compatible = "brcm,bcm43438-bt";
> -		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> -		max-speed = <2000000>;
> -		clocks = <&wifi32k>;
> -		clock-names = "lpo";
> -	};
>   };
>   
>   /* This is brought out on the Linux_RX (18) and Linux_TX (19) pins: */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
