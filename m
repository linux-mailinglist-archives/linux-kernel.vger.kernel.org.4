Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462486A02D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjBWGeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjBWGep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:34:45 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC6E38EB0;
        Wed, 22 Feb 2023 22:34:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PMjtP1mTHz4f3l8K;
        Thu, 23 Feb 2023 14:34:37 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBnG6_5CPdjxfOcEA--.14578S2;
        Thu, 23 Feb 2023 14:34:35 +0800 (CST)
Subject: Re: [PATCH 17/17] block, bfq: remove unnecessary local variable
 __bfqq in bfq_setup_merge
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202302200841.9zinyY7i-lkp@intel.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <10be999e-0b35-198b-7e04-83fcdd58c34c@huaweicloud.com>
Date:   Thu, 23 Feb 2023 14:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <202302200841.9zinyY7i-lkp@intel.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBnG6_5CPdjxfOcEA--.14578S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1ftFW3Kw4DWryDGryxAFb_yoW5tr17pa
        15JFsI9w48Jr42qFy7KasYvr1vvrn5Jas7X3s0yr47uFs8AF929F1Skry5ZrWxuFWxtrW3
        Jr4fur1xKr15Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 2/23/2023 1:48 PM, Dan Carpenter wrote:
> Hi Kemeng,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/block-bfq-properly-mark-bfqq-remained-idle/20230219-104312
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> patch link:    https://lore.kernel.org/r/20230219104309.1511562-18-shikemeng%40huaweicloud.com
> patch subject: [PATCH 17/17] block, bfq: remove unnecessary local variable __bfqq in bfq_setup_merge
> config: openrisc-randconfig-m041-20230219 (https://download.01.org/0day-ci/archive/20230220/202302200841.9zinyY7i-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202302200841.9zinyY7i-lkp@intel.com/
> 
> New smatch warnings:
> block/bfq-iosched.c:2785 bfq_setup_merge() error: we previously assumed 'new_bfqq' could be null (see line 2766)
> 
> Old smatch warnings:
> block/bfq-iosched.c:6195 __bfq_insert_request() warn: variable dereferenced before check 'bfqq' (see line 6191)
> 
> vim +/new_bfqq +2785 block/bfq-iosched.c
> 
> 36eca894832351 Arianna Avanzini 2017-04-12  2751  static struct bfq_queue *
> 36eca894832351 Arianna Avanzini 2017-04-12  2752  bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
> 36eca894832351 Arianna Avanzini 2017-04-12  2753  {
> 36eca894832351 Arianna Avanzini 2017-04-12  2754  	int process_refs, new_process_refs;
> 36eca894832351 Arianna Avanzini 2017-04-12  2755  
> 36eca894832351 Arianna Avanzini 2017-04-12  2756  	/*
> 36eca894832351 Arianna Avanzini 2017-04-12  2757  	 * If there are no process references on the new_bfqq, then it is
> 36eca894832351 Arianna Avanzini 2017-04-12  2758  	 * unsafe to follow the ->new_bfqq chain as other bfqq's in the chain
> 36eca894832351 Arianna Avanzini 2017-04-12  2759  	 * may have dropped their last reference (not just their last process
> 36eca894832351 Arianna Avanzini 2017-04-12  2760  	 * reference).
> 36eca894832351 Arianna Avanzini 2017-04-12  2761  	 */
> 36eca894832351 Arianna Avanzini 2017-04-12  2762  	if (!bfqq_process_refs(new_bfqq))
> 36eca894832351 Arianna Avanzini 2017-04-12  2763  		return NULL;
> 36eca894832351 Arianna Avanzini 2017-04-12  2764  
> 36eca894832351 Arianna Avanzini 2017-04-12  2765  	/* Avoid a circular list and skip interim queue merges. */
> 114533e1e26a36 Kemeng Shi       2023-02-19 @2766  	while ((new_bfqq = new_bfqq->new_bfqq)) {
> 114533e1e26a36 Kemeng Shi       2023-02-19  2767  		if (new_bfqq == bfqq)
> 36eca894832351 Arianna Avanzini 2017-04-12  2768  			return NULL;
> 36eca894832351 Arianna Avanzini 2017-04-12  2769  	}
> 
> This now loops until new_bfqq is NULL.
> 
> 36eca894832351 Arianna Avanzini 2017-04-12  2770  
> 36eca894832351 Arianna Avanzini 2017-04-12  2771  	process_refs = bfqq_process_refs(bfqq);
> 36eca894832351 Arianna Avanzini 2017-04-12  2772  	new_process_refs = bfqq_process_refs(new_bfqq);
> 
> What?Sorry, I didn't expect that there is a behavior change. I will drop
this one in next version. Thanks.

-- 
Best wishes
Kemeng Shi

