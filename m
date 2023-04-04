Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351646D5814
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjDDFkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjDDFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:40:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEFC268F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:40:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso34970944pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 22:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680586814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fo9S7Y7H6OiDjzyP+gILwuzOqgiPIaotUdswMbGHx94=;
        b=Q7UakpHypgT1mfcbMrTsKV8QX/qeuPGg6VYSSjda0ocBQucK1hA9q+FyPL7tuX+plo
         HkDhXfdb3iiAl2C9Gh3bFgugb0GVrKl0PMT90fQgTC4/G+/vzUo+d05U7WGjge5oLwSt
         UXOF2IkN1o5OX5zCqZedQej2av8vvZUl8xDo6LCxU640W9Jg3hy9a7cnNCidewhjSlRm
         5Gn93SKs4hwg/UmCOiZgbCmA2V6M4dqcIfqeIFhKlGrxzbZX+ZtmC3nZ+oH2+ZHmIT6G
         X2Wdx/iyqiH/QaNVQnl64T45iXbjdBKr9EMBFNEfm7ICY/R3MqTaYNtMyGrkflRyFeWw
         jy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680586814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo9S7Y7H6OiDjzyP+gILwuzOqgiPIaotUdswMbGHx94=;
        b=wt9bo+Dmz6Kolv91ehGrVeT5T+7j1FQDLnn0UtBNoNh83KvjIG1CGytgoBCPOohpTQ
         o+hf53KDWH3LZPo3aXku/QDkJdohix7O/xGNrDX/M8FMHvmgCMmRcILe0CIQGjp8VwwM
         5vFGT0+SkjvHpf2ES2udtVgkH4D+NHj17wQtC9gxCNIbZni0OlX4/uEOXGAqoaekUvZO
         qvzK0zhueQmcdCC7uSmWMa25TLc3zpD9vVC95xAFApVWq6RsTLnI+JGrvZFImPKS12wW
         vMQfW7z4wbe91qROXUhHmiRuiYWO8Sno9omBqyh93SFArrR0MhaTuliGmeEpQdVUX4Mb
         Eetw==
X-Gm-Message-State: AAQBX9dTZyN3H7M9wymthoqWIAr2rlJo9YJiNG1HO6Ezak7O3+q6gMD+
        kLZU3d7lJ/NwsxR6Ug1s8dMTvuAoUnw=
X-Google-Smtp-Source: AKy350aKW+eY1NOdzGNHRIQAIRb9i76DP758C2pRzt6kwRsG8OvvmrdFNCnSJ1VHxaoJ+nUFF2JLbA==
X-Received: by 2002:a17:903:11d2:b0:19c:fc41:2dfd with SMTP id q18-20020a17090311d200b0019cfc412dfdmr1871435plh.29.1680586813828;
        Mon, 03 Apr 2023 22:40:13 -0700 (PDT)
Received: from [192.168.0.11] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709027b8f00b0019f789cddccsm7586104pll.19.2023.04.03.22.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 22:40:13 -0700 (PDT)
Message-ID: <70f40425-5793-af6e-7405-778bef140205@gmail.com>
Date:   Tue, 4 Apr 2023 14:40:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 10/10] mtd: spi-nor: spansion: Determine current
 address mode
To:     Tudor Ambarus <tudor.ambarus@linaro.org>, michael@walle.cc,
        pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
 <20230331074606.3559258-11-tudor.ambarus@linaro.org>
Content-Language: en-US
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20230331074606.3559258-11-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 4:46 PM, Tudor Ambarus wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Internal address mode (3- or 4-byte) affects to the address length in
> Read Any Reg op. Read Any Reg op is used in SMPT parse and other setup
> functions. Current driver assumes that address mode is factory default
> but users can change it via volatile and non-volatile registers.
> 
> Current address mode can be checked by CFR2V[7] but Read Any Reg op is
> needed to read CFR2V (chicken-and-egg).
> 
> Introduce a way to determine current address mode by comparing status
> register 1 values read by different address length.
> 
> Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/spansion.c | 131 ++++++++++++++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 1678b7b2e9f7..352c40dd3864 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -14,10 +14,12 @@
>  #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
>  #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
>  #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
> +#define SPINOR_REG_CYPRESS_STR1V		0x00800000
>  #define SPINOR_REG_CYPRESS_CFR1V		0x00800002
>  #define SPINOR_REG_CYPRESS_CFR1_QUAD_EN		BIT(1)	/* Quad Enable */
>  #define SPINOR_REG_CYPRESS_CFR2V		0x00800003
>  #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
> +#define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
>  #define SPINOR_REG_CYPRESS_CFR3V		0x00800004
>  #define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */
>  #define SPINOR_REG_CYPRESS_CFR5V		0x00800006
> @@ -188,6 +190,117 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
>  	return 0;
>  }
>  
> +/**
> + * cypress_nor_determine_addr_mode_by_sr1() - Determine current address mode
> + *                                            (3 or 4-byte) by querying status
> + *                                            register 1 (SR1).
> + * @nor:		pointer to a 'struct spi_nor'
> + * @addr_mode:		ponter to a buffer where we return the determined
> + *			address mode.
> + *
> + * This function tries to determine current address mode by comparing SR1 value
> + * from RDSR1(no address), RDAR(3-byte address), and RDAR(4-byte address).
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int cypress_nor_determine_addr_mode_by_sr1(struct spi_nor *nor,
> +						  u8 *addr_mode)
> +{
> +	struct spi_mem_op op =
> +		CYPRESS_NOR_RD_ANY_REG_OP(3, SPINOR_REG_CYPRESS_STR1V, 0,
> +					  nor->bouncebuf);
> +	bool is3byte, is4byte;
> +	int ret;
> +
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[1]);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> +
> +	is3byte = (nor->bouncebuf[0] == nor->bouncebuf[1]);
> +
> +	op = (struct spi_mem_op)
> +		CYPRESS_NOR_RD_ANY_REG_OP(4, SPINOR_REG_CYPRESS_STR1V, 0,
> +					  nor->bouncebuf);
> +	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> +
> +	is4byte = (nor->bouncebuf[0] == nor->bouncebuf[1]);
> +
> +	if (is3byte == is4byte)
> +		return -EIO;
> +	if (is3byte)
> +		*addr_mode = 3;
> +	else
> +		*addr_mode = 4;
> +
> +	return 0;
> +}
> +
> +/**
> + * cypress_nor_set_addr_mode_nbytes() - Set the number of address bytes mode of
> + *                                      current address mode.
> + * @nor:		pointer to a 'struct spi_nor'
> + *
> + * Determine current address mode by reading SR1 with different methods, then
> + * query CFR2V[7] to confirm. If determination is failed, force enter to 4-byte
> + * address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
> +{
> +	struct spi_mem_op op;
> +	u8 addr_mode;
> +	int ret;
> +
> +	/*
> +	 * Read SR1 by RDSR1 and RDAR(3- AND 4-byte addr). Use write enable
> +	 * that sets bit-1 in SR1.
> +	 */
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +	ret = cypress_nor_determine_addr_mode_by_sr1(nor, &addr_mode);
> +	if (ret) {
> +		ret = spi_nor_set_4byte_addr_mode(nor, true);
> +		if (ret)
> +			return ret;
> +		return spi_nor_write_disable(nor);
> +	}
> +	ret = spi_nor_write_disable(nor);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Query CFR2V and make sure no contradiction between determined address
> +	 * mode and CFR2V[7].
> +	 */
> +	op = (struct spi_mem_op)
> +		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode, SPINOR_REG_CYPRESS_CFR2V,
> +					  0, nor->bouncebuf);
> +	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> +
> +	if (nor->bouncebuf[0] & SPINOR_REG_CYPRESS_CFR2_ADRBYT) {
> +		if (addr_mode != 4)
> +			return spi_nor_set_4byte_addr_mode(nor, true);
> +	} else {
> +		if (addr_mode != 3)
> +			return spi_nor_set_4byte_addr_mode(nor, true);
> +	}
> +
> +	nor->params->addr_nbytes = addr_mode;
> +	nor->params->addr_mode_nbytes = addr_mode;
> +
> +	return 0;
> +}
> +
>  /**
>   * cypress_nor_set_page_size() - Set page size which corresponds to the flash
>   *                               configuration.
> @@ -227,9 +340,9 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
>  	struct spi_mem_op op;
>  	int ret;
>  
> -	/* 4-byte address mode is enabled by default */
> -	nor->params->addr_nbytes = 4;
> -	nor->params->addr_mode_nbytes = 4;
> +	ret = cypress_nor_set_addr_mode_nbytes(nor);
> +	if (ret)
> +		return ret;
>  
>  	/* Read Architecture Configuration Register (ARCFN) */
>  	op = (struct spi_mem_op)
> @@ -280,6 +393,12 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
>  			const struct sfdp_parameter_header *bfpt_header,
>  			const struct sfdp_bfpt *bfpt)
>  {
> +	int ret;
> +
> +	ret = cypress_nor_set_addr_mode_nbytes(nor);
> +	if (ret)
> +		return ret;
> +
>  	/* Replace Quad Enable with volatile version */
>  	nor->params->quad_enable = cypress_nor_quad_enable_volatile;
>  
> @@ -375,6 +494,12 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
>  				   const struct sfdp_parameter_header *bfpt_header,
>  				   const struct sfdp_bfpt *bfpt)
>  {
> +	int ret;
> +
> +	ret = cypress_nor_set_addr_mode_nbytes(nor);
> +	if (ret)
> +		return ret;
> +
>  	return cypress_nor_set_page_size(nor);
>  }
>  

Confirmed S25HS(default 3B), S28HS(default 3B), and S25FS256T(default 4B) works
fine on top of this series.

Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
