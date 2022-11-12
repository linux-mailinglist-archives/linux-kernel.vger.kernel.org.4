Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F426268ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiKLKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKLKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:44:43 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46830140F9;
        Sat, 12 Nov 2022 02:44:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N8XJN2h3nz4f3jZK;
        Sat, 12 Nov 2022 18:44:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgC329gWeW9j+BWaAQ--.8709S3;
        Sat, 12 Nov 2022 18:44:39 +0800 (CST)
Subject: Re: [PATCH] blk-mq: only unregister sysfs when registration succeeded
To:     Liu Shixin <liushixin2@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221112110754.1109979-1-liushixin2@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <607beb5b-8d54-b795-8a05-76352d7ed863@huaweicloud.com>
Date:   Sat, 12 Nov 2022 18:44:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221112110754.1109979-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329gWeW9j+BWaAQ--.8709S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DJrW3AFW3KF43Aw4fKrg_yoWftwc_Wa
        y0kFy8Kan8GrnIkw12kFy8ZrySkay8XF47GrZrXFZFy3WkXFZ5GwsI9r18Xw43Ga1xuFsx
        tr1DA34rWr1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
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

�� 2022/11/12 19:07, Liu Shixin д��:
> kobject_del() must not be called if kobject_add() has not been called.
> Hence only unregister sysfs when registration succeeded.
> 

 From what I see, the blk_queue_registered() from caller
blk_unregister_queue() can already prevent that. QUEUE_FLAG_REGISTERED
will only be set if blk_register_queue() succeed.

Thanks,
Kuai

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   block/blk-mq-sysfs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 93997d297d42..63f2df2500d9 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -279,6 +279,8 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>   	unsigned long i;
>   
>   	lockdep_assert_held(&q->sysfs_dir_lock);
> +	if (!q->mq_sysfs_init_done)
> +		return;
>   
>   	queue_for_each_hw_ctx(q, hctx, i)
>   		blk_mq_unregister_hctx(hctx);
> 

