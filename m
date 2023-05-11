Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B626FEDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjEKIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjEKIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:38:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3D469F;
        Thu, 11 May 2023 01:38:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QH4zP1xYXz4f3l2p;
        Thu, 11 May 2023 16:38:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CFtqVxkBMjoIQ--.27674S3;
        Thu, 11 May 2023 16:38:07 +0800 (CST)
Subject: Re: Situation of CONFIG_BLK_WBT_MQ after commit b11d31ae01e6
 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com>
 <8a86ba08-cde4-97a4-d7e2-dc340609381c@huaweicloud.com>
 <CAKXUXMzA8GfJaWmdaszhrTtjMy5987oZ8AaBcoT6hNVvgCiZ-w@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <40f7206a-350b-7522-79b0-35cd92e38017@huaweicloud.com>
Date:   Thu, 11 May 2023 16:38:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMzA8GfJaWmdaszhrTtjMy5987oZ8AaBcoT6hNVvgCiZ-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CFtqVxkBMjoIQ--.27674S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1rXF1kZr13AF43Zry5Jwb_yoW8uFy8pr
        y8GF42ka1DKFs2kr4Iy34jka4ftF4kt347Xrn5Gw1UWwn0yayxAr4Sgr1a9F98Ars2gw1j
        y3ySqry3K345AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/10 13:40, Lukas Bulwahn 写道:
> On Wed, May 10, 2023 at 5:24 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/05/08 12:37, Lukas Bulwahn 写道:
>>> Dear Yu Kuai, dear Christoph, dear Jens,
>>>
>>>
>>> The commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
>>> wbt_enable_default()") removes the only reference to the config
>>> BLK_WBT_MQ in the kernel tree.
>>>
>>> The commit comes with the statement "If CONFIG_BLK_WBT_MQ is disabled,
>>> wbt_init() won't do anything.". The statement "If CONFIG_BLK_WBT is
>>> disabled, wbt_init() won't do anything." (note: CONFIG_BLK_WBT vs.
>>> CONFIG_BLK_WBT_MQ) is certainly true, but I do not see that "If
>>> CONFIG_BLK_WBT_MQ is disabled, wbt_init() won't do anything.", but I
>>> believe it would simply do what wbt_init() does with CONFIG_BLK_WBT
>>> being enabled.
>>>
>>> Now, it seems that with this commit applied, the intended switch of
>>> the config BLK_WBT_MQ is gone, and the config really now has no effect
>>> at all.
>>>
>>> So, I am a bit puzzled:
>>>
>>> 1. Either the config BLK_WBT_MQ does have an effect somewhere, but one
>>> cannot find its reference with 'git grep -i "BLK_WBT_MQ" .' --- so, my
>>> investigation is just incomplete or wrong, or
>>>
>>> 2. We really do not need this further build config BLK_WBT_MQ beyond
>>> the other configs already there --- then this config should just be
>>> removed, or
>>>
>>> 3. the commit unintentionally broke the purpose of the config
>>> BLK_WBT_MQ --- then this commit above should be reverted.
>>
>> Thanks for the report, it's the above case and it's my mistake.
>> I will fix this.
>>
> 
> Kuai, thanks for letting me know. Feel free to add a "Reported-by:
> Lukas Bulwahn <lukas.bulwahn@gmail.com>" tag, and to include in the
> list of recipients when you send out the fix to the mailing list.

I just send the fix, sorry that I forgot to cc you...

https://lore.kernel.org/all/20230511014509.679482-2-yukuai1@huaweicloud.com/

Thanks,
Kuai
> 
> I am glad to see that my investigation of kernel code is finding some
> issues that we can fix.
> 
> Lukas
> .
> 

