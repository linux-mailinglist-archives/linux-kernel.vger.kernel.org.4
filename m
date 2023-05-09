Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A16FCE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjEITaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEITaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:30:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E72E52
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:30:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f19a80a330so42199375e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683660606; x=1686252606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KD8foC69hYMuBlOy5cIRDovU5YqqAriedzy7jkhIVWc=;
        b=hjWv4CdizCb5J1oWEPMb12XkrjAsfQJBpfSuY/yw18u5IvhHwU+r5+CS87XB6EhFan
         Hp3okvkgOTZIsWb8B3BYO/x/sDcVlXubXhnq7IDT9vinkWUOSzjpRfUKsP+9G5XOw+k4
         nWLZaW9fVOppOU5x/O4DICinwl5wep+EcNSpu3+Oh9cH0EkfC/XErl9JOT6Z/LjBV3uk
         4d7QjiX+xMAzIWb9uH3AU9hDSrovA0wSEECUM0S/2nuVnl+30se+yD1AXzm2Pkbk6wbD
         UNRbAEvRDkEbnQBVZcEDuKHPRnpnoHS27LLR4DjEw2J6L35WlKSyIDjGtPxcny7V1fA/
         b9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660606; x=1686252606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KD8foC69hYMuBlOy5cIRDovU5YqqAriedzy7jkhIVWc=;
        b=GoILr7pPYMOgm4krJ4dnJDVVn93X59QsZ7EB9YEr+N7M1RC1gTJ+hXKawGtO80KgUL
         tHWrmuPb/TywydgQXBQ7Yu/CcR0tkXf2g5L68pJehOzwvldi/ZsAxpl6VKHP4WI1sN5/
         SAFXybXRnyHyxGuwEnctWznAMk6srtUNuU9KO8QtCq4mfx/aHGxRrYYGhr9aYb6d7gpC
         2OmRErkvrY4HO4RN18e5pChR/PKKusjvvYvP9fHfuGWX2L3pT3UEEi/TOp4AYrXNAiz2
         uOIhYur4B16idiG+kJ4AIig6IO8O5ewj5pXFBcczNI1k+0seXnmNNDFn1Fq3sdIQzkAY
         pUSw==
X-Gm-Message-State: AC+VfDxp4KcWNDGxJtawdb8RyeqZIoJ7z09OlsPfuoyo2mRVHgfToXLO
        QWPDTXHf2dHV6vLPRswStc6Few==
X-Google-Smtp-Source: ACHHUZ5eHOkeZGugmMpFbGtkyT8Fb0sgGowYT4KC7/jTTUMf3nNxozaQjiyoHYcHI62l+bVbKcqf3A==
X-Received: by 2002:a05:600c:3655:b0:3f4:2cc7:aac5 with SMTP id y21-20020a05600c365500b003f42cc7aac5mr1773933wmq.9.1683660606538;
        Tue, 09 May 2023 12:30:06 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id h8-20020a1ccc08000000b003f17eaae2c9sm20814149wmb.1.2023.05.09.12.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 12:30:05 -0700 (PDT)
Message-ID: <29a5762d-ecf8-948c-2892-58ff3349ada3@linaro.org>
Date:   Tue, 9 May 2023 20:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] mtd: spi-nor: spansion: make sure local struct does
 not contain garbage
Content-Language: en-US
To:     miquel.raynal@bootlin.com
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
References: <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
 <20230509192506.947094-1-tudor.ambarus@linaro.org>
 <20230509192506.947094-2-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230509192506.947094-2-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/23 20:25, Tudor Ambarus wrote:
> Following error was seen with um-x86_64-gcc12/um-allyesconfig:
> + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27
> 
> Set the spi_mem_op fields at the time of declaration so that all
> uninitialized members be initialized to default value.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 6afcc84080c41 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/spansion.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index d44ffaac1dba..257d05ed4146 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -492,7 +492,10 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
>  			  const struct sfdp_parameter_header *bfpt_header,
>  			  const struct sfdp_bfpt *bfpt)
>  {
> -	struct spi_mem_op op;
> +	struct spi_mem_op op =
> +		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
> +					  SPINOR_REG_CYPRESS_ARCFN, 1,
> +					  nor->bouncebuf);
>  	int ret;
>  

oops, this is wrong as addr_mode_nbytes is updated just below in
cypress_nor_set_addr_mode_nbytes(), so the fix is to init op with {} at
declaration, as in the previous patch.

>  	ret = cypress_nor_set_addr_mode_nbytes(nor);
> @@ -500,10 +503,6 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
>  		return ret;
>  
>  	/* Read Architecture Configuration Register (ARCFN) */
> -	op = (struct spi_mem_op)
> -		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
> -					  SPINOR_REG_CYPRESS_ARCFN, 1,
> -					  nor->bouncebuf);
>  	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
>  	if (ret)
>  		return ret;
