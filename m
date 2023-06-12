Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45472CDC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbjFLSUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbjFLSUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:20:06 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5038E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:20:03 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dx_+vRYYdk1PkDAA--.8611S3;
        Tue, 13 Jun 2023 02:20:01 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxjcrQYYdkO+gWAA--.57583S3;
        Tue, 13 Jun 2023 02:20:00 +0800 (CST)
Message-ID: <90fb836f-ba54-1d3c-965c-67f91ff89fb0@loongson.cn>
Date:   Tue, 13 Jun 2023 02:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm: etnaviv: Replace of_platform.h with explicit
 includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230410232647.1561308-1-robh@kernel.org>
 <CAL_JsqLeAvEVa8h3qywqESkqGG1O+9QWqA7fc1EJeDGkmAV7Fw@mail.gmail.com>
 <0ce32e34-d53b-4038-ef39-3b0f3e2f8a7f@loongson.cn>
 <CAL_JsqKsa9KQxk6r=ZxtY30Mk5nk9ST5ejJ+8VXZ5vPJAGHMBg@mail.gmail.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <CAL_JsqKsa9KQxk6r=ZxtY30Mk5nk9ST5ejJ+8VXZ5vPJAGHMBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxjcrQYYdkO+gWAA--.57583S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr4rWFWUXF1xGr13KrWkKrX_yoWDuFgE9F
        1I9w4kWr4fGr97Ja90yFyDZr909ry3JF4DZ3Z5tFn3W3sayry5JrykCryrXa43WF1IkFnx
        X3Z3AF93Ar1IgosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVWU
        JVW8JwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
        0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1l
        Yx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
        0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
        vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2G-eUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/13 02:15, Rob Herring wrote:
> On Sun, Jun 11, 2023 at 12:49 AM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>>
>> On 2023/6/10 04:17, Rob Herring wrote:
>>> On Mon, Apr 10, 2023 at 5:26 PM Rob Herring <robh@kernel.org> wrote:
>>>> Etnaviv doesn't use anything from of_platform.h, but depends on
>>>> of.h, of_device.h, and platform_device.h which are all implicitly
>>>> included, but that is going to be removed soon.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>    drivers/gpu/drm/etnaviv/etnaviv_drv.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>> Ping!
>>
>> of_device.h already has 'linux/of.h' and 'linux/platform_device.h' included,
>>
>> Would it be sufficient by simply including linux/of_device.h ?
> That's part of what I'm trying to remove. Standard practice is to not
> rely on implicit includes.

Ok, that's fine then.


Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>


> Rob

-- 
Jingfeng

