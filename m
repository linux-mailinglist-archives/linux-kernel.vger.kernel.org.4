Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEEF74B445
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGGP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGGP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:28:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16432694
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:28:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e29964942so2632619a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688743679; x=1691335679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCPt10eJunGxoUAty0wv+0oPojq0aRHxO6NScGjyhcQ=;
        b=HZMBDyODTA8zWGhK5iLK2t55lizqmA/vOEBGnYDBZ9mqESO/Xi2+REm3lwsqPYGkh8
         QiQCGzECTwgKUMhC6jWd9KwawAeIBv5rlndpSZ1IBp+vSEeMgI0fKSEPQkyIpSllLEqJ
         E8NvYmHoUTsmNan5NEiWCjNPyo1EJXEMh7xPdkAtbBGlBygaw3XRmDuONWnLbcCHkjkp
         F6cpcz2VSivZPCr7AeHKOL1Gf+4w6XKNzC2KSjfODTBXHD8Kh0mD/FgwuD47wqprpuUD
         b9NzxTIdcsD9Fs/BAYSvpp8IUUcs/N/dUDNaPwc76tiOFiFUyJfmIatnx+sV6yKSBDnv
         LBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743679; x=1691335679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCPt10eJunGxoUAty0wv+0oPojq0aRHxO6NScGjyhcQ=;
        b=CUHcemxKUtHY+zPZyo4cRbP9cPJpu1Ft37EI9ayVVbynecHlMF1Kfu7FSJubPmnaDu
         NgekXXV7ZvbiXDIzOaaV4W2XlKdpdUHliQxGGBx6WLTsxEkaM0kzqgnLmKE81ry8+lQc
         zmHhytdPBXXEEDx9aip6MhgobcZlsNb2lgC6ncrkWOwT7mb1m0yVUpOhF7GCSaK39Nrs
         meYEEMDWRwCHJgYcBrj6R7STk9b15wxMx35woOaSqaByYA+Gh1XPNCVabrhv/A6DG2Ti
         GMQ5DiYmRAv+xJpulJ1S8uTU4r8gZz/Ec8CYvDeULigTgrQKOfvpI8JF/33WrXD5aeLr
         uVKA==
X-Gm-Message-State: ABy/qLZ1bHOX0Ci6BSOXM/LKnuPGENU1Y4gpHDtn+NuNe0PYHR0Luj+H
        RtFs/ddqbkqt/qR4bQb0EtU=
X-Google-Smtp-Source: APBJJlGyjBwSP1v53L4dk2mg9m3aQdAHknb8EfcfR+h97k/CqOCDOgtKfInvuQm8Tt5MJsbZ5vO6nw==
X-Received: by 2002:a17:906:3f1d:b0:98d:e605:2bce with SMTP id c29-20020a1709063f1d00b0098de6052bcemr4137847ejj.46.1688743678991;
        Fri, 07 Jul 2023 08:27:58 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906851200b0098669cc16b2sm2278860ejx.83.2023.07.07.08.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 08:27:58 -0700 (PDT)
Message-ID: <3af40582-d350-8eac-8639-10c285964c49@gmail.com>
Date:   Fri, 7 Jul 2023 17:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add
 skipbbt option
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
 <457c1da7-61dc-2a56-4f86-47413795138c@gmail.com>
 <20230704171348.5eee98f7@xps-13>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230704171348.5eee98f7@xps-13>
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

Hi Miquel,

Some comments/questions below,

On 7/4/23 17:13, Miquel Raynal wrote:
> Hi Johan,
> 
> jbx6244@gmail.com wrote on Thu, 15 Jun 2023 19:34:26 +0200:
> 
>> On Rockchip SoCs the first boot stages are written on NAND

>> with help of manufacturer software that uses a different format
>> then the MTD framework. Skip the automatic BBT scan with the

Not only about the boot blocks.
The rest of the Nand is formatted as well by closed source.
It formats the location at the new BBT pages as well.

>> NAND_SKIP_BBTSCAN option so that the original content is unchanged
>> during the driver probe.
>> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
>> the nand_erase_nand() function and the flash_erase command.
>> With these options the user has the "freedom of choice" by neutral
>> access mode to read and write in whatever format is needed.
> 

> Can the boot_rom_mode thing help?

This boot_rom_mode thing is for switching ECC mode in boot block pages and is not related to BBT pages.

> 
> For writing this part you can disable the bad block protection using
> debugfs and then write an externally processed file in raw mode I guess.

The use of debugfs only might make sense when the driver can pass the probe function without errors.
It does however not save guard existing data when it creates and writes to a new BBT page location.
When the data at the new BBT pages previously is written with a different ECC or data/OOB format the hardware driver probe fails.

Your suggestion does not work for the Rockchip case.
Please advise what to do with this patch.

===

[ 2148.026403] calling  rk_nfc_driver_init+0x0/0x1000 [rockchip_nand_controller] @ 2062
[ 2148.039156] rockchip-nfc 10500000.nand-controller: timing 11e1
[ 2148.056891] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xde
[ 2148.067700] nand: Hynix H27UCG8T2ATR-BC 64G 3.3V 8-bit
[ 2148.076717] nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 8192, OOB size: 640
[ 2148.089022] rockchip-nfc 10500000.nand-controller: hynix_nand_init
[ 2148.099317] rockchip-nfc 10500000.nand-controller: h27ucg8t2atrbc_choose_interface_config
[ 2148.111779] rockchip-nfc 10500000.nand-controller: timing 11e1
[ 2148.129836] rockchip-nfc 10500000.nand-controller: rd hw page: 1048575
[ 2148.149364] rockchip-nfc 10500000.nand-controller: read page: fffff ecc error!
[ 2148.160742] rockchip-nfc 10500000.nand-controller: rd hw page: 1048319
[ 2148.180164] rockchip-nfc 10500000.nand-controller: read page: ffeff ecc error!
[ 2148.191413] rockchip-nfc 10500000.nand-controller: rd hw page: 1048063

[..]

Check for existing BBT pages.

[ 2148.339836] rockchip-nfc 10500000.nand-controller: read page: ffdff ecc error!
[ 2148.350864] rockchip-nfc 10500000.nand-controller: rd hw page: 1047807
[ 2148.369835] rockchip-nfc 10500000.nand-controller: read page: ffcff ecc error!
[ 2148.380597] Bad block table not found for chip 0
[ 2148.388479] Scanning device for bad blocks
[ 2148.395591] rockchip-nfc 10500000.nand-controller: rd hw page: 255
[ 2148.414087] rockchip-nfc 10500000.nand-controller: read page: max_bitflips: 0

[..]

Check all pages to create a new BBT.

[ 2258.693279] rockchip-nfc 10500000.nand-controller: rd hw page: 1030143
[ 2258.710970] rockchip-nfc 10500000.nand-controller: read page: max_bitflips: 0
[ 2258.720804] rockchip-nfc 10500000.nand-controller: rd hw page: 1030399
[ 2258.738394] rockchip-nfc 10500000.nand-controller: read page: fb8ff ecc error!
[ 2258.748229] Bad eraseblock 4024 at 0x0001f7000000

[..]

All BBT pages are marked bad, so it thinks there's no space left

[ 2261.403708] rockchip-nfc 10500000.nand-controller: rd hw page: 1048575
[ 2261.422750] rockchip-nfc 10500000.nand-controller: read page: fffff ecc error!
[ 2261.433634] Bad eraseblock 4095 at 0x0001ffe00000

[ 2261.441723] No space left to write bad block table

This is not done.
A Nand disk should not be altered if it's formatted in a different format unless an explicit command is given.

[ 2261.449860] nand_bbt: error while writing bad block table -28
[ 2261.467156] rockchip-nfc 10500000.nand-controller: failed to init NAND chips
[ 2261.477917] rockchip-nfc: probe of 10500000.nand-controller failed with error -28
[ 2261.497011] probe of 10500000.nand-controller returned 28 after 113456649 usecs
[ 2261.508273] initcall rk_nfc_driver_init+0x0/0x1000 [rockchip_nand_controller] returned 0 after 113468040 usecs

Probe failed, but there nothing wrong with hardware.
MTDx partitions are not created.
User space commands that rely strings like "/dev/mtd0" don't work.

===

Application
Kernel
Drivers
Hardware

Why do we fail a hardware driver probe when the level above doesn't deal with all real world situations.
Shouldn't that be more separated in MTD levels.

===

> 
> For the boot I think I proposed a DT property. I don't remember how far
> the discussion went.

Is there a web link of that discussion?

How do I link 'compatible' to '/dev/mtd0' for example.
In a '/proc/mtd' entry?
See /drivers/mtd/spi-nor/debugfs.c


In order to write boot blocks in a pattern it needs to know the chip ID as used in nand_flash_ids[].
How can we export this ID to userspace?
Also in a '/proc/mtd' entry?

===

		partitions {
			compatible = "fixed-partitions";
			#address-cells = <2>;
			#size-cells = <2>;

			partition@0 {
				reg = <0x0 0x0 0x0 0x02000000>;
				compatible = "rockchip,boot-blk";
				label = "boot-blk";
			};

			partition@2000000 {
				reg = <0x0 0x02000000 0x1 0xfa000000>;
				label = "rootfs";
			};

			partition@1fc000000 {
				reg = <0x1 0xfc000000 0x0 0x04000000>;
				compatible = "mtd,bbt"
				label = "bbt";
			};
		};

How many erase blocks is MTD using for BBT pages? 4 or 8 or ?

BBT pages are not clearly defined in the DT.
They are somehow marked bad in the overlapping partition.
How are suppose to erase BBT pages in a automated way?
Is there a need for a new BBT compatible?

What is your idea about compatibles suggestion:
rockchip,boot-blk
mtd,bbt

===

Johan

> 
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Changes V3:
>>   Change prefixes
>>
>> Changed V2:
>>   reword
>>
>> ---
>>
>> I'm aware that the maintainer finds it "awful",
>> but it's absolute necessary to:
>> 1: read/write boot blocks in user space without touching original content
>> 2: format a NAND for MTD either with built in or external driver module
>>
>> So we keep it include in this serie.
>> ---
>>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> index 5a0468034..fcda4c760 100644
>> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
>> @@ -188,6 +188,10 @@ struct rk_nfc {
>>  	unsigned long assigned_cs;
>>  };
>>
>> +static int skipbbt;
>> +module_param(skipbbt, int, 0644);
>> +MODULE_PARM_DESC(skipbbt, "Skip BBT scan if data on the NAND chip is not in MTD format.");
>> +
>>  static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip *chip)
>>  {
>>  	return container_of(chip, struct rk_nfc_nand_chip, chip);
>> @@ -1153,6 +1157,9 @@ static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,
>>
>>  	nand_set_controller_data(chip, nfc);
>>
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
