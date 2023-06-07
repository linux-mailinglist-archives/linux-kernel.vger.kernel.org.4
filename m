Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C5725459
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbjFGGel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbjFGGeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:34:05 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15ADC1FF0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:33:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxCerDJIBkDAwAAA--.156S3;
        Wed, 07 Jun 2023 14:33:39 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax6OTBJIBkc_IDAA--.14543S3;
        Wed, 07 Jun 2023 14:33:37 +0800 (CST)
Message-ID: <7db6a90f-1929-5e36-3f1d-c96acb5c70a1@loongson.cn>
Date:   Wed, 7 Jun 2023 14:33:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: display/Kconfig: replace leading spaces with
 tab
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230606133328.148490-1-suijingfeng@loongson.cn>
 <CADnq5_MdNSBJuNrJC2-fRByhEoUqEJmMGATT+OrFvjqA7k4F5Q@mail.gmail.com>
 <85b7bf66-840b-c6de-a7e3-be1f49953464@loongson.cn>
Organization: Loongson
In-Reply-To: <85b7bf66-840b-c6de-a7e3-be1f49953464@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax6OTBJIBkc_IDAA--.14543S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW3uFW3CFy3uF1UWF4DGFX_yoW8tr4Upw
        4kJFy5CrWUJF1rJr47J3WUXFy5Jw4fJa4UJryDX3WUZ34DAF1jgr4qgrn0grWUJFWxA3W8
        JF1rWr47ZF1qyrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
        kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1q6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcV
        AKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
        JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        ceOJUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://cgit.freedesktop.org/amd/drm-amd/


This one has a long time with no update.


On 2023/6/7 14:31, Sui Jingfeng wrote:
> Hi,
>
> On 2023/6/7 03:15, Alex Deucher wrote:
>> Applied.  Thanks!
>
> Where is the official branch of drm/amdgpu, I can't find it on the 
> internet.
>
> Sorry for asking this silly question.

>
>> Alex
>>
>> On Tue, Jun 6, 2023 at 9:33 AM Sui Jingfeng <suijingfeng@loongson.cn> 
>> wrote:
>>> This patch replace the leading spaces with tab, make them keep 
>>> aligned with
>>> the rest of the config options. No functional change.
>>>
>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> ---
>>>   drivers/gpu/drm/amd/display/Kconfig | 17 +++++++----------
>>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/Kconfig 
>>> b/drivers/gpu/drm/amd/display/Kconfig
>>> index 2d8e55e29637..04ccfc70d583 100644
>>> --- a/drivers/gpu/drm/amd/display/Kconfig
>>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>>> @@ -42,16 +42,13 @@ config DEBUG_KERNEL_DC
>>>            Choose this option if you want to hit kdgb_break in assert.
>>>
>>>   config DRM_AMD_SECURE_DISPLAY
>>> -        bool "Enable secure display support"
>>> -        depends on DEBUG_FS
>>> -        depends on DRM_AMD_DC_FP
>>> -        help
>>> -            Choose this option if you want to
>>> -            support secure display
>>> -
>>> -            This option enables the calculation
>>> -            of crc of specific region via debugfs.
>>> -            Cooperate with specific DMCU FW.
>>> +       bool "Enable secure display support"
>>> +       depends on DEBUG_FS
>>> +       depends on DRM_AMD_DC_FP
>>> +       help
>>> +         Choose this option if you want to support secure display
>>>
>>> +         This option enables the calculation of crc of specific 
>>> region via
>>> +         debugfs. Cooperate with specific DMCU FW.
>>>
>>>   endmenu
>>> -- 
>>> 2.25.1
>>>
-- 
Jingfeng

