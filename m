Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454065FDABD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJMNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJMNWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:22:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59C10565D;
        Thu, 13 Oct 2022 06:22:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mp9BP4PbNzl3nR;
        Thu, 13 Oct 2022 21:20:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnKMohEUhjqX_XAA--.48818S3;
        Thu, 13 Oct 2022 21:22:42 +0800 (CST)
Subject: Re: [PATCH] blk-mq: put the reference of the io scheduler module
 after switching back
To:     Jinlong Chen <chenjinlong2016@outlook.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <OS0P286MB0338E8D41770BFDE7B3A4EBBBE229@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
 <OS0P286MB033887ED7C81DD1F782000DBBE259@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b79a8187-5342-8ff3-73fc-0324bdfb67fb@huaweicloud.com>
Date:   Thu, 13 Oct 2022 21:22:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <OS0P286MB033887ED7C81DD1F782000DBBE259@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnKMohEUhjqX_XAA--.48818S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1fZry7Xr4fur48Kr4DJwb_yoWDWrc_ur
        40kFykKw1UGr4FgFyxKF1UZrZxW395Gr98JFW2yF4fAa90gay3tr4DK3WxWr1xJws7Cr1Y
        qF43uF43uw15XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/10/13 21:03, Jinlong Chen Ð´µÀ:
> Sorry for the disturbance.
> 
> This patch is just wrong. elevator_switch_mq does not increase the reference
>   count of the io scheduler module to which we are switching. Hence, we do not
>   need to put the reference back manually.

I'm confused here, cause I do think this patch make sense.

blk_mq_update_nr_hw_queues
  // for each queue using the tagset
  blk_mq_freeze_queue
  // if current elevator is not none, swith to none
  blk_mq_elv_switch_none
   // elevator need to be switched back, got a reference to
   // prevent module to be removed.
   __module_get
   elevator_switch(q, NULL);

  // switch back from none elevator
  blk_mq_elv_switch_back
   -> should release the module reference here
  blk_mq_unfreeze_queue

By the way, I do not test yet, but I think problem can be reporduced:

1. modprobe bfq
2. switch elevator to bfq
3. trigger blk_mq_update_nr_hw_queues
4. switch elevator to none
5. rmmod bfq will fail

Thanks,
Kuai
> 
> Sincerely
> Jinlong Chen
> .
> 

