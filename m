Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5347E639FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiK1DJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiK1DJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:09:35 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A512621;
        Sun, 27 Nov 2022 19:09:33 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NL9Rq2Hgbz4f3jHd;
        Mon, 28 Nov 2022 11:09:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBnybRoJoRjC3cNBQ--.46112S3;
        Mon, 28 Nov 2022 11:09:30 +0800 (CST)
Subject: Re: Why is MEGASAS_SAS_QD set to 256?
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     John Garry <john.g.garry@oracle.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <1c4d66ca-fe1a-3d1a-d7f9-4981d2fc9eb1@huaweicloud.com>
 <e11cdb17-053c-390c-9c48-36790eb70cc5@oracle.com>
 <2b89210a-222c-a919-ab5b-c76830308f92@huaweicloud.com>
 <Y4F3XG3lMCCKlLAr@T590>
 <aef69f3b-a8db-f34c-4a52-49ba9020f6cf@huaweicloud.com>
 <Y4MxEcF+DWCAgxGJ@T590>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <27aae921-d016-0416-17ff-a591cd2ae12d@huaweicloud.com>
Date:   Mon, 28 Nov 2022 11:09:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4MxEcF+DWCAgxGJ@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnybRoJoRjC3cNBQ--.46112S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4kXr47Zw43tFW5Jw45GFg_yoW8XF4xp3
        yrJa12kr1kZr40k340yr17XF1Sgw13ur1agF1Dt3sFkF9Ykan7Xw4Fg3y5XFZ29r40kw1j
        kws5X3srXwnYqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/27 17:42, Ming Lei 写道:
> On Sat, Nov 26, 2022 at 02:08:02PM +0800, Yu Kuai wrote:
>> Hi, Ming
>>
>> 在 2022/11/26 10:18, Ming Lei 写道:
>>>
>>> If you want aggressive merge on sequential IO workload, the queue depth need
>>> to be a bit less, then more requests can be staggered into scheduler queue,
>>> and merge chance is increased.
>>
>> But if nr_requests >= queue_depth, it seems to me elevator will have no
>> effect, no request can be merged or sorted by scheduler, right?
> 
> Yeah.
> 
> If nr_requests <= queue_depth, every request can be queued to
> driver/device, so requests won't be merged by scheduler.
> 
> But plug merge still works if IOs are submitted as batch.

Yes, io can still be merged by plug. I just find it a little werid to
set default elevator as deadline, and default queue_depth to 256. Which
means deadline here is useless.

> 
>>>
>>> If you want good perf on random IO perf, the queue depth needs to
>>> be deep enough to have enough parallelism for saturating SSD internal.
>>>
>>> But we don't recognize sequential/random IO pattern, and usually fixed
>>> queue depth is used.
>>
>> Is it possible to use none elevator and set large queue_depth if nvme is
>> used in this case?
> 
> Yeah, if the storage is SSD, usually none with bigger queue_depth should
> help, and usually 256 should be enough to saturate one single SSD for
> one well implemented driver.

Yes, I'm testing with multiple SSDs / NVMEs, and I can't get optimal
performance by default.

Thanks,
Kuai
> 
> 
> Thanks
> Ming
> 
> .
> 

