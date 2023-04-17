Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A056E4119
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDQHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDQHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:33:03 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA294EC3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:32:09 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:33518.461400368
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 9940B100248;
        Mon, 17 Apr 2023 15:32:04 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id 3150ac44627a4b4cb80ece4c13008730 for christian.koenig@amd.com;
        Mon, 17 Apr 2023 15:32:07 CST
X-Transaction-ID: 3150ac44627a4b4cb80ece4c13008730
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <35ebedcb-cec7-54ea-2d60-8a8db19269ea@189.cn>
Date:   Mon, 17 Apr 2023 15:32:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dma-buf/dma-resv.c: fix a typo
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn
References: <20230416143849.1142779-1-suijingfeng@loongson.cn>
 <a8ca8691-5507-a80d-357c-43d45a44d799@amd.com>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <a8ca8691-5507-a80d-357c-43d45a44d799@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/17 14:58, Christian König wrote:
> Am 16.04.23 um 16:38 schrieb Sui Jingfeng:
>> The dma_resv_wait_timeout() function return a value greater than zero
>> on success.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>
> Reviewed and pushed to drm-misc-next.
>
Thanks.

> Thanks,
> Christian.
>
>> ---
>>   drivers/dma-buf/dma-resv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
>> index 2a594b754af1..b6f71eb00866 100644
>> --- a/drivers/dma-buf/dma-resv.c
>> +++ b/drivers/dma-buf/dma-resv.c
>> @@ -660,7 +660,7 @@ EXPORT_SYMBOL_GPL(dma_resv_get_singleton);
>>    * dma_resv_lock() already
>>    * RETURNS
>>    * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out, or
>> - * greater than zer on success.
>> + * greater than zero on success.
>>    */
>>   long dma_resv_wait_timeout(struct dma_resv *obj, enum 
>> dma_resv_usage usage,
>>                  bool intr, unsigned long timeout)
