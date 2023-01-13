Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B62B668FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjAMH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbjAMH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:58:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568F48590
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:58:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q10so947902wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lTgLjRFwV0QhSHdprvNXbaq1wi2uRVNOBcOLztOH9/0=;
        b=I+gqAzHM6C30XEAOWia99D44uThsNdYvbfowSG6sF3EujrvgynBowmkyfAhu5lvhoT
         R0xRIYj8E/06u2Avm4MfpAPgC8uoPKNpSPlPD7wTeuYLG8JskFQq0MnY6J/HkYBeMDyA
         8yTJeKqclR1+6rU+6Xx9gmuoXx0tNtUMVt5mxjCpEaD6rvXBHuArGgmd9+5Gy5I4UN57
         qEzqmc5CJRTY1LdDl4sSM3EWTm54sO4XHudG6CLYgMxG1A9efPEHrn2dd2CVckF7t4lD
         GybDSWWXnUgGESaawqbN2AT4X9bGodydoBjwcCfYIRQgETaNb5GAJxoS+nawEFYo9akr
         XbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTgLjRFwV0QhSHdprvNXbaq1wi2uRVNOBcOLztOH9/0=;
        b=ZAL/NpCNFjB0VcyJSznUk/UG6qV394rhsPYWSsb/uPQRXYBw0txpRyFFqwm1nhULwW
         L2J9BvONgbWDezjljr2O4kgun4q6AyEom1GMbHXr7coxIv10EyyIS6smjC74/dSPHGfN
         Uy7xxbops32REl75zAjd5I6Zu3YSFBCWiW0NfRTGjWRzOwk9gKacr1EVmSFci7JTBU8J
         xHHf397uaCKyr0jEBNnKLzmfXJIKrXjxXuKcTjUMCfDrVeQNXVE/gc0lyLeRhew/XZ8y
         8ud2xoHkBRnmkSkXumTleTjGvkZVneltseJMmM4BExEQlW3ld6zpEGjeX7KuaWRfB57U
         KYjQ==
X-Gm-Message-State: AFqh2kroe5wm7Q8F0nCkJ7TYsDfOHI/9D6cG4dI2TuW2lUR/JYIOTBpu
        BgBTh/z5Z4kwFY7eJT3nQ3plIQ==
X-Google-Smtp-Source: AMrXdXsF7us2r024+S7rzyBVhUmJScL/OfBzv9LEBf15jWE6PgDeTctsRrI4RgV/BTJVF6hnJP25LQ==
X-Received: by 2002:a5d:5405:0:b0:284:8a24:59e6 with SMTP id g5-20020a5d5405000000b002848a2459e6mr37484436wrv.3.1673596725631;
        Thu, 12 Jan 2023 23:58:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb? ([2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm18445057wrj.2.2023.01.12.23.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:58:45 -0800 (PST)
Message-ID: <c8057da5-fa0f-4801-a3b9-12b9215bc29a@linaro.org>
Date:   Fri, 13 Jan 2023 08:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/6] arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC
 address node
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Vyacheslav Bocharov <adeep@lexina.in>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
 <20230111211350.1461860-2-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230111211350.1461860-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 22:13, Martin Blumenstingl wrote:
> Unit addresses should be written using lower-case hex characters. Use
> wifi_mac@c to fix a yaml schema validation error once the eFuse
> dt-bindings have been converted to a yaml schema:
>    efuse: Unevaluated properties are not allowed ('wifi_mac@C' was
>    unexpected)
> 
> Also node names should use hyphens instead of underscores as the latter
> can also cause warnings.
> 
> Fixes: abfaae24ecf3 ("arm64: dts: meson-gxl: add support for JetHub H1")
> Acked-by: Vyacheslav Bocharov <adeep@lexina.in>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> changes from v1 -> v2:
> - Added Vyacheslav's Acked-by (originally given as "Vyachesav", but my
>    understanding is that this was a typo
> - Also replace the underscore in the node name with a hyphen
> 
>   .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> index 6831137c5c10..270483e007bc 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> @@ -90,7 +90,7 @@ bt_mac: bt_mac@6 {
>   		reg = <0x6 0x6>;
>   	};
>   
> -	wifi_mac: wifi_mac@C {
> +	wifi_mac: wifi-mac@c {
>   		reg = <0xc 0x6>;
>   	};
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
