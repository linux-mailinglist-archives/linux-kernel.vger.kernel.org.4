Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384796179AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKCJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCJSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:18:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241F8DEE9;
        Thu,  3 Nov 2022 02:17:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N2ykV6SVvzK9bd;
        Thu,  3 Nov 2022 17:14:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCntOYMh2NjRuuSAg--.21550S3;
        Thu, 03 Nov 2022 17:17:02 +0800 (CST)
Subject: Re: [PATCH 1/2] block: don't allow a disk link holder to itself
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221103025541.1875809-1-yukuai1@huaweicloud.com>
 <20221103025541.1875809-2-yukuai1@huaweicloud.com>
 <20221103080628.GA3346@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <faabea7a-b06b-1494-59ce-e06d0a7b2882@huaweicloud.com>
Date:   Thu, 3 Nov 2022 17:17:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221103080628.GA3346@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCntOYMh2NjRuuSAg--.21550S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1DGw15WFy8uw47urWkXrb_yoWkGrbEga
        s09r97GwnrJ3Z7tFsIyr13ZrZ09FWkWry8CrWUKF129w15XryUJF48C390qr9xGrs8tr4a
        9rZ8W343Aw12vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/11/03 16:06, Christoph Hellwig Ð´µÀ:
> Yes, this is a good one.  Please add a single sentence blurb explaing
> the issue before the Test prodecure?
Ok, I'll do that.
> 
> With that this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> On Thu, Nov 03, 2022 at 10:55:40AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Test procedures:
>>
>> 1) dmsetup create test --table "xxx sda", assume dm-0 is created
>> 2) dmsetup suspend test
>> 3) dmsetup reload test --table "xxx dm-0"
>> 4) dmsetup resume test
> 
> Can you wire this up for blocktests?

Of course I can, I'm not very familiar with how to add new test in
blktests, so I might take some time to do that.
> 
> I've also been wondering how we could wire your other two test cases
> up as I think they'be very useful.  Hopefully I can find some time
> to inject delays with eBPF or something like it.

The problem was found without the delay originally, such delay can make
sure the problem is reproduced 100%, but it's still possible without the
delay. Perhaps we can add the test without delay for now.

Thanks,
Kuai
> 
> .
> 

