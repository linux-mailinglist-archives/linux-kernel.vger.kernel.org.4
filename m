Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE470BC37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjEVLuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjEVLtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:49:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3932E0;
        Mon, 22 May 2023 04:49:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPwjG6hbbz4f3lXP;
        Mon, 22 May 2023 19:49:38 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7PSVmtkTzLkJw--.54944S3;
        Mon, 22 May 2023 19:49:40 +0800 (CST)
Subject: Re: [PATCH] md/raid5: Convert stripe_head's "dev" to flexible array
 member
To:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517233313.never.130-kees@kernel.org>
 <ZGWpLClY7vz+xl5A@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <229ac866-9710-5dbe-80c4-61498f807662@huaweicloud.com>
Date:   Mon, 22 May 2023 19:49:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZGWpLClY7vz+xl5A@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7PSVmtkTzLkJw--.54944S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47trWDKFWxGw17CF1ftFb_yoW8ZFyrpF
        WDZasrAr4UGr15Ka1DAw4DWFWrK39agFW7JFWIg3yrA3Z2gryvkay8GFWY9Fy5ZFWfCa4x
        Za1qvryUZr4qyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
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

Hi, Christoph

在 2023/05/18 12:27, Christoph Hellwig 写道:

It's not related to this patch, just I think I found a problem while
reviewing raid5 code, commit e82ed3a4fbb5 ("md/raid6: refactor
raid5_read_one_chunk") changes the caculation of 'end_sector',
'end_sector' is compared to 'rdev->recovery_offset', so it should be
offset to rdev, but this commit change it to offset to the array.

Perhaps following change will make sense:

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7e2bbcfef325..8686d629e3f2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5516,7 +5516,7 @@ static int raid5_read_one_chunk(struct mddev 
*mddev, struct bio *raid_bio)

         sector = raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector, 0,
                                       &dd_idx, NULL);
-       end_sector = bio_end_sector(raid_bio);
+       end_sector = sector + bio_sectors(raid_bio);

         rcu_read_lock();
         if (r5c_big_stripe_cached(conf, sector))


Thanks,
Kuai
> On Wed, May 17, 2023 at 04:33:14PM -0700, Kees Cook wrote:
>>   	sc = kmem_cache_create(conf->cache_name[conf->active_name],
>> -			       sizeof(struct stripe_head)+(devs-1)*sizeof(struct r5dev),
>> +			       struct_size((struct stripe_head *)0, dev, devs),
>>   			       0, 0, NULL);
>>   	if (!sc)
>>   		return 1;
>> @@ -2559,7 +2559,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
>>   
>>   	/* Step 1 */
>>   	sc = kmem_cache_create(conf->cache_name[1-conf->active_name],
>> -			       sizeof(struct stripe_head)+(newsize-1)*sizeof(struct r5dev),
>> +			       struct_size((struct stripe_head *)0, dev, newsize),
> 
> The constant you're casting here should be NULL, not 0.
> Also given that this expression is duplicated, I'd suggest a little
> helper for it…
> 
>> -	} dev[1]; /* allocated with extra space depending of RAID geometry */
>> +	} dev[]; /* allocated with extra space depending of RAID geometry */
> 
> And this isn't extra space over the single entry anymore, so I'd
> change this to:
> 
> 	/* allocated depending of RAID geometry */
> .
> 

