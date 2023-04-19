Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13E6E7751
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjDSKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjDSKWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:22:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2964C22
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:22:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o29-20020a05600c511d00b003f1739de43cso1162798wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681899756; x=1684491756;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fU2wrMIC42PqEyjIjG+AcTqJMu7tdAgxZ3YGA63S+ss=;
        b=RweJHU7K9YVIDRY8mwPkF0JFg0GxNdl0lmXPL7bK3kiIdciBN9YA/Gh8LWECNT83yo
         RXe2GiJ3d//2Xa4JrXfrgPvdw+spLWr6FLHiH0VMAaXngZ9xK4fxT+3w/JO6wm1dHc5f
         P8DDymRsMcE+mSRstLK/H8DVn96DQrZbFQjEXOi0vrCg0+OrjqOOz3q1F8L8YtJSsyQo
         ZUqLsuNjGPmTEHP1SSXj/Fjwozq+fCTgSsFP1REckJvCYVP+/ENvaM8lfCoEmmUEft3i
         k6juegJ0t7BX2Q1H2+4y0NnzV+14pnVHoHDAU9V/Iqh7FE7paFYYcKv8TSSOuvVMzw6Z
         lA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681899756; x=1684491756;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fU2wrMIC42PqEyjIjG+AcTqJMu7tdAgxZ3YGA63S+ss=;
        b=WFYSuZuHqXmATiUIBkAGYHsTGbMVqX2BAy2Vn0mVeoiKKiqy/I5Nk7NHeyChwczYRi
         q11N24/dmtz1shSQiIDdm6+1mvWEUsaIJEqACa+7pXrDUdj4Sr7fb+vj4Lwy/WT00/cK
         GHz0jbhqD7G1owewuLNbOaUMvHwo3Lbx28FQcJUhNbUxPX0SguGU6JXV41YMGVZSsYWX
         jZkQrZSjqb7qYfQZ77mRrNERFRMjIGAAjHqS4JWFfR9wiS9NB2jqFgU30WaHoD88tOdo
         Q51aUFQwysE4CizUB5maq+CYXXiIHdcNoPeeqp0ik2PbcWo5qBAE9U++lJ6dCpvy2hZr
         AGvQ==
X-Gm-Message-State: AAQBX9f7MiVsOQm0/UKzG/RVx7SKWqxUqvYf2aymIDeV2JQ+dPnQRlFB
        QJjuU+ckPE75wGUCgSMxVmILJg==
X-Google-Smtp-Source: AKy350adVq+0Enif94wp4RhcZ0STlydhZB7rHzAw+LUwH+tkkZJ5nZxGpmn1sKzin3LOW8z9QJJ8Jg==
X-Received: by 2002:a05:600c:284:b0:3f1:819d:d046 with SMTP id 4-20020a05600c028400b003f1819dd046mr1102778wmk.5.1681899756569;
        Wed, 19 Apr 2023 03:22:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1360:9fbb:dfd6:2db4? ([2a01:e0a:982:cbb0:1360:9fbb:dfd6:2db4])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d6a89000000b002cf1c435afcsm15475539wru.11.2023.04.19.03.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 03:22:36 -0700 (PDT)
Message-ID: <2804f8ba-e0c5-554b-645b-20320fda89ae@linaro.org>
Date:   Wed, 19 Apr 2023 12:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Content-Language: en-US
To:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230419073834.972273-2-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/04/2023 09:38, =Xianwei Zhao wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> The C series SoCs are designed for smart IP camera
> applications, which does not belong to Meson series.
> So, Add ARCH_AMLIPC for the new series.
> 
> There are now multiple amlogic SoC seies supported, so group them under
> their own menu. we can easily add new platforms there in the future.
> Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.

There's no strong reason to add a new ARCH here, apart willing to kill
the MESON name, but it's usual to keep a arch naming from the first
SoC family supported, it doesn't mean the new aren't supported or
whatever, it's only a simple config name.

I understand the new SoCs are a new family, but they still share a lot of
IPs and driver that are present and supported on the Meson SoCs.

Please concentrate on adding the DTs and compatibles, changing the
current config and driver names is low priority unless there's a really
strong reason.

It's perfectly ok to drop meson for new configs, new driver & new bindings,
and it's already the case for the A1 SPIFC driver and most new G12/SM1
compatibles.

Neil

> 
> No functional changes introduced.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/Kconfig.platforms | 12 ++++++++++++
>   arch/arm64/configs/defconfig |  2 ++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 89a0b13b058d..bfbc817eef8f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
>   	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
>   	  & MT81xx ARMv8 SoCs
>   
> +menuconfig ARCH_AMLOGIC
> +	bool "NXP SoC support"
> +
> +if ARCH_AMLOGIC
> +
>   config ARCH_MESON
>   	bool "Amlogic Platforms"
>   	help
>   	  This enables support for the arm64 based Amlogic SoCs
>   	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
>   
> +config ARCH_AMLIPC
> +	bool "Amlogic IPC Platforms"
> +	help
> +	  This enables support for the arm64 based Amlogic IPC SoCs
> +	  such as the C302X, C308L
> +endif
> +
>   config ARCH_MVEBU
>   	bool "Marvell EBU SoC Family"
>   	select ARMADA_AP806_SYSCON
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7790ee42c68a..f231bd1723fd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -46,7 +46,9 @@ CONFIG_ARCH_LG1K=y
>   CONFIG_ARCH_HISI=y
>   CONFIG_ARCH_KEEMBAY=y
>   CONFIG_ARCH_MEDIATEK=y
> +CONFIG_ARCH_AMLOGIC=y
>   CONFIG_ARCH_MESON=y
> +CONFIG_ARCH_AMLIPC=y
>   CONFIG_ARCH_MVEBU=y
>   CONFIG_ARCH_NXP=y
>   CONFIG_ARCH_LAYERSCAPE=y

