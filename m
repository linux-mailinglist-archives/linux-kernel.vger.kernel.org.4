Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE67E63B7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiK2CPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiK2CPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:15:11 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E53F05B;
        Mon, 28 Nov 2022 18:15:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NLmBb27YRz4f3v51;
        Tue, 29 Nov 2022 10:15:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnitcoa4Vj6_5UBQ--.52275S3;
        Tue, 29 Nov 2022 10:15:06 +0800 (CST)
Subject: Re: [PATCH RFC] scsi: core: remove unsed 'restarts' from scsi_device
To:     Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221118113052.1324140-1-yukuai1@huaweicloud.com>
 <cefdae2e-67e3-b4b4-f569-31db960e991f@huaweicloud.com>
 <Y4QqtbXsuYmkOe88@T590>
 <7a747bc3-b902-6f0c-21ef-0ef470ec326e@huaweicloud.com>
 <Y4Q1KPgBsDCZTyTW@T590>
 <1caa7d49-0322-3eb9-7e99-6be96f77c80a@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8280fa32-4a96-be98-06ac-1890f95f026f@huaweicloud.com>
Date:   Tue, 29 Nov 2022 10:15:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1caa7d49-0322-3eb9-7e99-6be96f77c80a@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnitcoa4Vj6_5UBQ--.52275S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF43tw4kXw48Gw4DZryftFb_yoWxArXE9r
        1a9rnrtrWrGFyI9rZrKFWrZF9YyFZYqa4rJ3yUtayfX3sxZF13Gr10q3yxAa13J3Wjkrn7
        Xrs0kFyktrZI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hi,
> 
> 在 2022/11/28 12:12, Ming Lei 写道:

>>
>> BTW, why do you drive nvme via megaraid instead nvme driver?
>>
>>> And by the way, after Jan's patch "blk-mq: Improve performance of non-mq
>>> IO schedulers with multiple HW queues", scsi_run_queue_async() can only
>>> garantee to run hw queue for the current cpu, not all the hw queues.
>>
>> That isn't true, each hctx is still run in case of none & kyber 
>> scheduler.

And I really suspect that why Jan's patch can improve performance is
because it avoid many run queues from scsi_run_queue_async().

> 
> Yes, but current default hctx shared elevator is deadline.
>>
>> thanks,
>> Ming
>>
>> .
>>
> 
> .
> 

