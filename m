Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7C748BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjGESWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjGESW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:22:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0C2694
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:21:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso31270011fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688581256; x=1691173256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7iqWni3eK8x3dTleEGq98e3HnfEpiof9+EFvCVfJeA=;
        b=lcHhhZJ6UA3AaQGfvUqt/v6qgzBe4qjRli/ZwMNWbWFNKRJuoYH/PNcBNy64/kkQ77
         Qm1aUvHQGPebLCfWmTrgGclckRL2j19Cu2XFej0v1AWuWlpg0Si8hgXauI9+QgK0gBQ4
         2MADHn/a+BIrH8jeGN7OEyfb+N9fAyIYgNd2xBcalXN+8RPMcM2a35wdI0zJXiMPwKMd
         /kUxQVqpOykM6keZP7tPcp38JOnNiK8oCzYQ6kxbs5u9KFU9m9mOTc+5HAp7T4Nk5P8v
         4a0fQVoWHivgC2jfuBLVJ6m6YiErJ+3/lvX7+B3NqNSiaUrdb7D6NwEJGuMciykXo8Mj
         /SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581256; x=1691173256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7iqWni3eK8x3dTleEGq98e3HnfEpiof9+EFvCVfJeA=;
        b=J/wchp5Y9QyoCBB9OO50lFZDfiPTrloGqFnj9eQ7gqWmmyJsoO5krInRrrIlzTaIwZ
         KVU+p6tJD63/mXz6aPZ8l35UJsntAB+1QJChPWIy9z/FymzbOR2NvQYkW5L1EYknRWxV
         /elysYGDqqzTjZWQvI5C6B4TTyICNhva4aAAKoh+FcS7m577LVs7qnzBkrfEjiQrX/l9
         9XDRgPfymyWbmRWD1vu6KbGXTu00gGYt8TobX/JFHqOHDl/oU8fQczKGWdNE2DKh2BwI
         XcSsNhVeHnjP+EXpMoBY0rUxfzIyl/HM1e0NWz+eHk+XkkHnkzLYsZhK223V9lWvsrBD
         qDSg==
X-Gm-Message-State: ABy/qLYoTAz5xwj1wMBtlqpm55e31YuH6s+6seAJ3Q8AEhofPFfLKg9a
        P8uGlYMdaUwDB0OXns4kwqw=
X-Google-Smtp-Source: APBJJlGrUgXkEQsV1QF3xFlWaDw9jfN/TvbHLUD9SGHxGFDYPwKfO0V/VHYG98M8lFENx5tsGzAgfg==
X-Received: by 2002:a19:7418:0:b0:4f9:5d2a:e0f6 with SMTP id v24-20020a197418000000b004f95d2ae0f6mr11255992lfe.14.1688581255815;
        Wed, 05 Jul 2023 11:20:55 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b009931baa0d44sm6553278ejb.140.2023.07.05.11.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 11:20:55 -0700 (PDT)
Message-ID: <ebb0d719-4fa0-791d-f160-e8ffc75385b1@gmail.com>
Date:   Wed, 5 Jul 2023 20:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] mtd: rawnand: rockchip-nand-controller: copy hwecc
 PA data to oob_poi buffer
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
 <539cfba7-dd6f-015e-b990-a2335cb3aac9@gmail.com>
 <20230704170858.2a64c181@xps-13>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230704170858.2a64c181@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/23 17:08, Miquel Raynal wrote:
> Hi Johan,
> 
> jbx6244@gmail.com wrote on Thu, 15 Jun 2023 19:34:13 +0200:
> 
>> Rockchip boot blocks are written per 4 x 512 byte sectors per page.
>> Each page must have a page address (PA) pointer in OOB to the next page.

> 
> Only when used as boot device I guess? It's a BootROM limitation.

Yes, required by the BootROM.

> 
>> Pages are written in a pattern depending on the NAND chip ID.
>> This logic used to build a page pattern table is not fully disclosed and
>> is not easy to fit in the MTD framework.
>> The formula in rk_nfc_write_page_hwecc() function is not correct.
>> Make hwecc and raw behavior identical.
> 

> So this is a fix as well, deserves a tag. Whatever the reason why you
> need this, the issue you are solving is: write_page_hwecc and
> write_page_raw are not aligned.

Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")

> 
>> Generate boot block page address and pattern for hwecc in user space
>> and copy PA data to/from the already reserved last 4 bytes before EEC
> 
> ECC

OK

> 
>> in the chip->oob_poi data layout.
>>
>> This patch breaks all existing jffs2 users that have free OOB overlap
>> with the reserved space for PA data.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Changed V3:
>>   Change prefixes
>>   Reword
>> ---
>>  .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
>>  1 file changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> index 37fc07ba5..5a0468034 100644
>> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> @@ -598,7 +598,7 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
>>  	int pages_per_blk = mtd->erasesize / mtd->writesize;
>>  	int ret = 0, i, boot_rom_mode = 0;
>>  	dma_addr_t dma_data, dma_oob;
>> -	u32 reg;
>> +	u32 tmp;
>>  	u8 *oob;
>>
>>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>> @@ -625,6 +625,13 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
>>  	 *
>>  	 *   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
>>  	 *
>> +	 * The code here just swaps the first 4 bytes with the last
>> +	 * 4 bytes without losing any data.
>> +	 *
>> +	 * The chip->oob_poi data layout:
>> +	 *
>> +	 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
>> +	 *
>>  	 * Configure the ECC algorithm supported by the boot ROM.
>>  	 */
>>  	if ((page < (pages_per_blk * rknand->boot_blks)) &&
>> @@ -635,21 +642,17 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
>>  	}
>>
>>  	for (i = 0; i < ecc->steps; i++) {
>> -		if (!i) {
>> -			reg = 0xFFFFFFFF;
>> -		} else {
>> +		if (!i)
>> +			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
>> +		else
>>  			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
>> -			reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
>> -			      oob[3] << 24;
>> -		}
>>
>> -		if (!i && boot_rom_mode)
> 

> So we no longer need boot_rom_mode? Or do we?

boot_rom_mode is still in use for ecc switching.

> 
>> -			reg = (page & (pages_per_blk - 1)) * 4;
>> +		tmp = oob[0] | oob[1] << 8 | oob[2] << 16 | oob[3] << 24;
>>
>>  		if (nfc->cfg->type == NFC_V9)
>> -			nfc->oob_buf[i] = reg;
>> +			nfc->oob_buf[i] = tmp;
>>  		else
>> -			nfc->oob_buf[i * (oob_step / 4)] = reg;
>> +			nfc->oob_buf[i * (oob_step / 4)] = tmp;
>>  	}
>>
>>  	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
>> @@ -812,12 +815,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
>>  		goto timeout_err;
>>  	}
>>
>> -	for (i = 1; i < ecc->steps; i++) {
>> -		oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
>> +	for (i = 0; i < ecc->steps; i++) {
>> +		if (!i)
>> +			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
>> +		else
>> +			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
>> +
>>  		if (nfc->cfg->type == NFC_V9)
>>  			tmp = nfc->oob_buf[i];
>>  		else
>>  			tmp = nfc->oob_buf[i * (oob_step / 4)];
>> +
>>  		*oob++ = (u8)tmp;
>>  		*oob++ = (u8)(tmp >> 8);
>>  		*oob++ = (u8)(tmp >> 16);
>> --
>> 2.30.2
>>
> 
> 
> Thanks,
> Miquèl
