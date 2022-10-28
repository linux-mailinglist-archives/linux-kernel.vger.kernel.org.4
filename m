Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4C6119AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJ1Ryy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJ1Ryv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:54:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A719025
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:54:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay12so3285537qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPPPi5v6XuLB3813cqcFBuR57ngCmvkcFB0jTGQyiig=;
        b=MtUAzGVb7iDR7Oyu4rO0rQnr0CDw4RrVC6fi5JNA7E1JYz4QUhrfTwZ7LT81G5F78S
         4DqjtVFwDvlSWdH/IxpMEkYOVu4Ptw+o554zDvnnAVBDypTzLi8aamLaq0iNRAUBN+7s
         0dPZ6TydUDC/UZJoGx8hyF6yZKQSlm6kLdoPQ5ZBDV+kCRL5WtzZMas6BsZlnpPrxio+
         BGkvwnxY57bLnLV83ik68NmD8t1lwurBEhyFlSVktAjDU1jOo965kGYPAjGTvc8X5RO5
         xRw7K0QibSG1T15JTUfFhM6bDIZMG5GyGCBKm/CC4RSWnO/LrSh9tPjqkO7GBBS4GYK1
         vTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPPPi5v6XuLB3813cqcFBuR57ngCmvkcFB0jTGQyiig=;
        b=bKMDsaqkv+tHs231LL0sFDFv38E0v1wkF5iZQsesQK71khafNbS2YBNGJxUOIywvLR
         7DcuXlD5o/WLQCEeqKWtGzip/1vL7i4Ks4lN7LTjFE6WXg06mVGByFHYxVcKUEg14N2r
         88VwkI6BojRNLnKtDhhLsxl0QTcQooErvXNyzkuf1UaGprls2Zu/6Ae2M260A7aMgh1Y
         RvkFKjDSapZaXQfAk733DGLdsVxu4idiUDuhmTo/T/mheimwRjmppjuScZFLQuddGUEj
         CGXWLiX07BKAk1oTehvzDdXJ1O34q7NGpGmMw1lmpcK2PA5xwVWBUkIoKM3sV309Weax
         LHiA==
X-Gm-Message-State: ACrzQf0fu7mnX1WRR6WwWAZppuJk67Ov0mgjIhlnKvAXcXTPC+Qnj3vk
        79WEw82MlXTPB6LYsLcWVjdzyA==
X-Google-Smtp-Source: AMsMyM4YYymK8nVKNzn3BsrohpPL4lv5XFK9f/hpOwucaO1bp0vfJ0Co8mIT/DF3/5QGSVcLmXdDIg==
X-Received: by 2002:a05:622a:44e:b0:39d:c1a:3282 with SMTP id o14-20020a05622a044e00b0039d0c1a3282mr601872qtx.75.1666979684180;
        Fri, 28 Oct 2022 10:54:44 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d13-20020a05620a240d00b006f0fc145ae5sm3488976qkn.15.2022.10.28.10.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:54:43 -0700 (PDT)
Message-ID: <02523fe5-bf99-9891-d00c-347893d5dabe@linaro.org>
Date:   Fri, 28 Oct 2022 13:54:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/4] pwm: Add Apple PWM controller
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
 <20221028165215.43662-3-fnkl.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028165215.43662-3-fnkl.kernel@gmail.com>
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

On 28/10/2022 12:52, Sasha Finkelstein wrote:
> Adds the Apple PWM controller driver.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/pwm/Kconfig     |  12 ++++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-apple.c | 124 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 drivers/pwm/pwm-apple.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..ec6acb368073 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,18 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
>  
> +config PWM_APPLE
> +	tristate "Apple SoC PWM support"
> +	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)

Why this code cannot be build on 32-bit?

> +	help
> +	  Generic PWM framework driver for PWM controller present on
> +	  Apple SoCs
> +

Best regards,
Krzysztof

