Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE629706327
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEQIlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjEQIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:41:28 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BCC3B1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:41:26 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:36902.606101932
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id CFB771002B1;
        Wed, 17 May 2023 16:41:22 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-prw2v with ESMTP id f2cf8a95b7ad40ae9100f5bdcd0d8cca for tzimmermann@suse.de;
        Wed, 17 May 2023 16:41:23 CST
X-Transaction-ID: f2cf8a95b7ad40ae9100f5bdcd0d8cca
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <abecad9f-f6d7-1dca-68d3-a96b492a4c56@189.cn>
Date:   Wed, 17 May 2023 16:41:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/drm_atomic_helper.c: fix a typo
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sui Jingfeng <15330273260@189.cn>
References: <20230517041602.3225325-1-suijingfeng@loongson.cn>
 <40689882-6771-97c7-f771-d57ceefd052a@suse.de>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <40689882-6771-97c7-f771-d57ceefd052a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks a lot


Please help to take a look drm/loongson at 
https://patchwork.freedesktop.org/series/113566/ ?

let's merge it if no big problem?


On 2023/5/17 15:24, Thomas Zimmermann wrote:
> Merged. Thanks a lot.
>
> Am 17.05.23 um 06:16 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <15330273260@189.cn>
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/drm_atomic_helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c 
>> b/drivers/gpu/drm/drm_atomic_helper.c
>> index e0ab555aad2c..41b8066f61ff 100644
>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>> @@ -3154,7 +3154,7 @@ int drm_atomic_helper_update_plane(struct 
>> drm_plane *plane,
>>   EXPORT_SYMBOL(drm_atomic_helper_update_plane);
>>     /**
>> - * drm_atomic_helper_disable_plane - Helper for primary plane 
>> disable using * atomic
>> + * drm_atomic_helper_disable_plane - Helper for primary plane 
>> disable using atomic
>>    * @plane: plane to disable
>>    * @ctx: lock acquire context
>>    *
>
