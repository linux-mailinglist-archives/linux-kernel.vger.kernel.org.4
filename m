Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23A75FB2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJKMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:54:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24ED5D;
        Tue, 11 Oct 2022 05:54:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mmwf66rJXzKFRM;
        Tue, 11 Oct 2022 20:51:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnKMp1Z0VjKY1sAA--.63802S3;
        Tue, 11 Oct 2022 20:54:15 +0800 (CST)
Subject: Re: [PATCH] block: put the reference of the io scheduler module after
 switching back
To:     Jinlong Chen <chenjinlong2016@outlook.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <OS0P286MB0338069A20BA87C2C9B2F2E0BE239@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a0d0c50e-061b-ce4e-0341-35156dde00c7@huaweicloud.com>
Date:   Tue, 11 Oct 2022 20:54:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <OS0P286MB0338069A20BA87C2C9B2F2E0BE239@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnKMp1Z0VjKY1sAA--.63802S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyxtry8CFWfZFWxWry5twb_yoWkXFX_Ww
        10vr97Ca1DJanY9F40kFyFqr4fWa95GryIk3yxJFZFvFW0vF4xZw4kKFnxJrZ2ganrGa4r
        Gr15Cr4Yv34IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

ÔÚ 2022/10/11 18:21, Jinlong Chen Ð´µÀ:
> We got a reference of the io scheduler module in
> blk_mq_elv_switch_none to prevent the module from
> being removed. We need to put that reference back
> once we are done.

However, if blk_mq_elv_switch_none() failed due to OOM, and module
reference is not acquired, blk_mq_elv_switch_back() will still be
called. This seems not to be the right fix.

Thanks,
Kuai
> 
> Signed-off-by: Jinlong Chen <chenjinlong2016@outlook.com>
> ---
>   block/blk-mq.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..8dfe3bf3e599 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4595,6 +4595,13 @@ static void blk_mq_elv_switch_back(struct list_head *head,
>   
>   	mutex_lock(&q->sysfs_lock);
>   	elevator_switch(q, t);
> +	/**
> +	 * We got a reference of the io scheduler module in
> +	 * blk_mq_elv_switch_none to prevent the module from
> +	 * being removed. We need to put that reference back
> +	 * once we are done.
> +	 */
> +	module_put(t->elevator_owner);
>   	mutex_unlock(&q->sysfs_lock);
>   }
>   
> 

