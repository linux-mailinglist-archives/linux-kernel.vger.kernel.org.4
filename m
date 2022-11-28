Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEBC63A029
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiK1DfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK1DfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:35:24 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B910EB;
        Sun, 27 Nov 2022 19:35:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NLB1d0Pv7z4f3tqc;
        Mon, 28 Nov 2022 11:35:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgCHnrl2LIRjZnoOBQ--.6103S3;
        Mon, 28 Nov 2022 11:35:20 +0800 (CST)
Subject: Re: [PATCH RFC] scsi: core: remove unsed 'restarts' from scsi_device
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221118113052.1324140-1-yukuai1@huaweicloud.com>
 <cefdae2e-67e3-b4b4-f569-31db960e991f@huaweicloud.com>
 <Y4QqtbXsuYmkOe88@T590>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7a747bc3-b902-6f0c-21ef-0ef470ec326e@huaweicloud.com>
Date:   Mon, 28 Nov 2022 11:35:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4QqtbXsuYmkOe88@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCHnrl2LIRjZnoOBQ--.6103S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1fGF18ur45JFWDGr1rJFb_yoW8Aw1Upa
        y5ta1Yya1kJr4Yk34Syr4UWryftw4qqw43XFn7GryUtF909rs3WF4rtw45WF92vF92gFsF
        y3WUX3s3Xr10y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/28 11:27, Ming Lei 写道:
> On Sat, Nov 26, 2022 at 04:54:46PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/11/18 19:30, Yu Kuai 写道:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> During code review, I found that 'restarts' is not useful anymore after
>>> the following commits:
>>>
>>> 1) commit ab3cee3762e5 ("blk-mq: In blk_mq_dispatch_rq_list() "no budget"
>>> is a reason to kick")
>>> 2) commit d3b38596875d ("blk-mq: run queue no matter whether the request
>>> is the last request")
>>> 3) commit 673235f91531 ("scsi: core: Fix race between handling STS_RESOURCE
>>> and completion")
>>>
>>> Now that if get budget ever failed, block layer will make sure to
>>> trigger new run queue for the hctx. Hence there is no need to run queue
>>> from scsi layer in this case.
>>>
> 
> But scsi_run_queue_async() needs to run all hw queue because budget is
> actually LUN/request queue wide.

Why the hw queue need to run if get budget never failed in this hw
queue?

> 
>>
>> Does anyone has suggestions about this patch?
>>
>> More info why I tried to remove this:
>>
>> while testing megaraid with 4 nvme with none elevator, the default
>> queue_depth is 128, while I test it with fio 128 jobs and 1 iodepth,
>> bw is about 4Gib/s, however, if I test with 128 jobs and 2 iodepth,
>> bw is decreased to about 0.8Gib/s, and with this patch applied,
>> bw can stay 4Gib/s in the later case.
> 
> What is .can_queue and nr_hw_queues in your setting?
test cmd:
fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 -randseed=2022 
-rwmixread=70 -refill_buffers -filename=/dev/sdg -numjobs=128 -size=1TB 
-runtime=60s -bs=4k -iodepth=2 -rw=randwrite

test environment:
arm64 Kunpeng-920, 128 cpu
megaraid with 4 NVMEs, 128 hctx and queue_depth is 128

> 
> 
> 
> thanks,
> Ming
> 
> .
> 

