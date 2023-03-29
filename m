Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37BF6CF0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjC2RYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjC2RYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:24:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7B422C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:24:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v1so16553925wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680110680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOVryfUc/Y7KjZjnjn4gxlGPo9P8/dCDEanWdQi+WXQ=;
        b=lD9lZ8hN2nlaomGDG9pEF1n2PYsGKTs6CSDeCLPRwGJYoWigpivPxMvyntuUyLpQjL
         Qr62gI6pSd+fGSUbAxbhX3/WdilT6y5wPTrtq2ZhswFZF/B8nZQfjDpeWBsp6aE9YDbh
         iXdlIiGE4ugianAH8hwKOLaV9FUJ7jseL5BTOL/S/P9P9+XP2fzJ4DJL+w79CFLVhQbp
         xBngcOZh2kKIsQKpmi8ru4FcYoNQYBRx9YDsR0MhGh3YAqse1CbFB3XCHu1CLlhl639X
         dI6pDbKUQWoo8Hxp7kzl5U3zgNAiR+qXhIj/AXwixriY28U1c2UFxDnx2/f9H3A2tUkA
         QyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680110680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOVryfUc/Y7KjZjnjn4gxlGPo9P8/dCDEanWdQi+WXQ=;
        b=qFt8ab7dkfm1lrPV9xt3JzuOCZY/OxmGosB5QLcZmldvHuRFhgL0kC3I8RWaSoiz5q
         Me59L6VDpXTDVy1h1iVMsOQknrEYOGwvTvDbQTr3R2n0al13X+A89ziE/Trvw+TH2ApI
         bVDBahrzl1vzaZHk6jIr/R1VLp/wjYmWQbuXeaYne5yfG9XE3beM3yj1+6/Jf9PGT16T
         YWyem3M1iovQm/R/WT1NikiKcqDMusEECewilKU/Da37DUrMQvdxWp77AIUHK3kfCyUw
         B2Sba457aOiRzrhV7Rs4EUK9KVFHt+oPGeg/xBNj52NwNP8OvJi+/b3hmmtAFXkWiEYN
         9xNA==
X-Gm-Message-State: AAQBX9cEdRniznT2qkHqPVq/ZQiJftCKCyd6LxiBrzg8J2jeR9I9pWGq
        QJAuCehEKe8aEHWfPJBVmpPzyg==
X-Google-Smtp-Source: AKy350bwBDiwIZb096/dwTQ/bpgovqDe5sR+tIN6djcFzDFEXPd5pcPZJBBDLKU74RRA/8X0pJxavA==
X-Received: by 2002:a5d:538e:0:b0:2d5:ac9e:cdde with SMTP id d14-20020a5d538e000000b002d5ac9ecddemr13961131wrv.51.1680110680249;
        Wed, 29 Mar 2023 10:24:40 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id p5-20020adfce05000000b002d64fcb362dsm25454518wrn.111.2023.03.29.10.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:24:39 -0700 (PDT)
Message-ID: <14eb22ec-3609-0a61-85eb-d8d4ad771583@linaro.org>
Date:   Wed, 29 Mar 2023 18:24:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 07/11] mtd: spi-nor: Favor the BFPT-parsed
 set_4byte_addr_mode method
Content-Language: en-US
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
 <20230322064033.2370483-8-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230322064033.2370483-8-tudor.ambarus@linaro.org>
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



On 3/22/23 06:40, Tudor Ambarus wrote:
> JESD216 SFDP defines in the BFPT standard methods to enter and exit the
> 4-Byte Address Mode. The flash parameters and settings that are retrieved
> from SFDP have higher precedence than the static initialized ones, because
> they should be more accurate and less error prone than those initialized
> statically. Favor the BFPT-parsed set_4byte_addr_mode method and use the
> generic core methods where possible.
> This patch may introduce regressions in case BFPT contains wrong data. The
> fix is to introduce a post_bfpt() fixup hook and update the wrong BFPT
> data.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/core.c      | 7 ++++++-
>  drivers/mtd/spi-nor/macronix.c  | 8 +++++++-
>  drivers/mtd/spi-nor/micron-st.c | 6 ++++--
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index e212cc3c630d..2a08f8de97fa 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2533,6 +2533,8 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
>   */
>  static void spi_nor_late_init_params(struct spi_nor *nor)
>  {
> +	struct spi_nor_flash_parameter *params = nor->params;
> +
>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>  	    nor->manufacturer->fixups->late_init)
>  		nor->manufacturer->fixups->late_init(nor);
> @@ -2540,6 +2542,10 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
>  	if (nor->info->fixups && nor->info->fixups->late_init)
>  		nor->info->fixups->late_init(nor);
>  
> +	/* Default method kept for backward compatibility. */
> +	if (!params->set_4byte_addr_mode)
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
> +
>  	spi_nor_init_flags(nor);
>  	spi_nor_init_fixup_flags(nor);
>  
> @@ -2606,7 +2612,6 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	struct device_node *np = spi_nor_get_flash_node(nor);
>  
>  	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
> -	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
>  	params->otp.org = &info->otp_org;
>  
>  	/* Default to 16-bit Write Status (01h) Command */
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 91a8fa7d4512..075a26945f2d 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -105,11 +105,17 @@ static const struct flash_info macronix_nor_parts[] = {
>  static void macronix_nor_default_init(struct spi_nor *nor)
>  {
>  	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
> -	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
> +}
> +
> +static void macronix_nor_late_init(struct spi_nor *nor)
> +{
> +	if (!nor->params->set_4byte_addr_mode)
> +		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
>  }
>  
>  static const struct spi_nor_fixups macronix_nor_fixups = {
>  	.default_init = macronix_nor_default_init,
> +	.late_init = macronix_nor_late_init,
>  };
>  
>  const struct spi_nor_manufacturer spi_nor_macronix = {
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index a75f0f4e1c38..4d5333b14807 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -425,13 +425,15 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
>  	nor->flags |= SNOR_F_HAS_LOCK;
>  	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
>  	nor->params->quad_enable = NULL;
> -	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
>  }
>  
>  static void micron_st_nor_late_init(struct spi_nor *nor)
>  {
> +	struct spi_nor_flash_parameter *params = nor->params;
> +
>  	if (nor->info->mfr_flags & USE_FSR)
> -		nor->params->ready = micron_st_nor_ready;
> +		params->ready = micron_st_nor_ready;
> +	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;

should have been:
	if (!params->set_4byte_addr_mode)
		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;


>  }
>  
>  static const struct spi_nor_fixups micron_st_nor_fixups = {
