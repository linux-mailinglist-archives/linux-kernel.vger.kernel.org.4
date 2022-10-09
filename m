Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32325F8A62
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJIJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJIJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:32:41 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0432CCA8;
        Sun,  9 Oct 2022 02:32:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MlcGQ57rhzKDny;
        Sun,  9 Oct 2022 17:30:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHzYwzlUJjegAJCA--.61104S3;
        Sun, 09 Oct 2022 17:32:36 +0800 (CST)
Subject: Re: [blk] 8c5035dfbb: fio.read_iops -10.6% regression
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <202210081045.77ddf59b-yujie.liu@intel.com>
 <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
 <Y0KJmODYOh83OtGa@T590>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e81ea0fe-dcd2-1e5d-9b78-3c79751b3097@huaweicloud.com>
Date:   Sun, 9 Oct 2022 17:32:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y0KJmODYOh83OtGa@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHzYwzlUJjegAJCA--.61104S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy7XF13Zw43tw4fuF1rWFg_yoW3uwb_Zw
        1vvF1xCrn8Gan2vrsFkr4agr4kX34xGFy7JF4rJa17X3sIgrn8ZFyDWFy8W3s8Ww1rtF4a
        krWFy343Xrs2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/10/09 16:43, Ming Lei 写道:
> On Sat, Oct 08, 2022 at 04:00:10PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/10/08 10:50, kernel test robot 写道:
>>> Greeting,
>>>
>>> FYI, we noticed a -10.6% regression of fio.read_iops due to commit:
>>
>> I don't know how this is working but I'm *sure* this commit won't affect
> 
> Looks it is wrong to move
> 
> 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
> 
> before rq_qos_add() in wbt_init().
> 
> Without adding wbt rq_qos, wbt_set_write_cache is just a nop.

Yes, I got it now, I'm being foolish here.

I missed that "rwb->wc" is got by rq_qos in wbt_set_write_cache(), which
is NULL before rq_qos_add(). By the way, it's interesting that how read
performance is affected, I still don't know why yet...

Thanks,
Kuai
> 
> 
> thanks,
> Ming
> 
> .
> 

