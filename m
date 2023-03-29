Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437AF6CF0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjC2RWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2RWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:22:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838E3211D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:22:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s13so9385652wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680110557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBLp/jpc9y9rMvN5jw6+q5ZIa3l3RNNfXuhJJ0vQxR0=;
        b=VC7WGgGMWaIeOKyxq6SQxvp9oqdZxna2+hYudCWSUs8GeIpJDaBDhBpKAKwxRscwDX
         RN1h08gvCeCF51kMXoXnx7yKVHxdMCZINtJZfkA0CflsMpyH4+TkrITtHzqZ+mJz0v7I
         88Ujk4P2vnreGOOC8IH2NQHPPrK1+eloCX8YS4w+iAvT90uPqxYll5qCYKpgtIoHX8qe
         llpMvo+ht67jL4l0Y+cfJOOHt+R180i7mmANwAeXlmz78m70hdeaOiD2CHASjf4Kg4/K
         9vnjnmwLpfjsafeJix1DcQw4MSc8qeFA9aRyUYZxGOsSE8VNU2U6J7jSrLDt0A05HO/h
         WBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680110557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBLp/jpc9y9rMvN5jw6+q5ZIa3l3RNNfXuhJJ0vQxR0=;
        b=l6evPM9k6BioCxk6WTbyN23G74MuDSZE+5gwMtHOQpIdHq3Te3bsA6U9V9sDTjJTDW
         yes62KlT3kevcMzuruB1OH7NDvDfI/S6fPTVZBxe+CPnCJaF4RMDnc4/XnVJzRkm0XO/
         2mT/nj9UeoMZ1SyRlcbKyKR5mpUFxLKhTJIP7h3fE0LcwhhbrQ+8BKgb5/Y9HQwZ+y9s
         alDoVuGIgmKgfpr4YgJsLAxBIu8boX6Px5s78sH8O5pzbh6x2DxBMDzIVscaiXwRBJs0
         eNtmVl/6v8tus2FLaCqMlf4G3TNwLFpeOZIfCz6Hg9vPfo2pXykuxymAUtld1TDm526A
         fiiQ==
X-Gm-Message-State: AO0yUKW/fv5ajaWi4SXvbNYbNEoCZ8I9ZASC762SGK558j1eBKUBFF3L
        FT4eEVe5L61qmdL2c9dctfSuZA==
X-Google-Smtp-Source: AK7set/NSAMg6i4zixiSHj3EJSwBQeYlpqO8qP+egSBJ7ZX924oEjLN4eEaaKdMHEOIWuKM4RsdJfA==
X-Received: by 2002:a7b:ca58:0:b0:3ed:93de:49ff with SMTP id m24-20020a7bca58000000b003ed93de49ffmr14877842wml.0.1680110556986;
        Wed, 29 Mar 2023 10:22:36 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b003eea205671fsm2902356wml.39.2023.03.29.10.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:22:36 -0700 (PDT)
Message-ID: <86d79a51-d7d9-897e-9a4a-590987270e05@linaro.org>
Date:   Wed, 29 Mar 2023 18:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 06/11] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
 <20230322064033.2370483-7-tudor.ambarus@linaro.org>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230322064033.2370483-7-tudor.ambarus@linaro.org>
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
> BFPT[DWORD(16)] defines the methods to enter and exit the 4-Byte Address
> Mode. Parse BFPT to determine the method. Will rename the methods with
> generic names in a further patch, to keep things trackable in this one.>

I forgot to update the commit message, will respin.

> Some regressions may be introduced by this patch, because the
> params->set_4byte_addr_mode method that was set either in
> spi_nor_init_default_params() or later overwritten in default_init() hooks,
> may now be overwritten with a different value based on the BFPT data. If
> that's the case, the fix is to introduce a post_bfpt fixup hook where one
> should fix the wrong BFPT info.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/sfdp.c    | 11 +++++++++++
>  drivers/mtd/spi-nor/sfdp.h    | 28 ++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/winbond.c | 11 ++++++++++-
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 298ab5e53a8c..63b2810cf75e 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -438,6 +438,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  	size_t len;
>  	int i, cmd, err;
>  	u32 addr, val;
> +	u32 dword;
>  	u16 half;
>  	u8 erase_mask;
>  
> @@ -607,6 +608,16 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		break;
>  	}
>  
> +	dword = bfpt.dwords[SFDP_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK;
> +	if (sfdp_bits_set(dword, BFPT_DWORD16_4B_ADDR_MODE_BRWR))
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
> +	else if (sfdp_bits_set(dword, BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B))
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
> +	else if (sfdp_bits_set(dword, BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B))
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
> +	else
> +		dev_dbg(nor->dev, "BFPT: 4-Byte Address Mode method is not recognized or not implemented\n");
> +
>  	/* Soft Reset support. */
>  	if (bfpt.dwords[SFDP_DWORD(16)] & BFPT_DWORD16_SWRST_EN_RST)
>  		nor->flags |= SNOR_F_SOFT_RESET;
> diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> index 500659b35655..a4b5fe795f18 100644
> --- a/drivers/mtd/spi-nor/sfdp.h
> +++ b/drivers/mtd/spi-nor/sfdp.h
> @@ -16,6 +16,8 @@
>  /* SFDP DWORDS are indexed from 1 but C arrays are indexed from 0. */
>  #define SFDP_DWORD(i)		((i) - 1)
>  
> +#define sfdp_bits_set(dword, mask)		(((dword) & (mask)) == (mask))

s/sfdp_bits_set/sfdp_mask_check> +
>  /* Basic Flash Parameter Table */
>  
>  /* JESD216 rev D defines a Basic Flash Parameter Table of 20 DWORDs. */
> @@ -89,6 +91,32 @@ struct sfdp_bfpt {
>  #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
>  #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
>  
> +#define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
> +#define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
> +#define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
> +#define BFPT_DWORD16_EN4B_16BIT_NV_CR		BIT(28)
> +#define BFPT_DWORD16_EN4B_BRWR			BIT(27)
> +#define BFPT_DWORD16_EN4B_WREAR			BIT(26)
> +#define BFPT_DWORD16_EN4B_WREN_EN4B		BIT(25)
> +#define BFPT_DWORD16_EN4B_EN4B			BIT(24)
> +#define BFPT_DWORD16_EX4B_MASK			GENMASK(18, 14)
> +#define BFPT_DWORD16_EX4B_16BIT_NV_CR		BIT(18)
> +#define BFPT_DWORD16_EX4B_BRWR			BIT(17)
> +#define BFPT_DWORD16_EX4B_WREAR			BIT(16)
> +#define BFPT_DWORD16_EX4B_WREN_EX4B		BIT(15)
> +#define BFPT_DWORD16_EX4B_EX4B			BIT(14)
> +#define BFPT_DWORD16_4B_ADDR_MODE_MASK			\
> +	(BFPT_DWORD16_EN4B_MASK | BFPT_DWORD16_EX4B_MASK)
> +#define BFPT_DWORD16_4B_ADDR_MODE_16BIT_NV_CR		\
> +	(BFPT_DWORD16_EN4B_16BIT_NV_CR | BFPT_DWORD16_EX4B_16BIT_NV_CR)
> +#define BFPT_DWORD16_4B_ADDR_MODE_BRWR			\
> +	(BFPT_DWORD16_EN4B_BRWR | BFPT_DWORD16_EX4B_BRWR)
> +#define BFPT_DWORD16_4B_ADDR_MODE_WREAR			\
> +	(BFPT_DWORD16_EN4B_WREAR | BFPT_DWORD16_EX4B_WREAR)
> +#define BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B	\
> +	(BFPT_DWORD16_EN4B_WREN_EN4B | BFPT_DWORD16_EX4B_WREN_EX4B)
> +#define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
> +	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
>  #define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
>  
>  #define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 9cea241c204b..a1b387accc07 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -218,13 +218,22 @@ static const struct spi_nor_otp_ops winbond_nor_otp_ops = {
>  
>  static void winbond_nor_default_init(struct spi_nor *nor)
>  {
> -	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
>  }

I should have got ridden of default_init entirely, it's now an empty
function.
>  
>  static void winbond_nor_late_init(struct spi_nor *nor)
>  {
>  	if (nor->params->otp.org->n_regions)
>  		nor->params->otp.ops = &winbond_nor_otp_ops;
> +
> +	/*
> +	 * Winbond seems to require that the Extended Address Register to be set
> +	 * to zero when exiting the 4-Byte Address Mode, at least for W25Q256FV.
> +	 * This requirement is not described in the JESD216 SFDP standard, thus
> +	 * it is Winbond specific. Since we do not know if other Winbond flashes
> +	 * have the same requirement, play safe and overwrite the method parsed
> +	 * from BFPT, if any.
> +	 */
> +	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
>  }
>  
>  static const struct spi_nor_fixups winbond_nor_fixups = {
