Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CC6B75E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCMLXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCMLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:23:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE161DBB0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:23:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cy23so47108984edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678706596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lf1/86ozgaIa3RAGsRCPww/jl+a9ZNIHp7P9TXGkzms=;
        b=Cx/1iSede1uZX+5ocrnlaNMuoP2OpXl1i7utUBcfvmTvKRkqGW9qCQQu/BMISybk6V
         fafywXHq/X0KU4NZmNpvCzGZ0XOXrXdhgScUZRKBUwzdLt59MMO5dWoJw+A+rBcuo4GN
         bFVwX/alrzoojK3Eh0jBg8jBA55jlP/dsPAsceA/AJa6XG2j7u90oeZBNClxzNVqTNEG
         y4vZDiJFrVTQZ7+hvHqitrYoFLsq25Wa7Q13NHmlj5O6DMHiNmBVLr05cQGuHPHr58wf
         6aAP5uDrq/O4Uin8y3FLFys49PRIo83MbRVPoCVRhpxTKexofpiqce34e/vhOS2yHm5o
         R8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf1/86ozgaIa3RAGsRCPww/jl+a9ZNIHp7P9TXGkzms=;
        b=Qvl09V/9rzJE/61LVFrexzdyV0yy2vwy595n5GwjiKhkKbFVysabvFxeq1mvrJkuj3
         gOX2s1vbLOWP+M/IK31RlfwrY7HD8r3G/3alai/1A/01Ewf3LcpOpcHhSTLi5QK2ofdh
         0x+MW9Cl+HL1WpiQcWv8N9snNFOqY/GdZps1yp8PMIC6WHd8pXPFYEXBzZsyUbXAuM50
         KP0ewlTa+zJY4Td0GAB8ry2var4vBOvKVWm8lou+1y1vgXo/vMETXPv00GNdncR5YsYn
         r1c0881DAfouHB1sN4XVhG/s4YtNIIK+stfhop76Hw3bUUutwWonsT8uNjK/vRxVNtMW
         B5mw==
X-Gm-Message-State: AO0yUKXfKH9naDiYO3ePKcM3frucFwv/tigBEkokPjg8VOyyfKZ6kIhT
        8jYwgk2i1xghqz9OVWwiJQ865A==
X-Google-Smtp-Source: AK7set+YPCeQcgti39T/fUEGCwOaIBLUWe9jpMzxFhKMF18/KNYCUiJGErM8NMh4xQEAmQefIxB/xg==
X-Received: by 2002:a17:907:c68a:b0:8de:acd1:90f6 with SMTP id ue10-20020a170907c68a00b008deacd190f6mr38250264ejc.4.1678706596350;
        Mon, 13 Mar 2023 04:23:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id pk10-20020a170906d7aa00b008d1693c212csm3310127ejb.8.2023.03.13.04.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:23:15 -0700 (PDT)
Message-ID: <939c029f-6679-b364-531c-bf0193135ffd@linaro.org>
Date:   Mon, 13 Mar 2023 11:23:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mtd: spi-nor: Add support for XMC XM25QH256C / XM25QU256C
 / XM25QH512C / XM25QU512C site: https://www.xmcwh.com/site/product#
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Luke He <sixuerain@gmail.com>, pratyush@kernel.org, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230313100153.15441-1-sixuerain@gmail.com>
 <d553beb1c6e38eac748d0b6b62bcd335@walle.cc> <20230313113304.1611638d@xps-13>
 <17d46633869f64e029e065693e341e3b@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <17d46633869f64e029e065693e341e3b@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/23 10:39, Michael Walle wrote:
> Am 2023-03-13 11:33, schrieb Miquel Raynal:
>> Hi Michael,
>>
>> michael@walle.cc wrote on Mon, 13 Mar 2023 11:08:15 +0100:
>>
>>> Hi,
>>>
>>> please have a look at Documentation/process/submitting-patches.rst
>>> how to properly format patches. But also see below.
>>>
>>> Am 2023-03-13 11:01, schrieb Luke He:
>>> > Signed-off-by: Luke He <sixuerain@gmail.com>
>>> > ---
>>> >  drivers/mtd/spi-nor/xmc.c | 12 ++++++++++++
>>> >  1 file changed, 12 insertions(+)
>>> >
>>> > diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
>>> > index 051411e86339..6db01b80237f 100644
>>> > --- a/drivers/mtd/spi-nor/xmc.c
>>> > +++ b/drivers/mtd/spi-nor/xmc.c
>>> > @@ -16,6 +16,18 @@ static const struct flash_info xmc_nor_parts[] = {
>>> >      { "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>>> >          NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>> >                    SPI_NOR_QUAD_READ) },
>>> > +    { "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
>>> > +        NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>> > +                  SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>> > +    { "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
>>> > +        NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>> > +                 SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>> > +    { "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
>>> > +        NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>> > +                 SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>> > +    { "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
>>> > +        NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>> > +                 SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) }
>>>
>>> I've just looked at XM25QH256C [1], but I suspect all of these
>>> flashes supports SFDP, therefore you shouldn't use the NO_SFDP_FLAGS.
>>
>> I didn't check, do we have a kdoc or something like that which explains
>> what flags to use and when?
> 
> https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/mtd/spi-nor/core.h#L429
> 
> What's missing is still some overview document when and how to add a new
> entry to our database. /me looks in Tudors direction :)
> 

Right, the code comments should help. I've been planning to do the
documentation, even started it few months ago, but I'm still behind with
some patch reviews, including Miquel's, so the documentation has to
wait. I'm doing this in my spare time, so I'll stop giving estimates.

Cheers,
ta
