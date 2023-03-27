Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C76C995F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 03:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjC0BhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 21:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC0BhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 21:37:11 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACBB4696;
        Sun, 26 Mar 2023 18:37:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PlFmK04KHz4f3jMd;
        Mon, 27 Mar 2023 09:37:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyFB8yBkwDiEFg--.45250S3;
        Mon, 27 Mar 2023 09:37:06 +0800 (CST)
Subject: Re: [PATCH] md/raid5: remove unused working_disks variable
To:     Tom Rix <trix@redhat.com>, song@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, "yukuai (C)" <yukuai3@huawei.com>
References: <20230326125637.1352895-1-trix@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <afd9db2f-72af-8ac0-9ab1-655fc79d992e@huaweicloud.com>
Date:   Mon, 27 Mar 2023 09:37:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230326125637.1352895-1-trix@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyFB8yBkwDiEFg--.45250S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4rWF1fWF4DuF4UCrWxZwb_yoW8Jw4fpa
        10v3W5ur4UXFW5Ka9rA3y7CFyFqanFy3y8GF9xu3WfXay5XrWDKw4rXry5WryDJFWSy3ya
        vF1UKr4DGw1fKrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/03/26 20:56, Tom Rix Ð´µÀ:
> clang with W=1 reports
> drivers/md/raid5.c:7719:6: error: variable 'working_disks'
>    set but not used [-Werror,-Wunused-but-set-variable]
>          int working_disks = 0;
>              ^
> This variable is not used so remove it.

Other than some nits below, this patch looks good to me, feel free to
add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Please also mention that commit 908f4fbd2657 ("md/raid5: be more
thorough in calculating 'degraded' value.") remove the last reference.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/md/raid5.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7b820b81d8c2..2b1e78c46817 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7716,7 +7716,6 @@ static void raid5_set_io_opt(struct r5conf *conf)
>   static int raid5_run(struct mddev *mddev)
>   {
>   	struct r5conf *conf;
> -	int working_disks = 0;
>   	int dirty_parity_disks = 0;
>   	struct md_rdev *rdev;
>   	struct md_rdev *journal_dev = NULL;
> @@ -7913,7 +7912,6 @@ static int raid5_run(struct mddev *mddev)
>   			goto abort;
>   		}
>   		if (test_bit(In_sync, &rdev->flags)) {
> -			working_disks++;
Please remove the braces as well,

Thanks,
Kuai
>   			continue;
>   		}
>   		/* This disc is not fully in-sync.  However if it
> 

