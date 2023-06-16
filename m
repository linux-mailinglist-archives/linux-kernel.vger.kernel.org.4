Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B87732BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjFPJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245741AbjFPJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:30:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3B1FC7;
        Fri, 16 Jun 2023 02:30:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QjDRH0zkGz4f50JL;
        Fri, 16 Jun 2023 17:30:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHK5+2K4xkJsdRLw--.3111S3;
        Fri, 16 Jun 2023 17:30:32 +0800 (CST)
Subject: Re: [PATCH] md/raid1-10: shut up randstruct warning again
To:     Arnd Bergmann <arnd@kernel.org>, Song Liu <song@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230616092532.3307719-1-arnd@kernel.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1d2ea39d-e909-f0b2-0ff8-979ca35f16e9@huaweicloud.com>
Date:   Fri, 16 Jun 2023 17:30:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230616092532.3307719-1-arnd@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHK5+2K4xkJsdRLw--.3111S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xAF45ZFW7KFWDGF4UArb_yoW8AF4kpa
        18Ka48uw45GrWUCa1Dua18Za1F9a1FkrW3CFyru3ySvan8tFyDJFW8J3y5Cr1DCF4rury2
        vF1UKF4Yk3Wj9FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
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

Hi,

ÔÚ 2023/06/16 17:24, Arnd Bergmann Ð´µÀ:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A code reorganization brought back a warning when structure randomization
> is enabled:
> 
> drivers/md/raid1-10.c:119:25: error: casting from randomized structure pointer type 'struct block_device *' to 'struct md_rdev *'
>          struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
>                                 ^
> 
> Before the rework, this used a (void*) cast, so go back to that in order
> to avoid the warning. Casting between pointers to incompatible types is
> clearly something that is dangerous, but this driver has always done so,
> and it's not made any worse by the struct randomization in this case.
> 
> Fixes: 8295efbe68c08 ("md/raid1-10: factor out a helper to submit normal write")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch, and this problem is already reported by kernel
test robot:

https://lore.kernel.org/oe-kbuild-all/202306142042.fmjfmTF8-lkp@intel.com/

And fixed patch is already applied:

https://lore.kernel.org/lkml/CAPhsuW6aSvCEa1khjjmDYGozUEs+Tx75RxfaE1+xL2Y1T6aN=Q@mail.gmail.com/T/

Thanks,
Kuai
> ---
>   drivers/md/raid1-10.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 169ebe296f2d0..3f22edec70e78 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -116,7 +116,7 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
>   
>   static inline void raid1_submit_write(struct bio *bio)
>   {
> -	struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
> +	struct md_rdev *rdev = (void *)bio->bi_bdev;
>   
>   	bio->bi_next = NULL;
>   	bio_set_dev(bio, rdev->bdev);
> 

