Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C45FF224
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJNQR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJNQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:17:55 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED471D0D68
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:17:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x13so2758782qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gzC+6pIKgTRrlwCoquBVcFiz8VbT8QxkPUglAW6yjw=;
        b=AA/+P5YcqpsI8jTynPbHxeED8efo3L92Ft5IK7ZzFKCeZmZ4nv3SKnoENmrrbu/8c8
         fZkq4I5jbeaxW/bTEvgFGJ7vTxd6kJQO2Wd184HbCSRGuN2a7jyS0+iwTGwUFRiyQOo2
         hyPZFOOti4Ql9unYGK/ye9LyGhSkdQhmSqCahl4S5rlO+8NUf0+zQhaMHLrptVab8xy8
         JMnrDZbsLvRupj2sQiwFt+WLO/BGVgXo535qowjp1AVNKRq1x//oIv1EP/Zm6JAup12+
         jxubr6v9hhJEh4TeZ6RJwgnEw6q4SEH2E80BJNRbWIGpMqT9zebQVtGdpwHmeJM0Gc93
         NMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gzC+6pIKgTRrlwCoquBVcFiz8VbT8QxkPUglAW6yjw=;
        b=Ld3cv/n5yRcVOdB/HvUbGmN/tP+tIkBmvbf1vKujJ8Kqxn/XKc7uYBLOz+YlsbfKlc
         5o5qlUVdE6JVdWNfab8ka7fG9X+9jS6T0gEG0aTvpXK4eGebjgWLwBj8Yfr4NlBXraW2
         lHcsP6fqdDnI3n1+WuTfy9oWnT/0DiPv7nvsu6/WAeQwYS3kWMKStGVvQEPLXJGwoEO6
         5aLZudSlxcNp9ER6iXwuJrymOseGhb4OeelwTQ4A27MixEGPK2sw+qtVSZuaTNv/F3nA
         fQ1o5ixnOl63IWzVpt/SsRmYe1mNLMRRlF1Q/KiJ7XOXCjgrHo2LYDltuU9Q0yqFWyKX
         cUTw==
X-Gm-Message-State: ACrzQf1WJQ7ZBkrd+ZmLkjeLZEP0/k2Bn8TCnRKEAlkaWUS68CA8OiUG
        XhpN8qzWyoHJ2ZnAPgNBKa0PUA==
X-Google-Smtp-Source: AMsMyM6zeraRWOrhtxrEgxldJTmnsoJAKyRx/WeT0BIT3KKR45k0neMZPYTh54xC8XbnEVvqPXN4dg==
X-Received: by 2002:a05:620a:b05:b0:6ee:cb0e:3c94 with SMTP id t5-20020a05620a0b0500b006eecb0e3c94mr3673383qkg.379.1665764273917;
        Fri, 14 Oct 2022 09:17:53 -0700 (PDT)
Received: from [192.168.7.170] ([12.190.236.102])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a441100b006ce813bb306sm3137040qkp.125.2022.10.14.09.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:17:53 -0700 (PDT)
Message-ID: <de4726f5-d7da-041a-31a3-dc7177786bf4@linaro.org>
Date:   Fri, 14 Oct 2022 12:16:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 09/10] ARM: dts: stm32: enable USB OTG in dual role mode
 on stm32mp135f-dk
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     amelie.delaunay@foss.st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
 <20221014092651.25202-10-fabrice.gasnier@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014092651.25202-10-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 05:26, Fabrice Gasnier wrote:
> The USB OTG controller provides the USB data available on stm32mp135f-dk,
> on the Type-C connector. Data role is determined by "usb-role-switch".
> 
> A STM32G0 provides the USB Type-C and Power Delivery connectivity.
> It controls dual role power and dual role data through UCSI protocol over
> I2C. It's wired on I2C1, with an interrupt pin on PI2 GPIO.
> Its firmware maybe updated over I2C, so use the optional firmware-name
> to enable firmware update.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  arch/arm/boot/dts/stm32mp135f-dk.dts | 34 ++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
> index 02ff2bc664da..1c92bf096397 100644
> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
> @@ -95,6 +95,28 @@ &i2c1 {
>  	/* spare dmas for other usage */
>  	/delete-property/dmas;
>  	/delete-property/dma-names;
> +
> +	stm32g0@53 {

Node names should be generic, usually typec.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof

