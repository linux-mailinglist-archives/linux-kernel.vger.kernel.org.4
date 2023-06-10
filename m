Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF372AF64
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjFJWN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjFJWN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:13:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC635A9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:13:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so5363602a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686435203; x=1689027203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0o0Yvc3c6FVV1VluGu/lqaqZRz1w2u2WvuBDLHSzGq8=;
        b=IjFLu5Be4nnmTBiTHV1WJxs0jww/SeCu0YgQ4DhraObX4wPMy1MZrRNY0HTrPOMNhA
         KZewv4qiAjVJe+ZSbUsMxrUb5b1Bb4uo/O5Q39z5DzqDO41jWo8mlys6kmwO4VZcumO0
         /e7r6HbYXSQP4V4lZy8A/4a/D9++vjJg0qGEdkbJAr3ZPRR+jWfVHJ0ZRfQDxdFi9nVt
         X8AFEIkgiHgEd0w2NQpVu5Uwwxc5XHrqBLwOafECS84vM7NOwokuteZxAqrjSlWHGLgv
         3kV6EzU1Pl+A8ldEXm+gqAx5gCY+khHp+yBv0ZlfaPS6dzT3T3bMgCHBGfKw/9tHxbxO
         IMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686435203; x=1689027203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0o0Yvc3c6FVV1VluGu/lqaqZRz1w2u2WvuBDLHSzGq8=;
        b=D/d8h8BH7igN5p6Q9HJN+xpciYzHKgdC6RrK+40Twwmq0R8NfIrvT/y314nClCVij1
         oGviQWcOre7Me1fQUkWYxOJ1NKvVtJ30eDcTyeWcYv0fMFE3QUMEEuc02W7WaJFsOO7r
         o8P+40VkHyhmCVdaJScZK0P3EzQ1z6+uYbuAmDGp8JLb00hEmKuKOX739xiDPsMtqugd
         lm5C+7m69JIXVRImT9AlHWKnq8/VGHVdJQZjdsLzQ4AAyMdZUoUx23wZyg0FZ8Z/qcLe
         U8VfrYTkVtoKik/zlcXkxBl69BAiD0Y85k8r9oZ7GIwk4AdnzgPDYt1eJyieQeOxDYyp
         ObFA==
X-Gm-Message-State: AC+VfDyYzaqaXx3QRLH34uCkTMG5RrsBJyJtO3Rek+EVbAVvPQHXdKSp
        ms+cb2OxmbO9bNTyPQvBQEU=
X-Google-Smtp-Source: ACHHUZ72K8bKVnLgNDLVUH3TqR5tF036RDmlhZ8fjazxLDTxntBAuCbSCXvrptbdDOUCysKJJPX1Gw==
X-Received: by 2002:aa7:df84:0:b0:514:a4c9:e43b with SMTP id b4-20020aa7df84000000b00514a4c9e43bmr2480758edy.5.1686435203461;
        Sat, 10 Jun 2023 15:13:23 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c7-20020a056402120700b00514b99afa57sm3265105edw.44.2023.06.10.15.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 15:13:22 -0700 (PDT)
Message-ID: <78aa84a3-4080-2a50-dea9-4948f6b6a2d1@gmail.com>
Date:   Sun, 11 Jun 2023 00:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/5] mtd: nand: raw: rockchip-nand-controller: add
 skipbbt option
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
 <4d9473ce-c167-47d7-e37a-7b39915a724c@gmail.com>
 <20230609104426.3901df54@xps-13>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230609104426.3901df54@xps-13>
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






On 6/9/23 10:44, Miquel Raynal wrote:
> Hi Johan,
> 
> jbx6244@gmail.com wrote on Thu, 8 Jun 2023 18:30:27 +0200:
> 
>> On Rockchip SoCs the first boot stages are written on NAND
>> with help of manufacturer software that uses a different format
>> then the MTD framework. Skip the automatic BBT scan with the
>> NAND_SKIP_BBTSCAN option so we can run it manually.
> 

> How do you run it manually?
> 
>> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
>> the nand_erase_nand() function and the flash_erase command.
> 
> For erasure you now have access to a debugfs entry for

Hi Miquel,

Thank for your comments.
It's not about erasure alone. 

> experts/forensics which allows you to bypass all bad block checks.


It would be nice if all manufacturers would have taken the MTD framework as center for there NAND activity.
In the real world Rockchip has done it there own way.
For the Rockchip rk3066 SoC we still depend on a closed source loader/usbplug to either (1) load U-Boot/Linux from MMC or (2) write Linux to NAND with help of a closed source FTL.

We currently end up in these scenarios:

(1)
Full NAND support in U-Boot that works with all existing tools is still WIP.
I've done some work there, but still incomplete:

Fixes for Rockchip NFC driver part 1
https://lore.kernel.org/u-boot/be3c5f12-9df4-0a52-4858-c44d848e9147@gmail.com/

Proof of concept:
[PATCH v2 00/11] Add Rockchip IDB device
https://lore.kernel.org/u-boot/a1458a7b-2043-6397-3107-2d1fdf08c8e1@gmail.com/

So if users already manage to use U-Boot they probably skip formatting due to the lack of support or not at all if they don't manage to solder the missing serial debug port in the box.
Best chance is most users see all blocks marked as bad due to the different format when this module is built in.
On top of that the MTD framework also starts a block search loop and a mess with the original content in particular at the BBT location in the last blocks which is "not done" if not MTD formatted yet!
If a user only wants to read/write/erase boot blocks he/she must do so without effect on other content.
A fixed module parameter is then the better option either as built-in or as separate module then your debugfs suggestion that is not going to work for the average user.

(2)
When Linux is loaded from NAND with help of a FTL "what most users still do". It should not start to overwrite it's own blocks of that just happens to be MTD BBT blocks.

===

Both cases require a more neutral probe beside the optimal normal Linux boot flow with already MTD formatted.

Johan


===

Example skipbbt function in existing driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/nand/raw/cafe_nand.c#n80


> 
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> index cafccc324..f56430f6c 100644
>> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> @@ -188,6 +188,10 @@ struct rk_nfc {
>>  	unsigned long assigned_cs;
>>  };
>>
>> +static int skipbbt;
>> +module_param(skipbbt, int, 0644);
>> +MODULE_PARM_DESC(skipbbt, "Skip BBT scan if the NAND chip contains data not in MTD format.");
> 

> I highly dislike this.

When build in how to change probe behavior in a more neutral way?
No scanning, erasing allowed everywhere and no changes to original content!

> 
> It's not a module parameter that you need, it is related to a partition.

Please advise what text could be better in this case.

> 
>> +
>>  static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip *chip)
>>  {
>>  	return container_of(chip, struct rk_nfc_nand_chip, chip);
>> @@ -1156,6 +1160,10 @@ static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,
>>
>>  	nand_set_controller_data(chip, nfc);
>>
>> +	/* Skip the automatic BBT scan so we can run it manually. */
>> +	if (skipbbt)
>> +		chip->options |= NAND_SKIP_BBTSCAN | NAND_NO_BBM_QUIRK;
>> +
>>  	chip->options |= NAND_USES_DMA | NAND_NO_SUBPAGE_WRITE;
>>  	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
>>
>> --
>> 2.30.2
>>
> 
> 
> Thanks,
> Miquèl
