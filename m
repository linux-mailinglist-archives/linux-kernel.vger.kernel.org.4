Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FBE6090CB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 04:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJWCZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 22:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJWCZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 22:25:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6ED59E99;
        Sat, 22 Oct 2022 19:25:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mw26n06mLzKG4l;
        Sun, 23 Oct 2022 10:22:57 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3RecRplRjYA8yAA--.60936S3;
        Sun, 23 Oct 2022 10:25:22 +0800 (CST)
Subject: Re: [PATCH v5 0/6] blk-wbt: simple improvment to enable wbt correctly
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, ebiggers@google.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eb1c7962-c9bb-9148-6c62-cdd5e3105afe@huaweicloud.com>
Date:   Sun, 23 Oct 2022 10:25:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3RecRplRjYA8yAA--.60936S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XryfJF48Jry8AFyUXFWUJwb_yoWkurgEga
        y0kas5KF1DJ3WFkFZrJF1UXFWj9rs5Zr15X3ZrtrWayry3JF1Utw4vyrWUZ3s8Xa93C3Z8
        A3yUu3yfZr12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens

Can you apply this patchset?

Thanks,
Kuai

在 2022/10/19 20:15, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> changes in v5:
>   - code adjustment in patch 4, as suggested by Christoph.
>   - add review tag by Christop.
> 
> changes in v4:
>   - remove patch 3 from v3
>   - add patch 2,3 in v4
> 
> changes in v3:
>   - instead of check elevator name, add a flag in elevator_queue, as
>   suggested by Christoph.
>   - add patch 3 and patch 5 to this patchset.
> 
> changes in v2:
>   - define new api if wbt config is not enabled in patch 1.
> 
> Yu Kuai (6):
>    elevator: remove redundant code in elv_unregister_queue()
>    blk-wbt: remove unnecessary check in wbt_enable_default()
>    blk-wbt: make enable_state more accurate
>    blk-wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
>    elevator: add new field flags in struct elevator_queue
>    blk-wbt: don't enable throttling if default elevator is bfq
> 
>   block/bfq-iosched.c |  2 ++
>   block/blk-sysfs.c   |  3 +++
>   block/blk-wbt.c     | 26 ++++++++++++++++++++++----
>   block/blk-wbt.h     | 17 ++++++++++++-----
>   block/elevator.c    |  8 ++------
>   block/elevator.h    |  5 ++++-
>   6 files changed, 45 insertions(+), 16 deletions(-)
> 

