Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77375EA8B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiIZOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiIZOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:40:55 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2CF3131;
        Mon, 26 Sep 2022 06:01:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MbjWv0n6FzKHQS;
        Mon, 26 Sep 2022 20:59:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBH53C1ojFjD0y2BQ--.50147S3;
        Mon, 26 Sep 2022 21:01:42 +0800 (CST)
Subject: Re: [PATCH v3 1/5] wbt: don't show valid wbt_lat_usec in sysfs while
 wbt is disabled
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-2-yukuai3@huawei.com>
 <20220926094434.jrl6gnlbjqkex3wa@quack3>
 <6736753f-b5ae-39f1-b0c4-508b7f45d701@huaweicloud.com>
 <20220926114726.ta2w3vcbxgkh3sov@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <84ae1c2c-9b57-6cb7-173b-68b5c7634d64@huaweicloud.com>
Date:   Mon, 26 Sep 2022 21:01:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220926114726.ta2w3vcbxgkh3sov@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53C1ojFjD0y2BQ--.50147S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrCr4UWr1UAFy5Wr1UGFg_yoWkCwcEvF
        1j9F4DCFn8WFsaya1DKr1xArWvyF4agFyrXw10gF12vrZ7XF47CrWkGrZ3Z3s093WxtF9r
        Ga1q9r15ZrZxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jan

在 2022/09/26 19:47, Jan Kara 写道:
> On Mon 26-09-22 18:25:18, Yu Kuai wrote:
>> Hi, Jan
>>
>> 在 2022/09/26 17:44, Jan Kara 写道:
>>> On Thu 22-09-22 19:35:54, Yu Kuai wrote:
>>>> Currently, if wbt is initialized and then disabled by
>>>> wbt_disable_default(), sysfs will still show valid wbt_lat_usec, which
>>>> will confuse users that wbt is still enabled.
>>>>
>>>> This patch shows wbt_lat_usec as zero and forbid to set it while wbt
>>>> is disabled.
>>>
>>> So I agree we should show 0 in wbt_lat_usec if wbt is disabled by
>>> wbt_disable_default(). But why do you forbid setting of wbt_lat_usec?
>>> IMHO if wbt_lat_usec is set, admin wants to turn on wbt so we should just
>>> update rwb->enable_state to WBT_STATE_ON_MANUAL.
>>
>> I was thinking that don't enable wbt if elevator is bfq. Since we know
>> that performance is bad, thus it doesn't make sense to me to do that,
>> and user might doesn't aware of the problem.
> 
> Yeah, I don't think it is a good idea (that is the reason why it is
> disabled by default) but in priciple I don't see a reason why we should
> block admin from enabling it.

I'll enable it in next version.

Thanks,
Kuai

