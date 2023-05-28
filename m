Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC342713886
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjE1Ht6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjE1Ht4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:49:56 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66137C9;
        Sun, 28 May 2023 00:49:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QTW5n5qx8z4f3pF7;
        Sun, 28 May 2023 15:49:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LOeB3NktD6MKQ--.9124S3;
        Sun, 28 May 2023 15:49:50 +0800 (CST)
Subject: Re: [PATCH] md/raid10: clean up md_add_new_disk()
To:     linan666@huaweicloud.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230527101851.3266500-1-linan666@huaweicloud.com>
 <20230527101851.3266500-2-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <216ed892-11a9-2d8b-c6d5-a0c7dabe2c9d@huaweicloud.com>
Date:   Sun, 28 May 2023 15:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230527101851.3266500-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LOeB3NktD6MKQ--.9124S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17ur1rZrW8Wr43Kr4xXrb_yoW8Xr47pF
        Wvqa43Cw1kCr1jkw1kXFyUWa4rGanrur4rtFy3A348ZasrXr1DWa1rKasxXw1DXFyfA3Z0
        vFnFqas5Ja4kuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/05/27 18:18, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> Commit 1a855a060665 ("md: fix bug with re-adding of partially recovered
> device.") only add device which is set to In_sync. But it let devices
> without metadata cannot be added when they should be.
> 
> Commit bf572541ab44 ("md: fix regression with re-adding devices to arrays
> with no metadata") fix the above issue, it set device without metadata to
> In_sync when add new disk.
> 
> However, after commit f466722ca614 ("md: Change handling of save_raid_disk
> and metadata update during recovery.") deletes changes of the first patch,
> setting In_sync for devcie without metadata is meanless because the flag
> will be cleared soon and will not be used during this period. Clean it up.

LGME, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8e344b4b3444..e5b67b2d2166 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6733,7 +6733,6 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
>   			if (info->state & (1<<MD_DISK_SYNC)  &&
>   			    info->raid_disk < mddev->raid_disks) {
>   				rdev->raid_disk = info->raid_disk;
> -				set_bit(In_sync, &rdev->flags);
>   				clear_bit(Bitmap_sync, &rdev->flags);
>   			} else
>   				rdev->raid_disk = -1;
> 

