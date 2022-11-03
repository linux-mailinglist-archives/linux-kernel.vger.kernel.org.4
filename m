Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8076184C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiKCQfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiKCQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:34:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5AD1DF23
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:33:00 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x21so1518176qkj.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKUFy7ieLF5LsV/tUUgZVZtMlIYHNIb+otGAUnhMelU=;
        b=IamZAUgJg0IXAd4USwAjT5ZVQ8xTLKBUgUKDR8JA/fKfgQ0LwEwruIj7GQtAy93jKz
         7KPDfurJsfUro8NuhfcsJqTjK1gYGUoFnZ7Q0f/alKn+aOdlXYAUaDTHKD5R08ilNbDB
         9R1F6fvIUqh+/tVEKZ7tN99fj0/Fp9KZvo3uw3AJ/PxGLw1X4trHHwN9FXgefABFVuUS
         kcgBfxZTXuGPLwM1RNY+Ffe/YeUSkdPaBpEwd+KYVAVKUH8NpodXTXuD7dShHCunYbgq
         tOJNaDwSSpop2KZex1SVWKGvf+idhPavQ6DutT4jq6BXaP7rDRpCMo08Pw40zOSISfe/
         CneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKUFy7ieLF5LsV/tUUgZVZtMlIYHNIb+otGAUnhMelU=;
        b=RL0rboKFJEPo+ufy3NdePDeXJAhTjAafJ2m9qXSFp3ggvvIXKUZBj7M3Mg7azVr7hP
         +a1E4B+0D02foA6XIgsfPJ048Usv3W1v4L7NLK9ZWopiF0IL6d4YbWc6KXyE+g699vdE
         UHyvh34fej/c9PsexaQeEITKMnvxgUyUdia8d1V4+oY1Vfm23vFXupIdb25a/yxdNhvg
         L8lBELgELixVuJQZG+KrFRkQYx3Wj5ashQYG1TiM2LZhY1popMeWyGARwHEJhqHE0fbF
         1e5InwwZ2M0rE6LEu+OVhm4ub97uGun4VQ7fBViISzvix/tTEckZXVJF/w0zh/RbCBfZ
         TROQ==
X-Gm-Message-State: ACrzQf025Dc9d+iCOzueuVUd9k3BNnjicOR8lY0Kw9baS3cDxY9Z0QQ+
        SYynJaWaZIItcr3xafeUiMZ2AA==
X-Google-Smtp-Source: AMsMyM7u/7kABK8eTzftwB5GlQ2WHsPpYG8n1Mx/V5Muo7sySe6zOp+2bo/Nbr6YpLLWyqANV+zpWQ==
X-Received: by 2002:a05:620a:ec6:b0:6fa:1c5b:2be4 with SMTP id x6-20020a05620a0ec600b006fa1c5b2be4mr20378775qkm.85.1667493179131;
        Thu, 03 Nov 2022 09:32:59 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006fa2dde9db8sm1033150qkp.95.2022.11.03.09.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:32:58 -0700 (PDT)
Message-ID: <a3dee3e4-a245-3198-301e-b1812bd6983c@linaro.org>
Date:   Thu, 3 Nov 2022 12:32:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 6/7] ARM: configs: multi_v7_defconfig: Enable HPE GXP
 USB Driver
Content-Language: en-US
To:     richard.yu@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-7-richard.yu@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103160625.15574-7-richard.yu@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 12:06, richard.yu@hpe.com wrote:
> From: Richard Yu <richard.yu@hpe.com>
> 
> Enable the USB driver on the HPE GXP BMC.
> 
> Signed-off-by: Richard Yu <richard.yu@hpe.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 12b35008571f..940632995b9b 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -836,6 +836,7 @@ CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_MVEBU=y
>  CONFIG_USB_XHCI_TEGRA=m
>  CONFIG_USB_BRCMSTB=m
> +CONFIG_USB_GXP_UDC=y

Module

Best regards,
Krzysztof

