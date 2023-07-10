Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2774D827
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGJNui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGJNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:50:36 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68EE2BA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:50:34 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dxg_CoDKxkhDEDAA--.9114S3;
        Mon, 10 Jul 2023 21:50:32 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxsyYDKxkUGYnAA--.24416S3;
        Mon, 10 Jul 2023 21:50:31 +0800 (CST)
Message-ID: <425f7fb4-265f-2d71-9554-eabafdd227d2@loongson.cn>
Date:   Mon, 10 Jul 2023 21:50:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/loongson: Fix two warnings because of passing wrong
 type
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Li Yi <liyi@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>
References: <20230710100931.255234-1-suijingfeng@loongson.cn>
 <87h6qcjc46.fsf@intel.com>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <87h6qcjc46.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxxsyYDKxkUGYnAA--.24416S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr47KFWrKr48Zr43tw13trc_yoW5WrWrpF
        45CF1jkr4DJF12yws7GF42q34Sva1SqFZaqrZrJ3Zxuw1DAF1UXF1kWFW5Kry3ZFWjy3WS
        vrs3Gay3K3WqvwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jbTmhUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/7/10 18:26, Jani Nikula wrote:
> On Mon, 10 Jul 2023, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>> When accessing I/O memory, we should pass '__iomem *' type instead of
>> 'void *' simply, otherwise sparse tests will complain. After applied
>> this patch, the following two sparse warnings got fixed.
> Usually the commit message should explain why it's okay to cast away the
> warning.
>
> Because realistically this doesn't "fix" the warning, this merely hides
> it.


The reason why we don't fix this at the very beginning is that

we are following the ttm_kmap_obj_virtual() and the ttm_bo_kmap() function.

Our lsdc_bo_kmap() is implemented with the ttm_bo_kmap() function.


Another reason is that this warning don't emerge when compile with W=1,

at least this is true on our platform.


We don't think this warning is harmful, because implicit cast will do 
the cast for us.

It is just that we need eliminate the noise as a programmer.


Again, for the code at here, before you do the de-reference operation,

As long as a address is really(originally) point to the I/O memory, cast 
it to 'void __iomem *' is OK.

As long as a address is really(originally) point to the system memory, 
cast it to 'void *' is OK.


> BR,
> Jani.
>
>> 1) drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35:
>>     sparse:     expected void volatile [noderef] __iomem *
>>     sparse:     got void *kptr
>>
>> 2) drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51:
>>     sparse:     expected void const volatile [noderef] __iomem *
>>     sparse:     got void *kptr
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202307100243.v3hv6aes-lkp@intel.com/
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_benchmark.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_benchmark.c b/drivers/gpu/drm/loongson/lsdc_benchmark.c
>> index b088646a2ff9..36e352820bdb 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_benchmark.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_benchmark.c
>> @@ -24,7 +24,7 @@ static void lsdc_copy_gtt_to_vram_cpu(struct lsdc_bo *src_bo,
>>   	lsdc_bo_kmap(dst_bo);
>>   
>>   	while (n--)
>> -		memcpy_toio(dst_bo->kptr, src_bo->kptr, size);
>> +		memcpy_toio((void __iomem *)dst_bo->kptr, src_bo->kptr, size);
>>   
>>   	lsdc_bo_kunmap(src_bo);
>>   	lsdc_bo_kunmap(dst_bo);
>> @@ -39,7 +39,7 @@ static void lsdc_copy_vram_to_gtt_cpu(struct lsdc_bo *src_bo,
>>   	lsdc_bo_kmap(dst_bo);
>>   
>>   	while (n--)
>> -		memcpy_fromio(dst_bo->kptr, src_bo->kptr, size);
>> +		memcpy_fromio(dst_bo->kptr, (void __iomem *)src_bo->kptr, size);
>>   
>>   	lsdc_bo_kunmap(src_bo);
>>   	lsdc_bo_kunmap(dst_bo);

