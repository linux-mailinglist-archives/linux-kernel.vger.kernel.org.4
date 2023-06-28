Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48654740C62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjF1JHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:07:52 -0400
Received: from dggsgout12.his.huawei.com ([45.249.212.56]:11135 "EHLO
        dggsgout12.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjF1Izt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:55:49 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QrWrn26mKz4f3why;
        Wed, 28 Jun 2023 14:29:29 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7NJ05tkWyjYMg--.47347S3;
        Wed, 28 Jun 2023 14:29:31 +0800 (CST)
Subject: Re: [PATCH -next 1/2] md: don't quiesce in mddev_suspend()
To:     Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com, song@kernel.org,
        colyli@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230628012931.88911-1-yukuai1@huaweicloud.com>
 <20230628012931.88911-2-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <10137916-9feb-8ab6-e157-8c66bbad1932@huaweicloud.com>
Date:   Wed, 28 Jun 2023 14:29:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230628012931.88911-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7NJ05tkWyjYMg--.47347S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rXr4rCrykury7Xw4rGrg_yoW8AF17p3
        97tFW5Cr1UJF90kw12y3WDuFy5Xa1qgrZ2kFy3u34YywnFgryfGr1fuas8Xr9rC39YyrsI
        yw4UJrWrJr10grDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/28 9:29, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Some levels doesn't implement "pers->quiesce", for example
> raid0_quiesce() is empty, and now that all levels will drop 'active_io'
> until io is done, wait for 'active_io' to be 0 is enough to make sure all
> normal io is done, and percpu_ref_kill() for 'active_io' will make sure
> no new normal io can be dispatched. There is no need to call
> "pers->quiesce" anymore from mddev_suspend().

Just found that this patch actually prevent null_ptr_deref in some cases
that "pers->quiesce" is NULl for some personalities, and caller of
mddev_suspend() doesn't check this. For example, suspend_lo_store()
checks "pers->quiesce" is not NULL before calling mddev_suspend(), while
suspend_hi_store() doesn't.

Thanks,
Kuai
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index abb616720393..962dacfd98cf 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -453,7 +453,6 @@ void mddev_suspend(struct mddev *mddev)
>   		mddev->pers->prepare_suspend(mddev);
>   
>   	wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io));
> -	mddev->pers->quiesce(mddev, 1);
>   	clear_bit_unlock(MD_ALLOW_SB_UPDATE, &mddev->flags);
>   	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
>   
> @@ -472,7 +471,6 @@ void mddev_resume(struct mddev *mddev)
>   		return;
>   	percpu_ref_resurrect(&mddev->active_io);
>   	wake_up(&mddev->sb_wait);
> -	mddev->pers->quiesce(mddev, 0);
>   
>   	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	md_wakeup_thread(mddev->thread);
> 

