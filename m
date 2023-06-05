Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE63722609
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjFEMhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjFEMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:36:51 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCAE75;
        Mon,  5 Jun 2023 05:36:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZY4q4sHXz4f3kpB;
        Mon,  5 Jun 2023 20:36:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77LL1n1ktEr8Kw--.27071S3;
        Mon, 05 Jun 2023 20:36:28 +0800 (CST)
Subject: Re: [PATCH -next] loop: Add parm check in loop_control_ioctl
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, axboe@kernel.dk,
        kay.sievers@vrfy.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230605122838.2148878-1-zhongjinghua@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aa6963b1-6add-161f-aac2-6e30634f9f19@huaweicloud.com>
Date:   Mon, 5 Jun 2023 20:36:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230605122838.2148878-1-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77LL1n1ktEr8Kw--.27071S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWDWw1xKF18XrykAr13urg_yoW5WF4DpF
        W8Ja4Yya4DKF47Ca12qa4UZa45C3Wjv3yrZry2ywnY9r9xCryav3y5WFW5Xa17tFW3tFW5
        XF1DXa48K3WUCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/05 20:28, Zhong Jinghua Ð´µÀ:
> From: Zhong Jinghua <zhongjinghua@huawei.com>
> 
> We found that in loop_control_ioctl, the kernel panic can be easily caused:
> 
> 1. syscall(__NR_ioctl, r[1], 0x4c80, 0x80000200000ul);
> Create a loop device 0x80000200000ul.
> In fact, in the code, it is used as the first_minor number, and the
> first_minor number is 0.
> So the created loop device number is 7:0.
> 
> 2. syscall(__NR_ioctl, r[2], 0x4c80, 0ul);
> Create a loop device 0x0ul.
> Since the 7:0 device has been created in 1, add_disk will fail because
> the major and first_minor numbers are consistent.
> 
> 3. syscall(__NR_ioctl, r[5], 0x4c81, 0ul);
> Delete the device that failed to create, the kernel panics.

Please notice that kernel panic won't be triggered because add_disk()
has appropriate error handling.

Thanks,
Kuai
> 
> Panic like below:
> BUG: KASAN: null-ptr-deref in device_del+0xb3/0x840 drivers/base/core.c:3107
> Call Trace:
>   kill_device drivers/base/core.c:3079 [inline]
>   device_del+0xb3/0x840 drivers/base/core.c:3107
>   del_gendisk+0x463/0x5f0 block/genhd.c:971
>   loop_remove drivers/block/loop.c:2190 [inline]
>   loop_control_ioctl drivers/block/loop.c:2289 [inline]
> 
> The stack like below:
> Create loop device:
> loop_control_ioctl
>    loop_add
>      add_disk
>        device_add_disk
>          bdi_register
>            bdi_register_va
>              device_create
>                device_create_groups_vargs
>                  device_add
>                    kfree(dev->p);
>                      dev->p = NULL;
> 
> Remove loop device:
> loop_control_ioctl
>    loop_remove
>      del_gendisk
>        device_del
>          kill_device
>            if (dev->p->dead) // p is null
> 
> Fix it by adding a check for parm.
> 
> Fixes: 770fe30a46a1 ("loop: add management interface for on-demand device allocation")
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   drivers/block/loop.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 76b96c42f417..60f2a31c4a24 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2084,6 +2084,17 @@ static int loop_add(struct loop_device **l, int i)
>   	struct gendisk *disk;
>   	int err;
>   
> +	/*
> +	 * i << part_shift is actually used as the first_minor.
> +	 * So here should avoid i << part_shift overflow.
> +	 * And, MKDEV() expect that the max bits of
> +	 * first_minor is 20.
> +	 */
> +	if (i > 0 && i > MINORMASK >> part_shift) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>   	err = -ENOMEM;
>   	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
>   	if (!lo)
> @@ -2097,7 +2108,8 @@ static int loop_add(struct loop_device **l, int i)
>   		if (err == -ENOSPC)
>   			err = -EEXIST;
>   	} else {
> -		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
> +		err = idr_alloc(&loop_index_idr, lo, 0,
> +				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
>   	}
>   	if (err < 0)
>   		goto out_free_dev;
> 

