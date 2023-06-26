Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9773D5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFZCbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjFZCbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:31:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2357E53;
        Sun, 25 Jun 2023 19:31:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqBgB1bqjz4f3vf5;
        Mon, 26 Jun 2023 10:31:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7KG+JhkJ5cxMg--.20122S3;
        Mon, 26 Jun 2023 10:31:35 +0800 (CST)
Subject: Re: [PATCH 2/3] md: remove redundant check in fix_read_error()
To:     linan666@huaweicloud.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
 <20230623173236.2513554-3-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8f71afdb-f762-ac59-c71f-8241ad2e9144@huaweicloud.com>
Date:   Mon, 26 Jun 2023 10:31:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230623173236.2513554-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7KG+JhkJ5cxMg--.20122S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13AF1rZr4rGr13uFWfZrb_yoW8Gry5pa
        1q9a4Y934UCw1UAFyUAayUCa45Wa4agay8Crn5Aw1FvF9xZFy3tFWUKayDWrn7XF1Sya43
        XFn0q39rJF48tFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/06/24 1:32, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> In fix_read_error(), 'success' will be checked immediately after assigning
> it, if it is set to 1 then the loop will break. Checking it again in
> condition of loop is redundant. Clean it up.

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid1.c  | 2 +-
>   drivers/md/raid10.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> :
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 3570da63969b..0391c2d0c109 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2318,7 +2318,7 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
>   			d++;
>   			if (d == conf->raid_disks * 2)
>   				d = 0;
> -		} while (!success && d != read_disk);
> +		} while (d != read_disk);
>   
>   		if (!success) {
>   			/* Cannot read from anywhere - mark it bad */
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 94ae294c8a3c..a36e53fce21f 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2790,7 +2790,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			sl++;
>   			if (sl == conf->copies)
>   				sl = 0;
> -		} while (!success && sl != slot);
> +		} while (sl != slot);
>   		rcu_read_unlock();
>   
>   		if (!success) {
> 

