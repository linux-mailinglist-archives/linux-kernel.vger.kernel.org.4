Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D06717876
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjEaHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjEaHmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:42:12 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54E93;
        Wed, 31 May 2023 00:42:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWLnV1Fgxz4f3xbG;
        Wed, 31 May 2023 15:42:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7NN+nZkQ0hsKg--.57984S3;
        Wed, 31 May 2023 15:42:07 +0800 (CST)
Subject: Re: [PATCH -next] block: fix blktrace debugfs entries leak
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230511065633.710045-1-yukuai1@huaweicloud.com>
 <20230511152808.GA8641@lst.de>
 <18db3894-d128-7857-4c11-25b59d82ff54@huaweicloud.com>
 <e26d37bc-0f09-426a-ef25-57bdbd716ae9@huaweicloud.com>
 <20230530142945.GA9553@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1a3cdcab-362b-1d6e-3988-9c07df4533ec@huaweicloud.com>
Date:   Wed, 31 May 2023 15:42:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230530142945.GA9553@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7NN+nZkQ0hsKg--.57984S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF43Cr13uw1kJrW3CF43trb_yoWfJrb_Xa
        1Uu3srGw1Ikr1vvw4rGr47ZFWaqFWkuwn8W34kXFZrZ34jvryrWFnrG395W3yrtrWvvFWY
        9r43uFySvFsxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
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

ÔÚ 2023/05/30 22:29, Christoph Hellwig Ð´µÀ:
> On Tue, May 30, 2023 at 10:07:54AM +0800, Yu Kuai wrote:
>>> If we don't care about blktrace for passthrough io after del_gendisk(),
>>> and /dev/sg* has separate handling, I think it's better just to check
>>> QUEUE_FLAG_REGISTERED in blk_trace_setup(), and don't enable blktrace
>>> in the first place.
>>
>> Any suggestions about this problem? Should we use separate handling for
>> /dev/sd? Or just free blktrace in blk_free_queue().
> 
> I'd be fine with trying to either remove the /dev/sg blktrace handling
> and / or splitting it up so that it doesn't interact with the main disk
> based one.  I can look into this if you want, or leave it to you.
> 

Ok, I'll send a v2 to free blktrace in disk_release(), in the meantime
I'll take a look how to handle blktrace for /dev/sg.

Thanks,
Kuai
> .
> 

