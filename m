Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6219714871
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjE2LU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjE2LUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:20:24 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54FEBCD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:20:23 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:38010.867005441
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 313FA1028BB;
        Mon, 29 May 2023 19:20:20 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id 40b0b2cc20eb420b8f017a90b76d4b16 for jani.nikula@linux.intel.com;
        Mon, 29 May 2023 19:20:22 CST
X-Transaction-ID: 40b0b2cc20eb420b8f017a90b76d4b16
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <edcc8838-f097-4c29-a26f-8cc5e325acb7@189.cn>
Date:   Mon, 29 May 2023 19:20:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/i915_drm.h: fix a typo
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230529074912.2070902-1-suijingfeng@loongson.cn>
 <874jnvimtf.fsf@intel.com> <970d2cff-f181-d933-8ce3-b1dbe7f90fd8@189.cn>
 <87wn0rh2oa.fsf@intel.com>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <87wn0rh2oa.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I'm just hesitating to so, thank you.


On 2023/5/29 18:06, Jani Nikula wrote:
> On Mon, 29 May 2023, Sui Jingfeng <15330273260@189.cn> wrote:
>> Hi,
>>
>>
>> On 2023/5/29 16:06, Jani Nikula wrote:
>>> On Mon, 29 May 2023, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>>>>    'rbiter' -> 'arbite'
>>> Should be arbiter.
>> Yeah, should be arbiter.
>>
>> arbiter is a noun. Here, this arbiter may referrer to the
>> drivers/pci/vgaarb.c.
>>
>> Can you help correct then apply it ? thanks.
> Please send a fixed version and I'll apply it. I'm not fixing trivial
> patches for you.
>
> BR,
> Jani.
>
>
>>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>>> ---
>>>>    include/drm/i915_drm.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
>>>> index 7adce327c1c2..3dcb1db519ae 100644
>>>> --- a/include/drm/i915_drm.h
>>>> +++ b/include/drm/i915_drm.h
>>>> @@ -42,7 +42,7 @@ extern struct resource intel_graphics_stolen_res;
>>>>     * The Bridge device's PCI config space has information about the
>>>>     * fb aperture size and the amount of pre-reserved memory.
>>>>     * This is all handled in the intel-gtt.ko module. i915.ko only
>>>> - * cares about the vga bit for the vga rbiter.
>>>> + * cares about the vga bit for the vga arbite.
>>>>     */
>>>>    #define INTEL_GMCH_CTRL		0x52
>>>>    #define INTEL_GMCH_VGA_DISABLE  (1 << 1)
