Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B93686347
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBAKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBAKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:01:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B072CC67
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:01:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so16717707wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PeirgNv4K+MaTJYJXPOs6pjXe3XDc2jdbu04P3+Uqg=;
        b=FevURJwklWJbZc8yfYCdpW/FY2gyIrS/CcneIgAnH2XmJX0jzpxry9Mbax07VDcsl9
         cvKZ3bPk0w15P9VVjbaB/YqKkIV4019oVy5U61GYhWKZURAT7bxVVxgZbks9ojqUYEnx
         V2GUW+GFDm3PRPG8hjt/AxlQP2stI5KOcTgM4Pjpvl+GMWtV2vQdxFeEsA8wGWm7VORb
         RrcQTe6+e4iipt+s9CeiXNB/Kw0t/0U55pOmH7+zwSkDS/aAqAu3Lb8osCq77rToQ1FI
         PVYsq4DnS8o2HSMiQbSVqcLRssm3k7gJdY0sPiKR6Y7sXJBNg98sD4tFNrISDoB0zv9K
         06SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PeirgNv4K+MaTJYJXPOs6pjXe3XDc2jdbu04P3+Uqg=;
        b=2siNVWI3J5XF7rQW70szPHcHiiSiS7rLzioCxxmGz6314232Lzyp0gT0ccxYNAR1Qy
         cq313HKVSYtIyXCbPcx7SdAVMJTaUa2lOLvPmnA7NCRT6HuHpdUt5aS/tRqMqetN6x1C
         ukkPnjnf9uRhgN4uatO8R2G1sNPcTAGT7/7xLyjTqZW68q1jXSqX/j3nZ0pHl4IKaPJX
         KE4fV8J7h01R6QzSJsYun9W7OQxNSlRBIoLnaCKevzhKWmhCmgLtv46o62i06xMzWFJC
         531039RsKT+qTlIADoJWvGIn7IKMEdNxHSU095xskh3ovwEVyU5CKUC+uC3/0fsG+n7W
         RTDw==
X-Gm-Message-State: AO0yUKWFUWxANkPQ36CIujPVaprZ2H1lWhS1CJOq9R2OyBpVEzZQR3zE
        Kau4N30fQZoSYy215QdP/Np5PQ==
X-Google-Smtp-Source: AK7set9MtwM8BkQIwFg6AWIBrpsKGSS2KBX2SDLUBxmbn7KNUZAZW8QqNNeARq6RmLgi/YqU4o/DYg==
X-Received: by 2002:adf:fa06:0:b0:2bf:d2b8:8c09 with SMTP id m6-20020adffa06000000b002bfd2b88c09mr1849557wrr.61.1675245708414;
        Wed, 01 Feb 2023 02:01:48 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id r28-20020adfa15c000000b002bfd137ecddsm15008446wrr.11.2023.02.01.02.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:01:48 -0800 (PST)
Message-ID: <49427044-f8be-34dc-d158-0ce067c1c591@linaro.org>
Date:   Wed, 1 Feb 2023 12:01:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mtd: spi-nor: remove duplicate included header files
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <202302011730294177177@zte.com.cn>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <202302011730294177177@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.02.2023 11:30, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> linux/delay.h is included more than once.

I see it only once included. Would you please double check?

> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/mtd/spi-nor/core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index e9ea14598ec3..d67c926bca8b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -16,7 +16,6 @@
>   #include <linux/math64.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
> -#include <linux/delay.h>
> 
>   #include <linux/mtd/mtd.h>
>   #include <linux/of_platform.h>
