Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC85274D4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGJLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:34:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CABFE1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:34:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxNvHW7KtkCB8DAA--.9167S3;
        Mon, 10 Jul 2023 19:34:46 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxviPE7Ktk5DwnAA--.5489S3;
        Mon, 10 Jul 2023 19:34:45 +0800 (CST)
Message-ID: <8182fecd-d290-293a-d963-ddbea79dbf03@loongson.cn>
Date:   Mon, 10 Jul 2023 19:34:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/loongson: Remove a useless check in
 cursor_plane_atomic_async_check()
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230710102411.257970-1-suijingfeng@loongson.cn>
 <6c7bbce7-5521-b868-019f-bce26f309730@suse.de>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <6c7bbce7-5521-b868-019f-bce26f309730@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviPE7Ktk5DwnAA--.5489S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1DKF47Gw4UWr1kWw17urX_yoWrJF1kpr
        WkJry8CrWUJr1xJr9rJr1Utry5uw47tw1xWF1UJF1UtFWUtr1Yqr1UXryjgr4UArW8Gr1U
        Jr1UJFn8ZF1UtrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4oGQDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/7/10 18:39, Thomas Zimmermann wrote:
>
>
> Am 10.07.23 um 12:24 schrieb Sui Jingfeng:
>> Because smatch warnings:
>>
>> drivers/gpu/drm/loongson/lsdc_plane.c:199
>> lsdc_cursor_plane_atomic_async_check()
>> warn: variable dereferenced before check 'state' (see line 180)
>>
>> vim +/state +199 drivers/gpu/drm/loongson/lsdc_plane.c
>>
>> 174  static int
>>       lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
>> 175                                       struct drm_atomic_state 
>> *state)
>> 176  {
>> 177          struct drm_plane_state *new_state;
>> 178          struct drm_crtc_state *crtc_state;
>> 179
>> 180          new_state = drm_atomic_get_new_plane_state(state, plane);
>>                                                          ^^^^^
>> state is dereferenced inside this function
>>
>> 181
>> 182  if (!plane->state || !plane->state->fb) {
>> 183          drm_dbg(plane->dev, "%s: state is NULL\n", plane->name);
>> 184                  return -EINVAL;
>> 185  }
>> 186
>> 187  if (new_state->crtc_w != new_state->crtc_h) {
>> 188          drm_dbg(plane->dev, "unsupported cursor size: %ux%u\n",
>> 189                  new_state->crtc_w, new_state->crtc_h);
>> 190          return -EINVAL;
>> 191  }
>> 192
>> 193  if (new_state->crtc_w != 64 && new_state->crtc_w != 32) {
>> 194          drm_dbg(plane->dev, "unsupported cursor size: %ux%u\n",
>> 195                  new_state->crtc_w, new_state->crtc_h);
>> 196          return -EINVAL;
>> 197  }
>> 198
>> 199  if (state) {
>>           ^^^^^
>> Checked too late!
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202307100423.rV7D05Uq-lkp@intel.com/
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> BTW, you're posting these patches for loongson, 

I'm posting these patches for the drm/loongson driver in drm-misc and/or 
drm-tip branch,

what do you means for *loongson*,

> but that driver is not yet in our tree?
>

I already applied(push) drm/loongson driver to drm-misc-next branch,

What do you means that by "not yet in our tree", linux kernel side?

Am I missing something ?


> Best regards
> Thomas
>
>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_plane.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c 
>> b/drivers/gpu/drm/loongson/lsdc_plane.c
>> index 2ab3db982aa3..0d5094633222 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
>> @@ -196,13 +196,7 @@ static int 
>> lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
>>           return -EINVAL;
>>       }
>>   -    if (state) {
>> -        crtc_state = drm_atomic_get_existing_crtc_state(state, 
>> new_state->crtc);
>> -    } else {
>> -        crtc_state = plane->crtc->state;
>> -        drm_dbg(plane->dev, "%s: atomic state is NULL\n", plane->name);
>> -    }
>> -
>> +    crtc_state = drm_atomic_get_existing_crtc_state(state, 
>> new_state->crtc);
>>       if (!crtc_state->active)
>>           return -EINVAL;
>

