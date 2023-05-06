Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4466F9098
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjEFIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:32:32 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E987B659F;
        Sat,  6 May 2023 01:32:30 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:57024.1397785887
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id DF90A1002B5;
        Sat,  6 May 2023 16:32:27 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-6qwzn with ESMTP id 0da97246ee464bcaad97b2a1e31af4c9 for chenhuacai@kernel.org;
        Sat, 06 May 2023 16:32:28 CST
X-Transaction-ID: 0da97246ee464bcaad97b2a1e31af4c9
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <7764c60c-371a-89f7-c9a8-6727551926ae@189.cn>
Date:   Sat, 6 May 2023 16:32:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v12 1/2] MAINTAINERS: add maintainers for DRM LOONGSON
 driver
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nathan@kernel.org, linux-media@vger.kernel.org
References: <20230504080406.1213623-1-suijingfeng@loongson.cn>
 <20230504080406.1213623-2-suijingfeng@loongson.cn>
 <CAAhV-H4zKGkd2JUyYTDKBEGFEO5V+oRz8iuzF9w+ivz0t6+CFw@mail.gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <CAAhV-H4zKGkd2JUyYTDKBEGFEO5V+oRz8iuzF9w+ivz0t6+CFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Ah, I did't notice this.

The disorder is because during developing phase,

it is more easy amend new changes to the top of the commits.

So, I put another patch of this series on the top of this.

Will be fixed at next version, thanks for you point out that.


On 2023/5/6 11:09, Huacai Chen wrote:
> Hi, Jingfeng,
>
> I think you should exchange the order of these two patches.
>
>
> Huacai
>
> On Thu, May 4, 2023 at 4:04 PM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>>   This patch add myself as maintainer to drm loongson driver
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 73b3298b7232..1f5aa8756d87 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6922,6 +6922,13 @@ T:       git git://anongit.freedesktop.org/drm/drm-misc
>>   F:     drivers/gpu/drm/lima/
>>   F:     include/uapi/drm/lima_drm.h
>>
>> +DRM DRIVERS FOR LOONGSON
>> +M:     Sui Jingfeng <suijingfeng@loongson.cn>
>> +L:     dri-devel@lists.freedesktop.org
>> +S:     Supported
>> +T:     git git://anongit.freedesktop.org/drm/drm-misc
>> +F:     drivers/gpu/drm/loongson/
>> +
>>   DRM DRIVERS FOR MEDIATEK
>>   M:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>   M:     Philipp Zabel <p.zabel@pengutronix.de>
>> --
>> 2.25.1
>>
