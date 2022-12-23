Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57154654CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiLWG6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiLWG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:57:59 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A128763;
        Thu, 22 Dec 2022 22:57:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NddKq2M8Xz4f3m7M;
        Fri, 23 Dec 2022 14:57:51 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDHfLBwUaVjWx50AQ--.24660S2;
        Fri, 23 Dec 2022 14:57:54 +0800 (CST)
Subject: Re: [PATCH 12/13] blk-mq: use switch/case to improve readability in
 blk_mq_try_issue_list_directly
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
 <20221223125223.1687670-13-shikemeng@huaweicloud.com>
 <20221223055308.GB2676@lst.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5ea6649d-8932-b2b7-730b-00419caf6488@huaweicloud.com>
Date:   Fri, 23 Dec 2022 14:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221223055308.GB2676@lst.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHfLBwUaVjWx50AQ--.24660S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4ftw45uFW3Cr43JrW7CFg_yoWfXFbEkr
        WFkas7Aw4DKF9rGF4qkF4UXrnrKa4UX3Z5Cr4rXF12g34vqrWrWw4vkr1S9w45trW8CFna
        934Fv3yjyr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 12/23/2022 1:53 PM, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 08:52:22PM +0800, Kemeng Shi wrote:
>> +			blk_mq_request_bypass_insert(rq, false, list_empty(list));
> 
> Please try to avoid the overly long line here.
Get it and I will fix this in next version. Thanks!
> That beng said blk_mq_request_bypass_insert is simply a horrible
> API.  I think we should do something like this:
I am not quite follow this. I guess this API is horrible for two possbile reasons:
1. It accepts two bool parameters which may be confusing betwwen them.
2. It adds additional checks for if we need to insert at head and if we need to run
queue which is already checked by caller.

Anyway, it seems another patch is needed for this, but I don't know proper way to
send this patch. Add your patch to this patchset or you want to send a single one
after this patchset.

-- 
Best wishes
Kemeng Shi

