Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3499D740DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjF1Juw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:50:52 -0400
Received: from dggsgout11.his.huawei.com ([45.249.212.51]:7594 "EHLO
        dggsgout11.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjF1J21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:28:27 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrbqC0hvpz4f4HDH;
        Wed, 28 Jun 2023 17:28:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rE3_Ztk6L_hMg--.19650S3;
        Wed, 28 Jun 2023 17:28:23 +0800 (CST)
Subject: Re: [PATCH 3/3] md/raid10: use get_rdev_repl_from_mirror() to get
 devices
To:     linan666@huaweicloud.com, song@kernel.org,
        guoqing.jiang@cloud.ionos.com, colyli@suse.de, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230628015752.102267-1-linan666@huaweicloud.com>
 <20230628015752.102267-4-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b06cafde-a6e0-6d52-8113-7ec3895f3b30@huaweicloud.com>
Date:   Wed, 28 Jun 2023 17:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230628015752.102267-4-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rE3_Ztk6L_hMg--.19650S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xWrW5Zr4xWrWfXw4fKrg_yoW8trWkpa
        n8K3WYyFWUW3yjkF1UJFWUGa4FvryxtF4fAr98Z3y3W39xJrZ3J3W8G345Wr98ZFZ8uFy5
        WF1UKanay3W0qFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

�� 2023/06/28 9:57, linan666@huaweicloud.com д��:
> From: Li Nan <linan122@huawei.com>
> 
> Commit 2ae6aaf76912 ("md/raid10: fix io loss while replacement replace
> rdev") reads replacement first to prevent io loss. However, there are same
> issue in wait_blocked_dev() and raid10_handle_discard(), too. Fix it by
> using get_rdev_repl_from_mirror() to get devices.

LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Fixes: d30588b2731f ("md/raid10: improve raid10 discard request")
> Fixes: f2e7e269a752 ("md/raid10: pull the code that wait for blocked dev into one function")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index eaaf6307ddda..2d55374d8b22 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1376,11 +1376,9 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
>   	blocked_rdev = NULL;
>   	rcu_read_lock();
>   	for (i = 0; i < conf->copies; i++) {
> -		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
> -		struct md_rdev *rrdev = rcu_dereference(
> -			conf->mirrors[i].replacement);
> -		if (rdev == rrdev)
> -			rrdev = NULL;
> +		struct md_rdev *rdev, *rrdev;
> +
> +		get_rdev_repl_from_mirror(&conf->mirrors[i], &rdev, &rrdev);
>   		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
>   			atomic_inc(&rdev->nr_pending);
>   			blocked_rdev = rdev;
> @@ -1816,15 +1814,12 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
>   	 */
>   	rcu_read_lock();
>   	for (disk = 0; disk < geo->raid_disks; disk++) {
> -		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
> -		struct md_rdev *rrdev = rcu_dereference(
> -			conf->mirrors[disk].replacement);
> +		struct md_rdev *rdev, *rrdev;
>   
> +		get_rdev_repl_from_mirror(&conf->mirrors[disk], &rdev, &rrdev);
>   		r10_bio->devs[disk].bio = NULL;
>   		r10_bio->devs[disk].repl_bio = NULL;
>   
> -		if (rdev == rrdev)
> -			rrdev = NULL;
>   		if (rdev && (test_bit(Faulty, &rdev->flags)))
>   			rdev = NULL;
>   		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
> 

