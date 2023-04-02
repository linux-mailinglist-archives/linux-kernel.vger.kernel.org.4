Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF76D397D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDBRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:38:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7183E8;
        Sun,  2 Apr 2023 10:38:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p34so15769542wms.3;
        Sun, 02 Apr 2023 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680457079;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAKxm6MzCphy5Z2gvE2Jr+LH4ajwExyKc8Eoh3hOm1A=;
        b=dtm9ymYqBU5D/2K0eq/oNxuYV0djmKwUOmlQ0PWCBYr+JSm412ciULUeuUFZbq3vL/
         cnuDuLULPh2rOEAY5MVcLpn4WACpjF0ENO5xN1gAqBurSRfYMHlceYlp81tL3Co5ZBbo
         v1Ni3ifdgStxMXh2hB79hbUrh3XcV3dsefBjEYMkU+Y3zThU7XLx5QDkPOtiXnI84Zl4
         vu/W8b/gCRhsOTv0KmOY24HdK/MHDWS/6W+C2dVnWXlgRT757bTMxD5eYsghoYZmVZXm
         neFvBoR5cMRKmlxnT9Qbact8NIq7e4QloBRZmrXRXiIuCMrnVlJCUPFzQaiEAhj8czdx
         GqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680457079;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAKxm6MzCphy5Z2gvE2Jr+LH4ajwExyKc8Eoh3hOm1A=;
        b=24SI2DNcxaiSkl33lDZXlZtkd02O6Tb+E3U235oKTcRfHlL9SFmQuFA7WoPcQuDy+L
         2zffpIPU2glOVBewTyn/iu/K45wdehpqVgdwbBa0VzAY/vs4ifHLPgHN/BuGEUWnVyZ8
         jt0bd465Dbo5UZC2AABYuIaY9tuSvttb0zt874jMN+nspPrfkADLc67orWSut6IIRaNY
         6B/J09wATinHWCxaREoX/zLU0tiBvrOvOlAS6JqD5zk7nfuu6z1ouIX7HYgERQIp7QU1
         acft7s0k0YzC7woTvO8tdcDkgXN/OHlzFXZsCy01ja2DH9jCbDEsqc6WjASzn7nk+Chh
         4pFQ==
X-Gm-Message-State: AO0yUKUFGXXrbBXag/4Kzng/R1TsyhkeuPg+S8BfbbUbeRl+snqgzJIV
        HMh8Bs15h+r4mWedZNFJzO8=
X-Google-Smtp-Source: AK7set84pyQWNwhP6zk2k0vqJMXn1mqREdZavTBb2sWu3uESiHjFSV4SYgnJic1228mXwbwRwdDCJA==
X-Received: by 2002:a7b:cd87:0:b0:3ed:de58:1559 with SMTP id y7-20020a7bcd87000000b003edde581559mr26298914wmj.2.1680457079332;
        Sun, 02 Apr 2023 10:37:59 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003ee8ab8d6cfsm17066115wmn.21.2023.04.02.10.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 10:37:58 -0700 (PDT)
Message-ID: <0b743983-1534-d860-5ce8-7fcb67382474@gmail.com>
Date:   Sun, 2 Apr 2023 19:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173: correct GPIO keys wakeup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230304123301.33952-1-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230304123301.33952-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2023 13:33, Krzysztof Kozlowski wrote:
> gpio-keys,wakeup is a deprecated property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index d452cab28c67..d77f6af19065 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -58,7 +58,7 @@ switch-lid {
>   			gpios = <&pio 69 GPIO_ACTIVE_LOW>;
>   			linux,code = <SW_LID>;
>   			linux,input-type = <EV_SW>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>   		};
>   
>   		switch-power {
> @@ -66,7 +66,7 @@ switch-power {
>   			gpios = <&pio 14 GPIO_ACTIVE_HIGH>;
>   			linux,code = <KEY_POWER>;
>   			debounce-interval = <30>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>   		};
>   
>   		switch-tablet-mode {
> @@ -74,7 +74,7 @@ switch-tablet-mode {
>   			gpios = <&pio 121 GPIO_ACTIVE_HIGH>;
>   			linux,code = <SW_TABLET_MODE>;
>   			linux,input-type = <EV_SW>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>   		};
>   
>   		switch-volume-down {
