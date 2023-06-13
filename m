Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5171F72DDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbjFMJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjFMJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:32:09 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B267D13E;
        Tue, 13 Jun 2023 02:32:07 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxOuqWN4hk9o0EAA--.9907S3;
        Tue, 13 Jun 2023 17:32:06 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxJeSRN4hkRNAYAA--.5565S3;
        Tue, 13 Jun 2023 17:32:02 +0800 (CST)
Message-ID: <f0e88e6d-b2bf-8bff-0cbd-8d864391adf4@loongson.cn>
Date:   Tue, 13 Jun 2023 17:32:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 0/2] drm: add kms driver for loongson display
 controller
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
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <7rbtdidyfpctz22pw2mnt2a6yp34hwp2bdp7usp52ft5mfrfud@nokbyxjip5by>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxJeSRN4hkRNAYAA--.5565S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1UArW8Kr1rGr48tF1fAFc_yoW8Gr17pr
        WUJF18KF4ktr4fJrZYvw1IqF1Fvwn3JF17uw1qgr17urWqvr13GF4Ikr4YkF9xXrn7Ca17
        tF45XFy3tr45C3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
        Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxO
        zsDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

I have already submit the commit access  request [1], would you like to 
agree?

Thanks for you and thomas.

[1] 
https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/673#note_1932024

> Maxime

-- 
Jingfeng

