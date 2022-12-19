Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAE4650E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiLSPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiLSPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:12:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7A63B3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:12:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so9153318pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AXVvNqpaKog0+KoAAgFUzZQUXXp78Pzo7uIDvg6rlJ4=;
        b=J64xI24z4FcdI0Ztr8D4bUf2q4sD4l6AJnBJNQ8rBvS8Ixlg4tGZkWme7m5Sy68j4T
         pM1QwgCTwACTKC8fX7rN1in9CecRGSG4enPoy47rcIdG5VaPXeI5icRMc2ef5zPh7kCt
         1luO6xcrWkPIMpIiAylObPP9T6FJoBnthcLRlNpN5c+OQAhr7rm160EvZ2TMtCliDYTY
         ry+kp3wBVjhvlXYm63uXz7uUXYOWkPv+usQ9fceTc0mvgQw33nRjbkRg5KXyx2jhcY7B
         /FTwyrNmksqBH+gAXGoD86Z/dL9tKii6bvjDQBI3r7cuyeUcekM1D4WROrRyBfqrkdwm
         ne4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXVvNqpaKog0+KoAAgFUzZQUXXp78Pzo7uIDvg6rlJ4=;
        b=62nu42gmYz5s16A4CWffblWsFMj/te9YPwFxJhQru/ghzRAyH9m1Y7wqcrSjl5zBPA
         Cl6f425sBkixjuziC45BG4idlSTRUt6p3I0UqZbgEpTGW3+FKrqOEUy0eS2RHXXnPD5f
         ZwKtK+Z7WVHsDJZjybzleMLURw7MFX7NMzcz4S0uGx8ET+Pk9xhdKeIxPBEt4ShqUt3I
         kc8G+kfDcXv2efw4Mn3nXJaAXYImC6Ljy1r7lfTl6AdPn2GPTAbGnz8GKqNqgnads9Z5
         Y5M127oTmYOzK6OCRKp1rtnzOWT0Nc94TA39doSP+dX+BgPvzkSEvJglFo/uZAbK+K/8
         eXpQ==
X-Gm-Message-State: ANoB5pmSHsCiLfTYIbOk+C2R3R35j4m8g3dcH+pPMJFzTa3TM4TADVtr
        a6Va4Y47cyFGPd/Pr0EKEiM=
X-Google-Smtp-Source: AA0mqf5SdKgy2/AFn3qxKx6jplH4Dg71faboz2VgI2JNAGtTefVoc4ita7xmyI9S9Ri+30z7u1mukw==
X-Received: by 2002:a17:90b:3c0d:b0:219:10dd:a389 with SMTP id pb13-20020a17090b3c0d00b0021910dda389mr41039164pjb.31.1671462777584;
        Mon, 19 Dec 2022 07:12:57 -0800 (PST)
Received: from [192.168.122.100] (36-2-101-155.tokyo.ap.gmo-isp.jp. [36.2.101.155])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a66c400b001f94d25bfabsm9257936pjl.28.2022.12.19.07.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:12:56 -0800 (PST)
Message-ID: <d68c9137-f485-e0a0-dfc3-c72c26d0433a@gmail.com>
Date:   Tue, 20 Dec 2022 00:12:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Subject: Re: [PATCH] mtd: cfi: allow building spi-intel standalone
To:     Arnd Bergmann <arnd@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221215163950.649791-1-arnd@kernel.org>
Content-Language: en-US
In-Reply-To: <20221215163950.649791-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/16 1:39, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
>
> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
> fails to build, as it includes the shared CFI header:
The header file linux/mtd/cfi.h is included by the head file 
linux/mtd/spi-nor.h so seems the warning caused.
Is it really necessary to inculude linux/mtd/cfi.h from linux/mtd/spi-nor.h?
(It seems that it can be resolved the issue by removing the including 
cfi.h from spi-nor.h if unnecessary.)
>
> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>     62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
>
> Use an #ifdef here to guard the settings so the header can be included
> in all configurations.
>
> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> ---
>   include/linux/mtd/cfi.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
> index d88bb56c18e2..0e87b6e2faad 100644
> --- a/include/linux/mtd/cfi.h
> +++ b/include/linux/mtd/cfi.h
> @@ -15,6 +15,7 @@
>   #include <linux/mtd/cfi_endian.h>
>   #include <linux/mtd/xip.h>
>   
> +#if IS_ENABLED(CONFIG_MTD)

Is it enough to check only CONFIG_MTD here as not necessary to check if 
MTD_CFI_GEOMETRY also?
By the way it seems also that it is needed to use #ifdef only for the 
cfi_interleave warning checking as below.

#if IS_ENABLED(CONFIG_MTD) && IS_ENABLED(CONFIG_MTD_CFI_GEOMETRY)
#ifndef cfi_interleave
#warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
static inline int cfi_interleave(void *cfi)
{
     BUG();
     return 0;
}
#endif /* cfi_interleave */
#endif /* IS_ENABLED(CONFIG_MTD) && IS_ENABLED(CONFIG_MTD_CFI_GEOMETRY) */

Note: The cfi_interleave warning checking was implemented by the 
following commit.
   241651d04d67 ("[MTD] Fix CFI build error when no map width or 
interleave supported")

>   #ifdef CONFIG_MTD_CFI_I1
>   #define cfi_interleave(cfi) 1
>   #define cfi_interleave_is_1(cfi) (cfi_interleave(cfi) == 1)
> @@ -88,7 +89,7 @@ static inline int cfi_interleave_supported(int i)
>   		return 0;
>   	}
>   }
> -
> +#endif
>   
>   /* NB: these values must represents the number of bytes needed to meet the
>    *     device type (x8, x16, x32).  Eg. a 32 bit device is 4 x 8 bytes.
