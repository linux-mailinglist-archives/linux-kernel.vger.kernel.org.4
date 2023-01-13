Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BBE669616
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjAMLwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbjAMLwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503E395EB;
        Fri, 13 Jan 2023 03:49:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q8so3293054wmo.5;
        Fri, 13 Jan 2023 03:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWKzVegiwa5Stk0wIV2Qox87RUsnW7KUMQyCCHGUjVY=;
        b=b9fmNtI/tk6TKyJHc4xoLPUwo1opwIrOQKmPPAFlzOTurbE31JKpEAE3F0o2WYXW17
         ojcVxoGg8MGLM+1Nds5k+KvjWzddVBq8sdvsLeAn3MOhSUllRWONR/sjKjcgq01VC2Wr
         ozVYrHBTUM081VyR5KFTkGSvvzTEcmhWaE7Z7r9LX9IQYrytDcL/duYthYIK2/Wxn9U6
         0jRE2l/GGk5ToTAwnUZXsO6jsxj2CGR7nYhvywFyoFbTzRK1/wHN4UXG4l8Xc/g1pcLA
         NaDVTAwp7UoD/3y3W56jEmtnqPo2zwvNxmDXRYg4ID2BdM6O79Wr+5EcNjRLLjRUnELr
         pWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWKzVegiwa5Stk0wIV2Qox87RUsnW7KUMQyCCHGUjVY=;
        b=u5ZjyF0TBhvTLVEbMd9QsobezTJvxkV8r1ubZem9/Zf4b/eTE3+NBPKC/DbrqHhxs6
         pv6On+2WZflaQf9tqdQrYkjFLSKoI7w0PD7XuRSpkuYCaiu/KoEJvox4l5OKsgpdOK7C
         hu069ZBslW6do3cbExPTCWVLSx3LCrpKHJI8Lwdz+raXqr3EE+kEUasfXEx984f/Tso2
         QtHBV4LILPI3CDD5XM5TCGOBL5WENOqAkuE6yML3eegsjhOHCXA3cCqSYf6ertpzuEXL
         UoKFsnLO5loaLKYkKXqidpuWaBcK6kVCMcfisfhv2DDGYrYUYmre9Gcgug7lMlIr4k6m
         futw==
X-Gm-Message-State: AFqh2ko7YHOeAt4SFbeyN9MtWlOsF1a3k9JP8wGJd8Lj1nFEuqG+Ime4
        gcsxwkK/FGcKjyRanPDpCM4=
X-Google-Smtp-Source: AMrXdXt/Srf7GhPk4XgIqbIIDQBdXs0//l9o+N1sHwWkEw1BEj3pon5jHwUtTE/D9v/Bo5fllTCL+A==
X-Received: by 2002:a05:600c:34ca:b0:3d6:80b5:f948 with SMTP id d10-20020a05600c34ca00b003d680b5f948mr58668937wmq.39.1673610591416;
        Fri, 13 Jan 2023 03:49:51 -0800 (PST)
Received: from [192.168.0.30] ([37.222.254.155])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c3b0500b003c6b7f5567csm2597704wms.0.2023.01.13.03.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 03:49:50 -0800 (PST)
Message-ID: <daed4793-3aae-f927-5634-cfb876709f93@gmail.com>
Date:   Fri, 13 Jan 2023 12:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 6/6] arm64/dts/mt8195: Add temperature mitigation
 threshold
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-7-bchihi@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230112152855.216072-7-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2023 16:28, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> The mt8195 board has several hotspots around the CPUs. Specify the
> targeted temperature threshold when to apply the mitigation and define
> the associated cooling devices.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 153 ++++++++++++++++++++---
>   1 file changed, 137 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 683e5057d68d..0d6642603095 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -14,6 +14,7 @@
>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>   #include <dt-bindings/power/mt8195-power.h>
>   #include <dt-bindings/reset/mt8195-resets.h>
> +#include <dt-bindings/thermal/thermal.h>
>   #include <dt-bindings/thermal/mediatek-lvts.h>
>   
>   / {
> @@ -2413,107 +2414,227 @@ dp_tx: dp-tx@1c600000 {
>   
>   	thermal_zones: thermal-zones {
>   		cpu0-thermal {
> -			polling-delay = <0>;
> -			polling-delay-passive = <0>;
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
>   			thermal-sensors = <&lvts_mcu MT819x_MCU_LITTLE_CPU0>;

New line here please.

>   			trips {
> +				cpu0_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

New line here please and on other trip point definitions.

Regards,
Matthias
