Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16A72F79A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbjFNISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbjFNISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:18:02 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B45782108
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:17:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxKuqdd4lkbggFAA--.10678S3;
        Wed, 14 Jun 2023 16:17:33 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxCOWbd4lk614aAA--.9610S3;
        Wed, 14 Jun 2023 16:17:31 +0800 (CST)
Message-ID: <67c7f462-6564-0d54-9eda-0e97f66bee8b@loongson.cn>
Date:   Wed, 14 Jun 2023 16:17:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/fbdev-generic: Remove a redundant assignment clause
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230614013011.750598-1-suijingfeng@loongson.cn>
 <b99747c5-8810-d2b6-80c7-dbc85fcefb8b@suse.de>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <b99747c5-8810-d2b6-80c7-dbc85fcefb8b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxCOWbd4lk614aAA--.9610S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw17JFWDWr1UAFWUGFyxCrX_yoW8ZF15pF
        Z5KFW5GryDKF4rGF4xJwnxJryUXanrJa4DKr18Aa4jyr4qyryI9FykZrn0gF15Jw4xGF4U
        JrnI9F97uryxCrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uuWJUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/14 13:29, Thomas Zimmermann wrote:
> Hi
>
> Am 14.06.23 um 03:30 schrieb Sui Jingfeng:
>> The assignment "dst = map;" in the drm_fbdev_generic_damage_blit() 
>> function
>> is redundant because it has already been copied when the call to
>> drm_client_buffer_vmap() is finished. Therefore, this patch saves a 
>> useless
>> copy. No functional change.
>
> Isn't that what we discussed here?
>
Yeah,

Lucas say he would like to take a deeper look in later time.

Then, two and half a mouths passed, it seem that no one send

fix patch.

I thinks this is an exercise for me, I resend this patch again.

Any idea?

> https://lore.kernel.org/dri-devel/20230325074636.136833-1-15330273260@189.cn/ 
>
>
> Best regards
> Thomas
>
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/drm_fbdev_generic.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c 
>> b/drivers/gpu/drm/drm_fbdev_generic.c
>> index 98ae703848a0..aa6924e3a58c 100644
>> --- a/drivers/gpu/drm/drm_fbdev_generic.c
>> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>> @@ -182,7 +182,7 @@ static int drm_fbdev_generic_damage_blit(struct 
>> drm_fb_helper *fb_helper,
>>                        struct drm_clip_rect *clip)
>>   {
>>       struct drm_client_buffer *buffer = fb_helper->buffer;
>> -    struct iosys_map map, dst;
>> +    struct iosys_map map;
>>       int ret;
>>         /*
>> @@ -202,8 +202,7 @@ static int drm_fbdev_generic_damage_blit(struct 
>> drm_fb_helper *fb_helper,
>>       if (ret)
>>           goto out;
>>   -    dst = map;
>> -    drm_fbdev_generic_damage_blit_real(fb_helper, clip, &dst);
>> +    drm_fbdev_generic_damage_blit_real(fb_helper, clip, &map);
>>         drm_client_buffer_vunmap(buffer);
>
-- 
Jingfeng

