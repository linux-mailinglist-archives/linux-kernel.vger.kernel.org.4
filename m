Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B426D1E08
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCaK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCaK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:27:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E98A72
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:25:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so87620555edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680258350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhPcZKzZ67n0KKZPj2eL08C3CN1e7cIqv7ArPUwlLgI=;
        b=PJqxBoD3w05ozO6Y92E+86GHvX/eEjYeQz1KTXSVQGSPSm/KnR/kPCWWZbuDQvtTvY
         hZmAgiEkUP3jt8bMdxu1egkrCQLf12IzGSmi/wWnzpsd6LCofVGA0xUu2p/jpmtN31IW
         BKzeY2yYNE0T6PYkUz035ANwXI/SDBBQEufYegWtyepjyBtOgKoalWc1kEIdiPf5ARkW
         Xpe/o9XbIUnQ4MXcEc/lG4aoKPAEb1nUKNo802rbL/mQ9cluKLtkb91BOTF+UfbZugpN
         AW12FlIJskwa1RI/XH3TCTl8EWK1VinMilRsIRTMzEL7eVCZE34SyYO6pdtFvfqA+q0u
         RgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680258350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhPcZKzZ67n0KKZPj2eL08C3CN1e7cIqv7ArPUwlLgI=;
        b=URRuf/T9dAD2PC0qlZa8YAeULJkjfpUNiYtasmrxjMNIBhFCiMBdGHuJs9bwAzBbol
         NmvaLVkcJWillARtGBgIYPQkxFW0z5/R55jwMqEb7Wd8WqptrV9eS2VqJ7s7767kUyVp
         Rf8yZJk7EudmrLVCiAzIM6op8Rp9fgSt+PbxsPKelJPH/r4sLO6CuLK6dh813JWZEiol
         UFw0roHnz7m6cBAiqBjxAcwoAvyjBXKXh8UgNsmQDlhW5672kUcGtJ1FQvVJpzWUr8f3
         FWreKAPcmeDopIiWHVt3Z+GPWLNgZI6idwx1hY3FdnBY0M/thzBkCouUbVNyXCgZnjMe
         fwdQ==
X-Gm-Message-State: AAQBX9f/c0mLSwWmZ/IwZbpHBOAUqg/nFWJFbCOc2kQipB3/hfrJJfqW
        g0HW4ONhMOVasaCRnqDW6iwHEg==
X-Google-Smtp-Source: AKy350YJ4LYzUCv0idOQuBjabxmUfZDfksq/Q4sYfdAXRSpDGqKkm4QdotupyiZSnUq/XKQdu6bMgA==
X-Received: by 2002:aa7:c98b:0:b0:4fe:9374:30d0 with SMTP id c11-20020aa7c98b000000b004fe937430d0mr23651301edt.39.1680258350095;
        Fri, 31 Mar 2023 03:25:50 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id bx20-20020a0564020b5400b004ac54d4da22sm860205edb.71.2023.03.31.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 03:25:49 -0700 (PDT)
Message-ID: <6713b89a-a031-8f32-3de2-12643a8976e1@linaro.org>
Date:   Fri, 31 Mar 2023 11:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mtd: spi-nor: sst: Unlock addition for sst26vf016
Content-Language: en-US
To:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        alexandre.belloni@bootlin.com, linux-mtd@lists.infradead.org,
        Guillaume Socquet <guillaume.socquet@microchip.com>
References: <20230331095549.16393-1-nicolas.ferre@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230331095549.16393-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nicolas,

On 3/31/23 10:55, nicolas.ferre@microchip.com wrote:
> From: Guillaume Socquet <guillaume.socquet@microchip.com>
> 
> Modify sst26vf016 flash_info struct so when such device is detected by
> the driver it may be unlocked for write operation as sst26vf064.
> 
> Signed-off-by: Guillaume Socquet <guillaume.socquet@microchip.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/mtd/spi-nor/sst.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index 63bcc97bf978..99c8a19493f5 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -110,7 +110,9 @@ static const struct flash_info sst_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
>  	{ "sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32)
> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ)

If I remember correctly this flash has SFDP support. If so, we may be
able to get rid of the "NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ)". You
can check whether the flash defines the SFDP tables or not by dumping
the sfdp sysfs entry. Check the link from below on how to do that.

Also the sector size and nsectors should be superfluous if the SFDP
tables are present.

> +		.fixups = &sst26vf_nor_fixups },
So I'd try:

{ "sst26vf016b", INFO(0xbf2641, 0, 0, 0)
		PARSE_SFDP
		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
		.fixups = &sst26vf_nor_fixups },

We ask people that update or add new flash entries to do an erase,
verify erase, write, read back and compare test. Also to dump the sysfs
entries. Here's how to do that:

https://lore.kernel.org/lkml/97a3b023-b9bc-c34d-45a4-ddd56f47bd76@microchip.com/T/

Cheers,
ta
