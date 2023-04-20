Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6F6E9502
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjDTMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjDTMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:47:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74138A7;
        Thu, 20 Apr 2023 05:47:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q2HVp62pnz4f42Yv;
        Thu, 20 Apr 2023 20:47:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JiNEFkbCQlHw--.15266S3;
        Thu, 20 Apr 2023 20:47:32 +0800 (CST)
Subject: Re: [PATCH-next] nbd: fix incomplete validation of ioctl arg
To:     Zhong Jinghua <zhongjinghua@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230206145805.2645671-1-zhongjinghua@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f9e28d45-ddea-6056-7954-f28661975c1f@huaweicloud.com>
Date:   Thu, 20 Apr 2023 20:47:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230206145805.2645671-1-zhongjinghua@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77JiNEFkbCQlHw--.15266S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5Xr4kGw1UAw45tF48Xrb_yoW5WF1DpF
        WjkF4UCryjyF17ua9Fya9ruFy5Xa1ftrW3KFy7CFy8ZFn2ka4I9FW8KryFqw1UtrWUW398
        XFW5GFyvkw1jq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/02/06 22:58, Zhong Jinghua Ð´µÀ:
> We tested and found an alarm caused by nbd_ioctl arg without verification.
> The UBSAN warning calltrace like below:
> 
> UBSAN: Undefined behaviour in fs/buffer.c:1709:35
> signed integer overflow:
> -9223372036854775808 - 1 cannot be represented in type 'long long int'
> CPU: 3 PID: 2523 Comm: syz-executor.0 Not tainted 4.19.90 #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>   dump_backtrace+0x0/0x3f0 arch/arm64/kernel/time.c:78
>   show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x170/0x1dc lib/dump_stack.c:118
>   ubsan_epilogue+0x18/0xb4 lib/ubsan.c:161
>   handle_overflow+0x188/0x1dc lib/ubsan.c:192
>   __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:206
>   __block_write_full_page+0x94c/0xa20 fs/buffer.c:1709
>   block_write_full_page+0x1f0/0x280 fs/buffer.c:2934
>   blkdev_writepage+0x34/0x40 fs/block_dev.c:607
>   __writepage+0x68/0xe8 mm/page-writeback.c:2305
>   write_cache_pages+0x44c/0xc70 mm/page-writeback.c:2240
>   generic_writepages+0xdc/0x148 mm/page-writeback.c:2329
>   blkdev_writepages+0x2c/0x38 fs/block_dev.c:2114
>   do_writepages+0xd4/0x250 mm/page-writeback.c:2344
> 
> The reason for triggering this warning is __block_write_full_page()
> -> i_size_read(inode) - 1 overflow.
> inode->i_size is assigned in __nbd_ioctl() -> nbd_set_size() -> bytesize.
> We think it is necessary to limit the size of arg to prevent errors.
> 
> Moreover, __nbd_ioctl() -> nbd_add_socket(), arg will be cast to int.
> Assuming the value of arg is 0x80000000000000001) (on a 64-bit machine),
> it will become 1 after the coercion, which will return unexpected results.
> 
> Fix it by adding checks to prevent passing in too large numbers.

Looks good to me, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   drivers/block/nbd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 592cfa8b765a..e1c954094b6c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -325,6 +325,9 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>   	if (blk_validate_block_size(blksize))
>   		return -EINVAL;
>   
> +	if (bytesize < 0)
> +		return -EINVAL;
> +
>   	nbd->config->bytesize = bytesize;
>   	nbd->config->blksize_bits = __ffs(blksize);
>   
> @@ -1111,6 +1114,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>   	struct nbd_sock *nsock;
>   	int err;
>   
> +	/* Arg will be cast to int, check it to avoid overflow */
> +	if (arg > INT_MAX)
> +		return -EINVAL;
>   	sock = nbd_get_socket(nbd, arg, &err);
>   	if (!sock)
>   		return err;
> 

