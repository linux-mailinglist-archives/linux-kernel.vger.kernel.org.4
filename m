Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9372F8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbjFNJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjFNJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:23:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93B10E6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:23:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9823de726c3so86152566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686734626; x=1689326626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF9DiKi27qDNuUORKCvbVYXEPKOZZECq30qh1+aywdA=;
        b=rIjL/AuuGxm8g0I/gXXOlG7SQwCLqNVbREffXbWpNuOobfQtt3cC6VMr3Nsr1+gsh2
         dWyZU+KmcTc8fc18xLButVlGxIIlCjRj9CbFYsi6aN4Z2Br73KPn0sZq/qxtQLTllW/5
         J0CbgpnT2DniCfBJiDhqwtewOMOm9/Q/TthFO9+FANEulXZ5ybXSGxOAWTwObR1BubNQ
         rwReNNTdIZBNN1tsO8jU7HWCTS1wFCP7Chwdifrxmfq94NIXTdspF3gVYOAiJDW5Ec3p
         57VBAiHr0iSrjzHNq7emV1P931O4GHXL38qkqgAHBhJKL4IPEB4YDZxvK8BwtRz8u1gM
         YYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734626; x=1689326626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TF9DiKi27qDNuUORKCvbVYXEPKOZZECq30qh1+aywdA=;
        b=jvY14JrbEX0rWyCXfAfSG9fD6EFEMHS9LaX4UfdkJvW5XkHe/AcDJLmSkPDdyBSEAV
         hExoDtrhAdDQHDijKcYIWj27tPu0htpEljysSj2gjrQY9VMSgkpyiw9j3RK7ZtFg0zxB
         VaNqWD0bI+kxcfEMDzJyD49TdKfCyos+zNOWvVem6zEVf3W1Ih9u7VQ9qY3YZVjaOusW
         vT974mJIveRO+/IFmBtHRtSOVKmAdH2atAFK2P1PbeULJq1fUsvnZfN6RJ+A7701mb3N
         hadiWK+P/+PJBe084JIqTgSwtpI647cowJtO5KZmpIn22NBUqgOn0/hQ471CDiyZVx+m
         6Slg==
X-Gm-Message-State: AC+VfDzzDKT3lOJxmlywGyZKuK0nw8DnauTNw+K2QAxV81m0g1ussyPa
        JEa4A7JnC0kJj1DSauCr/Co=
X-Google-Smtp-Source: ACHHUZ73ZIT1tNvI4o/D8vL9DseZfJLD3vBtHI1wqXykCmCHryA8gfFFkG3empnmjNtiii26jO5y+Q==
X-Received: by 2002:a17:907:3681:b0:96b:e93:3aa8 with SMTP id bi1-20020a170907368100b0096b0e933aa8mr17898748ejc.21.1686734626156;
        Wed, 14 Jun 2023 02:23:46 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906045a00b0096fc35ca733sm7696954eja.41.2023.06.14.02.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 02:23:45 -0700 (PDT)
Message-ID: <8457ff3d-f033-8d06-42ca-d95f77ec8145@gmail.com>
Date:   Wed, 14 Jun 2023 11:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] mtd: nand: raw: rockchip-nand-controller: fix
 oobfree offset and description
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
 <f2cebf54-a16c-c849-a988-bfd98c502748@gmail.com>
 <20230612192640.63baf3e8@xps-13>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230612192640.63baf3e8@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 19:26, Miquel Raynal wrote:
> Hi Johan,
> 
> jbx6244@gmail.com wrote on Mon, 12 Jun 2023 17:03:18 +0200:
> 
>> The MTD framework reserves 1 or 2 bytes for the bad block marker
>> depending on the bus size. The rockchip-nand-controller driver
>> currently only supports a 8 bit bus, but reserves standard 2 bytes
>> for the BBM.
> 
> We always reserve 2 bytes, no?

Not always used, but for consistency/simplicity the author assumes/reserves 2 bytes. 

> 
>> The first free OOB byte is therefore OOB2 at offset 2.
>> Page address(PA) bytes are moved to the last 4 positions before
>> ECC. Update the description for Linux.
> 
> The description should just be:
> 

> Move Page Address (PA) bytes to the last 4 positions before ECC.

Space is already reserved, but overwritten.

> 
> And then you should justify why this is needed. Also, this would break
> all existing jffs2 users, right?

Hi Miquel,

From your comments it seems that the chip->oob_poi buffer layout is still not clear to you.
Hope that this text below helps.
If existing jffs2 users of free OOB are writing they are corrupting our PA data in RAW mode.
So that must be fixed. Please advise how we split pre and post change users.
(With a Module parameter like skipbbt renamed to "user_mode" = 0 offset 6, "user_mode" = 1 offset 2)
Copying PA data in both RAW and HW mode has already reserved space in the layout.
Let me know if I can help to get forward here.

Johan

===

Given:

Rockchip rk3066 MK808 with NAND:
nand: Hynix H27UCG8T2ATR-BC 64G 3.3V 8-bit
nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 8192, OOB size: 640

===

Calulations:

#define NFC_SYS_DATA_SIZE		(4) /* 4 bytes sys data in oob pre 1024 data.*/

So per step only 4 bytes of OOB can be read.

===

The NFC can read/write in 1024 data bytes per step.
To read/write a full page it needs 8 steps.

chip->ecc.size = 1024;
chip->ecc.steps = mtd->writesize / chip->ecc.size;
                = 8192 / 1024
                = 8 steps
===

The total size of usefull OOB before ECC:

rknand->metadata_size = NFC_SYS_DATA_SIZE * ecc->steps;
                      = 4 * 8
                      = 32
===

Wrong free OOB offset starts at OOB6:
oob_region->offset = NFC_SYS_DATA_SIZE + 2;
                   = 4 + 2
                   = 6

With a free OOB offset of 6 and a length of 26 ==> 6 + 26 = 32 we corrupt the PA address starting at offset 28.

New offset OOB2:
oob_region->offset = 2;

The full range of free runs from OOB2 till/including OOB27.
===

The last 4 bytes of metadata are reserved for this Page Address(PA) for the bootrom.
Currently only in use in RAW mode.
The current PA calculation needed to write boot blocks for all Rockchip SoCs is however useless.
The pattern of where the next page is written depends on the chip ID.
As the MTD framework doesn't pass this chip ID in it's data structures,
we must calculate that in userspace.

Therefore both RAW and HW mode must pass the PA bytes.

===

The NFC hardware is capable for a 16 bit bus, but not implemented yet.
Reserved are standard 2 bits for the BBM for a consistantency by the original author.

===

chip->oob_poi buffer layout for 8 steps:

BBM0   BBM1  OOB2  OOB3  | OOB4  OOB5  OOB6  OOB7

OOB8   OOB9  OOB10 OOB11 | OOB12 OOB13 OOB15 OOB15
OOB16  OOB17 OOB18 OOB19 | OOB20 OOB21 OOB22 OOB23

OOB24  OOB25 OOB26 OOB27 | PA0   PA1   PA2   PA3

ECC0   ECC1  ECC2  ECC3  | ...   ...   ...   ...

===

rk_nfc_ooblayout_free:
oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
                   = 32 - 4 - 2
                   = 26

oob_region->offset = 2;

Free OOB should start at OOB2 to not overwrite PA data.

===

rk_nfc_ooblayout_ecc:
	oob_region->length = mtd->oobsize - rknand->metadata_size;
	                   = 640 - 32
	                   = 608
	oob_region->offset = rknand->metadata_size;
	                   = 32

ECC data starts at offset 32.

===


> 
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> index 31d8c7a87..fcda4c760 100644
>> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> @@ -566,9 +566,10 @@ static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
>>  		 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
>>  		 *
>>  		 * The rk_nfc_ooblayout_free() function already has reserved
>> -		 * these 4 bytes with:
>> +		 * these 4 bytes together with 2 bytes for BBM
>> +		 * by reducing it's length:
>>  		 *
>> -		 * oob_region->offset = NFC_SYS_DATA_SIZE + 2;
>> +		 * oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
>>  		 */
>>  		if (!i)
>>  			memcpy(rk_nfc_oob_ptr(chip, i),
>> @@ -945,12 +946,8 @@ static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
>>  	if (section)
>>  		return -ERANGE;
>>
>> -	/*
>> -	 * The beginning of the OOB area stores the reserved data for the NFC,
>> -	 * the size of the reserved data is NFC_SYS_DATA_SIZE bytes.
>> -	 */
>>  	oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
>> -	oob_region->offset = NFC_SYS_DATA_SIZE + 2;
>> +	oob_region->offset = 2;
>>
>>  	return 0;
>>  }
>> --
>> 2.30.2
>>
> 
> 
> Thanks,
> Miquèl
