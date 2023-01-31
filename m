Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD75682D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjAaNKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjAaNKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:10:16 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AC54F87B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:09:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guoheyi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VaX6U-C_1675170563;
Received: from 30.233.48.168(mailfrom:guoheyi@linux.alibaba.com fp:SMTPD_---0VaX6U-C_1675170563)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 21:09:35 +0800
Message-ID: <a5920ee3-7168-7415-f975-fcdbdde069d5@linux.alibaba.com>
Date:   Tue, 31 Jan 2023 21:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   Heyi Guo <guoheyi@linux.alibaba.com>
Subject: Re: [PATCH] drivers/spi-nor: add support for Winbond w25q01jv
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
References: <20230128033957.125853-1-guoheyi@linux.alibaba.com>
 <c7c3c4cf5dd477953e366053859df08f@walle.cc>
Content-Language: en-US
In-Reply-To: <c7c3c4cf5dd477953e366053859df08f@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/30 下午5:29, Michael Walle wrote:
> Hi,
>
>> Winbond W25Q01JV is a 128MB SPI-NOR flash chip.
>>
>> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
>>
>> -- 
>> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Michael Walle <michael@walle.cc>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> Cc: linux-mtd@lists.infradead.org
>> ---
>>  drivers/mtd/spi-nor/winbond.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/winbond.c 
>> b/drivers/mtd/spi-nor/winbond.c
>> index ca39acf4112c8..0cd49f534bf8d 100644
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -142,6 +142,9 @@ static const struct flash_info 
>> winbond_nor_parts[] = {
>>      { "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>>          NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>                    SPI_NOR_QUAD_READ) },
>> +    { "w25q01jv", INFO(0xef4021, 0, 64 * 1024, 2048)
>> +        NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> +                  SPI_NOR_QUAD_READ) },
>
> I'd guess this flash has SFDP support, correct?

Yes, the spec says it supports SFDP :)


> In this case,
> could you please try the latest next (or -rc) kernel without
> this change?

Is v6.2-rc3 OK for the test? If so, surely I can do that.

Thanks for your comments :)

Heyi


> In the meantime we have a generic spi-nor driver [1]
> so you don't need a new entry in most cases.
>
> Apart from that, it would be nice if you could dump the
> SFDP tables, see [2].
>
> -michael
>
> [1] 
> https://elixir.bootlin.com/linux/v6.2-rc5/source/drivers/mtd/spi-nor/core.c#L1638
> [2] https://lore.kernel.org/r/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
