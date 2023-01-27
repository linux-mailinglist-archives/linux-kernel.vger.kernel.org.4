Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FC67E66C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjA0NTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjA0NSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:18:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0213D7D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:17:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id fl24so3435354wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PHUtNK1QUcmBWUA4niJy/dtuN1rM7eN2dajThZv9k/I=;
        b=uff7J6FNTNQnfTZKcq9sgfIV6BLs3iEe1qO6Nkjx9qHu/qaIaBQc9wSYwLC5MuiegX
         pdQ6gcVnlPa0GluVqhZKtX9oM+Tb3O4H3AKaHKL4BM0NRG4JpIb59n9LQsvem1VMIFPw
         CQl27+lZKSq05ZqTSrjqh5aXL5L3lF+dypYSIZaWJWbn+2O4UgGHkmnTPY/Y5E3nlMXJ
         sDkgm7vx7Rvqu1pLHI9FLr1xUUF7jj1Uav6476xM2kKTHUEq3yABJXAg2S0UKSO2Lvy9
         1qnBTTbBzFZcn9beeD3yZ6boQmv8f1uhgip+Ep4vQii4VGsvE+VsDr6i3ztd6EWNqgaq
         B8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHUtNK1QUcmBWUA4niJy/dtuN1rM7eN2dajThZv9k/I=;
        b=KF5OK6INxGy+tAemk4KyCD9tDjwA/3P7AI7h4E0e5xf3rbTLcUb5ZAw44gMkgenjBZ
         lzl6RVxPNzR061WRZ6LQjO8YE9N/lWSDk1wBknZAKtyG/EESVz45a4Kv/NiulIJZTMxy
         Zn+fjTZAnIbwNFkFWvaKvlMwEkdjTyosvsidiZYL1Ddh/17kW1+YIcESdxL9T+4oYXpU
         L8HXmEKrTdaAtcZS6zJHat9Npfx5pdhUo40K8qGkZDLwc09wZqSltraq0wKlzG50vLZR
         DFaZ22dmm45eKW4wDdMGd41J8NY1TiR1lBstgYi3ALH/AmL+QEcbDY88J0RebnaaleME
         JGhQ==
X-Gm-Message-State: AO0yUKUHU2yzEBqjKpeXoZ0sIaVkOqyJNTjvJ7MvJffR/X9MMtjqpFzF
        4eo4EqHW79tivjax3rMuWDuVxQ==
X-Google-Smtp-Source: AK7set+Pxyqp8I/31T+hmD4efINPIHybA0/rjg7Snx1FZ+sWFgsJRDV3DN4kYihRGmgXKAJgOhlsgw==
X-Received: by 2002:a05:600c:4494:b0:3dc:40a0:3853 with SMTP id e20-20020a05600c449400b003dc40a03853mr803614wmo.11.1674825467622;
        Fri, 27 Jan 2023 05:17:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6? ([2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003dc4050c97bsm1003279wmq.3.2023.01.27.05.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 05:17:47 -0800 (PST)
Message-ID: <a4b6d79f-972c-9169-16e0-b930e2c15c51@linaro.org>
Date:   Fri, 27 Jan 2023 14:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: meson: radxa-zero: allow usb otg mode
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230127103913.3386435-1-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230127103913.3386435-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 11:39, Christian Hewitt wrote:
> Setting dr_mode to "host" prevents otg which can be useful on a board
> with limited connectivity options. So don't force host mode.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> index e3bb6df42ff3..cf0a9be83fc4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> @@ -401,5 +401,4 @@ &uart_AO {
>   
>   &usb {
>   	status = "okay";
> -	dr_mode = "host";

At some point we would need to add the fusb302 node to have proper USB-C PD and mode switch handling.

Fixes: 26d1400f7457 ("arm64: dts: amlogic: add support for Radxa Zero")
Acked-by: Neil Armstrong <neil.armstrong@linaro.org
