Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025B6B75E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCMLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCMLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:23:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6611B554
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:23:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so7596646wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678706593;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rLGVLPIFgOtKQ1a+wS1BAV+N288Bpp6n/Ucqc35qlWk=;
        b=LsS0c6J+AVoISiWAO7r4b6y6bCk7GMsfZGc+HT6F9Ghm4ywea71Wt7HovQtqwWGROc
         Q2hjYgT7/Un0AsBvQj0fZ7+hSqs38WeJy66EqMxbYvkU1yb+HGmeZ3ES2K3NazYH0106
         nJY2OQbVt5LRHUFJsugUg4sPXII6W+vCYWvqSa2TIR4RFXxA6KvxpTbfO8TfWmhBupge
         uVwgEmEQ4V1KnnftyXU7njK+XK09JvHVigQvuFM+RZTuMSj7RQEHmNsR2sAquNqI4vBB
         LhUlonJ1aGQTYIPSV5ceWrMQ6O8Y/xwtUA9Khu26iA6KZmWtYLUve1CHvx8LKYvkwcGT
         hHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706593;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLGVLPIFgOtKQ1a+wS1BAV+N288Bpp6n/Ucqc35qlWk=;
        b=06H3VQ+1zg4gID6+vW9RAAdb0lQ9pXkqZQ1Nc9oRlxkDNlHzS+23b7Z9lbvICjyKwG
         PE6CI1JMrU6UghRmoHmAly6H+aRteDclKqQiscvsqCwbMfetdWNy3yhL/LZFIvETQ3LG
         CL6IaLgApoH2UDCAnwbNfQ155vvkIkz9QtjgMg/d+1u47pNNRHyj2Zie/lu1cP3s412R
         YlTFb5Myww8g2Yr+1jYhKAqEVVk0fk2HmdqU2s3gw1sOt3SrpGOuXj/J+BhR7WvT4lkK
         YNSyxc/1Fwg14r8HOlGRXcHBHqa9FcZMnh5EGBG3L4EADvCNmvm9f9IHAG0PyrON9Vuu
         tLoQ==
X-Gm-Message-State: AO0yUKUwbeJPPFg2Hx8Xw+39aa4XZHubonPxg39VQmXjkuNZ7x1vHTd0
        MN+D6P3kEPURGvEhltaoBeoI2g==
X-Google-Smtp-Source: AK7set+23Z30ivSz/1PYJXbplwwpSZTCzPnvJWfBTeRwlu6P8xmv+JHCm0PNCVihMych6X7TsW8vSA==
X-Received: by 2002:a05:600c:314c:b0:3eb:29fe:70df with SMTP id h12-20020a05600c314c00b003eb29fe70dfmr10583571wmo.35.1678706593364;
        Mon, 13 Mar 2023 04:23:13 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b002c567881dbcsm7529470wrs.48.2023.03.13.04.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:23:13 -0700 (PDT)
Message-ID: <dc46c06f-6b36-3c1c-bf96-2ef37e29dfdb@linaro.org>
Date:   Mon, 13 Mar 2023 12:23:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v1] mtd: rawnand: meson: invalidate cache on polling
 ECC bit
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
References: <d4ef0bd6-816e-f6fa-9385-f05f775f0ae2@sberdevices.ru>
 <20f7f1f8-e8f8-b3e1-251e-27db71ab6840@sberdevices.ru>
 <20230313121808.27170d1b@xps-13>
Organization: Linaro Developer Services
In-Reply-To: <20230313121808.27170d1b@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 12:18, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Mon, 13 Mar 2023 10:36:11 +0300:
> 
>> Hello,
>>
>> we reproduced this problem on one of our boards. It triggers very rare
>> when 'usleep_range()' is present, but when sleeping is removed - it fires
>> always. I suppose problem is with caching, as 'info_buf' memory is mapped by
>> 'dma_map_single()'.
> 
> The fix looks really legitimate, indeed I get that the usleep_range()
> might make it work most of the time but not always. Having this bit in
> a DMA buf area is a bit strange. Well, the fix LGTM anyway.

Yep it looks legitimate!

LGTM


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
>>
>> Thanks, Arseniy
>>
>> On 13.03.2023 10:32, Arseniy Krasnov wrote:
>>> 'info_buf' memory is cached and driver polls ECC bit in it. This bit
>>> is set by the NAND controller. If 'usleep_range()' returns before device
>>> sets this bit, 'info_buf' will be cached and driver won't see update of
>>> this bit and will loop forever.
>>>
>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>>   drivers/mtd/nand/raw/meson_nand.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>> index 5ee01231ac4c..2c05c08a0eaf 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -176,6 +176,7 @@ struct meson_nfc {
>>>   
>>>   	dma_addr_t daddr;
>>>   	dma_addr_t iaddr;
>>> +	u32 info_bytes;
>>>   
>>>   	unsigned long assigned_cs;
>>>   };
>>> @@ -503,6 +504,7 @@ static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *databuf,
>>>   					 nfc->daddr, datalen, dir);
>>>   			return ret;
>>>   		}
>>> +		nfc->info_bytes = infolen;
>>>   		cmd = GENCMDIADDRL(NFC_CMD_AIL, nfc->iaddr);
>>>   		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>   
>>> @@ -520,8 +522,10 @@ static void meson_nfc_dma_buffer_release(struct nand_chip *nand,
>>>   	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>   
>>>   	dma_unmap_single(nfc->dev, nfc->daddr, datalen, dir);
>>> -	if (infolen)
>>> +	if (infolen) {
>>>   		dma_unmap_single(nfc->dev, nfc->iaddr, infolen, dir);
>>> +		nfc->info_bytes = 0;
>>> +	}
>>>   }
>>>   
>>>   static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>>> @@ -710,6 +714,8 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>   		usleep_range(10, 15);
>>>   		/* info is updated by nfc dma engine*/
>>>   		smp_rmb();
>>> +		dma_sync_single_for_cpu(nfc->dev, nfc->iaddr, nfc->info_bytes,
>>> +					DMA_FROM_DEVICE);
>>>   		ret = *info & ECC_COMPLETE;
>>>   	} while (!ret);
>>>   }
> 
> 
> Thanks,
> Miquèl

