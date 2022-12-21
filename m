Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19A1653450
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLUQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiLUQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:48:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE712496C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:48:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so2656312pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zf7b1Um8dHFfJxzXmlJa5Ye00ncxyhJJVvmWoX+5UNg=;
        b=cXMnkLa/BEl6nLUkGegVRuJ8xP3NJvfAqoDs/4aAd/4kVWHWG0te6VfkTbUz+4Krmb
         WfBdJ26tmjnQl3Zs1pl40sBUE8qA5Qj1X3gRbYvE+qtsd8WAT/6cvCK3U8d3U0kuZ3Wn
         i2U1NDPwDUpXkh53mLz2UEPNQ3l3gEZZwurqquF/edSnip9aJ078wAupTNj0RPhe9n5C
         ZuWv8lfMdi/wsZwE3Unjk6sHcqffEhzedNuCBh7shGoHfk03rIIgBveDs53oKltETjyA
         /OmwvybSP89ZdaZe/gqm6+gRIfVf9nDmmKjo7lliMHfWaVb0pHCH7nLgpD/Ke1VwaTu9
         O4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf7b1Um8dHFfJxzXmlJa5Ye00ncxyhJJVvmWoX+5UNg=;
        b=bas8AkxxWYsaW4MCl/NJTrD33eT1unmvf9e0QAwzLzdUcXG1ceRcS31jXY0ADf+fqf
         RGxgJ0k43V3HzoSH0hK89Y9S/1mK+zScqQKDC9ebowDrxddC6cElJt+oB1XwW8+sla2d
         rdzZ8ZJTxMAoEIaIifjU7/R2Yh8aSEqg6c2EJQPjnR6nhssQ4wb5OPiZAihpLNtMdx5n
         ZUpSwNsEb5yNWA7kUhulsaTtOFxP3lf+3SGJw69a+lelBPPzPH0KHFnqNQg5f1woEKpB
         Ac85Fse1RT6unzR7eyiamht2PvD+90gZxtKpS8pHBNmm+UwjXItX0NQklyEg/cTFlFTv
         /2QA==
X-Gm-Message-State: AFqh2kqU7rxH00WoxXiEAchSwvXhO4vY0g4l6iMr3DpJHlr+pneNFIzb
        OdTZOC/P9gYAZaEXpDFgBLE=
X-Google-Smtp-Source: AMrXdXuYR9ISRKilIwT83DLgADmJAo7CNvXNazKKk2FaiV26xWK2a9ff1PC5F54Ydx3cjpzqQcKL5A==
X-Received: by 2002:a17:902:da86:b0:187:3921:2b1c with SMTP id j6-20020a170902da8600b0018739212b1cmr3498172plx.55.1671641279366;
        Wed, 21 Dec 2022 08:47:59 -0800 (PST)
Received: from ?IPV6:240b:10:2720:5500:24a0:f664:12ce:afd8? ([240b:10:2720:5500:24a0:f664:12ce:afd8])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b00186a437f4d7sm11712452plg.147.2022.12.21.08.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:47:58 -0800 (PST)
Message-ID: <ee2fa011-dac1-2495-cb17-e01ee99ce913@gmail.com>
Date:   Thu, 22 Dec 2022 01:47:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221220141352.1486360-1-arnd@kernel.org>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <20221220141352.1486360-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/20 23:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
> fails to build, as it includes the shared CFI header:
>
> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>     62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
>
> linux/mtd/spi-nor.h does not actually need to include cfi.h, so
> remove the inclusion here to fix the warning. This uncovers a
> missing #include in spi-nor/core.c so add that there to
> prevent a different build issue.
Reviewed-by: Tokunori Ikegami <ikegami.t@gmail.com>
>
> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/mtd/spi-nor/core.c  | 1 +
>   include/linux/mtd/spi-nor.h | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index d8703d7dfd0a..d67c926bca8b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -10,6 +10,7 @@
>   #include <linux/err.h>
>   #include <linux/errno.h>
>   #include <linux/module.h>
> +#include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/mutex.h>
>   #include <linux/math64.h>
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 25765556223a..a3f8cdca90c8 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -7,7 +7,6 @@
>   #define __LINUX_MTD_SPI_NOR_H
>   
>   #include <linux/bitops.h>
> -#include <linux/mtd/cfi.h>
>   #include <linux/mtd/mtd.h>
>   #include <linux/spi/spi-mem.h>
>   
