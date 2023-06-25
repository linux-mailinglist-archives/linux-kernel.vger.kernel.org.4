Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5790D73CFA2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFYJLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFYJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:11:46 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD91BF;
        Sun, 25 Jun 2023 02:11:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QplbC1H1Yz4f3q36;
        Sun, 25 Jun 2023 17:11:35 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCHK5_HBJhkK3T6MQ--.37814S3;
        Sun, 25 Jun 2023 17:11:37 +0800 (CST)
Message-ID: <b49f6f7e-16db-e3e0-188a-7ed848a9d43d@huaweicloud.com>
Date:   Sun, 25 Jun 2023 17:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/4] block/badblocks: change some members of badblocks
 to bool
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     axboe@kernel.dk, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>, linan122@huawei.com
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
 <20230621172052.1499919-2-linan666@huaweicloud.com>
 <ZJMC9rWFRqOTYgVk@araj-dh-work>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZJMC9rWFRqOTYgVk@araj-dh-work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHK5_HBJhkK3T6MQ--.37814S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15Ar45Xw4kJw45uF13XFb_yoWrGr47pF
        98G3Wayr4jqrn29F1jv3W7Ar10kw4xJF48J3y7Jw15KryDtw1xKa4kWryF9FyYqr4xursa
        vFyFgFW3Zr1vkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E
        8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Jr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUFfHjUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/21 22:02, Ashok Raj 写道:
> On Thu, Jun 22, 2023 at 01:20:49AM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> "changed" and "unacked_exist" are used as boolean type. Change the type
>> of them to bool. And reorder fields to reduce memory hole.
> 
> minor nit: If you use a .gitorderfile to list .h before .c it will help review them in
> order.
> 

I will config my git.

> I don't know if its even worth doing this manual compaction unless you are
> storing the entire struct in some flash or its in a sensitive cache
> thrashing structure.
> 

Yeah, it is worthless to manual compaction.

> bool is useful that it makes the code easier to read and can eliminate some
> class of bugs that you would otherwise use !! operator.
> 
>>
>> No functional changed intended.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   block/badblocks.c         | 14 +++++++-------
>>   include/linux/badblocks.h | 10 +++++-----
>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/badblocks.c b/block/badblocks.c
>> index 3afb550c0f7b..1b4caa42c5f1 100644
>> --- a/block/badblocks.c
>> +++ b/block/badblocks.c
>> @@ -141,7 +141,7 @@ static void badblocks_update_acked(struct badblocks *bb)
>>   	}
>>   
>>   	if (!unacked)
>> -		bb->unacked_exist = 0;
>> +		bb->unacked_exist = false;
>>   }
>>   
>>   /**
>> @@ -302,9 +302,9 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>>   		}
>>   	}
>>   
>> -	bb->changed = 1;
>> +	bb->changed = true;
>>   	if (!acknowledged)
>> -		bb->unacked_exist = 1;
>> +		bb->unacked_exist = true;
>>   	else
>>   		badblocks_update_acked(bb);
>>   	write_sequnlock_irqrestore(&bb->lock, flags);
>> @@ -414,7 +414,7 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>>   	}
>>   
>>   	badblocks_update_acked(bb);
>> -	bb->changed = 1;
>> +	bb->changed = true;
>>   out:
>>   	write_sequnlock_irq(&bb->lock);
>>   	return rv;
>> @@ -435,7 +435,7 @@ void ack_all_badblocks(struct badblocks *bb)
>>   		return;
>>   	write_seqlock_irq(&bb->lock);
>>   
>> -	if (bb->changed == 0 && bb->unacked_exist) {
>> +	if (bb->changed == false && bb->unacked_exist) {
> 
> 	if (!bb->changed && bb->unacked_exist)

I will change it in next version.

> 
> 
>>   		u64 *p = bb->page;
>>   		int i;
>>   
>> @@ -447,7 +447,7 @@ void ack_all_badblocks(struct badblocks *bb)
>>   				p[i] = BB_MAKE(start, len, 1);
>>   			}
>>   		}
>> -		bb->unacked_exist = 0;
>> +		bb->unacked_exist = false;
>>   	}
>>   	write_sequnlock_irq(&bb->lock);
>>   }
>> @@ -493,7 +493,7 @@ ssize_t badblocks_show(struct badblocks *bb, char *page, int unack)
>>   				length << bb->shift);
>>   	}
>>   	if (unack && len == 0)
>> -		bb->unacked_exist = 0;
>> +		bb->unacked_exist = false;
>>   
>>   	if (read_seqretry(&bb->lock, seq))
>>   		goto retry;
>> diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
>> index 2426276b9bd3..c2723f97d22d 100644
>> --- a/include/linux/badblocks.h
>> +++ b/include/linux/badblocks.h
>> @@ -27,15 +27,15 @@
>>   struct badblocks {
>>   	struct device *dev;	/* set by devm_init_badblocks */
>>   	int count;		/* count of bad blocks */
>> -	int unacked_exist;	/* there probably are unacknowledged
>> -				 * bad blocks.  This is only cleared
>> -				 * when a read discovers none
>> -				 */
>>   	int shift;		/* shift from sectors to block size
>>   				 * a -ve shift means badblocks are
>>   				 * disabled.*/
>> +	bool unacked_exist;	/* there probably are unacknowledged
>> +				 * bad blocks.  This is only cleared
>> +				 * when a read discovers none
> 
> read of what?

"... when a read of unacknowledged bad blocks discovers none"

Would this be better？

Thank for your suggestion.

> 
>> +				 */
>> +	bool changed;
>>   	u64 *page;		/* badblock list */
>> -	int changed;
>>   	seqlock_t lock;
>>   	sector_t sector;
>>   	sector_t size;		/* in sectors */
>> -- 
>> 2.39.2
>>
> 
> .

-- 
Thanks,
Nan

