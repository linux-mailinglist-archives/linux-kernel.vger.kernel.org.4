Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2612370B8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjEVJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjEVJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:22:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB7C6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:22:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f50e26b8bso715877766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684747327; x=1687339327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWgSPwQBspND+l5FgxYrCxjRrLfV4tAi/ncxGD1tzmY=;
        b=FkHTI+fsiFLIfDjjZ5x1vzvdzg/Inx3IhlSoCyRzBEtiI70M5Nj+tA+uHH2VbWzUpL
         fskgMO/+VQoj9OTYF1PLxgBzIfdKclOsHauE2Zw81v2nIT7oW2PG8NC6tNJE0TQht1Xd
         yf8D413LRuH8vlGkP5ACgqTW18Yrebli52a3/XIfkAvYCAY/5ST6JOW5lDqZnI6UE423
         hSNEh12LVhDuP26ei7qxgD3UMcF82/amjXo+LbwF/3eW0VUpbfNNL+D4JrtFcDZIrWCo
         Dka81MifnVt59oqHEfppyf6i41K5blguutbWMCsUgJpSI0jGoiHe8QqgFG9cTha+bMXJ
         Z+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684747327; x=1687339327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWgSPwQBspND+l5FgxYrCxjRrLfV4tAi/ncxGD1tzmY=;
        b=II+/GW5ggL4D5n/ty4NCI5tTwICAoC7mXeyS35TdjKhZ8tLCKkosd4TjxVofG+a84b
         QEojKm4Gck5N0HrNbDyWLuQlkMNbjIdmRxkzbdDuoms3mmIulbVjEw0u1zyMADxXSRWd
         FFEK8FrTCGT/5I3HiSGIh01vXjrXftFnZU91f//goR9a2otAoxhVeMBH8XxzIu1thFWB
         dD5y52whh8bKUmj2KjoF6F0O7Ucx/rx5riXBXEO4af9LMhj2Hbzma9BpjHE585NGaRM4
         IvZzR+p21S+j4TJW5TydstvCav44SJ/6pCUgNtujZDnZ2l6cCQXw4YIUdo4e4fDwu7qs
         PH7A==
X-Gm-Message-State: AC+VfDxWDeFpJ8di+iZv2h4JYPh3q98zR27z8TstLyvvFdeC/5GrXE1V
        hWz77hgudlqAR71dlSUvd5oT0A==
X-Google-Smtp-Source: ACHHUZ4llMsUm3mMQoEICKe9reTv0ubUpgf7y1rkTtZnCilVcgETeccWP3R23LSJ4AHV9kWAwFh8hw==
X-Received: by 2002:a17:907:1611:b0:966:37b2:7354 with SMTP id hb17-20020a170907161100b0096637b27354mr10227963ejc.31.1684747327487;
        Mon, 22 May 2023 02:22:07 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id kt26-20020a170906aada00b009663cf5dc3bsm2892334ejb.53.2023.05.22.02.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 02:22:07 -0700 (PDT)
Message-ID: <0c8a54ae-7f32-2614-9717-a00fe561513e@linaro.org>
Date:   Mon, 22 May 2023 10:22:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mtd: spi-nor: Fix divide by zero for spi-nor-generic
 flashes
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, todd.e.brandt@intel.com, vigneshr@ti.com,
        pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        regressions@lists.linux.dev, joneslee@google.com,
        Todd Brandt <todd.e.brandt@linux.intel.com>
References: <20230518085440.2363676-1-tudor.ambarus@linaro.org>
 <20230522102953.2fdf2b02@xps-13>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230522102953.2fdf2b02@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 09:29, Miquel Raynal wrote:
> Hi Tudor,

Hi, Miquel,

> 
> tudor.ambarus@linaro.org wrote on Thu, 18 May 2023 08:54:40 +0000:
> 
>> We failed to initialize n_banks for spi-nor-generic flashes, which
>> caused a devide by zero when computing the bank_size.
>>
>> By default we consider that all chips have a single bank. Initialize
>> the default number of banks for spi-nor-generic flashes. Even if the
>> bug is fixed with this simple initialization, check the n_banks value
>> before dividing so that we make sure this kind of bug won't occur again
>> if some other struct instance is created uninitialized.
>>
>> Suggested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
>> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217448
>> Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
>> Link: https://lore.kernel.org/all/20230516225108.29194-1-todd.e.brandt@intel.com/
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/mtd/spi-nor/core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 0bb0ad14a2fc..5f29fac8669a 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2018,6 +2018,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
>>  
>>  static const struct flash_info spi_nor_generic_flash = {
>>  	.name = "spi-nor-generic",
>> +	.n_banks = 1,
> 
> I definitely missed that structure.
> 
>>  	/*
>>  	 * JESD216 rev A doesn't specify the page size, therefore we need a
>>  	 * sane default.
>> @@ -2921,7 +2922,8 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
>>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>>  		spi_nor_init_default_locking_ops(nor);
>>  
>> -	nor->params->bank_size = div64_u64(nor->params->size, nor->info->n_banks);
>> +	if (nor->info->n_banks > 1)
>> +		params->bank_size = div64_u64(params->size, nor->info->n_banks);
> 
> I'm fine with the check as it is written because it also look like an
> optimization, but bank_size should never be 0 otherwise it's a real bug

bank_size was introduced just for chips featuring several banks, but we
made this field mandatory for all flashes, regardless of their type. I
find this restriction unnecessary, because we can differentiate the RWW
flashes by checking the SNOR_F_RWW flag. So the alternative to this
patch is to remove the n_banks restriction and set it just for the RWW
flashes. I think I prefer this, but keep in mind that I never read a RWW
flash's datasheet, not publicly available, so the decision is in your
court. Happy to make a patch.

> that must be catch and fixed. We do not want uninitialized bank_size's.>
>>  }
>>  
>>  /**
>> @@ -2987,6 +2989,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>>  	/* Set SPI NOR sizes. */
>>  	params->writesize = 1;
>>  	params->size = (u64)info->sector_size * info->n_sectors;
>> +	params->bank_size = params->size;
>>  	params->page_size = info->page_size;
> 
> We actually discarded that line in a previous discussion:
> https://lore.kernel.org/linux-mtd/20230331194620.839899-1-miquel.raynal@bootlin.com/T/#mcb4f90f7ca48ffe3d9838b2ac6f74e44460c51bd
> 
> I'm fine to re-add it though, it does not hurt.

we would get rid of this init as well with my suggestion.

Keep in mind that the bug was introduced in 6.4, so we'll have to fix
this fast, let's come to an agreement.

Cheers,
ta
> 
>>  
>>  	if (!(info->flags & SPI_NOR_NO_FR)) {
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miquèl
