Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7271C72DDFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbjFMJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbjFMJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:41:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B11510D8;
        Tue, 13 Jun 2023 02:41:30 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxGurJOYhkGJMEAA--.9851S3;
        Tue, 13 Jun 2023 17:41:29 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXMrIOYhkptkYAA--.62503S3;
        Tue, 13 Jun 2023 17:41:28 +0800 (CST)
Message-ID: <5050ec45-b82a-d815-659e-a408e692aea4@loongson.cn>
Date:   Tue, 13 Jun 2023 17:41:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 0/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        loongson-kernel@lists.loongnix.cn
References: <20230520105718.325819-1-15330273260@189.cn>
 <d4e647d8-294c-abd7-40c6-37381796203d@loongson.cn>
 <a23d6mgl4fbfa4ucgjvwgw7l3somxo4tkhit7ygy55fldlum56@vm3tyjdsx24l>
 <d2f744b6-e4c9-d1b5-d4ca-470b801c670d@189.cn>
 <hvfr6qkepf6l3ymqtp6vhlneeqihnli7g5v7nzd6rirwleffk6@4ernj6xng5rt>
 <42c54caf-0ab9-a075-b641-9e3e21b2a2f3@loongson.cn>
 <7rbtdidyfpctz22pw2mnt2a6yp34hwp2bdp7usp52ft5mfrfud@nokbyxjip5by>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <7rbtdidyfpctz22pw2mnt2a6yp34hwp2bdp7usp52ft5mfrfud@nokbyxjip5by>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxXMrIOYhkptkYAA--.62503S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Gr4fZrWkZr13CFWkGFWUWrX_yoW8JF13pr
        WUtF10kF4kGr1rJrZYvw18tFnYvwn8tr1Uuw1qqr17urWqvr13GF42kr4YkF9xXr97Ca17
        tF4UXa43tw4jkagCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Wrv_ZF1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7PE
        -UUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/13 17:28, Maxime Ripard wrote:
> On Tue, Jun 13, 2023 at 05:17:00PM +0800, Sui Jingfeng wrote:
>> On 2023/6/13 17:10, Maxime Ripard wrote:
>>> On Tue, Jun 13, 2023 at 04:35:44PM +0800, Sui Jingfeng wrote:
>>>> Hi,
>>>>
>>>> On 2023/6/13 16:30, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Jun 12, 2023 at 10:58:54PM +0800, Sui Jingfeng wrote:
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>> Any ideas for this trivial DC driver? Sorry about my broken English.
>>>>>>
>>>>>> What to do next? Send a new version?
>>>>> Thomas already told you to merge it in the previous version:
>>>>> https://lore.kernel.org/dri-devel/7b77020f-d543-13bf-e178-bc416bcc728d@suse.de/
>>>>>
>>>>> So.. do that?
>>>> Yes, that sound fine.
>>>>
>>>> But I can't do it myself, would you like to help?
>>> Why can't you do it yourself?
>> I don't have a commit access to the drm-misc,
>>
>> I think, I can get the commit access in a letter time when I good enough,
>>
>> But get the code merged, just merge the latest version is OK.
> Look at the link in Thomas mail, it's the documentation on how to get
> commit access.

Can I get the commit access at a latter time?

I do not need the commit access currently.

As long as somebody can help to merge this driver is OK.

> Maxime

-- 
Jingfeng

