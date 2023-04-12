Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF96DF03A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDLJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDLJXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:23:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126916195;
        Wed, 12 Apr 2023 02:23:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PxHMK080qz4f4nhq;
        Wed, 12 Apr 2023 17:23:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR+ceDZkj7KVGg--.31485S3;
        Wed, 12 Apr 2023 17:23:42 +0800 (CST)
Subject: Re: [PATCH -next v5 1/6] md: pass a md_thread pointer to
 md_register_thread()
To:     Logan Gunthorpe <logang@deltatee.com>, Song Liu <song@kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
 <20230410113559.1610455-2-yukuai1@huaweicloud.com>
 <CAPhsuW7rUQ9KFxCQw-iAAA64=x==b-Qu0nnp32TXn-85Okb00w@mail.gmail.com>
 <daa344fe-9d8d-16f9-aded-513f250928b9@huaweicloud.com>
 <CAPhsuW7bBaVsneBHYqwN3yd5k3sg6ZUFqEJad3yOD0=N-e411g@mail.gmail.com>
 <f67e8d9b-dae8-fced-ce7b-b0f8fff2d127@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <04a9522e-f0bb-5452-2ff4-4bb8017eb26b@huaweicloud.com>
Date:   Wed, 12 Apr 2023 17:23:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f67e8d9b-dae8-fced-ce7b-b0f8fff2d127@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR+ceDZkj7KVGg--.31485S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
        Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
        6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
        CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
        xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/04/11 23:46, Logan Gunthorpe 写道:

>>>> Can we do something like:
>>>>
>>>> struct md_thread __rcu *md_register_thread(void (*run) (struct md_thread *),
>>>>                  struct mddev *mddev, const char *name)
>>>
>>> I think this is not necessary, if we don't want to change api, we must
>>> use rcu_assign_pointer for each caller to set md_thread.
>>
>> I think it is better to use rcu_assign_pointer at the caller side.
> 
> I agree.
> 
> Logan
> .
> 
I'll remove this patch, and use rcu_assign_pointer() in the caller
directly in the next version.

Thanks,
Kuai

