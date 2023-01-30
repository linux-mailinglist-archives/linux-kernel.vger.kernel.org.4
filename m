Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36622680372
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjA3BQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjA3BQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:16:02 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3388513DC4;
        Sun, 29 Jan 2023 17:16:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P4qxm0M48z4f3tvK;
        Mon, 30 Jan 2023 09:15:56 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgAHcStMGtdjEr3wCQ--.59762S2;
        Mon, 30 Jan 2023 09:15:58 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH v3 0/5] A few bugfix and cleanup patches for sbitmap
To:     axboe@kernel.dk
Cc:     jack@suse.cz, kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
Message-ID: <f0428eec-f56e-4425-cc9b-4f352f90fc95@huaweicloud.com>
Date:   Mon, 30 Jan 2023 09:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAHcStMGtdjEr3wCQ--.59762S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW7JFyfGF1UWFWDZw1DJrb_yoW8Xw13pr
        1SqF1fGw1rKr9rWrnFy345JF1Sqw4ktrnrJw1I9F1rur1UAF9xKrykKFWfA34UXFy5tFW7
        GF4rXr18KF1UXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens. Could you apply this patchset and the patchset "[PATCH v4 0/8]
A few bugfix and cleancode patch for bfq" sent on the same day.

on 1/17/2023 4:50 AM, Kemeng Shi wrote:
> Hi, this series contain a bugfix patch to correct wake_batch
> recalculation to avoid potential IO hung and a few cleanup patches to
> remove unnecessary check and repeat code in sbitmap. Thanks.
> 
> ---
> v3:
>  -Thank Jan for review. Collect Reviewed-by from Jan for all patches.
>  -some cleanups according to recommends from Jan:
>    1)Add Fixes tag in patch 2/5 "sbitmap: remove redundant check in
> __sbitmap_queue_get_batch"
>    2)Avoid lines over 80 characters in patch 3/5 "sbitmap: rewrite
> sbitmap_find_bit_in_index to reduce repeat code"
>    3)Remove pointless line in patch 4/5 "sbitmap: add sbitmap_find_bit
> to remove repeat code in __sbitmap_get/__sbitmap_get_shallow"
> 
> ---
> v2:
>  -add patch "sbitmap: correct wake_batch recalculation to avoid potential
> IO hung"
> ---
> 
> Kemeng Shi (5):
>   sbitmap: remove unnecessary calculation of alloc_hint in
>     __sbitmap_get_shallow
>   sbitmap: remove redundant check in __sbitmap_queue_get_batch
>   sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
>   sbitmap: add sbitmap_find_bit to remove repeat code in
>     __sbitmap_get/__sbitmap_get_shallow
>   sbitmap: correct wake_batch recalculation to avoid potential IO hung
> 
>  lib/sbitmap.c | 102 ++++++++++++++++++++++----------------------------
>  1 file changed, 45 insertions(+), 57 deletions(-)
> 

-- 
Best wishes
Kemeng Shi

