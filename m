Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C127437B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjF3Isb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF3Is3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:48:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A111FD8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:48:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992b27e1c55so175606566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688114905; x=1690706905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ND7dNyhnZmormo1qsszJJ6OCUF3X4qBa9aUSKAs9Fo=;
        b=Nlop1p62Zh/45QHOahMCSK6OJcwNbUS62VDJ3r31xRt2FnsftZi2QO4R/NsyYDZa5e
         1zvPGzveJSdE+ybzyfS33E+L5xlInvTspjfDA8z5AUCz7MPpqtqzNuSbwQvlVlAh/s0G
         j0MsN5Z9ygKJyEuzKfccg/FlbUMjrP06pBmizZLbO2k7/lodJQmyVTVIXApbuKOhCa1c
         m1YWjsZE2/1gTfl9AkGS9Ml31kryTbvVgk5VJCD0wtyqwiybaQNTFmFDTwZPzMADUjGV
         WevQQI7HdEm6uiFz1X86+RpgaAC6rKZfsYkS0GEGQjMAw/fVJX2QXxYREi/NH2mhLiYm
         5RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114905; x=1690706905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ND7dNyhnZmormo1qsszJJ6OCUF3X4qBa9aUSKAs9Fo=;
        b=DqMGgqhm/dsesLqKBcoTtUZ1dDhkzvjLEAYO3/FEFN8irOI+yD0Vc5KJfcq+jpNYLR
         M0E20mWg9irtUaAVGGiGJwblTOdmFWsitXSSNO09xD7Ad88hTrO5YUGCW2+9Q4kIp465
         fEQk2eSDzNbYZ+uelETZauDK3WxGvTJ3AU3F6LgSjmw5WWck1dZrviLcbSQaPRTz3JX/
         KN2g2mkRRM6Grec6PkRjcvg1vW1bEtkYhvUtp7NXKACktsV4lhj27Aa5C/s7/nf1X28C
         gAQGEDP9mFksc65e3PpEl/+vtp9rCwRYtJSVHHOFUJkTB+wIBBjlx/GTixxTs4wE+9q8
         ivAQ==
X-Gm-Message-State: AC+VfDxbBjfjLYwhz2GJseDFSGwcq7oAm2JXwQhaEo7E4e5G8+ItBIjJ
        BkfZCCHhVOfWl6UNdcAnH30FqA==
X-Google-Smtp-Source: APBJJlH6NE+RJWp/uuJQSzzT7DyyRhteXkuogpPYaAVVGrddaQHIhsAoLXUO3RwlY41Mjc0+tAWgJw==
X-Received: by 2002:a17:906:4dcb:b0:96f:8439:6143 with SMTP id f11-20020a1709064dcb00b0096f84396143mr1384083ejw.40.1688114905435;
        Fri, 30 Jun 2023 01:48:25 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.171])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906960200b0098d2261d189sm7913892ejx.19.2023.06.30.01.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 01:48:24 -0700 (PDT)
Message-ID: <6190c9c4-6d6e-7577-f2a4-8fbede61b405@linaro.org>
Date:   Fri, 30 Jun 2023 09:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP#
 signal not connected
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        git@amd.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
 <20230625100251.31589-3-amit.kumar-mahapatra@amd.com>
 <5e5fe22aebe17da4f9ad2c4eaaa8985f@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <5e5fe22aebe17da4f9ad2c4eaaa8985f@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/23 07:14, Michael Walle wrote:
> Am 2023-06-25 12:02, schrieb Amit Kumar Mahapatra:
>> Setting the status register write disable (SRWD) bit in the status
>> register (SR) with WP# signal of the flash left floating or wrongly tied to
>> GND (that includes internal pull-downs), will configure the SR permanently
>> as read-only. If WP# signal is left floating or wrongly tied to GND, avoid
>> setting SRWD bit while writing the SR during flash protection.
>>
>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>> ---
>>  drivers/mtd/spi-nor/core.c | 3 +++
>>  drivers/mtd/spi-nor/core.h | 1 +
>>  drivers/mtd/spi-nor/swp.c  | 9 +++++++--
>>  3 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 0bb0ad14a2fc..520f5ab86d2b 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2864,6 +2864,9 @@ static void spi_nor_init_flags(struct spi_nor *nor)
>>      if (flags & NO_CHIP_ERASE)
>>          nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
>>
>> +    if (of_property_read_bool(np, "no-wp"))
>> +        nor->flags |= SNOR_F_NO_WP;
>> +
> 
> Please put it below the of_property_read_bool() which is already
> there, just to keep things sorted.
> 
>>      if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
>>          !nor->controller_ops)
>>          nor->flags |= SNOR_F_RWW;
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index 4fb5ff09c63a..55b5e7abce6e 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -132,6 +132,7 @@ enum spi_nor_option_flags {
>>      SNOR_F_SWP_IS_VOLATILE    = BIT(13),
>>      SNOR_F_RWW        = BIT(14),
>>      SNOR_F_ECC        = BIT(15),
>> +    SNOR_F_NO_WP        = BIT(16),
> 
> See the comment right above this enum :/
> 
>>  };
>>
>>  struct spi_nor_read_command {
>> diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
>> index 0ba716e84377..cfaba41d74d6 100644
>> --- a/drivers/mtd/spi-nor/swp.c
>> +++ b/drivers/mtd/spi-nor/swp.c
>> @@ -214,8 +214,13 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>>
>>      status_new = (status_old & ~mask & ~tb_mask) | val;
>>
>> -    /* Disallow further writes if WP pin is asserted */
>> -    status_new |= SR_SRWD;
>> +    /*
>> +     * Disallow further writes if WP# pin is neither left floating nor
>> +     * wrongly tied to GND(that includes internal pull-downs).
> 
> nit: space missing
> 
> Otherwise looks good.
> 

Thanks, Michael.

Amit, would be good if you can address Michael's comments and
resubmit. If not, I'll amend the patch by myself when applying.

Cheers,
ta
