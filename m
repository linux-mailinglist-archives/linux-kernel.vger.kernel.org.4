Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A487E7149C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjE2NA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2NA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:00:56 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6899;
        Mon, 29 May 2023 06:00:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVFyB2PNQz4f3vdW;
        Mon, 29 May 2023 21:00:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7MBonRkXhznKQ--.32845S3;
        Mon, 29 May 2023 21:00:51 +0800 (CST)
Subject: Re: [PATCH] md/raid10: prioritize adding disk to 'removed' mirror
To:     linan666@huaweicloud.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230527092007.3008856-1-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <45ee7cb9-6651-46a5-87a2-dd66532084d7@huaweicloud.com>
Date:   Mon, 29 May 2023 21:00:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230527092007.3008856-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7MBonRkXhznKQ--.32845S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF47WFWkZrW8JrWrXw4fKrg_yoW5uw13pa
        93J3ZxKry8JwsI9F1UJayDWFWSqrZ5Kayvkry3W34S9rZxtrWUGa4xG3y5JryDArZ8Zw4a
        q3W5GrZ09a4I9rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/27 17:20, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> When add a new disk to raid10, it will traverse conf->mirror from start
> and find one of the following mirror to add:
>    1. mirror->rdev is set to WantReplacement and it have no replacement,
>       set new disk to mirror->replacement.
>    2. no mirror->rdev, set new disk to mirror->rdev.
> 
> There is a array as below (sda is set to WantReplacement):
> 
>      Number   Major   Minor   RaidDevice State
>         0       8        0        0      active sync set-A   /dev/sda
>         -       0        0        1      removed
>         2       8       32        2      active sync set-A   /dev/sdc
>         3       8       48        3      active sync set-B   /dev/sdd
> 
> Use 'mdadm --add' to add a new disk to this array, the new disk will
> become sda's replacement instead of add to removed position, which is
> confusing for users. Meanwhile, after new disk recovery success, sda
> will be set to Faulty.
> 
> Prioritize adding disk to 'removed' mirror is a better choice. In the
> above scenario, the behavior is the same as before, except sda will not
> be deleted. Before other disks are added, continued use sda is more
> reliable.
> 

I think this change make sense, however, it's better to do this for all
personality instead of just for raid10.

Thanks,
Kuai
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 35 ++++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..d90eb830ca1a 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2148,9 +2148,10 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   {
>   	struct r10conf *conf = mddev->private;
>   	int err = -EEXIST;
> -	int mirror;
> +	int mirror, repl_slot = -1;
>   	int first = 0;
>   	int last = conf->geo.raid_disks - 1;
> +	struct raid10_info *p;
>   
>   	if (mddev->recovery_cp < MaxSector)
>   		/* only hot-add to in-sync arrays, as recovery is
> @@ -2173,23 +2174,14 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	else
>   		mirror = first;
>   	for ( ; mirror <= last ; mirror++) {
> -		struct raid10_info *p = &conf->mirrors[mirror];
> +		p = &conf->mirrors[mirror];
>   		if (p->recovery_disabled == mddev->recovery_disabled)
>   			continue;
>   		if (p->rdev) {
> -			if (!test_bit(WantReplacement, &p->rdev->flags) ||
> -			    p->replacement != NULL)
> -				continue;
> -			clear_bit(In_sync, &rdev->flags);
> -			set_bit(Replacement, &rdev->flags);
> -			rdev->raid_disk = mirror;
> -			err = 0;
> -			if (mddev->gendisk)
> -				disk_stack_limits(mddev->gendisk, rdev->bdev,
> -						  rdev->data_offset << 9);
> -			conf->fullsync = 1;
> -			rcu_assign_pointer(p->replacement, rdev);
> -			break;
> +			if (test_bit(WantReplacement, &p->rdev->flags) &&
> +			    p->replacement == NULL && repl_slot < 0)
> +				repl_slot = mirror;
> +			continue;
>   		}
>   
>   		if (mddev->gendisk)
> @@ -2206,6 +2198,19 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   		break;
>   	}
>   
> +	if (err && repl_slot >= 0) {
> +		p = &conf->mirrors[repl_slot];
> +		clear_bit(In_sync, &rdev->flags);
> +		set_bit(Replacement, &rdev->flags);
> +		rdev->raid_disk = repl_slot;
> +		err = 0;
> +		if (mddev->gendisk)
> +			disk_stack_limits(mddev->gendisk, rdev->bdev,
> +					  rdev->data_offset << 9);
> +		conf->fullsync = 1;
> +		rcu_assign_pointer(p->replacement, rdev);
> +	}
> +
>   	print_conf(conf);
>   	return err;
>   }
> 

