Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53356E7445
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjDSHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjDSHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:45:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32A7AB9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:45:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso4568755a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681890346; x=1684482346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHFSVmnBHgJzRBucjthBtFRkyCVVu3jxJ7HbaOvsy4E=;
        b=T8rcoi4uc5QP0oaPpPEX3GPlycGGm+btMZffpkKlPXBIHslJgpMyKfjAgSgSkrQuQ9
         i67efb6rK4OtRuL+V7o86Z6wxS2+O1j3qbD+Z4tlBs0vTspsFBN6S5bk3Hk1v0xTWhJw
         p9IoklDJi2wfrflu6v5DMG1Y+oXe990hwU8c5bb6BbVwje7GHM8XaZBLXIJfpTuGMg59
         leb3ztmVa8ZKgT4LKzY9eleB6QnxPYnJ5SeYwT+8s/QJbrS3LRxwLapqOGrmCo6LZwG6
         QNd6ws5PchcUxbifs7rFihHW8bkviUTu4AMJNYEMtWt8n5JEQim7nQq1GwG4h/hYwfun
         zKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890346; x=1684482346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHFSVmnBHgJzRBucjthBtFRkyCVVu3jxJ7HbaOvsy4E=;
        b=NCMlNFuHlqR0WN1fVetyd9BLECDSo/dqWU2BHtMF79HnpP0yEH/foswJfwtlskzduF
         JxBH9Sggu1mzx23Co1uXTMh9FhvdsmtuI/8eMTNsE0fn4fVrSEUmO0gKwdUn9sQvGpgO
         5XdMpJUM8ub9RTkxOZS24etb0AhOEXs6df7a4689h6flftodqR6ykk6TStVrBFAJvd7S
         S97m1pVwdA4Wb5/8XYlJt3uNKTtGQz47eqrae8T7c5GFNktv7d4pcSKSBB7mrFPFpumW
         W3sUmA/nAQTQyAWY9behGTB/rsimIOTZFJyuILYOa3QyLWDqHurDexnofKFo1wHgU5pG
         TfqA==
X-Gm-Message-State: AAQBX9dMhq7wQEBBizmPb0k9CboRVa/LL6H781+i3moZCXuSieBmuBRo
        7vFIIyoHlqM9HXVHsclWSpPIfw==
X-Google-Smtp-Source: AKy350bVuPcsEqrtDM1HSpKOyU4PTGA+UlfcRFz4jC16pTIUyqVFZK3mTqMzBmOidShsowjMkarm/g==
X-Received: by 2002:a50:ff07:0:b0:506:beb5:7b4e with SMTP id a7-20020a50ff07000000b00506beb57b4emr3532896edu.8.1681890345754;
        Wed, 19 Apr 2023 00:45:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402124900b0050488d1d376sm7937321edw.0.2023.04.19.00.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:45:45 -0700 (PDT)
Message-ID: <9557633d-efe0-4292-391c-9ae23c53c2dc@linaro.org>
Date:   Wed, 19 Apr 2023 09:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Content-Language: en-US
To:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419073834.972273-2-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> No functional changes introduced.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  arch/arm64/Kconfig.platforms | 12 ++++++++++++
>  arch/arm64/configs/defconfig |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 89a0b13b058d..bfbc817eef8f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
>  	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
>  	  & MT81xx ARMv8 SoCs
>  
> +menuconfig ARCH_AMLOGIC
> +	bool "NXP SoC support"

NXP? There is already amlogic anyway.


Best regards,
Krzysztof

