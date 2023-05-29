Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13B714E04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjE2QQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjE2QQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:16:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB9ECD;
        Mon, 29 May 2023 09:16:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso36397715e9.0;
        Mon, 29 May 2023 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685377002; x=1687969002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6oEUPyDe6k6imC6sIUryh04ys93Tehf8o/RTmSion4=;
        b=ICGdINm3mLMU2/7rwAV/0Uxi8M0SM8JdOb5gppFed94uXWCvdHUrPYCrJ8BWcjHlHe
         zctcq0JIwa1/vkGO+PDpbS9q4f+v1BK7wP70DJpqDTv4buctUfZPm2jIW3lj4Jplzk9C
         +oDvhJRoPROvApnrOheaSI7bfAykBSIfG1jg9k/qo5HYWJIkfh0tYEgASKds60omE4rc
         GvylKXZhLyK/p/9sA+NKIfVvxMn98vDZEkQ4ptNIArNgP3fvudR20uWicFqt6A22EKOg
         zZvSoT83TWa7GFqfQcbKZeUsP94FZpGH8J01x1ilR94gyGbGLPke/awnY1Rlm+XjMelM
         TWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685377002; x=1687969002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6oEUPyDe6k6imC6sIUryh04ys93Tehf8o/RTmSion4=;
        b=kL5CpLqiT4BdyNdMmOn/NLI0LqV8P+iZZv0+lk4wyB9foGS6UahU63QOop/59b5KSo
         zWc+w+9pqmwcKdGjG/hf8069kCWdHxcpMRcdnH301G7nCcIpwhiifBssbOKAHicXWIee
         E8XI+2HVguQEnzOiQOaanY6OjWuMKyeEKelnjNH/SymfFQZd7nuOuRDUv7VrrGA5bi0/
         ExzTNEuc0pDBL9Q/2Qxm9wnWRi524qgNPbzPouSEjVN/iwACHhBMJEpMEjoIGnQcSjH8
         SV/eIEGAWvFwOU8tmyryQ3M/Lp+MQJ6ES9bCnf+E4/caWJeZiCHHsVFOm1EkD4meCjaj
         +ISQ==
X-Gm-Message-State: AC+VfDw+JutjIX33ND0osAyLmarp29W1fDQhwcMPVVmGhqrfNqrXESHA
        5Le2qkqG+e5VERkGmtFEFpU=
X-Google-Smtp-Source: ACHHUZ75AMsCYyTd9+rBATqxtSpmcQNLV+356SY+CSM0VG6B9tAy5IrbZs0dtJ5u5DjvQseiEntplw==
X-Received: by 2002:a1c:4b10:0:b0:3f6:e79:3a8e with SMTP id y16-20020a1c4b10000000b003f60e793a8emr10807728wma.12.1685377002522;
        Mon, 29 May 2023 09:16:42 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000180700b003062d815fa6sm394876wrh.85.2023.05.29.09.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:16:41 -0700 (PDT)
Message-ID: <abef0fe6-ef80-283f-cfeb-e0a4366691fb@gmail.com>
Date:   Mon, 29 May 2023 18:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: mt8173: Power on panel regulator on boot
Content-Language: en-US, ca-ES, es-ES
To:     Pin-yen Lin <treapking@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Doug Anderson <dianders@chromium.org>
References: <20230417123956.926266-1-treapking@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230417123956.926266-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/04/2023 14:39, Pin-yen Lin wrote:
> Add "regulator-boot-on" to "panel_fixed_3v3" to save time on powering
> the regulator during boot.  Also add "off-on-delay-us" to the node to
> make sure the regulator never violates the panel timing requirements.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Applied, thanks!

> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index d77f6af19065..03d1ab2ca820 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -96,6 +96,8 @@ panel_fixed_3v3: regulator1 {
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
>   		enable-active-high;
> +		regulator-boot-on;
> +		off-on-delay-us = <500000>;
>   		gpio = <&pio 41 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&panel_fixed_pins>;
