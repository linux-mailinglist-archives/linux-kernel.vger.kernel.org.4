Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3EC705678
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjEPS6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPS6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:58:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5ADB;
        Tue, 16 May 2023 11:58:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so13413366a12.2;
        Tue, 16 May 2023 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263530; x=1686855530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7EO4n2Laz1C8qlwm0BP2KlWTOgG8jnlCRu8xYXVkBlM=;
        b=MLdDUCoUXgY3VBc/rG1vVKVuaE1Q0o8/k3HGC2dyqrjZRlmTTkH8Lg1E4Zi0qE9ko4
         AKGMH3/QCg70BRCEqyjyq2Z5GdWjCcpI+BQrdiKVNnts3+LlsBxk7F5NmILLGJzWznv/
         E7M+lc52SvCc9pyjHrxtvETLbOK5xHSbEu3fbBwgRnbp5KVP8gqEd6IrkTZbIOWHq/53
         3rp/VrPbNU1r+KwhSRLM7n+EOiJJR42SKrEkve/XkFNIAqDc8VT6bdHYRta0TcpK97cL
         qGEP8lszoL3GfSkb3b63V2grpmNueF4f5omuGTEbcnW1sSaD5py89A3zLVXy4snIAx6u
         7Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263530; x=1686855530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EO4n2Laz1C8qlwm0BP2KlWTOgG8jnlCRu8xYXVkBlM=;
        b=K3eLK4DhUO6pctd0EKX6Mb9kMRJPHXUfXVg5DxftxG44Lw/gjzKKvBDcQkdRZVjbIe
         jMZ77yC42MPDCuPRkkZTs1Z+iC9NmYaK1p6DhGucGb3EnNdcFiiuYCPqZ2fyFDvoKJ9L
         7yPdwaRe7dueBEaDXb1LDs6P5x1dTuGNeIA9AaZHcguYN2bTgsgdclMs19hwtZF0/gdi
         aNkqVIbjRm/b2Yj3OwM0A02D+CcO4O+A8RyZoQuSarUn2ai128MsrIYxmmej09qpQOOn
         S8GXHTChuMO/s7JVE1l81XgEkZM/dxaqlUPR8k/MVhK0vp1dP9+0MIJsxwmUq8zLDQ/5
         MjZg==
X-Gm-Message-State: AC+VfDwSYH0+/0tIguEFmquk0O8m2rlFSssIu+YqQgNJmGynGreCr8Oh
        KPHlQC378NjEsTLKmW9E0kg=
X-Google-Smtp-Source: ACHHUZ5CUsECtgNKu55O5QVrBpZTCG2cVdRZpXkmGOKliZK8PRC4JUHzZkvrgQg1GcCsCLTIZ6wUaQ==
X-Received: by 2002:a05:6a21:6d8b:b0:104:961d:9e6d with SMTP id wl11-20020a056a216d8b00b00104961d9e6dmr18591524pzb.37.1684263530149;
        Tue, 16 May 2023 11:58:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m26-20020aa78a1a000000b0063b7f3250e9sm13836231pfa.7.2023.05.16.11.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 11:58:49 -0700 (PDT)
Message-ID: <d0543f48-6f0b-58e0-cc18-695a28c493fc@gmail.com>
Date:   Tue, 16 May 2023 11:58:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new
 binding
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        liao jaime <jaimeliao.tw@gmail.com>,
        "William (Zhenghao) Zhang" <william.zhang@broadcom.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAAQoYRm3766SG7+VuwVzu_xH8aWihoKWMEp8xQGNgJ6oOtC9+g@mail.gmail.com>
 <CAAQoYRmXdMp7b2r+yCRUtGrbfQH-Cb8gMAVo7YscuQEM5kgajw@mail.gmail.com>
 <CAKR-sGdiLzZ7iVbLmz1uPwYoUXQZ2qGwmCBAq_-OKXfVT=Pj-A@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKR-sGdiLzZ7iVbLmz1uPwYoUXQZ2qGwmCBAq_-OKXfVT=Pj-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+William,

On 5/16/23 11:55, Álvaro Fernández Rojas wrote:
> Hi Jaime,
> 
> I've reproduced the issue on a Comtrend VR-3032u (MX30LF1G08AA). After
> forcing it to check block protection (it's not supported on that
> device), the NAND controller stops reading/writing anything.
> 
> @Florian is it possible that low level ops (GET_FEATURES/SET_FEATURES)
> aren't supported on BCM63268 NAND controllers and this is causing the
> issue?

Yes, this looks like what we have seen as well even with newer NAND 
controllers actually. Would it be possible to obtain a full log from 
either of you?

William, is this something you have seen before as well?

> 
> Best regards,
> Álvaro.
> 
> El mié, 26 abr 2023 a las 9:24, liao jaime (<jaimeliao.tw@gmail.com>) escribió:
>>
>> Hi Álvaro
>>
>> In nand_scan_tail(), each manufacturer init function call will be execute.
>> In macronix_nand_init(), block protect will be execute after flash detect.
>> I have validate MX30LF1G18AC in Linux kernel v5.15.
>> I didn't got situation "device hangs"  on my side.
>> BP is to prevent incorrect operations.
>> Please check the controller settings for tracing this issue.
>>
>> Thanks
>> Jaime
>>
>>>
>>> Hello YouChing and Jaime,
>>>
>>> I still didn't get any feedback from you (or Macronix) on this issue.
>>> Did you have time to look into it?
>>>
>>> Thanks,
>>> Álvaro.
>>>
>>> El vie, 24 mar 2023 a las 18:04, Álvaro Fernández Rojas
>>> (<noltari@gmail.com>) escribió:
>>>>
>>>> Hi Miquèl,
>>>>
>>>> 2023-03-24 15:36 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com>:
>>>>> Hi Álvaro,
>>>>>
>>>>> + YouChing and Jaime from Macronix
>>>>> TLDR for them: there is a misbehavior since Mason added block
>>>>> protection support. Just checking if the blocks are protected seems to
>>>>> misconfigure the chip entirely, see below. Any hints?
>>>>
>>>> Could it be that the NAND is stuck expecting a read 0x00 command which
>>>> isn’t sent after getting the features?
>>>>
>>>>>
>>>>> noltari@gmail.com wrote on Fri, 24 Mar 2023 15:15:47 +0100:
>>>>>
>>>>>> Hi Miquèl,
>>>>>>
>>>>>> 2023-03-24 14:45 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com>:
>>>>>>> Hi Álvaro,
>>>>>>>
>>>>>>> noltari@gmail.com wrote on Fri, 24 Mar 2023 12:21:11 +0100:
>>>>>>>
>>>>>>>> El vie, 24 mar 2023 a las 11:49, Miquel Raynal
>>>>>>>> (<miquel.raynal@bootlin.com>) escribió:
>>>>>>>>>
>>>>>>>>> Hi Álvaro,
>>>>>>>>>
>>>>>>>>> noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:
>>>>>>>>>
>>>>>>>>>> Hi Miquèl,
>>>>>>>>>>
>>>>>>>>>> El vie, 24 mar 2023 a las 10:40, Miquel Raynal
>>>>>>>>>> (<miquel.raynal@bootlin.com>) escribió:
>>>>>>>>>>>
>>>>>>>>>>> Hi Álvaro,
>>>>>>>>>>>
>>>>>>>>>>> noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
>>>>>>>>>>>
>>>>>>>>>>>> Add new "mxic,disable-block-protection" binding documentation.
>>>>>>>>>>>> This binding allows disabling block protection support for
>>>>>>>>>>>> those
>>>>>>>>>>>> devices not
>>>>>>>>>>>> supporting it.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>   Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3
>>>>>>>>>>>> +++
>>>>>>>>>>>>   1 file changed, 3 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git
>>>>>>>>>>>> a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>>>>>>>>>>>> b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>>>>>>>>>>>> index ffab28a2c4d1..03f65ca32cd3 100644
>>>>>>>>>>>> --- a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>>>>>>>>>>>> @@ -16,6 +16,9 @@ in children nodes.
>>>>>>>>>>>>   Required NAND chip properties in children mode:
>>>>>>>>>>>>   - randomizer enable: should be "mxic,enable-randomizer-otp"
>>>>>>>>>>>>
>>>>>>>>>>>> +Optional NAND chip properties in children mode:
>>>>>>>>>>>> +- block protection disable: should be
>>>>>>>>>>>> "mxic,disable-block-protection"
>>>>>>>>>>>> +
>>>>>>>>>>>
>>>>>>>>>>> Besides the fact that nowadays we prefer to see binding
>>>>>>>>>>> conversions
>>>>>>>>>>> to
>>>>>>>>>>> yaml before adding anything, I don't think this will fly.
>>>>>>>>>>>
>>>>>>>>>>> I'm not sure exactly what "disable block protection" means, we
>>>>>>>>>>> already have similar properties like "lock" and
>>>>>>>>>>> "secure-regions",
>>>>>>>>>>> not
>>>>>>>>>>> sure they will fit but I think it's worth checking.
>>>>>>>>>>
>>>>>>>>>> As explained in 2/2, commit 03a539c7a118 introduced a regression
>>>>>>>>>> on
>>>>>>>>>> Sercomm H500-s (BCM63268) OpenWrt devices with Macronix
>>>>>>>>>> MX30LF1G18AC
>>>>>>>>>> which hangs the device.
>>>>>>>>>>
>>>>>>>>>> This is the log with block protection disabled:
>>>>>>>>>> [    0.495831] bcm6368_nand 10000200.nand: there is not valid maps
>>>>>>>>>> for
>>>>>>>>>> state default
>>>>>>>>>> [    0.504995] nand: device found, Manufacturer ID: 0xc2, Chip ID:
>>>>>>>>>> 0xf1
>>>>>>>>>> [    0.511526] nand: Macronix MX30LF1G18AC
>>>>>>>>>> [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
>>>>>>>>>> 2048, OOB size: 64
>>>>>>>>>> [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB total,
>>>>>>>>>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
>>>>>>>>>> [    0.535912] Bad block table found at page 65472, version 0x01
>>>>>>>>>> [    0.544268] Bad block table found at page 65408, version 0x01
>>>>>>>>>> [    0.954329] 9 fixed-partitions partitions found on MTD device
>>>>>>>>>> brcmnand.0
>>>>>>>>>> ...
>>>>>>>>>>
>>>>>>>>>> This is the log with block protection enabled:
>>>>>>>>>> [    0.495095] bcm6368_nand 10000200.nand: there is not valid maps
>>>>>>>>>> for
>>>>>>>>>> state default
>>>>>>>>>> [    0.504249] nand: device found, Manufacturer ID: 0xc2, Chip ID:
>>>>>>>>>> 0xf1
>>>>>>>>>> [    0.510772] nand: Macronix MX30LF1G18AC
>>>>>>>>>> [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
>>>>>>>>>> 2048, OOB size: 64
>>>>>>>>>> [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB total,
>>>>>>>>>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
>>>>>>>>>> [    0.539687] Bad block table not found for chip 0
>>>>>>>>>> [    0.550153] Bad block table not found for chip 0
>>>>>>>>>> [    0.555069] Scanning device for bad blocks
>>>>>>>>>> [    0.601213] CPU 1 Unable to handle kernel paging request at
>>>>>>>>>> virtual
>>>>>>>>>> address 10277f00, epc == 8039ce70, ra == 8016ad50
>>>>>>>>>> *** Device hangs ***
>>>>>>>>>>
>>>>>>>>>> Enabling macronix_nand_block_protection_support() makes the device
>>>>>>>>>> unable to detect the bad block table and hangs it when trying to
>>>>>>>>>> scan
>>>>>>>>>> for bad blocks.
>>>>>>>>>
>>>>>>>>> Please trace nand_macronix.c and look:
>>>>>>>>> - are the get_features and set_features really supported by the
>>>>>>>>>    controller driver?
>>>>>>>>
>>>>>>>> This is what I could find by debugging:
>>>>>>>> [    0.494993] bcm6368_nand 10000200.nand: there is not valid maps for
>>>>>>>> state default
>>>>>>>> [    0.505375] nand: device found, Manufacturer ID: 0xc2, Chip ID:
>>>>>>>> 0xf1
>>>>>>>> [    0.512077] nand: Macronix MX30LF1G18AC
>>>>>>>> [    0.515994] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
>>>>>>>> 2048, OOB size: 64
>>>>>>>> [    0.523928] bcm6368_nand 10000200.nand: detected 128MiB total,
>>>>>>>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
>>>>>>>> [    0.534415] bcm6368_nand 10000200.nand: ll_op cmd 0xa00ee
>>>>>>>> [    0.539988] bcm6368_nand 10000200.nand: ll_op cmd 0x600a0
>>>>>>>> [    0.545659] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
>>>>>>>> [    0.551214] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
>>>>>>>> 0x00
>>>>>>>> [    0.557843] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
>>>>>>>> [    0.563475] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
>>>>>>>> 0x00
>>>>>>>> [    0.569998] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
>>>>>>>> [    0.575653] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
>>>>>>>> 0x00
>>>>>>>> [    0.582246] bcm6368_nand 10000200.nand: ll_op cmd 0x80010000
>>>>>>>> [    0.588067] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
>>>>>>>> 0x00
>>>>>>>> [    0.594657] nand: nand_get_features: addr=a0 subfeature_param=[00
>>>>>>>> 00 00 00] -> 0
>>>>>>>> [    0.602341] macronix_nand_block_protection_support:
>>>>>>>> ONFI_FEATURE_ADDR_MXIC_PROTECTION=0
>>>>>>>> [    0.610548] macronix_nand_block_protection_support: !=
>>>>>>>> MXIC_BLOCK_PROTECTION_ALL_LOCK
>>>>>>>> [    0.624760] Bad block table not found for chip 0
>>>>>>>> [    0.635542] Bad block table not found for chip 0
>>>>>>>> [    0.640270] Scanning device for bad blocks
>>>>>>>>
>>>>>>>> I don't know how to tell if get_features / set_features is really
>>>>>>>> supported...
>>>>>>>
>>>>>>> Looks like your driver does not support exec_op but the core provides a
>>>>>>> get/set_feature implementation.
>>>>>>
>>>>>> According to Florian, low level should be supported on brcmnand
>>>>>> controllers >= 4.0
>>>>>> Also:
>>>>>> https://github.com/nomis/bcm963xx_4.12L.06B_consumer/blob/e2f23ddbb20bf75689372b6e6a5a0dc613f6e313/shared/opensource/include/bcm963xx/63268_map_part.h#L1597
>>>>>
>>>>> Just to be sure, you're using a mainline controller driver, not this
>>>>> one?
>>>>
>>>> Yes, this was just to prove that the HW I’m using has get/set features support.
>>>> I’m using OpenWrt, so it’s linux v5.15 driver.
>>>>
>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> - what is the state of the locking configuration in the chip when
>>>>>>>>> you
>>>>>>>>>    boot?
>>>>>>>>
>>>>>>>> Unlocked, I guess...
>>>>>>>> How can I check that?
>>>>>>>
>>>>>>> It's in your dump, the chip returns 0, meaning it's all unlocked,
>>>>>>> apparently.
>>>>>>
>>>>>> Well, I can read/write the device if block protection isn’t disabled,
>>>>>> so I guess we can confirm it’s unlocked…
>>>>>>
>>>>>>>
>>>>>>>>> - is there anything that locks the device by calling mxic_nand_lock()
>>>>>>>>> ?
>>>>>>>
>>>>>>> So nobody locks the device I guess? Did you add traces there?
>>>>>>
>>>>>> It doesn’t get to the point that it enabled the lock/unlock functions
>>>>>> since it fails when checking if feature is 0x38, so there’s no point
>>>>>> in adding those traces…
>>>>>
>>>>> Right, it returns before setting these I guess.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>> - finding no bbt is one thing, hanging is another, where is it
>>>>>>>>> hanging
>>>>>>>>>    exactly? (offset in nand/ and line in the code)
>>>>>>>>
>>>>>>>> I've got no idea...
>>>>>>>
>>>>>>> You can use ftrace or just add printks a bit everywhere and try to get
>>>>>>> closer and closer.
>>>>>>
>>>>>> I think that after trying to get the feature it just start reading
>>>>>> nonsense from the NAND and at some point it hangs due to that garbage…
>>>>>
>>>>> It should refuse to mount the device somehow, but in no case the kernel
>>>>> should hang.
>>>>
>>>> Yes, I think that this is a side effect (maybe a different bug somewhere else).
>>>>
>>>>>
>>>>>> Is it posible that the NAND starts behaving like this after getting
>>>>>> the feature due to some specific config of my device?
>>>>>>
>>>>>>>
>>>>>>> I looked at the patch, I don't see anything strange. Besides, I have a
>>>>>>> close enough datasheet and I don't see what could confuse the device.
>>>>>>>
>>>>>>> Are you really sure this patch is the problem? Is the WP pin wired on
>>>>>>> your design?
>>>>>>
>>>>>> There’s no WP pin in brcmnand controllers < 7.0
>>>>>
>>>>> What about the chip?
>>>>
>>>> Maybe it has a GPIO controlling that, but I don’t have that info…
>>>>
>>>>>
>>>>> Thanks,
>>>>> Miquèl
>>>>>

-- 
Florian

