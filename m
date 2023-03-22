Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C834B6C47A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCVKaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCVKaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:30:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412820A34
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:30:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j24so7558893wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679481008;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L8nyYvjllegQ+DezE/uQIrYh8wB3PPI7la+fSHq0FZA=;
        b=XVV5EVXqcrnvNsEigJhYfwIrfCx1Apk5YPNrsuNTduVDscLlvD1hwUeZNhCCBD/aVh
         BrSRJC729AEKd1jR8RcHozkjSap3DV6WKBTctNl/MJldJTmZHpn7p31DzfTj8op51ffD
         OqkHr2v4yKM3k5Gf7nJxvbEaDwz8tGpts7iMvyyhC30hwBiQRqJctIYQv87HbqU5fyC0
         pgI+EO3NmhX0uZR10Gq0g22WslrBGNjVe6osv2hFT+glvZhDiv7a+bDGg8P+JJs/qz1N
         3+gwfrsR5gpV0W5reD04ZhsgqTQdbEPJoPGvZjN8mZCIKB1tD8g+XSsUByYEkSEFbG7X
         o1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481008;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8nyYvjllegQ+DezE/uQIrYh8wB3PPI7la+fSHq0FZA=;
        b=b0wLkthWsqofrSw1AcKlHvo2OA/7KXHaOHTfqwhBo/ExVUcA1CO0Dl2N1xBFkXB6YE
         Du4AZcz2O6ABb5Ai2hCJTy2HCoh0/ZpANgrRFe15VJoYz9BXgsBubXhcmm5RisuPIHPj
         SLXG9L/rWQnVpZuQR884DAfYJ9hsIxT0iR5Ck3Jv37T7iKgUoY2tDIWFBPYe1tQzMQ9m
         ArJzd7eT8s1lxyFNLoI8sDdPXTFJ5FznUt6ZJAIPN3PwVB2caPXkRimcBWKLRn4M+u5o
         xc7imO5ghQqrKQK6BISFHbbOKsLX5H/S0NYnpmaq9Z92ks7GwB/PaOzFCuc4CF8mM0HD
         SOQA==
X-Gm-Message-State: AO0yUKVveanxMJHfvZibVz4PsZoWcU5ADxsL6sLdArG4HDvcKhGoyQWA
        sioQ1z4i9UIjWob+Ioer3J6x+w==
X-Google-Smtp-Source: AK7set9K2BHyceKy3BXDDciMyj3suNB4W1OwN6Z2mJKcaD0YTnGqO5egtSXp2F7nHq2zgOPEtHpTCw==
X-Received: by 2002:adf:dc44:0:b0:2ce:ab0a:81fe with SMTP id m4-20020adfdc44000000b002ceab0a81femr4458299wrj.62.1679481008025;
        Wed, 22 Mar 2023 03:30:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3606:a601:f273:994a? ([2a01:e0a:982:cbb0:3606:a601:f273:994a])
        by smtp.gmail.com with ESMTPSA id b13-20020a056000054d00b002da1261aa44sm1864649wrf.48.2023.03.22.03.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:30:07 -0700 (PDT)
Message-ID: <35f8dcde-4817-e5c4-2556-a61572841209@linaro.org>
Date:   Wed, 22 Mar 2023 11:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/3] ARM: dts: meson8: add the SDXC_A pins
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
 <20230321171213.2808460-3-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230321171213.2808460-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 18:12, Martin Blumenstingl wrote:
> Add the pins for the SDHC MMC controller which connect to the SDIO wifi
> on some boards.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   arch/arm/boot/dts/meson8.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 4d18bb4e3c33..4f22ab451aae 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -506,6 +506,15 @@ mux {
>   			};
>   		};
>   
> +		sdxc_a_pins: sdxc-a {
> +			mux {
> +				groups = "sdxc_d0_a", "sdxc_d13_a",
> +					 "sdxc_clk_a", "sdxc_cmd_a";
> +				function = "sdxc_a";
> +				bias-pull-up;
> +			};
> +		};
> +
>   		sdxc_b_pins: sdxc-b {
>   			mux {
>   				groups = "sdxc_d0_b", "sdxc_d13_b",

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
