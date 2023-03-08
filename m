Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327876B025B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCHJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCHJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:05:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D519AFCC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:05:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so733803wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678266299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kA8QaXHaQv2zTvTrF1F5tUB/9uaPE/un/rBzeew06Qk=;
        b=q89OEdbdQ8/5wEe6qFgIWzh3vd6s4xaRgf89QS/3X4cOBtJctnoIMQxxEkA1D1BiHI
         0rPMGxYv1A8HM3xCu5rwnUu1Ej1pGr2yhOovW1vpKhfjmrhnTXnSrnkTPEb2jQaLNjCu
         gjPvDpbonBmkmrER6l1D5vxT9FfWi6H61jHjcQqvRP49uhXANQfBL/nTJmVo9mW1K9+n
         yBrlg1+msaFsX+hZi1yQGq1ALarkY7lxAgSKSy51rXIuUTDYzdRIQ4Td+1aCJOW/HPYu
         E7T1Lo6gbBZA2NMhBQNGnjngG9/h7JB3LioUT5eLeFK7zU7ue/RKGy/ITsQAn5o7NDuO
         SNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA8QaXHaQv2zTvTrF1F5tUB/9uaPE/un/rBzeew06Qk=;
        b=MxBOkI3F3KAauXsgpCw/YWxTQt0B5Z3Hvc9aA8uW/StZJPPp8G4h++TXULhoFIxHcj
         omNy9cW6sl+xo53ftclZRlNVoiD/Ci8/SvfSR9Pg8un1hEzmGXNBVrWkV5dRBRaBsfQ9
         hOAUsJZqODHiikXwIYE13aNBu4WyBNCrj34o0quj3lQottEFZXz7VHlF08luSb3/aWVp
         MmULIgZptJ1g1PO5W1SxvnaZ4VaN/bp+vWZ62MvrONPrRZ9N3Ms5+4+SOTuBmH5r0/q/
         lO9uKxksyQc2xhkbmoNMj3PV6mjipx+fNT2VCcFSW5qKgchAJ3hvXSnZEhEqQY+1XFiz
         To/w==
X-Gm-Message-State: AO0yUKU2S6qJCHMMKbdc+Gk/a1ygirIVMnv1kArJpjjDqvgn48d+nm6U
        3/9u12kaBDU9GtZ3Ct0mecJdFg==
X-Google-Smtp-Source: AK7set/L9zFk+/3muQ4XCE6qXO8h4slPi9HcknR81cfBA77IySEK46FikrIsHFywPlVNMXfACef86g==
X-Received: by 2002:a05:600c:1907:b0:3eb:29fe:7b9e with SMTP id j7-20020a05600c190700b003eb29fe7b9emr14295268wmq.17.1678266299463;
        Wed, 08 Mar 2023 01:04:59 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id v38-20020a05600c4da600b003eb68bb61c8sm14645299wmp.3.2023.03.08.01.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:04:58 -0800 (PST)
Message-ID: <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
Date:   Wed, 8 Mar 2023 09:04:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
To:     Serge Semin <fancer.lancer@gmail.com>, Sergiu.Moga@microchip.com,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, joel@jms.id.au, andrew@aj.id.au,
        kdasu.kdev@gmail.com, han.xu@nxp.com, john.garry@huawei.com,
        matthias.bgg@gmail.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, haibo.chen@nxp.com,
        yogeshgaur.83@gmail.com, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20220926172454.kbpzck7med5bopre@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sarge,

On 9/26/22 18:24, Serge Semin wrote:
>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>> index f2c64006f8d7..cc8ca824f912 100644
>>>> --- a/drivers/mtd/spi-nor/core.c
>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>> @@ -88,7 +88,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>>>        if (op->addr.nbytes)
>>>>                op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>>>
>>>
>>>
>>>> -     if (op->dummy.nbytes)
>>>> +     if (op->dummy.ncycles)
>>>>                op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>>>
>>>>        if (op->data.nbytes)
>>>> @@ -106,9 +106,6 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>>>                op->dummy.dtr = true;
>>>>                op->data.dtr = true;
>>>>
>>>> -             /* 2 bytes per clock cycle in DTR mode. */
>>>> -             op->dummy.nbytes *= 2;
>>>> -
>>>>                ext = spi_nor_get_cmd_ext(nor, op);
>>>>                op->cmd.opcode = (op->cmd.opcode << 8) | ext;
>>>>                op->cmd.nbytes = 2;
>>>> @@ -207,10 +204,7 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
>>>>
>>>>        spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
>>>>
>>>> -     /* convert the dummy cycles to the number of bytes */
>>>> -     op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
>>>> -     if (spi_nor_protocol_is_dtr(nor->read_proto))
>>>> -             op.dummy.nbytes *= 2;
>>>> +     op.dummy.ncycles = nor->read_dummy;
>>> So according to this modification and what is done in the rest of the
>>> patch, the dummy part of the SPI-mem operations now contains the number
>>> of cycles only. Am I right to think that it means a number of dummy
>>> clock oscillations? (Judging from what I've seen in the HW-manuals of
>>> the SPI NOR memory devices most likely I am...)
>>
>>
>> Yes, you are correct.
>>

I confirm.

>>
>>> If so the "ncycles" field
>>> is now free from the "data" semantic. Then what is the meaning of the
>>> "buswidth and "dtr" fields in the spi_mem_op.dummy field?
>>>
>>
>> It is still meaningful as it is used for the conversion by some drivers 
>> to nbytes and I do not see how it goes out of the specification in any 
>> way. So, at least for now, I do not see any reason to remove these fields.
> I do see the way these fields are used in the SPI-mem drivers. I was
> wondering what do these bits mean in the framework of the SPI-mem
> core? AFAICS from the specification the dummy cycles are irrelevant to
> the data bus state. It says "the master tri-states the bus during
> 'dummy' cycles." If so I don't see a reason to have the DTR and
> buswidth fields in the spi_mem_op structure anymore. The number of
> cycles could be calculated right on the initialization stage based on
> the SPI NOR/NAND requirements.
> 
> @Mark, @Tudor, @Pratyush, what do you think?
> 

In an ideal world, where both the controller and the device talk about
dummy number of cycles, I would agree with you, buswidth and dtr should
not be relevant for the number of dummy cycles. But it seems that there
are old controllers (e.g. spi-hisi-sfc-v3xx.c, spi-mt65xx.c, spi-mxic.c)
that support buswidths > 1 and work only with dummy nbytes, they are not
capable of specifying a smaller granularity (ncycles). Thus the older
controllers would have to convert the dummy ncycles to dummy nbytes.
Since mixed transfer modes are a thing (see jesd251, it talks about
4S-4D-4D), where single transfer mode (S) can be mixed with double
transfer mode (D) for a command, the controller would have to guess the
buswidth and dtr of the dummy. Shall they replicate the buswidth and dtr
of the address or of the data? There's no rule for that. So we're forced
to keep the dummy.{dtr, buswidth} fields by the old controllers that
don't understand dummy ncycles.

I'm going to send a v2 of this patch, I'll add you in To. Thanks for
taking the time to review this patch!

Cheers,
ta
