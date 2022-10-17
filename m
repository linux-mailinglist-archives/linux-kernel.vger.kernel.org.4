Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A821E6005C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiJQDiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiJQDiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:38:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510964F67C;
        Sun, 16 Oct 2022 20:38:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MrN1j4X5fzKFXS;
        Mon, 17 Oct 2022 11:35:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDn58kkzkxjf2KXAQ--.50937S3;
        Mon, 17 Oct 2022 11:38:14 +0800 (CST)
Subject: Re: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
To:     Yuwei Guan <ssawgyw@gmail.com>, paolo.valente@linaro.org,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221017032019.101-1-Yuwei.Guan@zeekrlife.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <98809bee-a5d6-d7c0-7229-4a74c6eec67f@huaweicloud.com>
Date:   Mon, 17 Oct 2022 11:38:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221017032019.101-1-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDn58kkzkxjf2KXAQ--.50937S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1UXry5Xw18Jry3GF1ftFb_yoWfCFb_J3
        4vy34fCF4DGw4kXF4ft345ArWYy3y3AF97GFn8GF4UWa45A3Z3Awn7t34UWFsxZa9xGa1Y
        vrWDZ3yftr1vkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
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
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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

ÔÚ 2022/10/17 11:20, Yuwei Guan Ð´µÀ:
> it defined in d0edc2473be9d, but there's nowhere to use it,
> so remove it.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> Acked-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>   block/bfq-iosched.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 64ee618064ba..6bcef8e5871a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -369,11 +369,8 @@ struct bfq_queue {
>   	unsigned long split_time; /* time of last split */
>   
>   	unsigned long first_IO_time; /* time of first I/O for this queue */
> -
>   	unsigned long creation_time; /* when this queue is created */
>   
> -	/* max service rate measured so far */
> -	u32 max_service_rate;
>   

You left two blank lines here. Have you tried checkpatch?

Thanks,
Kuai
>   	/*
>   	 * Pointer to the waker queue for this queue, i.e., to the
> 

