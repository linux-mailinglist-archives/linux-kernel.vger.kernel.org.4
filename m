Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9877B7060DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjEQHKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEQHKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:10:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE397
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:10:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so51529025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684307414; x=1686899414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueeC/Yu2Zi0jRM1bpkf54Qq6Ele7pKUjyyeMBr16uY0=;
        b=Xoimmx/5igzRrPKdcjFbG5nWxkgAVzkNaz6QTFt0cZAUt9c8lQEtzJv/rSDHDzbxUN
         xUj9IE853EOEMQKJ7MoXZdj3Xx2zXyBxemGwFT+kxEs8Zw3UGKgA/t3zM2txZJYmtKlL
         Nf0QoCtgdufUffepTHDZjsYYku5hdtTRaGgs8pN8i96QYm7krJuVR19TN5SP9ihNVPMR
         egWpT5pFKXnTwHs5ysp6xF/uz+dAWsXu+3Q062lcQD6z/zrlUr1YhBDKpN7uSgblN2Ek
         CqThu3fd3GRa1UycSbGUxQ5ByakNlfMJ/qqtfqeTiqefluNEhvd+m3qZ+XTNuO3OUfu9
         Zb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307414; x=1686899414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueeC/Yu2Zi0jRM1bpkf54Qq6Ele7pKUjyyeMBr16uY0=;
        b=J2IH06OQD5Yk/pG1mcTLq1UHoOOKanF5N/g6OC0cww8HfUDon+xIJ9z+8p2xSfz3dG
         LoYG96j/vgSTbBzB5ptdr1YJT9IooKnU8EkkbcabAagsCuCHxCRH6QcSOb/OZI/Bw6tN
         Xm/MUYQwG/f+0iAfwbNedyDEtZHOX/3lR7NH5Bi1m40e4rWCM87Q0A/z996blGr8ve1k
         2R5Bd5iIaWVSH2x7J9R5SH8YjrMLh8vohWdwdE2OpLPogl+bfwItwM7WvyjrVGv7clpE
         z9pGCnjKMCurDbHg02cBANatLQGcKAQyGWvUjDOVdNjE/I02WoPipt8izZ7QDSFUn7oZ
         6S+Q==
X-Gm-Message-State: AC+VfDznwdkQI9kbmkcFQ4N+hcrw3aC/D/2sFFSmzAkCweLZ8ChgDzJ0
        f0cDNOxX1h7b47PGKhNgpHnqdlzuyG0jX+B4oco=
X-Google-Smtp-Source: ACHHUZ7SD9B9xVL5JTU0mtLaL5rHFQfVN4qrtoQEWR/uTrGS/x08ocFSrQ6EhZP523zPhc6/XhXdww==
X-Received: by 2002:adf:f304:0:b0:2f7:cfe2:6507 with SMTP id i4-20020adff304000000b002f7cfe26507mr787955wro.20.1684307414206;
        Wed, 17 May 2023 00:10:14 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bc8d1000000b003f4290720cbsm1252171wml.29.2023.05.17.00.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:10:13 -0700 (PDT)
Message-ID: <3ab922a4-255a-5aef-86ba-d906819f0f3a@linaro.org>
Date:   Wed, 17 May 2023 08:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] MTD SPI-NOR: BUG FIX of divide by zero in new n_banks
 value
Content-Language: en-US
To:     Todd Brandt <todd.e.brandt@intel.com>, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, pratyush@kernel.org,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
References: <20230516225108.29194-1-todd.e.brandt@intel.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230516225108.29194-1-todd.e.brandt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Todd,

On 5/16/23 23:51, Todd Brandt wrote:
> While testing 6.4-rc1 on our Lenovo Thinkpad X1 I discovered
> that freeze, suspend, and shutdown, all hang the system. I bisected
> it to an addition made to the MTD spi-nor code.
> 
> The new "n_banks" value is being divided into without a proper check..
> Thus on certain systems this causes a divide by zero hang.
> 
> Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217448
> Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> ---
>  drivers/mtd/spi-nor/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0bb0ad14a2fc..084117959be4 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2921,7 +2921,10 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>  		spi_nor_init_default_locking_ops(nor);
>  
> -	nor->params->bank_size = div64_u64(nor->params->size, nor->info->n_banks);
> +	if (nor->info->n_banks > 0)
> +		nor->params->bank_size = div64_u64(nor->params->size, nor->info->n_banks);
> +	else
> +		nor->params->bank_size = 0;
>  }
>  
>  /**

Indeed, thanks for the report and patch. You probably use the
spi-nor-generic driver, don't you?

Can you try the following change instead?

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
                      index 0bb0ad14a2fc..37f750bd7bfb 100644
--- a/drivers/mtd/spi-nor/core.cdrivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.cdrivers/mtd/spi-nor/core.c
@@ -2018,6 +2018,7 @@ static const struct spi_nor_manufacturer
*manufacturers[] = {

 static const struct flash_info spi_nor_generic_flash = {
        .name = "spi-nor-generic",
+       .n_banks = 1,
        /*
         * JESD216 rev A doesn't specify the page size, therefore we need a
         * sane default.
