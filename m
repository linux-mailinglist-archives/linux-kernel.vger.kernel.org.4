Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59E6FEDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjEKIeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjEKIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:34:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9D49D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:34:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so56011865e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683794075; x=1686386075;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyhkadwy76PvtTG8OTGK3oTxfpKVBdNtjIXr+9MoiDs=;
        b=fsubfTEI2BtlX6kxz7dYaSrHibGdZ5zzvXiSkL3zgHh7TgTzu+YfFL/j7LTeGcthcR
         X0wxeAtY7ZOS1spFT1VVA7rWb67xJbO5UVhTw/+L5IO88h8pCEMhXMt60t3UCF5E8xUD
         6jcrmv0XRHF9cbuCK78hozX1rolI+R9JSX+MF9jUgIkkXisgonH+nwYgCX78QBLHJzN0
         6kdeyJTz+6n3mNaoc0RaAE1l4tr0A7InOKo+uYPYtZLXIc8vo3b9WEnvjU8maxzOf4KJ
         887HykpwZKrOp/+6TSaIIokJR91mYFk5ArQQYoBMTP+5kOxqQrGCj+QJ/Q/oPNQPJ47l
         dRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683794075; x=1686386075;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyhkadwy76PvtTG8OTGK3oTxfpKVBdNtjIXr+9MoiDs=;
        b=NE748TdjZlGUWAtAE9LAFEJ+eo9FVx9FPnaWps0zTrH/viC9befkUHt6Kw4CntIX8x
         6ullgUO7lwFvT49cVu8LDvyobnBcE/MXX//cAqTqTdYdr6b5FAdetawZqhMmvIO1PMZU
         C1ULt6lumQE99iyQLsCTrGR0JEs2nPqHUmo7u/RXrgGLMBw5Jbw/TPoc4xzAFYo67a0G
         zZpGPcF4uMnotbpaOt6FAiRZVJdamNPibvO0wa74ChyMVfoKxw2zDFoALyk2eH3fnQrI
         QlzM2waCDn5i3j9UA6N7B7W9Hfnx5WbSh+s1O8cEe/lcSE8dusLpB8Gk/pkuzTOJ09bo
         sHDQ==
X-Gm-Message-State: AC+VfDybLvFhbNVyImVxzDSNXdrEkIMT26IBWvESapstamPgXdZ75eje
        uXh7og4eKQx4a1d3SEzxuypFuQ==
X-Google-Smtp-Source: ACHHUZ4gH4IivEWz8QiW7o78Y0QhaNUiSoUPbbKtCiyPYCVSiuxVXZc2m5HIiHYNT+Qn0lAUxh/azw==
X-Received: by 2002:a7b:c7da:0:b0:3f4:2df7:e332 with SMTP id z26-20020a7bc7da000000b003f42df7e332mr5052691wmk.13.1683794075571;
        Thu, 11 May 2023 01:34:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:182d:9e6c:b8ff:5a99? ([2a01:e0a:982:cbb0:182d:9e6c:b8ff:5a99])
        by smtp.gmail.com with ESMTPSA id x25-20020a1c7c19000000b003f42a75ac2asm7531323wmc.23.2023.05.11.01.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 01:34:35 -0700 (PDT)
Message-ID: <ed230bf6-ef9c-f7e4-81eb-9c01b447aad4@linaro.org>
Date:   Thu, 11 May 2023 10:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] ARM: dts: meson8: correct uart_B and uart_C clock
 references
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hans-Frieder Vogt <hfdevel@gmx.net>
References: <20230510210847.996980-1-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230510210847.996980-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 23:08, Martin Blumenstingl wrote:
> On Meson8 uart_B and uart_C do not work, because they are relying on
> incorrect clocks. Change the references of pclk to the correct CLKID
> (UART1 for uart_B and UART2 for uart_C), to allow use of the two uarts.
> 
> Fixes: 57007bfb5469 ("ARM: dts: meson8: Fix the UART device-tree schema validation")
> Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net> # for meson8b.dtsi
> Link: https://lore.kernel.org/linux-amlogic/trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55/

This is confusing, please move this link to the commit message instead, I'll add
the Link to reference the patch from Lore.

With that changes:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   arch/arm/boot/dts/meson8.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 4f22ab451aae..1054297fa69f 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -769,13 +769,13 @@ &uart_A {
>   
>   &uart_B {
>   	compatible = "amlogic,meson8-uart";
> -	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
> +	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
>   	clock-names = "xtal", "pclk", "baud";
>   };
>   
>   &uart_C {
>   	compatible = "amlogic,meson8-uart";
> -	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
> +	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
>   	clock-names = "xtal", "pclk", "baud";
>   };
>   

